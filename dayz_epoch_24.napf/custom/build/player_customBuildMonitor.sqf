Private["_deconstructibles","_allowedDistance","_isPZombie","_target","_typeOfCursorTarget","_inVehicle","_text","_isAlive","_id","_ownerID"];

_deconstructibles = [
	"M2StaticMG",
	"DShKM_CDF",
	"Land_Water_barrel",
	"MAP_F_postel_manz_kov"
];

_allowedDistance = 4;
_isPZombie = player isKindOf "PZombie_VB";

if (isNil "s_player_deleteBuild2") then {
	s_player_deleteBuild2 = -1;
};

while {true} do {
	_target = cursorTarget;
	_typeOfCursorTarget = typeOf _target;
	_isAlive = alive _target;
	_inVehicle = player != vehicle player;
	_text = getText (configFile >> "CfgVehicles" >> _typeOfCursorTarget >> "displayName");
	if (DZE_permanentPlot) then {
		_id = getPlayerUID player;
		_ownerID = _target getVariable ["ownerPUID","0"];
	} else {
		_id = dayz_characterID;
		_ownerID = _target getVariable ["CharacterID","0"];
	};
	if (isNil "_ownerID") then {
		_ownerID = "0";
	};
	if (!isNull _target && !_inVehicle && !_isPZombie && (player distance _target < _allowedDistance) && _ownerID == _id && _isAlive) then {
		if (typeOf _target in _deconstructibles) then {
			if (s_player_deleteBuild2 < 0) then {
				s_player_deleteBuild2 = player addAction [format[localize "STR_EPOCH_REMOVE",_text], "\z\addons\dayz_code\actions\remove.sqf",_target, 1, false, true];
			};
		}else{
			player removeAction s_player_deleteBuild2;
			s_player_deleteBuild2 = -1;
		};
	} else {
		player removeAction s_player_deleteBuild2;
		s_player_deleteBuild2 = -1;
	};
	uiSleep 1.0;
};
