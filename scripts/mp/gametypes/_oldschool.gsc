#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;

#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_loadout;

#using scripts\mp\_pickup_items; // TODO

#using scripts\mp\gametypes\_oldschool_points;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

// T7 Script Suite
#insert scripts\m_shared\utility.gsh;
T7_SCRIPT_SUITE_INCLUDES
#insert scripts\m_shared\lui.gsh;
#insert scripts\m_shared\bits.gsh;

#precache( "xmodel", "p7_mp_flag_base" );
#precache( "string", "MOD_PICK_UP_ITEM" );
#precache( "fx", FLAG_FX_BASE );
#precache( "fx", FLAG_FX_BASE_GREEN );
#precache( "fx", FLAG_FX_BASE_RED );
#precache( "fx", FLAG_FX_BASE_YELLOW );

function autoexec init()
{
	if ( !IsInArray( Array( "tdm", "dm" ), ToLower( GetDvarString( "g_gametype" ) ) ) )
		return;

	/#
	level.dev_points = [];
	level.dev_points_type = "equipment";
	#/
	level.giveCustomLoadout = &give_custom_loadout;
	
	level._effect[ "flag_base" ] = FLAG_FX_BASE;
	level._effect[ "flag_base_green" ] = FLAG_FX_BASE_GREEN;
	level._effect[ "flag_base_red" ] = FLAG_FX_BASE_RED;
	level._effect[ "flag_base_yellow" ] = FLAG_FX_BASE_YELLOW;

	callback::on_connect( &on_player_connect ); // force teams on connecting
	callback::on_spawned( &on_player_spawned ); // extra code on spawning
	callback::on_start_gametype( &start_gametype );

	SetJumpHeight( 64 ); // stock is 39?
}

function start_gametype()
{
	spawn_items( oldschool_points::get_spawn_points() );
}

function on_player_connect()
{
	// pre-set the persistence to something so we prevent some errors related to menuTeam();
	// --- WARNING: Setting this will break ESC menu
	// --- ERROR: By disabling this healing will not work anymore.
	self.pers["team"] = "axis";
	// moving to a built-in, still setting a team just in case.
	self SetTeam( "axis" );
	// set this before to satisfy the spawnClient, need to fill in broken statement _globalloigc_spawn::836 
	self.waitingToSpawn = true;
	// something to satisfy matchRecordLogAdditionalDeathInfo 5th parameter (_globallogic_player)
	self.class_num = 0;
	// satisfy _loadout
	self.class_num_for_global_weapons = 0;
	// autoassign the player
	self [[level.autoassign]]( true );
	// notify class selection
	self notify( "menuresponse", MENU_CHANGE_CLASS, "class_assault" );
	// close the "Choose Class" menu
	self CloseMenu( game["menu_changeclass"] );	
}

function on_player_spawned()
{
	self thread disable_charger();
	/#
	self thread oldschool_points::debug_commands();
	#/
}

function give_custom_loadout()
{
	self TakeAllWeapons();
	self ClearPerks();

	primary_weapon = GetWeapon( "smg_mp40" ); // TODO
	secondary_weapon = GetWeapon( "pistol_m1911" ); // TODO

	self GiveWeapon( primary_weapon );
	self GiveWeapon( secondary_weapon );
	self SetSpawnWeapon( primary_weapon );

	self.grenadeTypeSecondary = "emp"; // just input something to satisify _weaponobjects::2924

	return primary_weapon;
}

function disable_charger()
{
    self endon( "death" );
    self endon( "disconnect" );

    self AllowDoubleJump( false );
    
    while ( true )
    {
        self SetDoubleJumpEnergy( 0 );
        self ResetDoubleJumpRechargeTime();
        WAIT_SERVER_FRAME;
    }
}

function spawn_items( a_spawn_points )
{
	foreach ( point in a_spawn_points )
	{
		point.base = point spawn_base();

		switch( point.type )
		{
			case "equipment":
				point create_equipment();
				break;
			case "health":
				point create_health();
				break;
			case "perk":
				point create_perk();
				break;
			case "weapon":
				point create_weapon();
				break;
			default: // should really never get this but whatever
				AssertMsg( "Unknown spawn type " + point.type + " for oldschool!" );
				break;
		}
	}
}

