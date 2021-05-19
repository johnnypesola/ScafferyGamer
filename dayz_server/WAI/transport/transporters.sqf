Private["_transportList","_startPos","_pos","_waypoints","_classname", "_currentTransport"];

if (!isServer) exitWith{};

waitUntil {!isNil "WAIconfigloaded" && {WAIconfigloaded}};

sleep 120;

_transportList = [
	[
		// Northern Island to Airport transport boat
		"RHIB",	// Transport type
		[
			[[17553.545, 14041.552, -0.90720141],30], 	// Airport
			[[17653.545, 15441.552, -0.90720141],30], 	// (intermediate)
			[[17448.283, 16820.844, -0.2508586],30]		// Island
		
		]
	]
	/*,
	[
		// Worb to Waldegg to Goldwil to Brienz transport boat
		"RHIB",
		[
			[[14338.662, 2689.0593, -1.1241074],30],	// Brienz
			[[11332.762, 1822.2366, -1.0583742],30],	// Goldwil
			[[8748.00,501.000,0],0],			// (intermediate)
			[[8381.1953, 786.237, -1.098087],30],		// Waldegg
			[[7932.00,149.000,0],0],			// (intermediate)
			[[5692.00,357.000,0],0],			// (intermediate)
			[[3156.00,3485.00,0],0],			// (intermediate)
			[[1948.00,7317.00,0],0],			// (intermediate)
			[[2082.907, 7451.21, -0.1692954],30],		// Worb
			[[1948.00,7317.00,0],0],			// (intermediate)
			[[3156.00,3485.00,0],0],			// (intermediate)
			[[5692.00,357.000,0],0],			// (intermediate)
			[[7932.00,149.000,0],0],			// (intermediate)
			[[8381.1953, 786.237, -1.098087],30],		// Waldegg
			[[8748.00,501.000,0],0],			// (intermediate)
			[[11332.762, 1822.2366, -1.0583742],30],	// Goldwil
			[[14338.662, 2689.0593, -1.1241074],30]		// Brienz
		]
	]*/
];

{
	_classname = _x select 0;
	_waypoints = _x select 1;
	_startPos = (_waypoints select 0) select 0;
	_pos = (_waypoints select 0) select 0;
	
	// Spawn the boat
	[_pos, _startPos, _waypoints, _classname] spawn friendly_transport;

} forEach _transportList;
