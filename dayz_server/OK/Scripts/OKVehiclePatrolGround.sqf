if (!isServer)exitWith{};
private ["_heliTurrets","_wpnum","_radius","_gunner","_gunner2","_skillarray","_startingpos","_heli_class","_startPos","_veh","_unitGroup","_pilot","_skill","_position","_wp","_groups","_aicskill","_weaponArray","_weapon","_magazine","_aigearArray","_aigear","_gearmagazines","_reward"];
_position = _this select 0;
_startingpos = _this select 1;
_radius = _this select 2;
_wpnum = _this select 3;
_heli_class = _this select 4;
_skill = _this select 5;
if ((count _this) > 6) then {
	_reward = _this select 6;
} else {
	_reward = false;
};

if (count _this > 7) then {
	_groups = _this select 7;
} else {
	_groups = [];
};
_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_unitGroup = createGroup east;
_pilot = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
[_pilot] joinSilent _unitGroup;

_veh = createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 0.2], [], 0, "CAN_COLLIDE"];
_veh setFuel 1;
_veh engineOn true;
_veh setVehicleAmmo 1;
if (_reward) then {
	_veh addEventHandler ["GetOut",{(_this select 0) setFuel 0;[(_this select 0)] ExecVM OKAIPinata; (_this select 0) setDamage 1}];
};
if (_reward) then {
	_veh allowCrewInImmobile true; 
	_veh lock true;
} else {
	_veh allowCrewInImmobile false; 
};

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];

_pilot assignAsDriver _veh;
_pilot moveInDriver _veh;

//Lets set the skills
switch (_skill) do {
	case 0: {_aicskill = OKSkills0;};
	case 1: {_aicskill = OKSkills1;};
	case 2: {_aicskill = OKSkills2;};
	case 3: {_aicskill = OKSkills3;};
};

_gunner = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
_gunner assignAsGunner _veh;
_gunner moveInTurret [_veh,[0]];
[_gunner] joinSilent _unitGroup;
{_gunner setSkill [(_x select 0), (_x select 1)]} forEach _aicskill;

if (_heli_class == "BAF_Jackal2_L2A1_w") then {

	_gunner2 = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
	_gunner2 assignAsGunner _veh;
	_gunner2 moveInTurret [_veh,[1]];
	[_gunner2] joinSilent _unitGroup;
	{_gunner2 setSkill [(_x select 0), (_x select 1)]} forEach _aicskill;
};

{_pilot setSkill [(_x select 0), (_x select 1)]} forEach _aicskill;


//Get the weapon array based on skill
_weaponArray = [_skill] call OKGetWeapon;

_weapon = _weaponArray select 0;
_magazine = _weaponArray select 1;

//Get the gear array
_aigearArray = [OKGear0,OKGear1,OKGear2,OKGear3,OKGear4];
_aigear = _aigearArray call BIS_fnc_selectRandom;
_gearmagazines = _aigear select 0;

{_pilot setSkill [(_x select 0),(_x select 1)]} forEach _aicskill;
{_x addweapon _weapon;_x addmagazine _magazine; _x addmagazine _magazine;} forEach (units _unitGroup);
{_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];} forEach (units _unitGroup);
//[_patrol] spawn veh_monitor;

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "FULL";
_unitGroup setCombatMode "RED";
for "_i" from 1 to _wpnum do {
	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
	_wp setWaypointType "SAD";
	_wp setWaypointCompletionRadius 200;
};

_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 200;

diag_log format ["OK: Spawned in %1 %2",1,_heli_class];

// Add to groups list
_groups set [count _groups, _unitGroup];

[_veh, _unitGroup]
