#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_loadout;

// T7ScriptSuite
#using scripts\m_shared\array_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#precache( "fx", FX_FLAG_BASE );
#precache( "fx", FX_FLAG_BASE_GREEN );
#precache( "fx", FX_FLAG_BASE_RED );
#precache( "fx", FX_FLAG_BASE_YELLOW );
#precache( "xmodel", MDL_FLAG_BASE );
#precache( "string", "MOD_PICK_UP_ITEM" );

#namespace oldschool_items;

// ***************************
// Item Spawn Code
// ***************************

function spawn_items( a_spawn_points )
{
	foreach ( point in a_spawn_points )
	{
		point.base = point spawn_base();
		point.trigger = point spawn_trigger();

		switch( point.type )
		{
			case "boost":
				point.create_func = &create_health;
				point thread [[point.create_func]](); // only one requiring thread due to internal wait
				break;
			case "equipment":
				point.create_func = &create_equipment;
				point [[point.create_func]]();
				break;
			case "health":
				point.create_func = &create_health;
				point [[point.create_func]]();
				break;
			case "perk":
				point.create_func = &create_perk;
				point [[point.create_func]]();
				break;
			case "weapon":
				point.create_func = &create_weapon;
				point [[point.create_func]]();
				break;
			default: // should really never get this but whatever
				AssertMsg( "Unknown spawn item type " + point.type );
				break;
		}
	}
}


// ***************************
// Create Code
// ***************************

function create_boost()
{
	selected = select_boost();

	self.model = spawn_item( selected );

	self.respawn_time = RandomIntRange( 1, 5 );

	wait( self.respawn_time ); // wait first spawn of around 10-60 seconds

	self thread spawned_item_pickup( selected );
}
// Equipment Code
function create_equipment()
{
	selected = select_equipment();

	self.model = spawn_item( selected );

	self.respawn_time = 5;

	self thread spawned_item_pickup( selected );
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
	selected = select_weapon();

	self.model = spawn_item( selected );

	self.respawn_time = 5;

	self thread spawned_item_pickup( selected );
}

// ***************************
// Spawn Code
// ***************************

function spawn_base()
{
	ent = Spawn( "script_model", self.origin );
	ent SetModel( MDL_FLAG_BASE );
	ent SetHighDetail( true );

	return ent;
}

function spawn_base_fx( fx )
{
	if ( isdefined( self.base.fx ) )
		self.base.fx Delete();

	self.base.fx = SpawnFX( fx, self.origin );
	TriggerFX( self.base.fx, 0.001 );
}

function spawn_trigger()
{
	trigger = Spawn( "trigger_radius", self.base.origin + (0,0,32), 0, 64, 32 );
	trigger SetCursorHint( "HINT_NOICON" );
	trigger TriggerIgnoreTeam(); // WHY ARE YOU NECESSARY

	return trigger;
}

function spawn_item( selected )
{
	model = Spawn( "script_model", self.origin + (0,0,32) );

	if ( IsWeapon( selected ) )
		model SetModel( selected.worldModel );
	else
		model UseWeaponModel( selected, selected.worldModel );

	model SetHighDetail( true );
	model Hide();
	model set_bob_item();
	model set_rotate_item();

	return model;
}

// ***************************
// Item Pickup Code
// ***************************

