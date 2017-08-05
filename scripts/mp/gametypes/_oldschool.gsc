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

function autoexec init()
{
	if ( !IsInArray( Array( "tdm", "dm" ), ToLower( GetDvarString( "g_gametype" ) ) ) )
		return;

	level.dev_points = [];
	level.dev_points_type = "equipment";
	level.giveCustomLoadout = &give_custom_loadout;

	callback::on_connect( &on_player_connect ); // force teams on connecting
	callback::on_spawned( &on_player_spawned ); // extra code on spawning
	callback::on_start_gametype( &start_gametype );
}

function start_gametype()
{
	//thread weapon_hack();
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
	self thread oldschool_points::debug_commands();
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

function spawn_items( a_spawn_points )
{
	foreach ( point in a_spawn_points )
	{
		//( "equipment", "health", "perk", "weapon" );
		switch( point.type )
		{
			case "equipment":
				create_equipment( point );
				break;
			case "health":
				create_health( point );
				break;
			case "perk":
				create_perk( point );
				break;
			case "weapon":
				create_weapon( point );
				break;
			default: // should really never get this but whatever
				AssertMsg( "Unknown spawn type " + point.type + " for oldschool!" );
				break;
		}
	}
}
function spawn_base( point )
{
	ent = Spawn( "script_model", point.origin );
	ent SetModel( "p7_mp_flag_base" );
	ent SetHighDetail( true );
}
// TODO
function create_equipment( point )
{
	equipments = Array( "frag_grenade", "hatchet" );

	weapon = GetWeapon( m_array::randomized_selection( equipments ) );
	ent = Spawn( "script_model", point.origin + (0,0,64) );
	ent UseWeaponModel( weapon, weapon.worldModel );
	ent SetHighDetail( true );

	ent thread spawned_item_watcher( weapon ); 
}

function create_health( point )
{
	// Use Spawn
	// Trigger Thread
}

function create_perk( point )
{
	perks = Array( "perks" );
	// Use Spawn Ent
	// Grab model type
	// Set model type
	// trigger thread
}

function create_weapon( point )
{
	weapons = Array( "ar_standard", "smg_capacity", "lmg_light", "shotgun_precision", "sniper_powerbolt", "pistol_shotgun" );
	weapon = GetWeapon( m_array::randomized_selection( weapons ) );
	
	ent = Spawn( "script_model", point.origin + (0,0,24) );
	ent UseWeaponModel( weapon, weapon.worldModel );
	ent SetHighDetail( true );

	ent thread spawned_item_watcher( weapon ); 
}

function spawned_item_watcher( item )
{
	self endon( "delete" );

	self Show();
	trigger = Spawn( "trigger_radius", self.origin, 0, 32, 32 );
	trigger SetCursorHint( "HINT_NOICON" );
	trigger TriggerIgnoreTeam(); // WHY ARE YOU NECESSARY
	trigger SetHintString( &"MOD_PICK_UP_ITEM", IString( item.displayname ) );
	hasBeenPickedUp = false;
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
			if ( !item.isgrenadeweapon ) // normal weapon, anything not a grenade
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
			if ( !item.isgrenadeweapon )
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
	self Hide();
	
	self thread respawn_item_time( 5, item );
}

function respawn_item_time( time, item )
{
	self endon( "delete" );
	IPrintLn( "Respawning item in " + time );

	wait time;
	IPrintLnBold( "Respawned Item" );
	self thread spawned_item_watcher( item );
}