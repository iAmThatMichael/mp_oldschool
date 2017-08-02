#using scripts\codescripts\struct;
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

#using scripts\mp\gametypes\_oldschool;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#namespace oldschool_points;

function get_spawn_points()
{
	a_spawn_points = [];
	a_spawn_points[ level.script ] = [];

	switch( level.script )
	{
		case "mp_sector":
			ARRAY_ADD( a_spawn_points[ "mp_sector" ], (0,0,0) );
			ARRAY_ADD( a_spawn_points[ "mp_sector" ], (0,0,100) );
			break;
		default:
			break;
	}

	return a_spawn_points[ level.script ];
}