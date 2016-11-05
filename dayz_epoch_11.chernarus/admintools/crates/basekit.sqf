// Name of this crate
_crateName = "Base Kit";

// Crate type. Possibilities: MedBox0, FoodBox0, BAF_BasicWeapons, USSpecialWeaponsBox, USSpecialWeapons_EP1, USVehicleBox, RUSpecialWeaponsBox, RUVehicleBox, etc.
_classname = "USOrdnanceBox";

// Location of player and crate
_dir = getdir player;
_pos = getposATL player;
_pos = [(_pos select 0)+1*sin(_dir),(_pos select 1)+1*cos(_dir), (_pos select 2)];
_spawnCrate = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
_spawnCrate setDir _dir;
_spawnCrate setposATL _pos;

// Remove default items/weapons from current crate before adding custom gear
clearWeaponCargoGlobal _spawnCrate;
clearMagazineCargoGlobal _spawnCrate;
clearBackpackCargoGlobal _spawnCrate;

// Add weapon-slot items to crate
// Syntax: _spawnCrate addWeaponCargoGlobal ["ITEM", number-of-items];
_spawnCrate addWeaponCargoGlobal ["ItemSledge", 1];
_spawnCrate addWeaponCargoGlobal ["ItemEtool", 1];
_spawnCrate addWeaponCargoGlobal ["ItemHatchet", 1];
_spawnCrate addWeaponCargoGlobal ["ItemCrowbar", 1];
_spawnCrate addWeaponCargoGlobal ["ItemKnife", 1];

// Add magazine-slot items to crate
// Syntax: _spawnCrate addMagazineCargoGlobal ["ITEM", number-of-items];
_spawnCrate addMagazineCargoGlobal ["cinder_wall_kit", 10];
_spawnCrate addMagazineCargoGlobal ["CinderBlocks", 60];
_spawnCrate addMagazineCargoGlobal ["MortarBucket", 16];
_spawnCrate addMagazineCargoGlobal ["ItemVault", 1];
_spawnCrate addMagazineCargoGlobal ["metal_floor_kit", 9];
_spawnCrate addMagazineCargoGlobal ["ItemComboLock", 2];
_spawnCrate addMagazineCargoGlobal ["PartWoodLumber", 52];
_spawnCrate addMagazineCargoGlobal ["PartWoodPlywood", 51];
_spawnCrate addMagazineCargoGlobal ["bulk_ItemTankTrap", 3];
_spawnCrate addMagazineCargoGlobal ["bulk_PartGeneric", 4];
_spawnCrate addMagazineCargoGlobal ["30m_plot_kit", 1];
_spawnCrate addMagazineCargoGlobal ["ItemLightBulb", 2];

// Add only 1 backpack. The rest will fall out onto the ground. Do not use LargeGunBag here, the box will not hold it.
//_spawnCrate addBackpackCargoGlobal ["DZ_Backpack_EP1", 1];

// Send text to spawner only
titleText [format[_crateName + " spawned!"],"PLAIN DOWN"]; titleFadeOut 4;

// Run delaymenu
delaymenu = 
[
	["",true],
	["Select delay", [-1], "", -5, [["expression", ""]], "1", "0"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["30 seconds", [], "", -5, [["expression", "SelectDelay=30;DelaySelected=true;"]], "1", "1"],
	["1 min", [], "", -5, [["expression", "SelectDelay=60;DelaySelected=true;"]], "1", "1"],
	["3 min", [], "", -5, [["expression", "SelectDelay=180;DelaySelected=true;"]], "1", "1"],
	["5 min", [], "", -5, [["expression", "SelectDelay=300;DelaySelected=true;"]], "1", "1"],
	["10 min", [], "", -5, [["expression", "SelectDelay=600;DelaySelected=true;"]], "1", "1"],
	["30 min", [], "", -5, [["expression", "SelectDelay=1800;DelaySelected=true;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["No timer", [], "", -5, [["expression", "DelaySelected=false;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"]
];
showCommandingMenu "#USER:delaymenu";
WaitUntil{DelaySelected};
DelaySelected=false;
titleText [format[_crateName + " will disappear in %1 seconds.",SelectDelay],"PLAIN DOWN"]; titleFadeOut 4;
sleep SelectDelay;

// Delete crate after SelectDelay seconds
deletevehicle _spawnCrate;
titleText [format[_crateName + " disappeared."],"PLAIN DOWN"]; titleFadeOut 4;
