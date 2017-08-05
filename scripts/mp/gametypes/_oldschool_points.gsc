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

#using scripts\mp\gametypes\_oldschool;

// T7 Script Suite
#insert scripts\m_shared\utility.gsh;
T7_SCRIPT_SUITE_INCLUDES
#insert scripts\m_shared\lui.gsh;
#insert scripts\m_shared\bits.gsh;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#namespace oldschool_points;
// TODO - Cleanup & Convert to objects/struct
function get_spawn_points()
{
	a_spawn_points = [];

	switch( level.script )
	{
		case "mp_sector":
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (631.194, -289.895, 146.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (757.876, -265.068, 146.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (690.704, -645.807, 146.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (767.606, -645.418, 152.545) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (698.528, -756.297, 146.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (687.746, -856.747, 146.125) ) );
			break;
		default:
			break;
	}

	return a_spawn_points;
}

function create_spawn( type, origin )
{
	s = SpawnStruct();
	s.type = type;
	s.origin = origin;
	return s;
}

//	******************************
//	DEBUG
//	******************************
// TODO - Add to HUD
function debug_commands()
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( !self IsHost() )
		return;

	while ( true )
	{
		// +activate -- ADD POINT
		if ( self UseButtonPressed() )
		{
			self add_point();
			while ( self UseButtonPressed() )
				WAIT_SERVER_FRAME;
		}
		// +actionslot 1 -- REMOVE POINT
		else if ( self ActionSlotOneButtonPressed() )
		{
			self remove_point();
			while ( self ActionSlotOneButtonPressed() )
				WAIT_SERVER_FRAME;
		}
		// +actionslot 2 -- CYCLE POINT TYPE
		else if ( self ActionSlotTwoButtonPressed() )
		{
			self cycle_point();
			while ( self ActionSlotTwoButtonPressed() )
				WAIT_SERVER_FRAME;
		}
		// +actionslot 3 -- PRINT POINTS
		else if ( self ActionSlotThreeButtonPressed() )
		{
			self print_points();
			while ( self ActionSlotThreeButtonPressed() )
				WAIT_SERVER_FRAME;
		}
		WAIT_SERVER_FRAME;
	}
}

function add_point()
{
	obj = create_spawn( level.dev_points_type, self.origin );
	ARRAY_ADD( level.dev_points, obj );
	IPrintLn( "Adding Type: " + obj.type + " at " + obj.origin );
}

function remove_point()
{
	array::pop( level.dev_points );
}

function cycle_point()
{
	types = Array( "equipment", "health", "perk", "weapon" );
	level.dev_points_type = m_array::get_next_in_array( types, level.dev_points_type );
	IPrintLn( "Now placing type: " + level.dev_points_type );
}

function print_points()
{
	foreach( point in level.dev_points )
		IPrintLn( "ARRAY_ADD( a_spawn_points, create_spawn( REP" + point.type + "REP, " + point.origin + " ) );" ); // T7 can't do \" escape sequence.
}