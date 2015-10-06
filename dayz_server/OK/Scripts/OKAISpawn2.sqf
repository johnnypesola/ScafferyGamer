/*																		//
	Based on DZMSAISpawn.sqf by Vampire
	Usage: [position,unitcount,skillLevel] execVM "dir\OKAISpawn.sqf";
		Position is the coordinates to spawn at [X,Y,Z]
		UnitCount is the number of units to spawn
		SkillLevel is the skill number defined in DZMSAIConfig.sqf
*/																		//
private ["_position","_unitcount","_skill","_skin","_wpRadius","_spawn","_unitGroup","_aiskin","_unit","_weapon","_magazine","_wppos1","_wppos2","_wppos3","_wppos4","_wp1","_wp2","_wp3","_wp4","_wpfin"];
_position = _this select 0;
_unitcount = _this select 1;
_skill = _this select 2;
_skin = _this select 3;
_spawn = _position call OKFindPos2;


diag_log format ["[OK]: AI Pos:%1 / AI UnitNum: %2 / AI SkillLev:%3 / AI Skin:%4 /AI Spawn:%5",_position,_unitcount,_skill,_skin,_spawn];

_wpRadius = 20;



//Create the unit group. We use east by default.
_unitGroup = createGroup east;

//Probably unnecessary, but prevents client AI stacking
if (!isServer) exitWith {};

for "_x" from 1 to _unitcount do {

	//Lets pick a skin from the arrays
    switch (_skin) do {
		case 0: {_aiskin = OKBanditSkins1 call BIS_fnc_selectRandom;};
		case 1: {_aiskin = OKBanditSkins2 call BIS_fnc_selectRandom;};
		case 2: {_aiskin = OKBanditSkins3 call BIS_fnc_selectRandom;};
        case 3: {_aiskin = OKBanditSkins4 call BIS_fnc_selectRandom;};
	};
	
	
	//Lets spawn the unit
	_unit = _unitGroup createUnit [_aiskin, [(_spawn select 0),(_spawn select 1),(_spawn select 2)], [], 10, "PRIVATE"];
	
	//Make him join the correct team
	[_unit] joinSilent _unitGroup;
	
	//Add the behaviour
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCombatMode "RED";
	_unit setBehaviour "COMBAT";
	
	//Remove the items he spawns with by default
	removeAllWeapons _unit;
	removeAllItems _unit;
	
	//Now we need to figure out their loadout, and assign it
	
	//Get the weapon array based on skill
	_weaponArray = [_skill] call OKGetWeapon;
	
	_weapon = _weaponArray select 0;
	_magazine = _weaponArray select 1;
	
	diag_log format ["[OK]: AI Weapon:%1 / AI Magazine:%2",_weapon,_magazine];
	
	//Get the gear array
	_aigearArray = [OKGear0,OKGear1,OKGear2,OKGear3,OKGear4];
	_aigear = _aigearArray call BIS_fnc_selectRandom;
	_gearmagazines = _aigear select 0;
	_geartools = _aigear select 1;
	
	//Gear the AI backpack
	//_aipack = OKPacklist call BIS_fnc_selectRandom;

	//Lets add it to the Unit
	for "_i" from 1 to 7 do {
		_unit addMagazine _magazine;
	};
	_unit addWeapon _weapon;
	_unit selectWeapon _weapon;
	
	//_unit addBackpack _aipack;
	
	{
		_unit addMagazine _x
	} forEach _gearmagazines;
	
	{
		_unit addWeapon _x
	} forEach _geartools;
    
    {
		_unit addMagazine _x
	} forEach _gearmagazines;
	
    //Some AT capability
	if ((random 1) > .5) then 
    {
    _unit addMagazine "MAAWS_HEAT";
    _unit addWeapon "MAAWS";
    diag_log format ["[OK]: Spawned MAAWS"];
    };
    
    //Some AA capability
	if ((random 1) > .93) then 
    {
    _unit addMagazine "Stinger";
    _unit addWeapon "Stinger";
    diag_log format ["[OK]: Spawned Stinger"];
    };
	
	//Lets set the skills
    _aicskill = nil;
	switch (_skill) do {
		case 0: {_aicskill = OKSkills1;};
		case 1: {_aicskill = OKSkills2;};
		case 2: {_aicskill = OKSkills3;};
        case 3: {_aicskill = OKSkills4;};
	};
	
	{
	_unit setSkill [(_x select 0),(_x select 1)]
	} forEach _aicskill;
	
	//Lets prepare the unit for cleanup
	_unit addEventHandler ["Killed",{ [(_this select 0), (_this select 1)] ExecVM OKAIKilled; }];
	_unit setVariable ["OKAI", true];
};

// These are some waypoints cruising between WP and center
_wppos1 = _position;
_wppos2 = _spawn;
//_wppos3 = _position;
//_wppos4 = [_xpos-100, _ypos, 0];

// We add the 4 waypoints
_wp1 = _unitGroup addWaypoint [_wppos1, _wpRadius];
_wp1 setWaypointType "MOVE";
_wp2 = _unitGroup addWaypoint [_wppos2, _wpRadius];
_wp2 setWaypointType "MOVE";
//_wp3 = _unitGroup addWaypoint [_wppos3, _wpRadius];
//_wp3 setWaypointType "SAD";
//_wp4 = _unitGroup addWaypoint [_wppos4, _wpRadius];
//_wp4 setWaypointType "SAD";

// Then we add a center waypoint that tells them to visit the rest
_wpfin = _unitGroup addWaypoint [_position, _wpRadius];
_wpfin setWaypointType "MOVE";
//_wpfin = _unitGroup addWaypoint [_spawn, _wpRadius];
//_wpfin setWaypointType "CYCLE";

diag_log format ["[OK]: Spawned %1 AI at %2 designated to %3",_unitcount,_spawn,_position];

// Start a monitor per group
[_unitGroup] spawn {

	private ["_unitGroup", "_done", "_timeout", "_timeLeft", "_unit", "_missionIdActive"];

	_unitGroup = _this select 0;

	// Don't despawn these AI until at least mission has finished!
	_missionIdActive = OKMissionIdActive;
	waitUntil {sleep 10; _missionIdActive != OKMissionIdActive};

	_done = false;
	_timeLeft = OKDespawnTime;
	_timeout = false;
	while {!_done} do {

		// If all units are dead, then just exit the monitor.
		if ({alive _x} count units _unitGroup == 0) then { _done = true; };

		// If players are too far from units
		if (_timeLeft <= 0) then { _timeout = true; _done = true; };

		_timeLeft = _timeLeft - 10;

		sleep 10;
	};
	// If timed out, just delete them.
	if (_timeout) then { {deleteVehicle _x} count units _unitGroup; deleteGroup _unitGroup; };
};

//Evac to NWAF???
