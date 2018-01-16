private ["_board","_menu","_veh","_rcvdVeh","_pos"];

go_random_spawn = {
	private ["_counter","_position","_isNear","_isZero","_mkr","_findSpot","_isIsland","_pos","_IslandMap","_w"];
	if (!isDedicated) then {endLoadingScreen;};
	_IslandMap = (toLower worldName in ["caribou","cmr_ovaron","dayznogova","dingor","dzhg","fallujah","fapovo","fdf_isle1_a","isladuala","lingor","mbg_celle2","namalsk","napf","oring","panthera2","ruegen","sara","sauerland","smd_sahrani_a2","tasmania2010","tavi","trinity","utes"]);

	//spawn into random
	_findSpot = true;
	_mkr = [];
	_position = [0,0,0];

	actualSpawnMarkerCount = 0;
	// count valid spawn markers, since different maps have different amounts
	for "_i" from 0 to 10 do {
		if ((getMarkerPos format["spawn%1",_i]) distance [0,0,0] > 0) then {
			actualSpawnMarkerCount = actualSpawnMarkerCount + 1;
		} else {
			_i = 11; // exit since we did not find any further markers 
		};
	};

	for [{_j=0},{_j<=100 && _findSpot},{_j=_j+1}] do {
		// random spawn location selected, lets get the marker and spawn in somewhere
		if (dayz_spawnselection == 1) then {_mkr = getMarkerPos ("spawn" + str(floor(random 6)));} else {_mkr = getMarkerPos ("spawn" + str(floor(random actualSpawnMarkerCount)));};
		_position = ([_mkr,0,spawnArea,10,0,2,spawnShoremode] call BIS_fnc_findSafePos);
		if ((count _position >= 2) // !bad returned position
			&& {(_position distance _mkr < spawnArea)}) then { // !ouside the disk
			_position set [2, 0];
			if (((ATLtoASL _position) select 2 > 2.5) //! player's feet too wet
			&& {({alive _x} count (_position nearEntities ["CAManBase",150]) == 0)}) then { // !too close from other players/zombies
				_pos = +(_position);
				_isIsland = false; //Can be set to true during the Check
				// we check over a 809-meter cross line, with an effective interlaced step of 5 meters
				for [{_w = 0}, {_w != 809}, {_w = ((_w + 17) % 811)}] do {
					//if (_w < 17) then { diag_log format[ "%1 loop starts with _w=%2", __FILE__, _w]; };
					_pos = [((_pos select 0) - _w),((_pos select 1) + _w),(_pos select 2)];
					if ((surfaceisWater _pos) && !_IslandMap) exitWith {_isIsland = true;};
				};
				if (!_isIsland) then {_findSpot = false};
			};
		};
		//diag_log format["%1: pos:%2 _findSpot:%3", __FILE__, _position, _findSpot];
	};
	if (_findSpot && !_IslandMap) then {
		diag_log format["%1: Error, failed to find a suitable spawn spot for player. area:%2... falling back to Chernogorsk.",__FILE__, _mkr];
		_position = getMarkerPos ("spawn1"); // Fallback to spawn1
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
