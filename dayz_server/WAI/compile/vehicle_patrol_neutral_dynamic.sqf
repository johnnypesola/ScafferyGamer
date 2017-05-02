if (!isServer)exitWith{};
private ["_heliTurrets","_wpnum","_gunner2","_skillarray","_startingpos","_heli_class","_startPos","_veh","_unitGroup","_pilot","_skill","_position","_wp", "_randomWaypoints", "_waypointList", "_useCyclicWaypoints"];
_heli_class = _this select 0;
_startingpos = _this select 1;
_position = _this select 2;
_skill = _this select 3;
_randomWaypoints = _this select 4;
_waypointList = _this select 5;
_useCyclicWaypoints = _this select 6;
_radius = _this select 7;

_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_unitGroup = createGroup east;
_pilot = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
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

_gunner = _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
_gunner assignAsGunner _veh;
_gunner moveInTurret [_veh,[0]];
[_gunner] joinSilent _unitGroup;
{_gunner setSkill [_x,_skill]} forEach _skillarray;
ai_vehicle_units = (ai_vehicle_units + 1);


{_pilot setSkill [_x,1]} forEach _skillarray;
{_x addweapon "Makarov";_x addmagazine "8Rnd_9x18_Makarov";_x addmagazine "8Rnd_9x18_Makarov";} forEach (units _unitgroup);
{_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill_neutral;}];} forEach (units _unitgroup);
[_veh] spawn veh_monitor;

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
//_unitGroup setSpeedMode "FULL";
_unitGroup setCombatMode "RED";

if (_randomWaypoints) then {

	for "_i" from 1 to _wpnum do {
		_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 100;
	};

	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 100;

} else {

	{	
		_wp = _unitGroup addWaypoint [[(_x select 0),(_x select 1),0],_radius];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 25;
	} forEach _waypointList;

	if (_useCyclicWaypoints) then {
		_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
		_wp setWaypointType "CYCLE";
		_wp setWaypointCompletionRadius 100;
	};

};

// Return vehicle reference
_veh
