// Name of this crate
_crateName = "(Most) Weapons Crate";

// Crate type
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

_spawnCrate addWeaponCargoGlobal ["glock17_EP1", 10];
_spawnCrate addWeaponCargoGlobal ["M1014", 10];
_spawnCrate addWeaponCargoGlobal ["M4A1", 10];
_spawnCrate addWeaponCargoGlobal ["nsw_er7s", 10];
_spawnCrate addMagazineCargoGlobal ["8Rnd_B_Beneli_74Slug", 30];
_spawnCrate addMagazineCargoGlobal ["17Rnd_9x19_glock17", 30];
_spawnCrate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 30];
_spawnCrate addMagazineCargoGlobal ["PipeBomb", 30];
_spawnCrate addMagazineCargoGlobal ["nsw_er7mm", 30];


// Send text to spawner only
titleText [format[_crateName + " spawned!"],"PLAIN DOWN"]; titleFadeOut 4;

