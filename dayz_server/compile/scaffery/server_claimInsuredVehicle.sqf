private ["_keyItem","_claimingPlayerUID","_claimingPlayer"];
#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

_keyItem = _this select 0;
_claimingPlayerUID = _this select 1;
_claimingPlayer = objNull;

// Check player who tries to claim lost vehicle by insurance
{ if (isPlayer _x && {_claimingPlayerUID == getPlayerUID _x}) exitWith {_claimingPlayer = _x;}; } forEach playableUnits;
if (isNull _claimingPlayer) exitWith {
	diag_log format["WAI: Unknown player called claim on key %1", _keyItem];
};

diag_log format["WAI: Player %1 wants to claim insurance on key %2", _claimingPlayerUID, _keyItem];
if (isNil "insurancemissions") then {
	insurancemissions = [];
};
insurancemissions = insurancemissions + [_this];

dze_waiting = "success";
(owner (_claimingPlayer)) publicVariableClient "dze_waiting";
