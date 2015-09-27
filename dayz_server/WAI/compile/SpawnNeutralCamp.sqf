private ["_campNumber","_position","_dir","_vehclass","_numUnits","_timeoutSeconds","_X","_Y","_Z","_objectList","_veh","_radius","_wpnumber","_notTimedOut","_createdTime","_currentTime","_playerPresent","_cleanCamp","_campId","_grp","_weapCrate","_itemCrate","_numberofguns","_numberoftools","_numberofitems","_weapon", "_mags", "_tool", "_item", "_extraStuff", "_campfire"];

_campNumber = _this select 0;
_position = _this select 1;
_dir = _this select 2;
_vehclass = _this select 3;
_numUnits = _this select 4;
_timeoutSeconds = _this select 5;

_X = _position select 0;
_Z = _position select 1;
_Y = _position select 2;

// Spawn campfire so it is visible from distance
_campfire = createVehicle ["Land_Campfire_burning", 	[_X, _Z, _Y], 			[], 0, "CAN_COLLIDE"],	//1

waitUntil
{
	sleep 5;
	_playerPresent = false;
	{ if ((isPlayer _x) AND (_x distance _position <= 1000)) then {_playerPresent = true}; } forEach playableUnits;
	(_playerPresent)
};

_objectList = [
	createVehicle ["MAP_Misc_WoodPile", 		[_X-3.104, _Z+0.8384, _Y], 	[], 0, "CAN_COLLIDE"],	//0
	_campfire,
	createVehicle ["ACamp_EP1", 			[_X+1.3032, _Z+4.1563, _Y], 	[], 0, "CAN_COLLIDE"],	//2
	createVehicle ["Land_A_tent", 			[_X-1.6001, _Z-4.6533, _Y], 	[], 0, "CAN_COLLIDE"],	//3
	createVehicle ["ACamp",				[_X+4.9731, _Z+0.7217, _Y], 	[], 0, "CAN_COLLIDE"],	//4
	createVehicle ["BAF_OrdnanceBox", 		[_X+2.2461, _Z+1.7681, _Y], 	[], 0, "CAN_COLLIDE"],	//5
	createVehicle ["Land_A_tent", 			[_X+1.3779, _Z-5.3525, _Y], 	[], 0, "CAN_COLLIDE"],	//6
	createVehicle ["ACamp", 			[_X+4.7051, _Z-3.3716, _Y], 	[], 0, "CAN_COLLIDE"],	//7
	createVehicle ["WeaponHolder_ItemTentOld", 	[_X-3.8447, _Z+0.9351, _Y], 	[], 0, "CAN_COLLIDE"],	//8
	createVehicle ["BAF_Launchers", 		[_X-3.5103, _Z-0.6777, _Y], 	[], 0, "CAN_COLLIDE"]	//9
];

_itemCrate = _objectList select 5;
_weapCrate = _objectList select 9;

(_objectList select 2) setDir (_dir-61.532906);
(_objectList select 3) setDir (_dir+198.07671);
(_objectList select 4) setDir (_dir-16.631907);
(_objectList select 6) setDir (_dir+166.38849);
(_objectList select 7) setDir (_dir+30.707647);
_itemCrate setDir (_dir+58.662807);
_weapCrate setDir (_dir-0.041808173);

(_objectList select 0) setPos [_X-3.104, _Z+0.8384, _Y];
(_objectList select 1) setPos [_X, _Z, _Y];
(_objectList select 2) setPos [_X+1.3032, _Z+4.1563, _Y];
(_objectList select 3) setPos [_X-1.6001, _Z-4.6533, _Y];
(_objectList select 4) setPos [_X+4.9731, _Z+0.7217, _Y];
_itemCrate setPos [_X+2.2461, _Z+1.7681, _Y];
(_objectList select 6) setPos [_X+1.3779, _Z-5.3525, _Y];
(_objectList select 7) setPos [_X+4.7051, _Z-3.3716, _Y];
(_objectList select 8) setPos [_X-3.8447, _Z+0.9351, _Y];
_weapCrate setPos [_X-3.5103, _Z-0.6777, _Y];


// Add items
_itemCrate setVariable ["ObjectID","1",true];
_itemCrate setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_itemCrate];

clearWeaponCargoGlobal _itemCrate;
clearMagazineCargoGlobal _itemCrate;

_numberoftools = (round (random 2)) + 3;
_numberofitems = (round (random 2)) + 8;

for "_i" from 1 to _numberoftools do {
	_tool = 
	[
		"ItemToolbox",
		"ItemKnife",
		"ItemCrowbar",
		"ItemEtool",
		"Binocular",
		"Binocular_Vector",
		"ItemCompass",
		"ItemFishingPole",
		"ItemFlashlightRed",
		"ItemGPS",
		"ItemHatchet_DZE",
		"ItemMachete",
		"ItemMatchbox_DZE",
		"NVGoggles",
		"chainsaw"
	] call BIS_fnc_selectRandom;
	_itemCrate addWeaponCargoGlobal [_tool,2];
};

