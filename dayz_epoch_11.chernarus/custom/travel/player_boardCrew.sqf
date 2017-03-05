private ["_board","_menu","_veh","_rcvdVeh","_pos"];

go_random_spawn = {
	private ["_spawnMarkerCount","_actualSpawnMarkerCount","_counter","_position","_isNear","_isZero","_mkr","_w"];
	_actualSpawnMarkerCount = 0;
	// count valid spawn marker positions
	for "_i" from 0 to _spawnMarkerCount do {
		if (!([(getMarkerPos format["spawn%1", _i]), [0,0,0]] call BIS_fnc_areEqual)) then {
			_actualSpawnMarkerCount = _actualSpawnMarkerCount + 1;
		} else {
			// exit since we did not find any further markers
			_i = _spawnMarkerCount + 99;
		};
	};
	if (!isDedicated) then {
		endLoadingScreen;
	};

	//Spawn modify via mission init.sqf
	if(isnil "spawnArea") then {
		spawnArea = 1500;
	};
	if(isnil "spawnShoremode") then {
		spawnShoremode = 1;
	};

	//spawn into random
	_findSpot = true;
	_mkr = "";
	while {_findSpot} do {
		_counter = 0;
		while {_counter < 20 && _findSpot} do {
			// switched to floor
			_mkr = "spawn" + str(floor(random _actualSpawnMarkerCount));
			_position = ([(getMarkerPos _mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
			_isNear = count (_position nearEntities ["Man",100]) == 0;
			_isZero = ((_position select 0) == 0) && ((_position select 1) == 0);
			//Island Check		//TeeChange
			_pos 		= _position;
			_isIsland	= false;		//Can be set to true during the Check
			for [{_w=0},{_w<=150},{_w=_w+2}] do {
				_pos = [(_pos select 0),((_pos select 1) + _w),(_pos select 2)];
				if(surfaceisWater _pos) exitWith {
					_isIsland = true;
				};
			};

			if ((_isNear && !_isZero) || _isIsland) then {_findSpot = false};
			_counter = _counter + 1;
		};
	};
	_isZero = ((_position select 0) == 0) && ((_position select 1) == 0);
	_position = [_position select 0,_position select 1,0];
	if (!_isZero) then {
		//_playerObj setPosATL _position;
	};
	_position
};

// If this player was crew member of a transported vehicle to this server.

_board = PV_travel_boardRcvdVeh select 0;
_rcvdVeh = PV_travel_boardRcvdVeh select 1;
_seatType = PV_travel_boardRcvdVeh select 2;
_seat = PV_travel_boardRcvdVeh select 3;

// 2: Wait at debug
if (_board == 2) then {
	// Let player wait at debug zone.
	diag_log "Received command from server: Wait in debug!";

	[_seatType, _seat, _rcvdVeh] spawn {
		private["_timeout","_timeLeft"];
		_timeout = time + 60;
		while {time < _timeout && player == vehicle player} do {
			
			_timeLeft = floor (_timeout - time);
			cutText [format["Waiting for transport... %1 seconds left.", _timeLeft], "BLACK", 1];
			sleep 1;
		};

		if (player != vehicle player) exitWith {
			cutText ["", "BLACK IN", 1];
		};

		diag_log format["Failed to move in player as %1, %2 in vehicle %3", _this select 0, _this select 1, typeOf (_this select 2)];

		// Move player and end loading screen.
		_pos = call go_random_spawn;
		_pos set [2,0.3];
		player setPos _pos;
		cutText ["","BLACK IN", 1];
	};
};

// 1: Send to the vehicle.
if (_board == 1) then {

	diag_log format["Received boarding command from server: Vehicle: %1, SeatType: %2, SeatIdx: %3", typeOf _rcvdVeh, _seatType, _seat];
	switch (_seatType) do {
		case 0: { player moveInDriver _rcvdVeh; };
		case 1: { player moveInCommander _rcvdVeh; };
		case 2: { player moveInTurret [_rcvdVeh, _seat]; };
		case 3: { player moveInCargo _rcvdVeh; };
		default {
			cutText ["No spot specified in vehicle! Guess I'll have to stay on ground then...", "PLAIN DOWN"];
		};
	};

	[_seatType, _seat, _rcvdVeh] spawn {
		private ["_timeout"];
		_timeout = time + 3;
		waitUntil {player != vehicle player || time > _timeout};

		if (player == vehicle player) then {
			diag_log format["Failed to move in player as %1, %2 in vehicle %3", _this select 0, _this select 1, typeOf (_this select 2)];

			_pos = call go_random_spawn;

			_pos set [2,0.3];
			player setPos _pos;
		};
		cutText ["","BLACK IN", 0.5];
	};
};

// 0: Send to terminal.
if (_board == 0) then {

	diag_log "Received command from server: Spawn at vanilla positions";

	_pos = call go_random_spawn;

	// Move player and end loading screen.
	_pos set [2,0.3];
	player setPos _pos;
	cutText ["","BLACK IN", 1];
};
