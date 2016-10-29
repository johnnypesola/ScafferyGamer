/*																		//
	Based on DZMSAISpawn.sqf by Vampire
	Usage: [position,unitcount,skillLevel] execVM "dir\OKAISpawn.sqf";
		Position is the coordinates to spawn at [X,Y,Z]
		UnitCount is the number of units to spawn
		SkillLevel is the skill number defined in DZMSAIConfig.sqf
*/																		//
private ["_position","_unitcount","_skill","_skin","_wpRadius","_xpos","_ypos","_unitGroup","_aiskin","_unit","_weapon","_magazine","_wppos1","_wppos2","_wppos3","_wppos4","_wp1","_wp2","_wp3","_wp4","_wpfin"];
_position = _this select 0;
_unitcount = _this select 1;
_skill = _this select 2;
_skin = _this select 3;

diag_log format ["[OK]: AI Pos:%1 / AI UnitNum: %2 / AI SkillLev:%3 / AI Skin:%4",_position,_unitcount,_skill,_skin];

_wpRadius = 20;

_xpos = _position select 0;
_ypos = _position select 1;

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
	_unit = _unitGroup createUnit [_aiskin, [(_position select 0),(_position select 1),(_position select 2)], [], 10, "PRIVATE"];
	
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

// These are 4 waypoints in a NorthSEW around the center
_wppos1 = [_xpos, _ypos+100, 0];
_wppos2 = [_xpos+100, _ypos, 0];
_wppos3 = [_xpos, _ypos-100, 0];
_wppos4 = [_xpos-100, _ypos, 0];

// We add the 4 waypoints
_wp1 = _unitGroup addWaypoint [_wppos1, _wpRadius];
_wp1 setWaypointType "SAD";
_wp2 = _unitGroup addWaypoint [_wppos2, _wpRadius];
_wp2 setWaypointType "SAD";
_wp3 = _unitGroup addWaypoint [_wppos3, _wpRadius];
_wp3 setWaypointType "SAD";
_wp4 = _unitGroup addWaypoint [_wppos4, _wpRadius];
_wp4 setWaypointType "SAD";

// Then we add a center waypoint that tells them to visit the rest
_wpfin = _unitGroup addWaypoint [[_xpos,_ypos, 0], _wpRadius];
_wpfin setWaypointType "CYCLE";

diag_log format ["[OK]: Spawned %1 AI at %2",_unitcount,_position];

_unitGroup

//Evac to NWAF???
