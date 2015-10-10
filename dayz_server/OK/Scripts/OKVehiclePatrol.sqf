if (!isServer)exitWith{};
private ["_heliTurrets","_wpnum","_radius","_gunner","_gunner2","_skillarray","_startingpos","_heli_class","_startPos","_unitGroup","_pilot","_skill","_position","_wp","_patrol","_aicskill","_sl", "_missionTag"];
_position = _this select 0;
_startingpos = _this select 1;
_radius = _this select 2;
_wpnum = _this select 3;
_heli_class = _this select 4;
_skill = _this select 5;
_missionTag = _this select 6;
_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_unitGroup = createGroup east;
_pilot = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
[_pilot] joinSilent _unitGroup;
//ai_vehicle_units = (ai_vehicle_units + 1);

//_patrol = ["patrol"] call OKGetVeh;
_patrol = createVehicle [_heli_class, _startingpos, [], 0, "FLY"];
[_patrol] call OKSetupVehicle;
_patrol setFuel 1;
_patrol engineOn true;
_patrol setVehicleAmmo 1;
_patrol flyInHeight 100;
_patrol addEventHandler ["GetOut",{(_this select 0) setFuel 0;[(_this select 0)] ExecVM OKAIPinata; (_this select 0) setDamage 1}];
_patrol allowCrewInImmobile false; 
_patrol lock false;
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_patrol];

diag_log format["[OK]: Blackhawk Mission %1 spawned as SAR.",_patrol];

_pilot assignAsDriver _patrol;
_pilot moveInDriver _patrol;

diag_log format["[OK]: Blackhawk Mission pilot in."];

_gunner = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
_gunner assignAsGunner _patrol;
_gunner moveInTurret [_patrol,[0]];
[_gunner] joinSilent _unitGroup;

diag_log format["[OK]: Blackhawk Mission gunner1 in."];

_gunner2 = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
_gunner2 assignAsGunner _patrol;
_gunner2 moveInTurret [_patrol,[1]];
[_gunner2] joinSilent _unitGroup;

diag_log format["[OK]: Blackhawk Mission gunner2 in."];

//Pinata
//_patrol addEventHandler ["Killed",{[(_this select 0)] ExecVM OKAIPinata; }];

//Lets set the skills
switch (_skill) do {
	case 0: {_aicskill = OKSkills0;};
	case 1: {_aicskill = OKSkills1;};
	case 2: {_aicskill = OKSkills2;};
	case 3: {_aicskill = OKSkills3;};
};
	
{_gunner setSkill [(_x select 0),(_x select 1)]} forEach _aicskill;
{_gunner2 setSkill [(_x select 0),(_x select 1)]} forEach _aicskill;
//ai_vehicle_units = (ai_vehicle_units + 1);

//Now we need to figure out their loadout, and assign it
	
//Get the weapon array based on skill
_weaponArray = [_skill] call OKGetWeapon;

_weapon = _weaponArray select 0;
_magazine = _weaponArray select 1;
	
//diag_log text format ["[OK]: AI Weapon:%1 / AI Magazine:%2",_weapon,_magazine];
	
//Get the gear array
_aigearArray = [OKGear0,OKGear1,OKGear2,OKGear3,OKGear4];
_aigear = _aigearArray call BIS_fnc_selectRandom;
_gearmagazines = _aigear select 0;

{_pilot setSkill [(_x select 0),(_x select 1)]} forEach _aicskill;
{_x addweapon _weapon;_x addmagazine _magazine; _x addmagazine _magazine;} forEach (units _unitgroup);
{_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];} forEach (units _unitgroup);
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

if (!isNil "_missionTag") then {
	_pilot setVariable ["OKClean", _missionTag];
	_gunner setVariable ["OKClean", _missionTag];
	_gunner2 setVariable ["OKClean", _missionTag];
};
