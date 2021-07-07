/*																		//
																		Based on DZMSAISpawn.sqf by Vampire
Usage: [position,unitcount,skillLevel] execVM "dir\OKAISpawn.sqf";
Position is the coordinates to spawn at [X,Y,Z]
UnitCount is the number of units to spawn
SkillLevel is the skill number defined in DZMSAIConfig.sqf
 */																		//
private ["_position","_direction","_skill","_skin","_wpRadius","_spawn","_unitGroup","_aiskin","_unit","_weapon","_magazine","_wppos1","_wppos2","_wppos3","_wppos4","_wp1","_wp2","_wp3","_wp4","_wpfin"];
_position = _this select 0;
_direction = _this select 1;
_weapon = _this select 2;
_skill = _this select 3;
_skin = _this select 4;
_useAT = _this select 5;
_useAA = _this select 6;

//Get the mag type for the weapon (can potentially give some interesting mags)
_magazine = (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) call BIS_fnc_selectRandom;

diag_log format ["[OK]: AI Pos:%1 / AI Gun: %2 / AI SkillLev:%3 / AI Skin:%4",_gun,_unitcount,_skill,_skin];

//Create the unit group. We use east by default.
_unitGroup = createGroup east;

//Probably unnecessary, but prevents client AI stacking
if (!isServer) exitWith {};

//Lets pick a skin from the arrays
switch (_skin) do {
	case 0: {_aiskin = OKBanditSkins1 call BIS_fnc_selectRandom;};
	case 1: {_aiskin = OKBanditSkins2 call BIS_fnc_selectRandom;};
	case 2: {_aiskin = OKBanditSkins3 call BIS_fnc_selectRandom;};
	case 3: {_aiskin = OKBanditSkins4 call BIS_fnc_selectRandom;};
};


//Lets spawn the unit
_unit = _unitGroup createUnit [_aiskin, _position, [], 10, "PRIVATE"];
_unit setDir _direction;

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
diag_log format ["[OK]: AI Weapon:%1 / AI Magazine:%2",_weapon,_magazine];

//Get the gear array
_aigearArray = [OKGear0,OKGear1,OKGear2,OKGear3,OKGear4];
_aigear = _aigearArray call BIS_fnc_selectRandom;
_gearmagazines = _aigear select 0;
_geartools = _aigear select 1;

//Gear the AI backpack
//_aipack = OKPacklist call BIS_fnc_selectRandom;

//Lets add it to the Unit
for "_i" from 1 to 4 do {
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

//Some AT capability
if (_useAT) then 
{
	_unit addMagazine "MAAWS_HEAT";
	_unit addMagazine "MAAWS_HEAT";
	_unit addWeapon "MAAWS";
	diag_log format ["[OK]: Spawned MAAWS"];
};

//Some AA capability
if (_useAA) then 
{
	_unit addMagazine "Stinger";
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

diag_log format ["[OK]: Spawned %1 guard AI at %2", 1, _position];

_unitGroup

