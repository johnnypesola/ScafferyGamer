private ["_veh","_driver","_commander","_turrets","_turretsFlat","_cargo","_mainTurrets","_subTurrets","_pos","_unit","_allExceptCargo","_crewToReturn"];

_veh = _this select 0;

// Get player UID for all crew members

_driver = if (isNull (driver _veh)) then { "0" } else { getPlayerUID (driver _veh) };
_commander = if (isNull (commander _veh)) then { "0" } else { getPlayerUID (commander _veh) };

// Getting turrets is a bit more complex:
_mainTurrets = configFile >> "CfgVehicles" >> typeof _veh >> "turrets";
_turrets = [];
_turretsFlat = [];
_pos = 0;

// Loop through main turrets
for "_i" from 0 to (count _mainTurrets)-1 do {

	_subTurrets = (_mainTurrets select 0);
	if ((count _subTurrets) > 0) then {

		_subTurrets = [];
		// Loop through sub turrets
		for "_j" from 0 to (count _subTurrets)-1 do {

			_unit = (_veh turretUnit [_i, _j]);
			if (isNull _unit) then { _unit = "0"; } else { _unit = getPlayerUID _unit; };
			_subTurrets set [_j, _unit];
			_turretsFlat set [_pos, _unit];
			_pos = _pos + 1;
		};
		_turrets set [_i, _subturrets];

	} else {

		_unit = (_veh turretUnit [_i]);
		if (isNull _unit) then { _unit = "0"; } else { _unit = getPlayerUID _unit; };
		_turrets set [_i, _unit]; 
		_turretsFlat set [_pos, _unit];
		_pos = _pos + 1;
	};
};

_crew = [];
{ _crew set [_forEachIndex, getPlayerUID _x] } forEach (crew _veh);

// Extract cargo via deduction with full crew
_allExceptCargo = [_driver, _commander] + [_turretsFlat];
_cargo = _crew - _allExceptCargo;

// Return all crew with exact positions in an array. Those positions that are not occupied are returned as "0". 
diag_log format ["FERRY: Returning vehicle crew assignments as follows: [driver: %1, commander: %2, turrets: %3, cargo: %4]", _driver, _commander, _turrets, _cargo];
[_driver, _commander, _turrets, _cargo]
