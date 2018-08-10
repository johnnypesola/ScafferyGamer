private ["_stopCondition", "_stopConditionArgs", "_vehicleList", "_vehicleData", "_classname", "_startingPos", "_patrolPos", "_useRandomWaypoints", "_randomWaypointRadius", "_useCyclicWaypoints", "_waypointList", "_spawnTime", "_skill", "_vehicle", "_timeLeft", "_vehicleListLength"];

// *** _vehicleList *** must contain data as follows:
//[
//	[
//		_classname,
//		_startingPos,		// Spawning position.
//		_patrolPos,		// Patrol position.
//		_skill,			// Patrol position.
//		_useRandomWaypoints,	// if set to true, random waypoints will be generated.
//		_randomWaypointRadius,	// radius around where random waypoints are placed. Ignored if previous parameter is false.
//		_useCyclicWaypoints,	// set true for cyclic waypoints (implicit if random waypoints are ser)
//		_waypointList,		// set as empty array to make vehicle stand still at patrol point.
//		_spawnTime 		// Initial spawn and respawn time in seconds.
//	],
//	[
//		_classname,
//		...
//	],
//	...
//];

_vehicleList = _this select 0;
_vehicleListLength = count _vehicleList;


// *** _stopCondition *** is a function that is called every 5 seconds to check if respawning of vehicles should stop. Respawning will stop if this function returns true.
// 
_stopCondition = _this select 1;	// function reference.
_stopConditionArgs _this select 2;	// array of arguments (should be empty if none are needed.)


// Add two extra fields
for "_i" from 0 to (count _vehicleList) do {

	_vehicleData = _vehicleList select _i;
	_spawnTime = _vehicleData select 8;
	_vehicleData set [9, objNull];			// Vehicle reference
	_vehicleData set [10, _spawnTime];		// Time left before spawn
	_vehicleList set [_i, _vehicleData];		// Update list
};

while { !(_stopConditionArgs call _stopCondition) } do {

	for "_i" from 0 to (count _vehicleList) do {

		_vehicleData = 		_vehicleList select _i;
		_vehicle = 		_vehicleData select 9;
		if (!isNull _vehicle) then {

			if (!alive _vehicle) then {

				// Decrease time
				_timeLeft = (_vehicleData select 10) - (5 + _vehicleListLength);
				_vehicleData set [10, _timeLeft];
				_vehicleList set [_i, _vehicleData];

				if (_timeLeft <= 0) then {

					deleteVehicle _vehicle;
					_spawnTime = _vehicleData select 8;
					_vehicleData set [9, objNull];
					_vehicleData set [10, _spawnTime];
					_vehicleList set [_i, _vehicleData];
				};
			} else {
				diag_log format ["WAI: Vehicle %1 is alive @ %2", _i, (getPos _vehicle)];
			};


		} else {

			_classname = _vehicleData select 0;
			_startingPos = _vehicleData select 1;
			_patrolPos = _vehicleData select 2;
			_skill = _vehicleData select 3;
			_useRandomWaypoints = _vehicleData select 4;
			_randomWaypointRadius = _vehicleData select 5;
			_useCyclicWaypoints = _vehicleData select 6;
			_waypointList = _vehicleData select 7;

			_vehicle = [_classname, _startingPos, _patrolPos, _skill, _useRandomWaypoints, _waypointList, _useCyclicWaypoints, _randomWaypointRadius] call spawn_dynamic_vehicle_patrol;
			_vehicleData set [9, _vehicle];
			_vehicleList set [_i, _vehicleData];
		};
		sleep 1;	// Vehicle loop delay
	};

	sleep 5;	// Main loop delay
};
