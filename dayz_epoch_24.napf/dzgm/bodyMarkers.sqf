{
	if (!isNull _x) then {
		_name = _x getVariable["bodyName","unknown"];
		if (_name == name player) then {_name = "My body";} else {_name = _name + "'s body";};
		if (((_x getVariable["bodyUID","0"]) == (getPlayerUID player)) || ((_x getVariable["bodyGroup",grpNull]) == group player)) then {
			_pPos = getPosATL _x;
			if (surfaceIsWater _pPos) then {_pPos = getPosASL _x;};			
			deleteMarkerLocal _name;
			_mrkr = createMarkerLocal [_name,_pPos];
			_mrkr setMarkerTypeLocal "DestroyedVehicle";
			_mrkr setMarkerTextLocal format ["%1",_name];
			_mrkr setMarkerColorLocal "ColorRed";
		} else {
			deleteMarkerLocal _name;
		};
	};
} count allDead;