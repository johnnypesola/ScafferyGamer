private ["_position", "_unit", "_healthmultiplier", "_group", "_moveToX", "_moveToY", "_moveToZ"];

_position = _this select 0;

_healthmultiplier = 20;

//_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_group = createGroup east;

_unit = "UN_CDF_Soldier_Crew_EP1" createUnit [_group, _position, [], 0.3, "CORPORAL"];

// What the unit is allowed to do
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

// Give weapon to unit
_unit addweapon "MP5SD";

// Give ammo to unit
for "_i" from 0 to 11 do {
   _unit addMagazine "30Rnd_9x19_MP5SD";
};

// Give unit more health
_unit addEventHandler ["HandleDamage",{if (_this select 1=="") then {damage (_this select 0)+((_this select 2)/_healthmultiplier)}}];

// Explode kent on kill
_unit addEventHandler ["Killed",{
	[_unit] call explodeKent
}];

// Get positions to move to
_moveToX = _position select 0;
_moveToY = _position select 1;
_moveToZ = _position select 2;

// Run 50 units east
_moveToX = _moveToX + 50;

// Move group
_group move [_moveToX, _moveToY, _moveToZ];

// Function that spawns explosion
explodeKent = {

	_theObject = _this select 0

	_bombLoc = GetPos _theObject
	_bombLocX = _bombLoc select 0
	_bombLocY = _bombLoc select 1
	_bombLocZ = _bombLoc select 2

	_ammoType createVehicle[_bombLocX, _bombLocY, _bombLocZ]
	_ammoType setVectorDirAndUp [[0,0,1],[0,1,0]];
	_theObject setdammage 1
	deleteVehicle _theObject;
};

[nil,nil,rTitleText,"Warning: Special military unit deployed. Kent Kombat has arrived at the northern base!", "PLAIN",5] call RE;


