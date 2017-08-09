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

function register( name, select, use, respawn_time )
{
	Assert( isdefined( name ) && IsString( name ), "oldschool_items::register: [name] Not a string" );
	Assert( isdefined( select ) && IsFunctionPtr( select ), "oldschool_items::register: [select] Not a function" );
	Assert( isdefined( use ) && IsFunctionPtr( use ), "oldschool_items::register: [use] Not a function" );
	Assert( isdefined( respawn_time ) && respawn_time > 0, "oldschool_items::register: [respawn_time] Not a number" );

	if ( !isdefined( level.os_item ) )
		level.os_item = [];

	level.os_item[ name ] = SpawnStruct();

	level.os_item[ name ].select_func = select;
	level.os_item[ name ].use_func = use;
	level.os_item[ name ].respawn_time = Int( respawn_time );
}

// ***************************
// Item Func Code
// ***************************

function on_use_boost( player )
{
	if ( player IsThrowingGrenade() )
		return;

	item = self.selected;

	// use pressed, is a weapon, and doesn't have the weapon
	if ( player UseButtonPressed() && IsWeapon( item ) && !player HasWeapon( item ) )
	{
		player take_player_gadgets();

		player GiveWeapon( item );
		slot = player GadgetGetSlot( item );
		player GadgetPowerSet( slot, 100.0 );
		player thread take_gadget_watcher( slot, item );
		self disable_obj();
	}
	// is a weapon, and has the weapon
	else if ( IsWeapon( item ) && player HasWeapon( item ) )
	{
		player GiveStartAmmo( item );
		player GadgetPowerSet( 0, 100.0 );
		self disable_obj();
	}
	// use pressed, isn't a weapon
	if ( player UseButtonPressed() && !IsWeapon( item ) )
	{
		switch( item.type )
		{
			case "exo":
			if ( !player.exo_enabled )
			{
				player thread set_exo_for_time( 15 );
				self disable_obj();
			}
				break;
			default:
				break;
		}
	}

	if ( !self gameobjects::is_trigger_enabled() )
		self thread respawn_obj();
}

function on_use_equipment( player )
{
	if ( player IsThrowingGrenade() )
		return;

	item = self.selected;

	if ( player UseButtonPressed() && !player HasWeapon( item ) )
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
		self disable_obj();
	}
	// is a weapon, and has the weapon
	else if ( player HasWeapon( item ) )
	{
		stock = player GetWeaponAmmoStock( item );
		maxAmmo = item.maxAmmo;
		// has max ammo don't do anything
		if ( stock == maxAmmo )
			return;

		count = 1;
		player.grenadeTypePrimaryCount = 1;

		player SetWeaponAmmoStock( item, count );

		self disable_obj();
	}

	if ( !self gameobjects::is_trigger_enabled() )
		self thread respawn_obj();
}

function on_use_health( player )
{
	//if ( player IsThrowingGrenade() )
	//	return;

	player IPrintLnBold( "Hello Health!" );

	if ( !self gameobjects::is_trigger_enabled() )
		self thread respawn_obj();
}

function on_use_perk( player )
{
	//if ( player IsThrowingGrenade() )
	//	return;

	player IPrintLnBold( "Hello Perk!" );

	if ( !self gameobjects::is_trigger_enabled() )
		self thread respawn_obj();
}

function on_use_weapon( player )
{
	if ( player IsThrowingGrenade() )
		return;

	item = self.selected;

	if ( player UseButtonPressed() && !player HasWeapon( item ) )
	{
		// weapons have 135 camos, 41 reflex, 41 acog, 34 ir, 41 dualoptic possibilies
		options = player CalcWeaponOptions( RandomInt( 135 ), 0, 0, false, false, false, false );

		player TakeWeapon( player take_weapon() );
		player GiveWeapon( item, options );
		player GiveStartAmmo( item );

		if ( !player GadgetIsActive( 0 ) )
			player SwitchToWeapon( item );

		self disable_obj();
	}
	// is a weapon, and has the weapon
	else if ( player HasWeapon( item ) )
	{
		stock = player GetWeaponAmmoStock( item );
		maxAmmo = item.maxAmmo;
		// has max ammo don't do anything
		if ( stock == maxAmmo )
			return;

		count = ( stock + item.clipSize <= maxAmmo ? stock + item.clipSize : maxAmmo );
		player SetWeaponAmmoStock( item, count );

		self disable_obj();
	}

	if ( !self gameobjects::is_trigger_enabled() )
		self thread respawn_obj();
}

// ***************************
// Item Spawn Code
// ***************************

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

	trigger = self spawn_obj_trigger( selected );
	visuals = Array( spawn_item( selected ) );

	obj = gameobjects::create_use_object( "neutral", trigger, visuals, (0,0,0), IString("pickup_item") );
	obj gameobjects::set_use_time( 0 );
	obj gameobjects::set_visible_team( "any" );

	obj gameobjects::allow_use( "any" );
	obj gameobjects::set_model_visibility( true );

	obj.onUse = level.os_item[ self.type ].use_func;
	obj.base = self spawn_base();
	obj.selected = selected;
	obj.respawn_time = level.os_item[ self.type ].respawn_time;
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

function spawn_base( offset = (0,0,0) )
{
	ent = Spawn( "script_model", self.origin + offset );
	ent SetModel( MDL_FLAG_BASE );
	ent SetHighDetail( true );

	ent spawn_base_fx( FX_FLAG_BASE_YELLOW );
	return ent;
}

function spawn_base_fx( fx )
{
	if ( isdefined( self.fx ) )
		self.fx Delete();

	self.fx = SpawnFX( fx, self.origin );
	TriggerFX( self.fx, 0.001 );
}

function spawn_items_go( a_spawn_points )
{
	foreach( point in a_spawn_points )
	{
		point.obj = point spawn_item_object();
	}
}

// ***************************
// Obj Code
// ***************************

function disable_obj()
{
	self.base spawn_base_fx( FX_FLAG_BASE_RED );
	self PlaySound( "mod_oldschool_pickup" );

	self gameobjects::disable_object();
	self gameobjects::allow_use( "none" );
	self gameobjects::set_model_visibility( false );
}

function enable_obj()
{
	self.base spawn_base_fx( FX_FLAG_BASE_YELLOW );
	self PlaySound( "mod_oldschool_return" );

	self gameobjects::enable_object();
	self gameobjects::allow_use( "any" );
	self gameobjects::set_model_visibility( true );
}

function respawn_obj()
{
	wait self.respawn_time;

	self enable_obj();
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