function spawn_item_watcher( item )
{
	self.s_model endon( "delete" );

	self.s_model Show();
	trigger = Spawn( "trigger_radius", self.s_model.origin, 0, 64, 32 );
	trigger SetCursorHint( "HINT_NOICON" );
	trigger TriggerIgnoreTeam(); // WHY ARE YOU NECESSARY
	trigger SetHintString( &"MOD_PICK_UP_ITEM", IString( item.displayname ) );
	hasBeenPickedUp = false;

	self create_base_fx( level._effect[ "flag_base_green" ] );

	// TODO:
	// convert from bool & break to thread respawn
	do
	{
		trigger waittill( "trigger", player );

		if ( !IsPlayer( player ) || player IsThrowingGrenade() )
			continue;
		// use pressed, is a weapon, and doesn't have the weapon
		if ( player UseButtonPressed() && IsWeapon( item ) && !player HasWeapon( item ) )
		{
			if ( item.inventoryType != "offhand" ) // normal weapon, anything not a grenade
			{
				player TakeWeapon( player GetCurrentWeapon() );
				player GiveWeapon( item );
				player GiveStartAmmo( item );
				player SwitchToWeapon( item );
				hasBeenPickedUp = true;
				break;
			}
			else // grenades
			{
				if ( !isdefined( player.grenadeTypePrimary ) )
					player.grenadeTypePrimary = item;

				if ( player.grenadeTypePrimary != item )
				{
					player TakeWeapon( player.grenadeTypePrimary );
					player.grenadeTypePrimary = item;
				}

				player GiveWeapon( item );
				player SetWeaponAmmoClip( item, 1 );
				player SwitchToOffHand( item );
				
				player.grenadeTypePrimaryCount = 1;
				hasBeenPickedUp = true;
				break;
			}
		}
		// is a weapon, and has the weapon
		else if ( IsWeapon( item ) && player HasWeapon( item ) )
		{
			stock = player GetWeaponAmmoStock( item );
			maxAmmo = item.maxAmmo;
			// has max ammo don't do anything
			if ( stock == maxAmmo )
				continue;
			// if normal weapon, get proper ammo count
			if ( item.inventoryType != "offhand" )
				count = ( stock + item.clipSize <= maxAmmo ? stock + item.clipSize : maxAmmo );
			// if is grenade just return only 1 for ammo
			else
			{
				count = 1;
				player.grenadeTypePrimaryCount = count;
			}
			
			player SetWeaponAmmoStock( item, count );
				
			hasBeenPickedUp = true;	
			break;
		}
		else if ( !IsWeapon( item ) ) // boost stuff
		{

		}
	} while ( !hasBeenPickedUp );
	
	trigger Delete();
	self.s_model Hide();

	self.s_model PlaySound( "mod_oldschool_pickup" );
	
	self thread respawn_item_time( item );
}

function respawn_item_time( item )
{
	self.s_model endon( "delete" );

	self create_base_fx( level._effect[ "flag_base_red" ] );

	wait 5;

	self thread spawn_item_watcher( item );
	self.s_model PlaySound( "mod_oldschool_return" );
}


function spawn_base()
{
	ent = Spawn( "script_model", self.origin );
	ent SetModel( "p7_mp_flag_base" );
	ent SetHighDetail( true );

	return ent;
}
// Equipment Code
function create_equipment()
{
	equipments = Array( "frag_grenade", "hatchet" );
	weapon = GetWeapon( m_array::randomized_selection( equipments ) );

	self.s_model = Spawn( "script_model", self.origin + (0,0,32) );
	self.s_model UseWeaponModel( weapon, weapon.worldModel );
	self.s_model SetHighDetail( true );
	self.s_model set_bob_item();
	self.s_model set_rotate_item();

	self thread spawn_item_watcher( weapon ); 
}
// Boost Code [TomTheBomb from YouTube]
// Re-enable the enhanced movement for the user
function create_boost()
{

}
// Health Code
// Unsure if I want to add this....
function create_health()
{
	// Use Spawn
	// Trigger Thread
}

function create_perk()
{
	perks = Array( "perks" );
	// Use Spawn Ent
	// Determine model
	// Set model
	// trigger thread
}

function create_weapon()
{
	weapons = Array( "ar_standard", "smg_capacity", "lmg_light", "shotgun_precision", "sniper_powerbolt", "pistol_shotgun" );
	weapon = GetWeapon( m_array::randomized_selection( weapons ) );
	
	self.s_model = Spawn( "script_model", self.origin + (0,0,32) );
	self.s_model UseWeaponModel( weapon, weapon.worldModel );
	self.s_model SetHighDetail( true );
	self.s_model set_bob_item();
	self.s_model set_rotate_item();

	self thread spawn_item_watcher( weapon ); 
}

function create_base_fx( fx )
{
	if ( isdefined( self.base.fx ) )
		self.base.fx Delete();

	self.base.fx = SpawnFX( fx, self.origin );
	TriggerFX( self.base.fx, 0.001 );
}

function set_bob_item()
{
	self Bobbing( (0,0,1), PICKUP_BOB_DISTANCE, 1 );
}

function set_rotate_item()
{
	self Rotate( (0,PICKUP_ROTATE_RATE,0) );
}