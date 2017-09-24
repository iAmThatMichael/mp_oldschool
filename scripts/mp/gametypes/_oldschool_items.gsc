#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\m_shared\array_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#precache( "fx", FX_FLAG_BASE );
#precache( "fx", FX_FLAG_BASE_GREEN );
#precache( "fx", FX_FLAG_BASE_RED );
#precache( "fx", FX_FLAG_BASE_YELLOW );

#precache( "xmodel", MDL_FLAG_BASE );

#precache( "xmodel", MDL_PERK_FLAKJACKET );
#precache( "xmodel", MDL_PERK_FASTHANDS );
#precache( "xmodel", MDL_PERK_GUNGHO );

#precache( "material", MAT_PERK_FLACKJACKET );
#precache( "material", MAT_PERK_FASTHANDS );
#precache( "material", MAT_PERK_GUNGHO );
#precache( "material", MAT_PERK_CHARGER );

#precache( "objective", OBJ_PICKUP_STR );
#precache( "string", LNG_PICKUP_STR );


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
		player thread take_gadget_watcher();
		self disable_obj();
	}
	// is a weapon, and has the weapon
	else if ( IsWeapon( item ) && player HasWeapon( item ) )
	{
		player GiveMaxAmmo( item );
		slot = player GadgetGetSlot( item );
		player GadgetPowerSet( slot, 100.0 );
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

	item = self.selected;
	perks = [];
	perks = StrTok( item.specialty, "|" );

	if ( player UseButtonPressed() && !player HasPerk( perks[0] ) )
	{
		player thread create_perk_hud( item.shader );

		if ( perks.size > 1 )
		{
			foreach ( perk in perks )
				player SetPerk( perk );

			self disable_obj();
		}
		else
		{
			player SetPerk( perks[0] );

			self disable_obj();
		}
	}

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
		// gamedata\weapoons\common\attachmentTable.csv
		// weapons have 135 camos, 41 reflex, 41 acog, 34 ir, 41 dualoptic posibilities
		// ignore the CoDCWL camos because they're really ugly.
		options = player CalcWeaponOptions( ( math::cointoss() ? RandomIntRange( 0, 89 ) : RandomIntRange( 118, 135 ) ), 0, 0, false, false, false, false );

		player take_next_weapon();
		player GiveWeapon( item, options );
		player GiveStartAmmo( item );

		if ( !player has_active_gadget() )
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
	trigger = Spawn( "trigger_radius_use", self.origin + (0,0,32), 0, 32, 32 );
	trigger SetCursorHint( "HINT_NOICON" );
	trigger SetHintString( IString( LNG_PICKUP_STR ), IString( selected.displayname ) );
	trigger TriggerIgnoreTeam();
	trigger UseTriggerRequireLookAt();

	return trigger;
}
// self == point
function spawn_item_object( respawn = false )
{
	selected = [[ level.os_item[ self.type ].select_func ]]();

	trigger = self spawn_obj_trigger( selected );
	visuals = Array( spawn_item( selected ) );

	obj = gameobjects::create_use_object( "neutral", trigger, visuals, (0,0,0), IString( OBJ_PICKUP_STR ) );
	obj gameobjects::set_use_time( 0 );
	obj gameobjects::set_visible_team( "any" );

	obj gameobjects::allow_use( "any" );
	obj gameobjects::set_model_visibility( true );

	obj.onUse = level.os_item[ self.type ].use_func;
	obj.selected = selected;
	obj.respawn_time = level.os_item[ self.type ].respawn_time;
	obj.point = self;
	obj.point.base = ( !respawn ? self spawn_base() : self.base );
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

function spawn_items( a_spawn_points )
{
	array::thread_all( a_spawn_points, &spawn_item_object );
}

// ***************************
// Obj Code
// ***************************

function disable_obj()
{
	self.point.base spawn_base_fx( FX_FLAG_BASE_RED );
	self PlaySound( "mod_oldschool_pickup" );

	self gameobjects::disable_object();
	self gameobjects::allow_use( "none" );
	self gameobjects::set_model_visibility( false );
}

function enable_obj()
{
	self.point.base spawn_base_fx( FX_FLAG_BASE_YELLOW );
	self PlaySound( "mod_oldschool_return" );

	self gameobjects::enable_object();
	self gameobjects::allow_use( "any" );
	self gameobjects::set_model_visibility( true );
}

function respawn_obj()
{
	wait self.respawn_time;

	if ( level.item_spawns_random )
	{
		self gameobjects::destroy_object( true );
		self.point spawn_item_object( true );
		self.point.base spawn_base_fx( FX_FLAG_BASE_YELLOW );
		self PlaySound( "mod_oldschool_return" );
	}
	else
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
	selected = ( RandomInt(100) >= 20 ? GetWeapon( m_array::randomized_selection( specialists ) ) : "exo" );

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
	perks = Array( "flakjacket", "fasthands", "gungho" );
	selected = m_array::randomized_selection( perks );
	// TODO: replace by tablelookup modular code
	switch( selected )
	{
		case "flakjacket":
			selected = SpawnStruct();
			selected.displayname = "PERKS_FLAK_JACKET";
			selected.shader = MAT_PERK_FLACKJACKET;
			selected.specialty = "specialty_flakjacket";
			selected.worldModel= MDL_PERK_FLAKJACKET;
		break;

		case "fasthands":
			selected = SpawnStruct();
			selected.displayname = "PERKS_FAST_HANDS";
			selected.shader = MAT_PERK_FASTHANDS;
			selected.specialty = "specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery";
			selected.worldModel= MDL_PERK_FASTHANDS;
		break;

		case "gungho":
			selected = SpawnStruct();
			selected.displayname = "PERKS_GUNG_HO";
			selected.shader = MAT_PERK_GUNGHO;
			selected.specialty = "specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment";
			selected.worldModel= MDL_PERK_GUNGHO;
		break;
	}

	return selected;
}

function select_weapon()
{
	weapons = Array( "ar_standard", "smg_capacity", "lmg_light", "shotgun_precision", "sniper_powerbolt", "pistol_burst", "launcher_standard" );
	dlc_weapons = Array( "ar_an94", "smg_msmc", "lmg_infinite", "shotgun_olympia", "sniper_double", "pistol_shotgun", "special_crossbow" );

	selected = GetWeapon( m_array::randomized_selection( ( math::cointoss() ? weapons: dlc_weapons ) ) );

	return selected;
}

// ***************************
// Utility Code
// ***************************

function has_active_gadget()
{
	weapons = self GetWeaponsList( true );
	foreach ( weapon in weapons )
	{
		if ( !weapon.isgadget )
			continue;

		if ( !weapon.isheroweapon && weapon.offhandslot !== "Gadget" )
			continue;

		slot = self GadgetGetSlot( weapon );
		if ( self GadgetIsActive( slot ) )
			return true;
	}

	return false;
}

function take_next_weapon()
{
	weapons = self GetWeaponsList( true );
	weapon = self GetCurrentWeapon();

	if ( weapon.isheroweapon || weapon.isgadget )
		weapon = m_array::get_next_in_array( weapons, weapon );

	self TakeWeapon( weapon );
}

function take_player_gadgets()
{
	weapons = self GetWeaponsList( true );
	foreach ( weapon in weapons )
	{
		if ( weapon.isgadget )
		{
			self TakeWeapon( weapon );
			self GadgetPowerSet( self GadgetGetSlot( weapon ), 0.0 );
		}
	}
}

function take_gadget_watcher()
{
	self endon( "death" );
	self endon( "disconnect" );

	self notify( "watcherGadgetActivated_singleton" );
	self endon ( "watcherGadgetActivated_singleton" );

	self waittill( "heroAbility_off", weapon );
	self GadgetPowerSet( self GadgetGetSlot( weapon ) , 0.0 );
	self TakeWeapon( weapon );
}

function set_exo_for_time( time )
{
	self endon( "death" );
	self endon( "disconnect" );

	self.exo_enabled = true;
	self AllowDoubleJump( true );

	self thread create_perk_hud( MAT_PERK_CHARGER );
	// DESIGN: keep it forever as per feedback
	//wait( time );

	//self.exo_enabled = false;
	//self AllowDoubleJump( false );
}

function set_bob_item()
{
	self Bobbing( (0,0,1), PICKUP_BOB_DISTANCE, 1 );
}

function set_rotate_item()
{
	self Rotate( (0,PICKUP_ROTATE_RATE,0) );
}

function create_perk_hud( shader )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( !isdefined( self.os_perk_hud ) )
		self.os_perk_hud = [];

	const ICONSIZE = 32;
	index = self.os_perk_hud.size;
	ypos = -30 - ( 30 * index );
	xpos = 220;

	hud = hud::createIcon( shader , ICONSIZE, ICONSIZE );
	hud hud::setPoint( "BOTTOM LEFT", "BOTTOM LEFT", xpos, ypos );
	hud.horzalign = "user_left";
	hud.vertalign = "user_bottom";
	hud.archived = false;
	hud.foreground = false;
	hud.hidewheninmenu = true;
	hud.immunetodemogamehudsettings = true;

	ARRAY_ADD( self.os_perk_hud, hud );

	self thread destroy_perk_hud( index );

}

function destroy_perk_hud( index )
{
	self util::waittill_any_ents( self, "death", self, "disconnect", level, "game_ended" );

	if ( isdefined( self.os_perk_hud[ index ] ) )
	{
		self.os_perk_hud[ index ] Destroy();
		ArrayRemoveIndex( self.os_perk_hud, index );
	}
}