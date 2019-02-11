if (!isServer)exitWith{};
private ["_heliTurrets","_wpnum","_radius","_gunner","_gunner2","_skillarray","_startingpos","_heli_class","_startPos","_veh","_unitGroup","_pilot","_skill","_position","_wp","_groups"];
_position = _this select 0;
_startingpos = _this select 1;
_radius = _this select 2;
_wpnum = _this select 3;
_heli_class = _this select 4;
_skill = _this select 5;

if (count _this > 6) then {
	_groups = _this select 6;
} else {
	_groups = [];
};
_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_unitGroup = createGroup east;
_pilot = _unitGroup createUnit ["Soldier1_DZ", [0,0,0], [], 1, "NONE"];
_pilot setVariable ["origin", _heli_class + ":pilot"];
[_pilot] joinSilent _unitGroup;
ai_vehicle_units = (ai_vehicle_units + 1);

_veh = createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 0.2], [], 0, "CAN_COLLIDE"];
_veh setFuel 1;
_veh engineOn true;
_veh setVehicleAmmo 1;
//_veh addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1; diag_log format ["Vehicle %1 [%2] destroyed due to crew got out!", _this select 0, typeOf (_this select 0)];}];
//_veh addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
_veh allowCrewInImmobile true; 
_veh lock true;
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];

_pilot assignAsDriver _veh;
_pilot moveInDriver _veh;

_gunner = _unitGroup createUnit ["Soldier1_DZ", [0,0,0], [], 1, "NONE"];
_gunner setVariable ["origin", _heli_class + ":gunner"];
_gunner assignAsGunner _veh;
_gunner moveInTurret [_veh,[0]];
[_gunner] joinSilent _unitGroup;
{_gunner setSkill [_x,_skill]} forEach _skillarray;
ai_vehicle_units = (ai_vehicle_units + 1);

if (_heli_class == "BAF_Jackal2_L2A1_w") then {

	_gunner2 = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
	_gunner2 setVariable ["origin", _heli_class + ":gunner2"];
	_gunner2 assignAsGunner _veh;
	_gunner2 moveInTurret [_veh,[1]];
	[_gunner2] joinSilent _unitGroup;
	{_gunner2 setSkill [_x,_skill]} forEach _skillarray;
	ai_vehicle_units = (ai_vehicle_units + 1);
};


{_pilot setSkill [_x,1]} forEach _skillarray;
{_x addweapon "Makarov";_x addmagazine "8Rnd_9x18_Makarov";_x addmagazine "8Rnd_9x18_Makarov";} forEach (units _unitgroup);
{_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill_3rd_faction;}];} forEach (units _unitgroup);
[_veh] spawn veh_monitor;

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
//_unitGroup setSpeedMode "FULL";
_unitGroup setCombatMode "RED";
for "_i" from 1 to _wpnum do {
	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
	_wp setWaypointType "SAD";
	_wp setWaypointCompletionRadius 200;
};

_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 200;

diag_log format ["WAI: Spawned in %1 %2",1,_heli_class];

// Add to groups list
_groups set [count _groups, _unitGroup];
