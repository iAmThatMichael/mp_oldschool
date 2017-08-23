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
		case "mp_biodome": // Aquarium
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1680.53, 732.833, 174.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1940.82, 1481.71, 174.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2258.92, 1284.45, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2560.52, 493.627, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1654.97, 299.79, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1692.56, 1133.86, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1382.72, 1642.06, 142.648) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-48.3978, 1243.45, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (654.663, 1160.99, 136.625) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (308.328, 268.221, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-663.105, 203.361, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2177.63, 846.301, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2357.04, 1467.94, 200.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-937.394, 2223.43, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (314.894, 2382.62, 232.207) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-731.823, 2194.62, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1741.95, 2046.24, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1022.17, 1245.89, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-735.165, 1286.86, 232.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-21.6491, 1636.48, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-361.204, 1439.44, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-292.502, 741.158, 104.125) ) );
		break;
		case "mp_sector": // Breach
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
		ARRAY_ADD( self.dev_hud, hud::createFontString( "default", 1 ) ); // 4 == show points

		for ( i = 0; i < self.dev_hud.size; i++ )
			self.dev_hud[ i ] hud::setPoint( "TOPLEFT", "TOPLEFT", 10, ( 5 + i ) * 25 );

		self.dev_hud[ 0 ] SetText( "[{+activate}]: Add Current Position" );
		self.dev_hud[ 1 ] SetText( "[{+actionslot 1}]: Remove Last Point: <none>" );
		self.dev_hud[ 2 ] SetText( "[{+actionslot 2}]: Cycle Type: " + self.dev_points_type );
		self.dev_hud[ 3 ] SetText( "[{+actionslot 3}]: Print Points" );
		self.dev_hud[ 4 ] SetText( "[{+actionslot 4}]: Show Points" );
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
		Print3D( point.origin, point.type, (1,1,1), 1, 1, 100 );
		#/
	}
}