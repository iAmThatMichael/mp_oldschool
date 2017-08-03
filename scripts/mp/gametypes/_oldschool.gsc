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

	return primary_weapon;
}

function spawn_items( a_spawn_points )
{
	foreach ( point in a_spawn_points )
	{

	}
}
// TODO
function create_equipment( point )
{
	equipment = Array( "equipment" );
	// Use Spawn
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
	ent = Spawn( "weapon_" + weapon.rootWeapon.name + "_mp", point.origin + (0,0,64), 3 );
	ent ItemWeaponSetAmmo( weapon.clipSize, weapon.maxAmmo );
}