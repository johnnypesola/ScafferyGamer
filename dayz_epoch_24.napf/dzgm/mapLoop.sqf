private ["_mrkr","_name","_pPos"];

while {true} do {
	if (visibleMap || (!isNull (findDisplay 88890))) then {
		{
			if ((!isNull _x) && {isPlayer _x} && {(driver (vehicle _x)) == _x}) then {
				_name = name _x;
				if (group _x == group player) then {
					_pPos = getPosATL _x;
					if (surfaceIsWater _pPos) then {_pPos = getPosASL _x;};
					if (_name == name player) then {_name = "I am here";};
					deleteMarkerLocal _name;
					_mrkr = createMarkerLocal [_name,_pPos];
					_mrkr setMarkerTypeLocal "DestroyedVehicle";
					_mrkr setMarkerTextLocal format ["%1",_name];
				} else {
					deleteMarkerLocal _name;
				};
			};
		} count playableUnits;
		#include "bodyMarkers.sqf"
	};
	uiSleep 1;
};