#using scripts\shared\callbacks_shared;
#using scripts\mp\gametypes\_oldschool_items;
#using scripts\mp\gametypes\_oldschool_points;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#namespace oldschool;

function autoexec init()
{
	if ( !IsInArray( Array( "tdm", "dm", "clean", "conf" ), ToLower( GetDvarString( "g_gametype" ) ) ) )
		return;

	level.giveCustomLoadout = &give_custom_loadout;

	callback::on_connect( &on_player_connect ); // force teams on connecting
	callback::on_spawned( &on_player_spawned ); // extra code on spawning
	callback::on_start_gametype( &start_gametype );

	SetJumpHeight( 64 ); // stock is 39?

	level oldschool_items::register( "boost", &oldschool_items::select_boost, &oldschool_items::on_use_boost, RandomIntRange( 1, 5 ) );
	level oldschool_items::register( "equipment", &oldschool_items::select_equipment, &oldschool_items::on_use_equipment, 5 );
	level oldschool_items::register( "health", &oldschool_items::select_health, &oldschool_items::on_use_health, 5 );
	level oldschool_items::register( "perk", &oldschool_items::select_perk, &oldschool_items::on_use_perk, 5 );
	level oldschool_items::register( "weapon", &oldschool_items::select_weapon, &oldschool_items::on_use_weapon, 5 );
}

function start_gametype()
{
	oldschool_items::spawn_items( oldschool_points::get_spawn_points() );
	level thread on_end_gametype();
}

function on_player_connect()
{
	// pre-set the persistence to something so we prevent some errors related to menuTeam();
	// --- WARNING: Setting this will break ESC menu
	// --- ERROR: By disabling this healing will not work anymore.
	self.pers["team"] = "free";
	// moving to a built-in, still setting a team just in case.
	self SetTeam( "free" );
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

	primary_weapon = GetWeapon( "smg_standard" );
	secondary_weapon = GetWeapon( "pistol_standard" );

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

function on_end_gametype()
{
	level waittill( "game_ended" );

	IPrintLn("Old School brought to you by: ^3DidUknowiPwn");
	IPrintLn("^1YouTube^7: iPwnAtZombies, ^5Twitter^7: iAmThatMichael");
	IPrintLn("Check out ^1UGX-Mods.com^7 for more mods!");
}