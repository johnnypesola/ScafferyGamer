private ["_position", "_unit", "_healthmultiplier", "_group", "_moveToX", "_moveToY", "_moveToZ", "_i","_waypoints"];

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
if (count _this > 1) then {
	_waypoints = _this select 1;
} else {
	_waypoints = [];
};

//_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

_group = createGroup east;

_unit = _group createUnit ["Soldier_Bodyguard_AA12_PMC_DZ", _position, [], 0.4, "CORPORAL"];

// What the unit is allowed to do
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

// Give weapon to unit
_unit addweapon "MP5SD";

// Give ammo to unit
for "_i" from 1 to 11 do {
   _unit addMagazine "30Rnd_9x19_MP5SD";
};

// Give something valuable... if you're lucky you will get it!
if ((random 100) >= 2) then {
	_unit addMagazine "ItemTopaz";	// 98% chance for a Topaz
} else {
	_unit addMagazine "ItemSapphire";  // 2% chance for a Sapphire
};


// Give unit more health
_unit addEventHandler ["HandleDamage",{if (_this select 1=="") then {damage (_this select 0)+((_this select 2)/300)}}];

// Explode kent on kill
_unit addEventHandler ["Killed",{

	[GetPos (_this select 0), [["ItemComboLock", "magazine"]]] call fn_generateCrashLoot;

	[_this select 0] call explodeKent;
	WAI_kentIsDead = true;
}];

// Get positions to move to
_moveToX = _position select 0;
_moveToY = _position select 1;
_moveToZ = _position select 2;

// Run 50 units east
_moveToX = _moveToX + 50;

// Move group
_group move [_moveToX, _moveToY, _moveToZ];

// Add waypoints
{ _group addWaypoint [_x, 0]; } forEach _waypoints;
[nil,nil,rTitleText,"Warning: Special military unit deployed. Kent Kombat has arrived at the northern base!", "PLAIN",5] call RE;


