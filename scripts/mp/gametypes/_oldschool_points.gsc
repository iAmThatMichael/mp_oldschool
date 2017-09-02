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
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (2886.89, -129.122, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2862.67, -1105.3, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (3698.08, -1558.81, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (3954.01, -1104.17, -6.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (4593.59, -39.5819, 0.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (5673.43, 818.884, 0.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (4369.76, 1138.47, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (3934.94, 1289.35, 88.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (5003.13, 1327.87, 0.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2803.35, 1159.39, 64.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1998.42, 773.087, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2879.99, 1533.58, 62.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1398.69, 779.663, 208.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (98.2153, 252.686, 32.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (826.61, -653.539, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1591.37, -701.79, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2002.89, -1580.07, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2859.53, -1772.77, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (3416.27, -1764.11, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (2870.34, -536.559, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1649.21, 480.233, 72.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (2050.88, 300.032, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1473.65, 242.092, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1468.04, -43.0001, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1657.06, 737.686, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (3443.13, -429.386, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (3722.58, -703.731, 136.077) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (4254.82, -248.512, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (3831.64, 344.542, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (4756.11, 413.382, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (4835.16, 618.597, -5.6143) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (4427.1, 723.641, -3.54869) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (4207.69, 1177.93, 88.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (3329.03, 1481.61, 56.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (2476.85, 1396.49, 56.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1784.64, 28.0181, 0.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1164.97, 82.0362, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1258.78, 905.443, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (496.129, -650.669, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2410.49, -1611.24, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (3116.36, -1297.07, -63.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (3743.07, -1390.88, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (4625.68, -728.583, 0.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (4884.97, 1004.37, -6.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (3919.03, 781.93, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1392.66, -363.426, -54.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2882.42, -88.8595, 127.125) ) );
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
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (66.0218, -2.21868, 105.077) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1175.13, -2165.51, 14.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-178.941, -1858.29, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (642.738, -2174.38, 32.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1053.95, -1293.66, 64.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (33.2075, -866.332, 0.124998) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1174.99, -1232.04, 40.4218) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-453.274, 1.81476, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1221.27, -2.26758, 120.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (79.2786, 852.773, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-846.329, 1634.06, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-858.698, 2917.11, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-113.875, 2644.09, 40.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (880.395, 1728.93, 83.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1591.04, 956.742, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-142.879, -2406.29, 56.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-393.839, -1791.79, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1088, -738.903, -49.4427) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1204.05, 881.565, 9.79072) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-119.379, 1708.67, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1248.61, 1878.79, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-216.601, -446.251, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (62.1513, -1980.87, 16.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-938.175, -1569.67, 9.26574) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (655.328, -241.993, 144.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-245.785, 453.282, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1459.03, 1236.37, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (351.438, 2832.61, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1204.39, -21.0632, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1284.98, -7.28554, 0.125) ) );
			break;
		case "mp_veiled": // Fringe
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-66.2085, 35.6862, -20.8477) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2212.24, 588.882, 48.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1423.22, 114.948, 12.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1568.88, 550.322, 12.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (509.186, 1345.36, 4.06829) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (164.691, 603.608, 16.1249) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1411.15, -546.774, 10.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-221.778, -522.817, -19.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1282.53, -947.411, -15.7909) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1394.95, -162.114, 104.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1644.42, 924.435, -27.0511) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-604.134, 345.12, -14.3224) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-629.739, -479.558, -22.2541) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1128.97, 1830.46, 1.82954) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1671.66, 690.464, 12.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (918.818, -204.033, -2.0441) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (192.47, -1115.88, 8.58167) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-480.634, 264.628, -24.589) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-591.898, 679.89, 4.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1109.94, 890.202, -1.43931) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-628.61, -1116.49, -10.4641) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1170.04, 601.576, -9.84828) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-973.276, -439.626, 20.0578) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-244.003, -985.956, -19.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1863.75, -1827.47, -16.1583) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1554.97, -288.636, -31.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (493.151, 778.135, -13.2936) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2399.26, 1100.54, 52.625) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2195.79, -343.774, 48.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1082.96, -1055.51, 10.125) ) );
			break;
		case "mp_havoc": // Havoc
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (87.0042, 185.815, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1419.26, -794.373, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2050.95, 1069.8, 39.9481) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1763.6, -125.597, -55.2213) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-25.9299, 1455.63, -15.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-13.2771, -1555.57, 13.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2172.46, 920.616, -15.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2739.52, -20.068, -101.324) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1896.55, -1307.41, 17.3776) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (786.93, -58.0515, 8.18777) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1098.24, 596.528, -16.3358) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-473.266, -293.117, 10.9706) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-2265.79, -306.922, -51.1894) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1032.45, 1182.84, -17.1207) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1197.08, -692.727, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1.24708, -582.918, 136.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-754.34, -1353.74, 72.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (756.901, -1347.77, 72.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1999.37, -777.838, 96.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1816.69, -103.636, -75.8281) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1037.71, -507.261, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1835.59, -1155.79, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1415.64, 218.302, -50.5785) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (736.599, 2212.36, -253.08) ) );
			break;
		case "mp_ethiopia": // Hunted
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (202.795, -1194, 32.9559) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (3132.46, -1659.48, 32.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2228.91, -811.779, -142.826) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (2720.93, -426.216, -34.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1192.32, 698.142, -243.894) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1406.75, -169.621, -69.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-726.47, 490.322, -207.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1937.68, 516.926, -71.3985) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-3065.85, 1065.46, -39.8632) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-2543.92, -218.695, -19.0637) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1566.49, -744.896, -45.0422) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1026.8, -1682.29, 35.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-357.496, -2271.57, 8.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-138.177, -1231.61, -225.589) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (818.794, -286.71, -197.192) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (358.41, -12.6611, -31.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (201.298, -982.611, 144.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1637.79, -180.113, -67.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (2069.46, 719.155, -191.113) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (3274.75, -581.45, -120.235) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-2115.7, -564.335, -45.0702) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-931.143, 1088.31, -383.457) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-824.513, -271.914, -159.146) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-744.801, -1480.2, 46.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (309.241, 264.614, -217.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-472.454, 906.263, -383.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (688.303, -2063.57, -3.45105) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (927.781, -1192.18, 34.4701) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2065.8, -88.255, -210.726) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (2663.71, -1417.53, -101.862) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1308.31, -722.075, -21.7655) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-2636.8, -556.515, 111.125) ) );
			break;
		case "mp_infection": // Infection
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-390.325, -106.299, 2.63425) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (428.158, 993.159, 62.7113) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (487.048, 1999.53, 75.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1078.96, 2265.24, 88.5639) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (665.637, 3058.81, 177.517) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (23.9746, 2510.31, 132.614) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-747.65, 1713.81, 104.89) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (186.636, -3565.91, -8.03608) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (63.8863, -2286.57, 6.24404) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-636.182, -2657.65, 22.3432) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-308.589, -1853.39, 3.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (722.415, -1806.99, -1.10026) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1412.73, -1472.23, -10.374) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1135.47, -2800.24, -28.3263) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1960.55, -1355.01, 103.126) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (147.788, -1327.41, 1.7796) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-380.674, -1999.26, 8.63682) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1215.22, -1706.77, 97.625) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-662.839, -1057.25, -5.84838) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-166.824, 937.671, 64.075) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-351.221, 1709.4, 95.763) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (576.902, 1449.08, 75.2689) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1503.57, 2009.35, 83.5012) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1474.01, 1009.27, 79.173) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (853.974, -259.498, 76.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (202.282, 170.013, 7.6372) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (680.126, 725.993, 53.8836) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (874.765, 1966.89, 92.6437) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-712.675, 856.12, 74.4875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (79.9379, -888.119, 7.90828) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (129.943, -2896.09, -6.05446) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1299.77, -2157.67, -3.78416) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1008.54, -1476.56, 22.9129) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (78.7865, 1316.06, 68.125) ) );
			break;
		case "mp_metro": // Metro
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-408.102, -0.252975, -47.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (314.539, -722.385, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-288.017, -1254.49, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-71.3802, -1828.61, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1326.61, -1939.1, -47.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-598.69, -2740.61, -47.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1413.18, 9.41258, -207.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-283.144, 1268.36, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (354.051, 608.641, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (74.4122, 2413.92, -39.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1358.05, 1919.51, -47.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (558.535, -4.20616, -47.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1002.59, -441.841, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1184.16, -1181.32, -151.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (19.2364, -2424.87, -39.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (860.431, -710.496, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-522.717, -412.719, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-606.185, 2442.68, -39.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (853.673, 644.128, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1153.08, 520.989, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1203.62, 1169.86, -151.75) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-532.016, 417.821, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-134.468, -1017.93, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-633.851, -2413.88, -39.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1286.86, -2795.12, -55.5602) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-675.672, -1300.48, -120.253) ) );
			break;
		case "mp_redwood": // Redwood
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (-486.858, -233.987, 42.2371) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (179.52, -2429.17, 178.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (961.176, -2125.3, 167.558) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1272.07, -2912.09, 196.448) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (440.498, -740.263, 174.817) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-217.141, -51.1045, 205.881) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-937.962, 262.02, 61.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-166.511, 2008.45, 49.148) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (341.692, 1969.33, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (626.116, 1640.22, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-329.75, 1230.66, 59.6312) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-963.247, -1138.78, 157.375) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1591.79, 1110.68, 208.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1556.53, -778.073, 207.625) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1851.32, -730.962, 207.625) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (996.565, 1506.37, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-158.698, 2974.8, 40.9854) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-285.931, -853.716, 114.802) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-304.766, -1677.35, 161.915) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1158.47, -1701.61, 151.752) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1960.92, 192.263, 264.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (956.58, 1912.55, 152.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (10.9268, 1478.48, 75.7481) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-0.545879, 49.5331, 70.4428) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1017.99, 117.708, 181.125) ) );
			break;
		case "mp_stronghold": // Stronghold
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (663.413, -43.7484, -33.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (322.279, 1455.84, 80.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1565.84, 1034.04, 80.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1556.1, 131.49, 120.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1932.86, -580.466, 33.9594) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1174.77, -2639.44, -123.65) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (785.422, -1977.53, -25.2202) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-179.468, -2306.68, -128.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (232.519, -1931.63, 0.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-602.904, -1282.03, -125.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-26.419, -339.278, -31.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-558.411, 32.2615, 128.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-953.625, 1007.76, 128.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (872.417, 2270.92, 80.8988) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (176.496, 157.237, 128.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-289.197, -77.4019, 128.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (14.6782, -1080.68, -66.4708) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1493.77, -562.95, 24.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-100.37, -2612.85, 0.287271) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (623.607, -3527.91, -140.719) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-423.364, 102.016, -15.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (295.529, 624.496, -0.181263) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-636.82, 758.585, 128.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-339.913, 766.847, -7.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (661.187, -1356.07, -16.7437) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-204.018, -1646.09, -78.012) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-966.832, -304.942, -19.9657) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-538.159, 1637.2, 80.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1371.19, 544.372, 120.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1158.74, -3305.55, -154.184) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1304.12, -1301.24, -186.628) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (712.324, 740.379, 16.125) ) );
			break;
		case "mp_nuketown_x": // Nuk3town
			ARRAY_ADD( a_spawn_points, create_spawn( "boost", (1.50254, 146.557, -65.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1366.47, 751.061, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1539.23, 241.983, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (1111.46, 305.031, -56.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (827.449, 646.257, -56.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (31.6257, -596.188, -65.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-984.931, 72.2315, -59.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1665.15, 76.8042, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-1210.84, 648.466, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-752.54, 402.066, -59.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (-592.001, 622.517, 76.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-584.223, 639.566, -59.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (98.3321, 521.921, -32.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (1479.93, 1139.93, -59.229) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-690.913, -287.98, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (-1250.25, 553.968, 76.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-863.908, 622.176, 76.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-1437.4, 669.209, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (-212.893, 664.578, -60.8749) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1311.57, 484.298, -60.875) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (1273.95, 480.286, 78.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "weapon", (714.923, 284.844, 79.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "equipment", (864.274, 343.142, 79.125) ) );
			ARRAY_ADD( a_spawn_points, create_spawn( "perk", (725.565, 304.271, -56.875) ) );
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