// TODO: convert to gameobjects
function spawned_item_pickup( item )
{
	self spawn_base_fx( level._effect[ "flag_base_green" ] );
	self.model Show();

	while( true )
	{
		self.trigger waittill( "trigger", player );

		if ( !IsPlayer( player ) || player IsThrowingGrenade() || ( IsWeapon( item ) && item.isHeroWeapon && player HasWeapon( item ) ) )
			continue;
		// use pressed, is a weapon, and doesn't have the weapon
		if ( player UseButtonPressed() && IsWeapon( item ) && !player HasWeapon( item ) )
		{
			if ( item.inventoryType != "offhand" ) // normal weapon, anything not a grenade
			{
				// weapons have 135 camos, 41 reflex, 41 acog, 34 ir, 41 dualoptic possibilies
				options = player CalcWeaponOptions( RandomInt( 135 ), 0, 0, false, false, false, false );
				if ( !item.isHeroWeapon )
				{
					player TakeWeapon( player take_weapon() );
					player GiveWeapon( item, options );
					player GiveStartAmmo( item );
					if ( !player GadgetIsActive( 0 ) )
						player SwitchToWeapon( item );
				}
				else
				{
					player take_player_gadgets();

					player GiveWeapon( item, options );
					slot = player GadgetGetSlot( item );
					player GadgetPowerSet( slot, 100.0 );
					player thread take_gadget_watcher( slot, item );
				}

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

			break;
		}

		if ( player UseButtonPressed() && !IsWeapon( item ) ) // boost stuff
		{
			switch( item.type )
			{
				case "exo":
				{
					if ( !IS_TRUE( self.exo_enabled ) )
						player thread set_exo_for_time( 15 );
				}
					break;
				default:
					break;
			}

			break;
		}
	}

	self.model PlaySound( "mod_oldschool_pickup" );

	self.trigger Delete();
	self.model Delete();

	self thread [[self.create_func]]();
}

// ***************************
// Selection Code
// ***************************

// Boost Code
// Re-enable the enhanced movement for the user [TomTheBomb from YouTube]
// Spawn a specialist weapon [Dasfonia]
function select_boost()
{
	specialists = Array( "hero_minigun", "hero_lightninggun", "hero_gravityspikes", "hero_armblade", "hero_annihilator", "hero_pineapplegun", "hero_bowlauncher", "hero_chemicalgelgun", "hero_flamethrower" );
	selected = ( math::cointoss() ? GetWeapon( m_array::randomized_selection( specialists ) ) : "exo" );

	if ( selected == "exo" )
	{
		selected = SpawnStruct();
		selected.displayname = "MOD_EXO";
		selected.type = "exo";
		selected.worldModel = "p7_perk_t7_hud_perk_jetcharge";
	}

	return selected;
}

function select_equipment()
{
	equipments = Array( "frag_grenade", "hatchet" );
	selected = GetWeapon( m_array::randomized_selection( equipments ) );

	return selected;
}

function select_perk()
{
	perks = Array( "perks" );
	selected = m_array::randomized_selection( perks );

	return selected;
}

function select_weapon()
{
	weapons = Array( "ar_standard", "smg_capacity", "lmg_light", "shotgun_precision", "sniper_powerbolt", "pistol_shotgun" );
	selected = GetWeapon( m_array::randomized_selection( weapons ) );

	return selected;
}

// ***************************
// Utility Code
// ***************************

function take_weapon()
{
	weapons = self GetWeaponsListPrimaries();

	foreach( weapon in weapons )
	{
		if ( !weapon.isgadget )
			return weapon;
	}
}

function take_player_gadgets()
{
	weapons = self GetWeaponsList( true );
	foreach ( weapon in weapons )
	{
		if ( weapon.isgadget )
			self TakeWeapon( weapon );
	}
}

function take_gadget_watcher( slot, weapon )
{
	self endon( "death" );
	self endon( "disconnect" );

	shouldTake = false;

	while ( true )
	{
		result = self util::waittill_any_return( "weapon_change", "grenade_pullback" );
		// make sure to not do it on equipment
		if ( result == "grenade_pullback" )
		{
			// also because shouldTake would return true for this case make sure to stop it
			shouldTake = false;
			continue;
		}

		if ( shouldTake )
		{
			self TakeWeapon( weapon );
			self GadgetPowerSet( slot, 0.0 );
			break;
		}

		shouldTake = ( self GetCurrentWeapon() === weapon );

		WAIT_SERVER_FRAME;
	}
}


// ***************************
// Model Code
// ***************************
function set_bob_item()
{
	self Bobbing( (0,0,1), PICKUP_BOB_DISTANCE, 1 );
}

function set_rotate_item()
{
	self Rotate( (0,PICKUP_ROTATE_RATE,0) );
}


// ***************************
// Other Code
// ***************************

function set_exo_for_time( time )
{
	self endon( "death" );
	self endon( "disconnect" );

	self.exo_enabled = true;
	self AllowDoubleJump( true );

	wait( time );

	self.exo_enabled = false;
	self AllowDoubleJump( false );
}
