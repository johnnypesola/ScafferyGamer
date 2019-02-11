private ["_unit","_player","_humanity"];
_unit = _this select 0;
_player = _this select 1;
_type = _this select 2;

switch (_type) do {
	case "ground" : {ai_ground_units = (ai_ground_units -1);};
	case "air" : {ai_air_units = (ai_air_units -1);};
	case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
	case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
};

_unit setVariable ["killedat", time];
if (isPlayer _player) then {
	private ["_humanity"];
	_humanity = _player getVariable["humanity",0];
	if (ai_humanity_gain) then {
		if (_humanity >= 0 ) then {
			_player setVariable ["humanity",(_humanity - ai_add_humanity),true];
		} else {
			_player setVariable ["humanity",(_humanity + ai_add_humanity),true];
		};
	};
	// Remove launchers but leave it in extreme cases
	if((random 1) > 0.02) then {
		{
			if (_x == "MAAWS") then {_unit removeWeapon _x;};
		} forEach (weapons _unit);
	};
	// Remove M136 launchers, since they are forbidden anyway
	{
		if (_x == "M136") then {_unit removeWeapon _x;};
	} forEach (weapons _unit);

	// Remove launchers, leave some ammo every now and then
	if((random 1) > 0.2) then {
		{
			if (_x == "MAAWS_HEAT") then {_unit removeMagazine _x;};
		} forEach (magazines _unit);
	};
	// Remove M136 ammo, since it is forbidden anyway
	{
		if (_x == "M136") then {_unit removeMagazine _x;};
	} forEach (magazines _unit);

	if (ai_clear_body) then {
		{_unit removeMagazine _x;} forEach (magazines _unit);
		{_unit removeWeapon _x;} forEach (weapons _unit);
	};
	if (ai_ahare_info) then {
		{if (((position _x) distance (position _unit)) <= ai_share_distance) then {_x reveal [_player, 4.0];}} forEach allUnits;
	};
};
