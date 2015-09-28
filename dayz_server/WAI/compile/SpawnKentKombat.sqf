private ["_position", "_unit", "_healthmultiplier", "_group", "_moveToX", "_moveToY", "_moveToZ", "_i"];

// Function that spawns explosion
explodeKent = {

	private ["_theObject", "_bombLoc", "_bombLocX", "_bombLocY", "_bombLocZ", "_ammoType", "_theExplosion"];

	_theObject = _this select 0;

	_ammoType = "Bo_GBU12_LGB"; // Huge explosion

	_bombLoc = GetPos _theObject;
	_bombLocX = _bombLoc select 0;
	_bombLocY = _bombLoc select 1;
	_bombLocZ = _bombLoc select 2;

	_theExplosion = _ammoType createVehicle[_bombLocX, _bombLocY, _bombLocZ];
	_theExplosion setVectorDirAndUp [[0,0,1],[0,1,0]];
};


// Define variables
_position = _this select 0;

//_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_group = createGroup east;

_unit = _group createUnit ["INS_Bardak_DZ", _position, [], 0.3, "CORPORAL"];

// What the unit is allowed to do
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

// Give weapon to unit
_unit addweapon "MP5SD";

// Give ammo to unit
for "_i" from 1 to 12 do {
   _unit addMagazine "30Rnd_9x19_MP5SD";
};

// Give unit more health
_unit addEventHandler ["HandleDamage",{if (_this select 1=="") then {damage (_this select 0)+((_this select 2)/300)}}];

// Explode kent on kill
_unit addEventHandler ["Killed",{

	[GetPos (_this select 0), [["ItemComboLock", 100]]] call fn_generateCrashLoot;
	[_this select 0] call explodeKent;
}];

// Get positions to move to
_moveToX = _position select 0;
_moveToY = _position select 1;
_moveToZ = _position select 2;

// Run 50 units east
_moveToX = _moveToX + 50;

// Move group
_group move [_moveToX, _moveToY, _moveToZ];

[nil,nil,rTitleText,"Warning: Special military unit deployed. Kent Kombat has arrived at the northern base!", "PLAIN",5] call RE;


