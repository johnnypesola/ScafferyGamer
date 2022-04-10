private ["_keyItem","_claimingPlayerUID","_claimingPlayer","_missionParams","_missionInsurance"];
#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

_keyItem = _this select 0;
_claimingPlayerUID = _this select 1;
_claimingPlayer = objNull;
insurancemissionstartstate = "none";

// Check player who tries to claim lost vehicle by insurance
{ if (isPlayer _x && {_claimingPlayerUID == getPlayerUID _x}) exitWith {_claimingPlayer = _x;}; } forEach playableUnits;
if (isNull _claimingPlayer) exitWith {
	diag_log format["WAI: Unknown player called claim on key %1", _keyItem];
};

diag_log format["WAI: Player %1 wants to claim insurance on key %2", _claimingPlayerUID, _keyItem];

if (!insurancemissionrunning) then {
	if (insurancemarkerready) then
	{
		clean_running_insurance_mission = False;
		_missionParams = [_keyItem, _claimingPlayerUID];
		_missionInsurance = wai_missions_insurance call BIS_fnc_selectRandom;
		_missionParams execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_missionInsurance];
		insurancemissionrunning = true;
		diag_log format["WAI: Starting Insurance mission %1", _missionInsurance];

	};
} else {
	diag_log format["WAI: Player %1 cannot claim insurance on key %2 since another claim is in progress", _claimingPlayerUID, _keyItem];
	dze_waiting = "busy";
};

[_claimingPlayer] spawn {
	private ["_claimingPlayer","_checkStartTime","_checkTime","_timeout"];
	_claimingPlayer = _this select 0;
	_checkStartTime = diag_tickTime;
	_checkTime =  diag_tickTime - _checkStartTime;
	_timeout = false;
	while {!_timeout && {insurancemissionstartstate != "Success"}} do {

		if (_checkTime >= 10) exitWith {
			_timeout = true;
		};
		sleep 3;
		_checkTime = diag_tickTime - _checkStartTime;
	};

	dze_waiting = insurancemissionstartstate;
	(owner (_claimingPlayer)) publicVariableClient "dze_waiting";
};
