private ["_block","_blockGroup","_blockPlot","_bodies","_body","_grid","_hlevel","_humanity","_index","_inGroup","_lb","_level","_name","_uid","_startTime"];
disableSerialization;
#include "scripts.sqf"

_startTime = diag_tickTime;
_block = [];
_blockGroup = false;
_blockPlot = false;
_lb = (findDisplay 88890) displayCtrl 8888;
_humanity = player getVariable ["humanity",0];
waitUntil {_inGroup = count units group player > 1; uiSleep 0.2; (_inGroup || diag_tickTime - _startTime > 2.0)};
_uid = getPlayerUID player;
spawn_plot = objNull;

// SPAWN BED
spawn_bed = objNull;

if (spawn_nearPlot) then {
	{
		if (_x getVariable ["ownerPUID","0"] == _uid) exitWith {
			spawn_plot = _x;
		};
	} count (entities "Plastic_Pole_EP1_DZ");
};
// SPAWN BED
{
	if (_x getVariable ["ownerPUID","0"] == _uid) exitWith {
		spawn_bed = _x;
	};
} count allMissionObjects "MAP_F_postel_manz_kov";

if (spawn_bodyCheck > 0) then {
	_bodies = [];
	{
		if (_x getVariable["bodyUID","0"] == _uid) then {
			_bodies set [count _bodies,(getPosATL _x)];
		};
	} count allDead;
	{
		_body = _x;
		{
			//Never block random or custom base
			if (count _x == 4 && {_body distance (_x select 1) < spawn_bodyCheck}) then {
				_block set [count _block,(_x select 0)];
			};
		} forEach spawn_public;
		if (!isNull spawn_plot) then {
			_grid = getPosATL spawn_plot;
			if (surfaceIsWater _grid) then {_grid = ATLToASL _grid;};
			if (_body distance _grid < spawn_bodyCheck) then {_blockPlot = true;};
		};
	} count _bodies;
	
	if (count _block > 0 or _blockGroup or _blockPlot) then {
		systemChat format [localize "STR_ESS_BLOCKED",spawn_bodyCheck];
	};
};

lbClear _lb;
{
	_name = _x select 0;
	if !(_name in _block) then {
		if (count _x == 2) then { //Custom base by UID
			_level = 0;
			_hlevel = 0;
		} else {
			_level = _x select 2;
			_hlevel = _x select 3;
		};
		
		_index = _lb lbAdd _name;
		
		if ((_hlevel < 0 && _humanity >= _hlevel) or (_hlevel > 0 && _humanity <= _hlevel) or (_level > 0 && !(_level in spawn_levels))) then {
			_lb lbSetPicture [_index,"\ca\ui\data\ui_task_failed_ca.paa"];
		} else {
			_lb lbSetPicture [_index,"\ca\ui\data\ui_task_done_ca.paa"];
		};
		
		_lb lbSetColor [_index, switch true do {
			case (count _x == 2): {[1,1,0,1]}; //Custom base by UID
			case (_level > 0): {[0,1,0,.8]};
			case (_hlevel > 0): {[.38,.7,.9,1]};
			case (_hlevel < 0): {[1,0,0,1]};
			case (count _x > 4): {[.97,.87,.35,1]}; //Random
			default {[.88,.88,.88,1]};
		}];
	};
} forEach spawn_public;

diag_log format["DEBUG: _inGroup: %1, spawn_nearGroup: %2, _blockGroup: %3", _inGroup, spawn_nearGroup, _blockGroup];

if (_inGroup && spawn_nearGroup && !_blockGroup) then {
	_index = _lb lbAdd (localize "STR_ESS_GROUP");
	_lb lbSetColor [_index,[1,.7,.4,1]];
	_lb lbSetPicture [_index,"\ca\ui\data\ui_task_done_ca.paa"];
};

if (!isNull spawn_plot && !_blockPlot) then {
	_index = _lb lbAdd (localize "STR_ESS_PLOT");
	_lb lbSetColor [_index,[1,.7,.4,1]];
	_lb lbSetPicture [_index,"\ca\ui\data\ui_task_done_ca.paa"];
};

// SPAWN BED
if (!isNull spawn_bed) then {
	_index = _lb lbAdd ("Spawn at bed");
	_lb lbSetColor [_index,[1,.7,.4,1]];
	_lb lbSetPicture [_index,"\ca\ui\data\ui_task_done_ca.paa"];
};

lbSort _lb;
