#using scripts\shared\array_shared;
#using scripts\shared\hud_util_shared;
#using scripts\m_shared\array_shared;
#using scripts\m_shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\mp\gametypes\oldschool.gsh;

#namespace oldschool_points;

function get_spawn_points()
{
	a_spawn_points = [];

	switch( GetDvarString( "mapname" ) )
	{
		case "mp_sector":
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-7.07355, 175.53, 172.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (720.153, -337.304, 145.269) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (146.323, 1112.43, 160.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (177.61, -551.683, 272.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-863.134, 167.878, 108.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (77.9822, -297.351, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (845.322, 1044.05, 156.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-147.212, 1490.85, 142.321) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1128.87, 873.447, 135.255) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1104.75, -680.819, 148.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-69.0299, -882.8, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (506.806, 176.672, 152.803) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-348.214, -1914.77, 155.428) ) );
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

function debug_commands()
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( !isdefined( self.dev_hud ) )
	{
		self.dev_points = [];
		self.dev_points_type = "boost";

		self.dev_hud = [];
		ARRAY_ADD( self.dev_hud, hud::createFontString( "default", 1 ) ); // 0 == addpoint
		ARRAY_ADD( self.dev_hud, hud::createFontString( "default", 1 ) ); // 1 == removepoint
		ARRAY_ADD( self.dev_hud, hud::createFontString( "default", 1 ) ); // 2 == cycle point
		ARRAY_ADD( self.dev_hud, hud::createFontString( "default", 1 ) ); // 3 == print points

		for ( i = 0; i < self.dev_hud.size; i++ )
			self.dev_hud[ i ] hud::setPoint( "TOPLEFT", "TOPLEFT", 10, ( 5 + i ) * 25 );

		self.dev_hud[ 0 ] SetText( "[{+activate}]: Add Current Position" );
		self.dev_hud[ 1 ] SetText( "[{+actionslot 1}]: Remove Last Point: <none>" );
		self.dev_hud[ 2 ] SetText( "[{+actionslot 2}]: Cycle Type: " + self.dev_points_type );
		self.dev_hud[ 3 ] SetText( "[{+actionslot 3}]: Print Points" );
		self.dev_hud[ 3 ] SetText( "[{+actionslot 4}]: Show Points" );
	}

	self thread m_util::button_pressed( &UseButtonPressed, &add_point );
	self thread m_util::button_pressed( &ActionSlotOneButtonPressed, &remove_point );
	self thread m_util::button_pressed( &ActionSlotTwoButtonPressed, &cycle_point );
	self thread m_util::button_pressed( &ActionSlotThreeButtonPressed, &print_points );
	self thread m_util::button_pressed( &ActionSlotFourButtonPressed, &show_points );
}

function add_point()
{
	obj = create_spawn( self.dev_points_type, self.origin );
	ARRAY_ADD( self.dev_points, obj );

	self.dev_hud[ 1 ] SetText( "[{+actionslot 1}]: Remove Last Point: " + obj.type + " " + obj.origin );
}

function remove_point()
{
	if ( self.dev_points.size > 0 )
	{
		array::pop( self.dev_points );

		if ( self.dev_points.size > 0 )
		{
			obj = self.dev_points[ self.dev_points.size - 1];
			self.dev_hud[ 1 ] SetText( "[{+actionslot 1}]: Remove Last Point: " + obj.type + " " + obj.origin );
		}
		else
			self.dev_hud[ 1 ] SetText( "[{+actionslot 1}]: Remove Last Point: <none>" );
	}
}

function cycle_point()
{
	types = Array( "boost", "equipment", "health", "perk", "weapon" );

	self.dev_points_type = m_array::get_next_in_array( types, self.dev_points_type );

	self.dev_hud[ 2 ] SetText( "[{+actionslot 2}]: Cycle Type: " + self.dev_points_type );
}

function print_points()
{
	foreach( point in self.dev_points )
		IPrintLn( "ARRAY_ADD( a_spawn_points, create_spawn( REP" + point.type + "REP, " + point.origin + " ) );" ); // T7 can't do \" escape sequence.
}

function show_points()
{
	foreach( point in self.dev_points )
	{
		/#
		Print3D( point.origin, point.type, (1,0,0), 1, 1, 100 );
		#/
	}
}