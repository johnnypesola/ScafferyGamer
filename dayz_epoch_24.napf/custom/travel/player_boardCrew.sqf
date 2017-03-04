private ["_board","_menu","_veh","_rcvdVeh","_pos"];

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
		while {time < _timeout} do {
			
			_timeLeft = floor (_timeout - time);
			cutText [format["Waiting for transport... %1 seconds left.", _timeLeft], "PLAIN", 1];
			sleep 1;
		};

		diag_log format["Failed to move in player as %1, %2 in vehicle %3", _this select 0, _this select 1, typeOf (_this select 2)];

		_pos = [server_ferryTerminalPos, 10, 100, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
		_pos set [2,0.3];
		player setPos _pos;
		cutText ["","BLACK IN",2];
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
		sleep 2;
		if (player == vehicle player) then {
			diag_log format["Failed to move in player as %1, %2 in vehicle %3", _this select 0, _this select 1, typeOf (_this select 2)];
		};
	};
	cutText ["","BLACK IN",1];
};

// 0: Send to terminal.
if (_board == 0) then {

	// Move player to terminal and end loading screen.
	diag_log "Received command from server: Arrive at terminal";
	_pos = [server_ferryTerminalPos, 10, 100, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
	_pos set [2,0.3];
	player setPos _pos;
	cutText ["","BLACK IN",2];
};
