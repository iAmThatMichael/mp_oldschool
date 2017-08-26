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
		case "mp_spire": // Breach
			break;
		case "mp_sector": // Combine
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
		case "mp_apartments": // Evac
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-1285.69, -1073.02, 1224.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1493.86, -231.744, 1320.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1266.38, 89.742, 1320.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1513.38, 689.122, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1268.54, 1208.19, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-824.035, 1718.5, 1246.21) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1085.64, 2037.62, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1918.81, 1068.03, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1952.88, 318.632, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2556.05, -817.178, 1216.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1929.96, -1191.64, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2164.44, -1904.75, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1583.79, -1532.88, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1191.22, -2578.45, 1271.76) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-403.816, -2450.24, 1345.22) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (227.25, -1695.86, 1344.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (252.666, -1229.08, 1480.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (379.448, -441.254, 1342.54) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-674.044, 331.913, 1472.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (95.2876, 616.44, 1344.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1474.81, 370.222, 1320.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-731.078, 642.133, 1344.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (392.041, -628.9, 1342.71) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1611.39, -433.348, 1320.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (230.985, -828.506, 1480.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-313.815, -1745.64, 1344.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1480.52, -3291.73, 1321.65) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1802.07, -2565.19, 1254.62) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-2168.82, -1544.43, 1312.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-2576.65, -477.171, 1216.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1795.39, 1144.64, 1439.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1456.75, 2201.96, 1315.61) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-264.023, 334.013, 1470.9) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-769.191, -503.448, 1112.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1452.42, -702.895, 1224.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-903.356, -1746.88, 1256.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-743.084, -2285.57, 1272.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (259.141, -1240.96, 1344.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-310.89, -186.291, 1344.87) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1799.75, 919.406, 1439.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-2437.18, -645.861, 1440.32) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1531.6, -2654.79, 1271.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-683.711, -3566.45, 1320.13) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-2858.46, -653.07, 1100.07) ) );
			break;
		case "mp_chinatown": // Exodus
			break;
		case "mp_veiled": // Fringe
			break;
		case "mp_havoc": // Havoc
			break;
		case "mp_ethiopia": // Hunted
			break;
		case "mp_infection": // Infection
			break;
		case "mp_metro": // Metro
			break;
		case "mp_redwood": // Redwood
			break;
		case "mp_stronghold": // Stronghold
			break;
		case "mp_nuketown_x": // Nuk3town
			break;
		/***********DLC1***********/
		case "mp_rise": // Rise
			break;
		case "mp_waterpark": // Splash
			break;
		case "mp_skyjacked": // Skyjacked
			break;
		case "mp_crucible": // Gauntlet
			break;
		/***********DLC2***********/
		case "mp_aerospace": // Spire
			break;
		case "mp_conduit": // Rift
			break;
		case "mp_banzai": // Verge
			break;
		case "mp_kung_fu": // Knockout
			break;
		/***********DLC3***********/
		case "mp_cryogen": // Cryogen
			break;
		case "mp_rally": // Rumble
			break;
		case "mp_rome": // Empire
			break;
		case "mp_shrine": // Berserk
			break;
		/***********DLC4***********/
		case "mp_city": // Rupture
			break;
		case "mp_miniature": // Micro
			break;
		case "mp_ruins": // Citadel
			break;
		case "mp_western": // Outlaw
			break;
		default:
			AssertMsg( "Unsupported map for Old School" );
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
	foreach( point in level.spawnpoints )
	{
		/#
		Print3D( point.origin, point.origin[2], (1,0,0), 1, 1, 100 );
		#/
	}

	foreach( point in self.dev_points )
	{
		/#
		Print3D( point.origin, point.type, (1,1,1), 1, 1, 100 );
		#/
	}
}