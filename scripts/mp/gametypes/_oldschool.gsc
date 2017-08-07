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

#using scripts\mp\gametypes\_oldschool_points;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#namespace oldschool;

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
	oldschool_items::spawn_items( oldschool_points::get_spawn_points() );
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
    self.exo_enabled = false;

	while ( !self.exo_enabled )
	{
		self SetDoubleJumpEnergy( 0 );
		self ResetDoubleJumpRechargeTime();
		WAIT_SERVER_FRAME;
	}
}
