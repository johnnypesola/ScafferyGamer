if (!isServer)exitWith{};
private ["_waypoints","_radius","_skillarray","_startingpos","_heli_class","_startPos","_veh","_unitGroup","_pilot","_position","_wp", "_wpPos", "_wpTimeout"];
_position = _this select 0;
_startingpos = _this select 1;
_waypoints = _this select 2;
_heli_class = _this select 3;
_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_radius = 0;
_unitGroup = createGroup west;
_pilot = _unitGroup createUnit ["Rocker1_DZ", [0,0,0], [], 1, "NONE"];
[_pilot] joinSilent _unitGroup;

_veh = createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
_veh setFuel 1;
_veh engineOn true;
_veh setVehicleAmmo 0;

if ((typeOf _veh) == "RHIB" ) then {
	_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
};

_veh allowCrewInImmobile true; 
_veh setVariable ["MalSar",1,true];
_veh lock false;
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];

_pilot assignAsDriver _veh;
_pilot moveInDriver _veh;
_pilot allowDamage false;
_veh allowDamage false;
_pilot setCaptive true; // Avoid Apache helo (or any other helos) attacking this boat.

// Make driver take the seat when he is moved out of it.
[_pilot, _veh] spawn {
	Private["_p","_v"];
	_p = _this select 0;
	_v = _this select 1;
	while {alive _p and (damage _v) < 1} do {
		
		_p assignAsDriver _v;
		_p moveInDriver _v;
		sleep 5;
	};
};

{_pilot setSkill [_x,1]} forEach _skillarray;
{_x addweapon "Makarov";_x addmagazine "8Rnd_9x18_Makarov";_x addmagazine "8Rnd_9x18_Makarov";} forEach (units _unitGroup);
[_veh] spawn veh_monitor;

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "FULL";
_unitGroup setCombatMode "GREEN";
{
	_wpPos = _x select 0;
	_wpTimeout = _x select 1;
	_wp = _unitGroup addWaypoint [_wpPos, _radius];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 3;
	_wp setWaypointTimeout [_wpTimeout, _wpTimeout, _wpTimeout];	// Wait before moving to next waypoint :)
} forEach _waypoints;

_wpPos = (_waypoints select 0) select 0;
_wp = _unitGroup addWaypoint [_wpPos, 1];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 3;

