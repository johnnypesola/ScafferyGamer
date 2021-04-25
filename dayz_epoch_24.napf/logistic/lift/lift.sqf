if (LOG_INPROGRESS) then{
[STR_LOG_INPROGRESS,COLOR_ERROR] call SAM_SAYS;
} else {
LOG_INPROGRESS = true;
	private ["_heliporteur", "_objects", "_object", "_off"];
	_off = 0;
	_heliporteur = _this select 0;
	_objects = nearestObjects [_heliporteur, LOG_CFG_ISLIFTABLE, 30];
	_objects = _objects - [_heliporteur];
	_object = objNull;
	if (count _objects > 0) then{
		{ if (!(locked _x)) exitWith {_object = _x;};} forEach _objects;
		if ((!isNull _object) && !(_object getVariable "LOG_disabled")) then {
			if (isNull (_object getVariable "LOG_moves_by")) then {
				if (count crew _object == 0) then{	
					if (isNull (_object getVariable "LOG_moves_by") || (!alive (_object getVariable "LOG_moves_by"))) then{
						private ["_no_trailer", "_trailer"];
						_no_trailer = true;
						_trailer = _object getVariable "LOG_trailer";
						if !(isNil "_trailer") then{
							if !(isNull _trailer) then{ _no_trailer = false;};
						};
						if (_no_trailer) then{
							_heliporteur setVariable ["LOG_heliporte", _object, true];
							_object setVariable ["LOG_moves_by", _heliporteur, true];
							if (typeOf _object == "UAZ") then {
								_off = 1.8;
							} else {
								if (typeOf _object == "ch53_dze") then {
									_off = -12.0;
									} else {
										if (typeOf _heliporteur == "ch53_dze") then {
										_off = 1.8;
									};
								};
							};
							_object attachTo [_heliporteur, [0,0,(boundingBox _heliporteur select 0 select 2) - (boundingBox _object select 0 select 2) - (getPos _heliporteur select 2) + 0.5 + _off]];		
							[ format [STR_LOG_ATTACHED,getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")], COLOR_SUCCESS] call SAM_SAYS;
						}else{ [ format [STR_LOG_CANT_LIFT_TOWING,getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};
					}else{[ format [STR_LOG_CANT_LIFT_MOVING,getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};	
				}else{[ format [STR_LOG_CANT_LIFT_PLAYER,getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};
			}else{[ format [STR_LOG_ALREADY, getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")],COLOR_ERROR] call SAM_SAYS;};
		};
	};
LOG_INPROGRESS = false;
};
