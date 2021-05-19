if (!isServer) exitWith {};
private ["_mission","_veh","_crew"];
_veh = _this select 0;
_crew = crew _veh;
if (count _this == 2) then {
	_mission = _this select 1;
} else {
	_mission = false;
};
waitUntil { count _crew > 0};
while {(alive _veh) || ({alive _x} count _crew > 0)} do {
	_veh setVehicleAmmo 1;
	_veh setFuel 1;
	if ({alive _x} count _crew == 0) then {
		diag_log format["Vehicle %1 [%2] destroyed, no crew members alive.", _veh, typeOf _veh];
		_veh setDamage 1;
		_veh setVariable ["killedat", time];
	};
	if ((_mission) AND (clean_running_mission)) then {
		diag_log format["Vehicle %1 [%2] destroyed, mission expired.", _veh, typeOf _veh];
		_veh setDamage 1;
		_veh setVariable ["killedat", time];
	};
	sleep 30;
};
diag_log format["Vehicle %1 [%2] destroyed: damage = %3", _veh, typeOf _veh, damage _veh];
_veh setDamage 1;
_veh setVariable ["killedat", time];
