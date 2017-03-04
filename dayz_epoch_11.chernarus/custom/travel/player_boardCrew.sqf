private ["_menu","_veh","_rcvdVeh"];

if (isNil "checked_boardRcvdVeh") then { checked_boardRcvdVeh = false; };

// If this player was crew member of a transported vehicle to this server.
if (!checked_boardRcvdVeh) then {

	_rcvdVeh = PV_travel_boardRcvdVeh select 0;
	_seatType = PV_travel_boardRcvdVeh select 1;
	_seat = PV_travel_boardRcvdVeh select 2;

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

	// Player has been moved to vehicle, don't enter this check anymore.
	checked_boardRcvdVeh = true;
};