for "_i" from 1 to _numberofitems do {
	_item = [
		"ItemBandage",
		"ItemBandage",
		"ItemBandage",
		"ItemBandage",
		"FoodCanFrankBeans",
		"FoodCanFrankBeans",
		"FoodCanBakedBeans",
		"FoodCanBakedBeans",
		"FoodCanSardines",
		"FoodCanSardines",
		"FoodCanPasta",
		"FoodCanPasta",
		"FoodMRE",
		"FoodMRE",
		"ItemBloodbag",
		"ItemBloodbag",
		"ItemBloodbag",
		"ItemBloodbag",
		"ItemMorphine",
		"ItemMorphine",
		"ItemMorphine",
		"ItemMorphine",
		"ItemMorphine",
		"ItemMorphine",
		"ItemSodaCoke",
		"ItemSodaPepsi",
		"ItemSodaMdew",
		"ItemSodaPepsi",
		"ItemSodaCoke",
		"ItemSodaPepsi",
		"ItemSodaOrangeSherbet",
		"ItemSodaPepsi",
		"ItemSodaRbull",
		"ItemSodaPepsi",
		"ItemBriefcase100oz",
		"ItemBriefcase100oz"
	] call BIS_fnc_selectRandom;
	_itemCrate addMagazineCargoGlobal [_item,1];
};
_extraStuff = [2, 2, 4, 2, 2, 2] call generateItems;
{ _itemCrate addMagazineCargoGlobal [_x,1]; } count (_extraStuff select 0);
{ _itemCrate addWeaponCargoGlobal [_x,1]; } count (_extraStuff select 1);


// Add weapons
_weapCrate setVariable ["ObjectID","1",true];
_weapCrate setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_weapCrate];

clearWeaponCargoGlobal _weapCrate;
clearMagazineCargoGlobal _weapCrate;

_numberofguns = (round (random 2)) + 3;

for "_i" from 1 to _numberofguns do {
	_weapon = [
		"M9SD",
		"M9",
		"AKS_74_UN_kobra",
		"AK_107_pso",
		"M4A3_CCO_EP1",
		"M4A1_AIM_SD_camo",
		"M16A4_ACG",
		"VSS_vintorez",
		"M8_sharpshooter",
		"M40A3",
		"Mk_48_DZ",
		"M240_DZ",
		"M249_DZ",
		"Pecheneg_DZ",
		"RPK_74",
		"BAF_LRR_scoped",
		"DMR",
		"SVD_CAMO",
		"SCAR_H_LNG_Sniper_SD",
		"M110_NVG_EP1",
		"Sa58V_RCO_EP1",
		"KSVK_DZE",
		"BAF_L86A2_ACOG",
		"M14_EP1",
		"Sa58V_CCO_EP1"
	] call BIS_fnc_selectRandom;
	_mags = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");
	_weapCrate addWeaponCargoGlobal [_weapon,1];
	_weapCrate addMagazineCargoGlobal [(_mags select 0),round(random 2) + 2];
};

// Add AI units
_radius = ai_patrol_radius;
_wpnumber = ai_patrol_radius_wp;
ai_patrol_radius = 20;
ai_patrol_radius_wp = 5;
[
	[_X-4.1538, _Z-2.4683, _Y],	// Relative position
	_numUnits,			//Number Of units
	0.25,				//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,				//Primary gun set number. "Random" for random weapon set.
	3,				//Number of magazines
	"",				//Backpack "" for random or classname here.
	"Survivor2_DZ",			//Skin "" for random or classname here.
	5,				//Gearset number 5, the random loot table.
	false,
	_campNumber
] call spawn_neutral_group;

ai_patrol_radius = _radius;
ai_patrol_radius_wp = _wpnumber;

// Create vehicle
_veh = createVehicle [_vehclass, [_X+4.3032, _Z+5.1563, _Y], [], 0, "CAN_COLLIDE"];
_veh setDir _dir;
_veh setPos [_X+4.3032, _Z+5.1563, _Y];
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
_veh setVariable ["ObjectID","1",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];

diag_log format["WAI: Spawned a %1 at camp", _vehclass];
diag_log format ["WAI: Spawned a camp of %1 Neutrals at %2", _numUnits, _position];

_createdTime = floor(time);
_notTimedOut = true;
_playerPresent = false;
_cleanCamp = false;

ai_active_survivorcamps = ai_active_survivorcamps + 1;

while { _notTimedOut } do {
	sleep 5;
	_currentTime = floor(time);
	{if((isPlayer _x) AND (_x distance _position <= 100)) then {_playerPresent = true};}forEach playableUnits;
	if (_currentTime - _createdTime >= _timeoutSeconds) then {_cleanCamp = true;};
	if ((_playerPresent) OR (_cleanCamp)) then {_notTimedOut = false;}
};
if (_playerPresent) then {
	[_veh,[_dir, (getPos _veh)],_vehclass,true,"0"] call custom_publish;
	waitUntil
	{
		sleep 5;
		_playerPresent = false;
		{if((isPlayer _x) AND (_x distance _position <= 30)) then {_playerPresent = true};}forEach playableUnits;
		(_playerPresent)
	};
	diag_log format["WAI: Survivor Camp found At %1",_position];
} else {
	deleteVehicle _veh;
	{ deleteVehicle _x } count _objectList;

	// Remove the AI survivors (only for this camp)
	{
		_campId = _x getVariable "camp_id";
		if (!isNil "_campId") then {
			if (_campId == _campNumber) exitWith {
				_grp = group _x;
				{
					deleteVehicle _x;
					ai_ground_units = (ai_ground_units - 1);

				} count units _grp;
				deleteGroup _grp;
			};
		};
	} forEach allUnits;

	diag_log format["WAI: Survivor Camp timed out At %1",_position];
};
ai_active_survivorcamps = ai_active_survivorcamps - 1;
