private["_heliPatrolParamsList","_heliPatrolList","_heliClass","_startTime","_elapsedTime", "_heliPatrolParams", "_i", "_currentHeliPatrol", "_numHeliPatrols"];

if (!isServer) exitWith {};
waitUntil {!isNil "WAIconfigloaded" && {WAIconfigloaded}};

sleep 130;

// Heli Patrol Parameters
_heliPatrolParamsList = 
[
	[
		[18172.75, 2014.4397, 0],	// Fly-to position before starting waypoint cycle
		[18100, 45, 50.0],			// Starting point
		[
			[18172.75, 2014.4397, 25],
			[20094.049, 6300.4355, 25],
			[18466.531, 9518.8311, 25],
			[17334.797, 10085.534, 25],
			[15864.838, 9547.8652, 25],
			[14541.202, 7328.5508, 25],
			[13091.323, 6924.2246, 25],
			[12184.36, 5853.4595, 25],
			[11682.611, 4739.1367, 25],
			[9131.9551, 3466.593, 25],
			[10448.688, 2152.5549, 25],
			[10287.311, 268.89038, 25],
			[5988.7803, 78.077393, 25],
			[2713.4761, 2943.7585, 25],
			[4825.2397, 4642.8262, 25],
			[2151.0747, 4756.749, 25],
			[850.85327, 10980.096, 25],
			[4137.6313, 14437.541, 25],
			[4934.543, 16611.893, 25],
			[6467.0088, 16982.445, 25],
			[8190.0264, 17785.305, 25],
			[8855.6162, 16072.183, 25],
			[9102.5283, 17707.439, 25],
			[10345.141, 18303.543, 25],
			[12406.854, 16969.033, 25],
			[14549.774, 16907.184, 25],
			[14603.453, 13811.208, 25],
			[16565.33, 12806.965, 25],
			[19530.959, 11053.565, 25],
			[18961.957, 8250.7275, 25],
			[20250.125, 5095.9839, 25],
			[18636.664, 808.65967, 25]
		],
		["MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
		"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
		"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
		"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
		"UH1H_DZ","UH1H_DZ","UH1Y_DZ","UH60M_EP1_DZ","CH_47F_EP1_DZ"] call BIS_fnc_selectRandom,
		1.0,
		3000
	]
];

//diag_log "WAI: Spawning Heli Patrol #1 and #2.";
_heliPatrolList = 
[
	(_heliPatrolParamsList select 0) call fn_createHeliPatrol
];

_numHeliPatrols = count _heliPatrolList;

while { true } do {

	for [{_i=0},{_i<_numHeliPatrols},{_i=_i+1}] do {

		_currentHeliPatrol = _heliPatrolList select _i;
		_heliPatrolParams = _heliPatrolParamsList select _i;
		

		_groupAlive = _currentHeliPatrol select 1;

		// Check alive flag
		if (_groupAlive) then {

			_group = _currentHeliPatrol select 0;
			// Have all members in group gotten killed?
			if ({alive _x} count units (_group) == 0) then {

				diag_log format ["WAI: Heli Patrol #%1 was destroyed. Respawning in %2 seconds...", _i, (_currentHeliPatrol select 2)];

				// Yes, set alive flag to false
				_groupAlive = false;
				_currentHeliPatrol set [1, _groupAlive];

			};
		} else {

			_respawnTime	= _currentHeliPatrol select 2;

			// Decrease respawn time
			_respawnTime = _respawnTime - 20;
			_currentHeliPatrol set [2, _respawnTime];

			// If time's up, respawn the patrol! :)
			if (_respawnTime <= 0) then {

				_heliPatrolParams set [3, (["MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
								"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
								"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
								"MH60S_DZ","MH60S_DZ","MH60S_DZ","MH60S_DZ","UH1H_DZ","UH1H_DZ",
								"UH1H_DZ","UH1H_DZ","UH1Y_DZ","UH60M_EP1_DZ","CH_47F_EP1_DZ"] call BIS_fnc_selectRandom)];

				diag_log format ["WAI: Time's up! Respawning Napf Heli Patrol #%1", _i];

				_currentHeliPatrol = _heliPatrolParams call fn_createHeliPatrol;
			};
		};

		// Update heli patrol
		_heliPatrolList set [_i, _currentHeliPatrol];

		diag_log format ["WAI: Dynamic Heli Patrol updated index %1: %2", _i, _currentHeliPatrol];
		sleep 20;
	};
};
