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
		if (_humanity < 0 ) then {
			_player setVariable ["humanity",(_humanity - ai_add_humanity),true];
		} else {
			_player setVariable ["humanity",(_humanity + ai_add_humanity),true];
		};
	};
	// Remove launchers
	{
		if (_x == "MAAWS" || _x == "M136") then {_unit removeWeapon _x;};
	} forEach (weapons _unit);

	// Leave some ammo in extremely rare cases
	if((random 1) > 0.002) then {
		{
			if (_x == "MAAWS_HEAT") then {_unit removeMagazine _x;};
		} forEach (magazines _unit);
	};
	// Remove all M136 ammo
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
} else {
	// Remove launchers
	{
		if (_x == "MAAWS" || _x == "M136") then {_unit removeWeapon _x;};
	} forEach (weapons _unit);

	// Remove all launcher ammo as well
	{
		if (_x == "MAAWS_HEAT" || _x == "M136") then {_unit removeMagazine _x;};
	} forEach (magazines _unit);

	if (ai_clear_body) then {
		{_unit removeMagazine _x;} forEach (magazines _unit);
		{_unit removeWeapon _x;} forEach (weapons _unit);
	};
};
