#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
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
#precache( "objective", "pickup_item" );
#precache( "string", "MOD_PICK_UP_ITEM" );

#namespace oldschool_items;

function register( name, select, use )
{
	Assert( isdefined( name ) && IsString( name ), "oldschool_items::register: [name] Not a string" );
	Assert( isdefined( select ) && IsFunctionPtr( select ), "oldschool_items::register: [select] Not a function" );
	Assert( isdefined( use ) && IsFunctionPtr( use ), "oldschool_items::register: [us3] Not a function" );

	if ( !isdefined( level.os_item ) )
		level.os_item = [];

	level.os_item[ name ] = SpawnStruct();

	level.os_item[ name ].select_func = select;
	level.os_item[ name ].use_func = use;
}

// ***************************
// Item Spawn Code
// ***************************

function on_use_boost( player )
{
	player IPrintLnBold( "Hello Boost!" );
}

function on_use_equipment( player )
{
	player IPrintLnBold( "Hello Equipment!" );
}

function on_use_health( player )
{
	player IPrintLnBold( "Hello Health!" );
}

function on_use_perk( player )
{
	player IPrintLnBold( "Hello Perk!" );
}

function on_use_weapon( player )
{
	player IPrintLnBold( "Hello Weapon!" );
}

function spawn_obj_trigger( selected )
{
	trigger = Spawn( "trigger_radius", self.origin + (0,0,32), 0, 64, 32 );
	trigger SetCursorHint( "HINT_NOICON" );
	trigger SetHintString( &"MOD_PICK_UP_ITEM", IString( selected.displayname ) );
	trigger TriggerIgnoreTeam();

	return trigger;
}
// self == point
function spawn_item_object()
{
	selected = [[ level.os_item[ self.type ].select_func ]]();

	if ( level.os_random_spawn )
		self.selected = selected;

	trigger = self spawn_obj_trigger( selected );
	visuals = Array( spawn_item( selected ) );

	obj = gameobjects::create_use_object( "neutral", trigger, visuals, (0,0,0), IString("pickup_item") );
	obj gameobjects::allow_use( "any" );
	obj gameobjects::set_use_time( 0 );
	obj gameobjects::set_visible_team( "any" );
	obj gameobjects::set_model_visibility( true );

	obj.onUse = level.os_item[ self.type ].use_func;
	obj.base = self spawn_base();
}


function spawn_items_go( a_spawn_points )
{
	foreach( point in a_spawn_points )
	{
		point.obj = point spawn_item_object();
	}
}

// ***************************
// Spawn Code
// ***************************

function spawn_base( offset = (0,0,0) )
{
	// spawn model although raised
	ent = Spawn( "script_model", self.origin + offset );
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
	trigger TriggerIgnoreTeam();

	return trigger;
}

function spawn_item( selected )
{
	model = Spawn( "script_model", self.origin + (0,0,32) );

	if ( !IsWeapon( selected ) )
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
	self.trigger = spawn_trigger();
	self.trigger SetHintString( &"MOD_PICK_UP_ITEM", IString( item.displayname ) );

	self.model PlaySound( "mod_oldschool_return" );

	while( isdefined( self.trigger ) )
	{
		self.trigger waittill( "trigger", player );

		if ( !IsPlayer( player ) || player IsThrowingGrenade() )
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
				self.trigger Delete();
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
				self.trigger Delete();
			}
		}
		// is a weapon, and has the weapon
		else if ( IsWeapon( item ) && player HasWeapon( item ) )
		{
			if ( !item.isHeroWeapon )
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
			}
			else
			{
				self GiveStartAmmo( item );
				self GadgetPowerSet( 0, 100.0 );
			}
			self.trigger Delete();
		}

		if ( player UseButtonPressed() && !IsWeapon( item ) ) // boost stuff
		{
			switch( item.type )
			{
				case "exo":
				if ( !player.exo_enabled )
				{
					player thread set_exo_for_time( 15 );
					self.trigger Delete();
				}
					break;
				default:
					break;
			}
		}
	}

	self.model PlaySound( "mod_oldschool_pickup" );

	self.model Delete();

	wait( self.respawn_time );

	self thread [[self.create_func]]();
}

// ***************************
// Selection Code
// ***************************

function select_boost()
{
	// Re-enable the enhanced movement for the user [TomTheBomb from YouTube]
	// Spawn a specialist weapon [Dasfonia]
	specialists = Array( "hero_minigun", "hero_lightninggun", "hero_gravityspikes", "hero_armblade", "hero_annihilator", "hero_pineapplegun", "hero_bowlauncher", "hero_chemicalgelgun", "hero_flamethrower" );
	selected = ( math::cointoss() ? GetWeapon( m_array::randomized_selection( specialists ) ) : "exo" );

	if ( selected === "exo" )
	{
		selected = SpawnStruct();
		selected.displayname = "MOD_EXO";
		selected.type = "exo";
		selected.worldModel = MDL_ITEM_EXO;
	}

	return selected;
}

function select_equipment()
{
	equipments = Array( "frag_grenade", "hatchet" );
	selected = GetWeapon( m_array::randomized_selection( equipments ) );

	return selected;
}

function select_health()
{
	selected = SpawnStruct();
	selected.displayname = "MOD_HEALTHPACK";
	selected.type = "health";
	selected.worldModel = MDL_ITEM_HEALTH;

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
