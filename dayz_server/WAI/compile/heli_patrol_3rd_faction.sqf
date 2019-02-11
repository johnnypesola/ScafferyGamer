if (!isServer)exitWith{};
private ["_wpnum","_radius","_gunner2","_gunner","_skillarray","_startingpos","_heli_class","_startPos","_helicopter","_unitGroup","_pilot","_skill","_position","_wp","_groups"];
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
//_pilot setVariable ["origin", _heli_class + ":pilot"];
[_pilot] joinSilent _unitGroup;
ai_air_units = (ai_air_units +1);

_helicopter = createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 200], [], 0, "FLY"];
_helicopter setFuel 1;
_helicopter engineOn true;
_helicopter setVehicleAmmo 1;
_helicopter flyInHeight 150;
_helicopter lock true;
_helicopter addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

_pilot assignAsDriver _helicopter;
_pilot moveInDriver _helicopter;

_gunner = _unitGroup createUnit ["Soldier1_DZ", [0,0,0], [], 1, "NONE"];
//_gunner setVariable ["origin", _heli_class + ":gunner"];
_gunner assignAsGunner _helicopter;
_gunner moveInTurret [_helicopter,[0]];
[_gunner] joinSilent _unitGroup;
ai_air_units = (ai_air_units +1);

if (!(_heli_class isKindOf "AH64D_EP1")) then {
	_gunner2 = _unitGroup createUnit ["Soldier1_DZ", [0,0,0], [], 1, "NONE"];
	//_gunner2 setVariable ["origin", _heli_class + ":gunner2"];
	_gunner2 assignAsGunner _helicopter;
	_gunner2 moveInTurret [_helicopter,[1]];
	[_gunner2] joinSilent _unitGroup;
	ai_air_units = (ai_air_units +1);
};
{_pilot setSkill [_x,1]} forEach _skillarray;
{_gunner setSkill [_x,_skill]} forEach _skillarray;
if (!(_heli_class isKindOf "AH64D_EP1")) then {
	{_gunner2 setSkill [_x,_skill]} forEach _skillarray;
};
{_x addweapon "Makarov";_x addmagazine "8Rnd_9x18_Makarov";_x addmagazine "8Rnd_9x18_Makarov";} forEach (units _unitgroup);
{_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill_3rd_faction;}];} forEach (units _unitgroup);
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_helicopter];
[_helicopter] spawn veh_monitor;

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "FULL";
_unitGroup setCombatMode "RED";
for "_i" from 1 to _wpnum do {
	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 200;
};

_helicopter addEventHandler ["killed", {[getPosATL (_this select 0)] call fn_generateCrashLoot;}];

_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 200;

diag_log format ["WAI: Spawned in %1 %2",1,_heli_class];

// Add to groups list
_groups set [count _groups, _unitGroup];
