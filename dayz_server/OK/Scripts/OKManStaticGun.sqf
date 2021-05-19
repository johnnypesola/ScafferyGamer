private ["_aipack","_class","_position2","_direction","_static","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_weaponandmag","_gearmagazines","_geartools","_unit","_groups","_weaponArray","_useSameGroup"];
_static = _this select 0;
_skill = _this select 1;
_skin = _this select 2;
if ((count _this) > 3) then {
	_groups = _this select 3;
} else {
	_groups = [];
};
if ((count _this) > 4) then {
	_useSameGroup = _this select 4;
};

// This script will spawn in one unit+group to man the specified static gun
_position = [getPos _static];

_position2 = [];
_aiweapon = [];
_aigear = [];
_aiskin = "";
_aipack = "";

if (_useSameGroup) then {
	if ((count _groups) == 0) then {
		_groups set [0, createGroup east];
	};
	_unitGroup = _groups select ((count _groups)-1);
} else {
	_unitGroup = createGroup east;
};
_unitnumber = count _position;

if (!isServer) exitWith {};

{
	_position2 = _x;

	//Lets pick a skin from the arrays
	switch (_skin) do {
		case 0: {_aiskin = OKBanditSkins1 call BIS_fnc_selectRandom;};
		case 1: {_aiskin = OKBanditSkins2 call BIS_fnc_selectRandom;};
		case 2: {_aiskin = OKBanditSkins3 call BIS_fnc_selectRandom;};
		case 3: {_aiskin = OKBanditSkins4 call BIS_fnc_selectRandom;};
	};

	_unit = _unitGroup createUnit [_aiskin, [0,0,0], [], 10, "PRIVATE"];
	[_unit] joinSilent _unitGroup;
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCombatMode "RED";
	_unit setBehaviour "COMBAT";
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
	_unit moveingunner _static;
} forEach _position;

_unitGroup selectLeader ((units _unitGroup) select 0);

diag_log format ["[OK]: Spawned %1 AI at %2",_unitnumber,_position];
if (!_useSameGroup) then {
	_groups set [count _groups, _unitGroup];
};
_unitGroup
