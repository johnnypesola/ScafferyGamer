private ["_center", "_radius", "_distFromNearestObj", "_inWater", "_gradient", "_shoreMode"];

_radius = 6000;
_center = getMarkerPos "center"; 
_distFromNearestObj = 10;
_inWater = 0;
_gradient = 0.3;
_shoreMode = 0;

if(WAIWorldName == "chernarus") then {
	_radius = 5500;
	_center = getMarkerPos "center"; 
	_distFromNearestObj = 10;
	_inWater = 0;
	_gradient = 0.3;
	_shoreMode = 0;
};
if(WAIWorldName == "napf") then {
	_radius = 10000;
	_center = getMarkerPos "center"; 
	_distFromNearestObj = 10;
	_inWater = 0;
	_gradient = 0.5;
	_shoreMode = 0;
};

([_center,0,_radius,_distFromNearestObj,_inWater,_gradient, _shoreMode] call BIS_fnc_findSafePos)
