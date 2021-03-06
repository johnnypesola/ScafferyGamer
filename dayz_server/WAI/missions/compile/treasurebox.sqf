private ["_mission","_mags","_tool","_box","_class","_numberofguns","_numberoftools","_weapon","_namecfg","_numberofitems","_item"];
_box = _this select 0;

//_box = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

_numberofguns = (round ((random 2) * wai_mission_noftreasureguns));	// Chance for a gun
_numberofitems = wai_mission_noftreasureitems;				// Extra gold

for "_i" from 1 to _numberofguns do {
	_weapon = treasure_box_random_guns call BIS_fnc_selectRandom;
	_mags = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");
	_box addWeaponCargoGlobal [_weapon,1];
	_box addMagazineCargoGlobal [(_mags select 0),round(random 3) + 1];
};

for "_i" from 1 to _numberofitems do {
	_item = treasure_box_random_items call BIS_fnc_selectRandom;
	_box addMagazineCargoGlobal [_item,1];
};
