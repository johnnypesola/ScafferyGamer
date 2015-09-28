spawn_group = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnGroup.sqf";
spawn_neutral_group = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnNeutralGroup.sqf";
spawn_neutral_group2 = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnNeutralGroupNoPatrol.sqf";
spawn_hero_group = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnHeroGroup.sqf";
group_waypoints = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\patrol.sqf";
group_goalposition = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\goalposition.sqf";
spawn_static = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnStatic.sqf";
spawn_neutral_static = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnNeutralStatic.sqf";
spawn_hero_static = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnHeroStatic.sqf";
heli_para = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
heli_patrol = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
vehicle_patrol = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";
vehicle_patrol_neutral = 	compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol_neutral.sqf";
friendly_transport =	 	compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\transport_friendly.sqf";
survivor_camp = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnNeutralCamp.sqf";
kent_combat =			compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\SpawnKentKombat.sqf";

// Function that generates the loot when a heli has crashed (crew members can still be alive though)
fn_generateCrashLoot = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\gen_crash_loot.sqf";
fn_createHeliPatrol = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol_global.sqf";

on_kill = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_killed.sqf";
on_kill_hero = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_hero_killed.sqf";
on_kill_neutral = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_neutral_killed.sqf";

ai_monitor = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\AImonitor.sqf";
veh_monitor = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_monitor.sqf";

attack_intruder = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\attack_intruder.sqf";

pickRandom = {
	private["_item", "_quantity", "_result", "_y", "_ret"];
	_param = _this select 0;
	_result = [];
	{
		_item = _x select 0;
		_quantity = _x select 1;
		for "_i" from  1 to _quantity do {
			_result set [count _result, _item];
		}; 
	} forEach _param;
	_ret = _result call BIS_fnc_selectRandom;
	_ret
};

generateItems = {
	private["_items_list", "_tools_list","_num_drinks_food", "_num_gold","_num_rare_ammo","_num_ammo","_num_tools","_num_mats","_drinks_and_food", "_gold", "_rare_ammo", "_ammo", "_tools", "_mats", "_y", "_foodAmount", "_goldAmount", "_ammoAmount", "_rareAmmoAmount", "_toolsAmount", "_matsAmount"];

	if (!isNil "_this") then {
		
		if ((count _this) == 6) then {
			
			_foodAmount  = _this select 0;
			_goldAmount  = _this select 1;
			_ammoAmount  = _this select 2;
			_rareAmmoAmount = _this select 3;
			_toolsAmount = _this select 4;
			_matsAmount  = _this select 5;
		};
	};


	if (isNil "_foodAmount") then { _foodAmount = 1; };
	if (isNil "_goldAmount") then { _goldAmount = 1; };
	if (isNil "_ammoAmount") then { _ammoAmount = 1; };
	if (isNil "_rareAmmoAmount") then { _rareAmmoAmount = 1; };
	if (isNil "_toolsAmount") then { _toolsAmount = 1; };
	if (isNil "_matsAmount") then { _matsAmount = 1; };

	_items_list = [];
	_tools_list = [];

	_num_drinks_food = _foodAmount * (floor ((random 1)+0.33) + floor ((random 1)+0.05)); // 67% chance for food + 5% chance for another one 
	_drinks_and_food = [
		["ItemSodaPepsi", 3],
		["ItemSodaCoke", 3],
		["ItemSodaOrangeSherbet", 2],
		["ItemSodaMdew", 1],
		["ItemSodaRbull", 1],
		["FoodCanFrankBeans", 1],
		["FoodCanBakedBeans", 1],
		["FoodCanSardines", 1],
		["FoodCanPasta", 1],
		["FoodCanUnlabeled", 1],
		["FoodPistachio", 1],
		["FoodNutmix", 1],
		["FoodSunFlowerSeed", 1],
		["FoodMRE", 1],
		["FoodrabbitCooked", 1]
	];

	_num_gold = _goldAmount*floor ((random 1)+0.05);	// 5% chance that the AI carries gold
	_gold = [
		["ItemGoldBar10oz", 55],	// 55% chance
		["ItemBriefcase20oz", 39],	// 39% chance
		["ItemBriefcase50oz", 5],	// 5% chance
		["ItemBriefcase100oz", 1]	// 1% chance
	];

	_num_rare_ammo = _rareAmmoAmount*floor ((random 1)+0.05);	// 5% chance that he carries some rare ammo
	_rare_ammo = [
		["100Rnd_762x51_M240", 20],	// 20% chance
		["100Rnd_556x45_M249", 20],	// 20% chance
		["200Rnd_556x45_M249", 20],	// 20% chance
		["100Rnd_762x54_PK", 20],	// 20% chance
		["5Rnd_86x70_L115A1", 10],	// 10% chance
		["10Rnd_127x99_m107", 4],	// 4% chance
		["5Rnd_127x108_KSVK", 5],	// 5% chance
		["Pipebomb", 1]	// 1% chance
	];

	_num_ammo = _ammoAmount*floor ((random 1)+0.2);	// 20% chance that he carries casual ammo
	_ammo = [
		["2Rnd_shotgun_74Slug", 4],	// 4% chance
		["2Rnd_shotgun_74Pellets", 4],	// 4% chance
		["8Rnd_9x18_Makarov", 10],	// 10% chance
		["6Rnd_45ACP", 5],		// 5% chance
		["7Rnd_45ACP_1911", 5],		// 5% chance
		["15Rnd_9x19_M9", 2],		// 2% chance
		["17Rnd_9x19_glock17", 2],	// 2% chance
		["8Rnd_B_Beneli_74Slug", 2],	// 2% chance
		["8Rnd_B_Beneli_Pellets", 2],	// 2% chance
		["15Rnd_W1866_Slug", 10],	// 10% chance
		["30Rnd_9x19_UZI", 2],		// 2% chance
		["30Rnd_9x19_MP5", 4],		// 4% chance
		["10x_303", 10],		// 10% chance
		["30Rnd_545x39_AK", 3],		// 3% chance
		["30Rnd_556x45_G36", 3],	// 3% chance
		["30Rnd_556x45_Stanag", 3],	// 3% chance
		["75Rnd_545x39_RPK", 1],	// 1% chance
		["100Rnd_556x45_BetaCMag", 1],	// 1% chance
		["20Rnd_762x51_FNFAL", 1],	// 1% chance
		["30Rnd_762x39_SA58", 1],	// 1% chance
		["30Rnd_762x39_AK47", 1],	// 1% chance
		["20Rnd_B_765x17_Ball", 1],	// 1% chance
		["20Rnd_762x51_SB_SCAR", 1],	// 1% chance
		["20Rnd_762x51_DMR", 2],	// 2% chance
		["5Rnd_762x51_M24", 2],		// 2% chance
		["5x_22_LR_17_HMR", 6],		// 6% chance
		["8Rnd_9x18_MakarovSD", 4],	// 4% chance
		["15Rnd_9x19_M9SD", 1],		// 1% chance
		["30Rnd_9x19_UZI_SD", 1],	// 1% chance
		["30Rnd_9x19_MP5SD", 1],	// 1% chance
		["10Rnd_9x39_SP5_VSS", 2],	// 2% chance
		["20Rnd_9x39_SP5_VSS", 1],	// 1% chance
		["30Rnd_556x45_G36SD", 1],	// 1% chance
		["30Rnd_556x45_StanagSD", 1]	// 1% chance
		
	];

	_num_tools = _toolsAmount*floor ((random 1)+0.05);	// 5% chance he will carry one tool
	_tools = [
		["ItemMatchbox_DZE", 2],// 2% chance
		["ItemKnife", 10],	// 10% chance
		["ItemMachete", 5],	// 5% chance
		["ItemHatchet_DZE", 9],	// 9% chance
		["ItemCrowbar", 2],	// 2% chance
		["ItemWatch", 5],	// 5% chance
		["ItemMap", 2],		// 2% chance
		["ItemFlashlight", 10],	// 10% chance
		["ItemFlashlightRed", 5],// 5% chance
		["ItemEtool", 2],	// 2% chance
		["ItemFishingPole", 10],// 10% chance
		["ItemSledge", 1],	// 1% chance
		["ItemToolbox", 10],	// 10% chance
		["Binocular", 10],	// 10% chance
		["Binocular_Vector", 5],// 5% chance
		["NVGoggles", 1],	// 1% chance
		["ItemGPS", 2],		// 2% chance
		["ItemRadio", 3],	// 3% chance
		["ItemCompass", 5],	// 5% chance
		["ItemKeyKit", 1]	// 1% chance
	];


	_num_mats = _matsAmount*floor ((random 1)+0.1) + floor ((random 1)+0.05);	// 10% + 5% chance he will carry some material
	_mats = [
		["ItemHotwireKit", 1],	// 0.43%
		["ItemPlotDeed", 1],	// 0.43%
		["PartVRotor", 20],	// 8.33%
		["PartGlass", 20],	// 8.33%
		["ItemComboLock", 1],	// 0.43%
		["PartWheel", 30],	// 8.33%
		["PartGeneric", 20],	// 8.33%
		["ItemPole", 10],	// 4.17%
		["ItemFuelBarrelEmpty", 10],// 4.17%
		["ItemJerrycan", 20],	// 8.33%
		["ItemLockbox", 1],	// 0.43%
		["PartEngine", 10],	// 4.17%
		["PartWoodPile", 20],	// 8.33%
		["PartPlankPack", 10],	// 4.17%
		["PartPlywoodPack", 10],// 4.17%
		["ItemTankTrap", 20],	// 8.33%
		["ItemPainkiller", 20],	// 8.33%
		["ItemBloodbag", 10],	// 4.17%
		["ItemBandage", 20]	// 8.33%
	];

	for [{_y=0},{_y<_num_drinks_food},{_y=_y+1}] do {
		_el = [_drinks_and_food] call pickRandom;
		_items_list set [count _items_list, _el];
	};
	for [{_y=0},{_y<_num_gold},{_y=_y+1}] do {
		_el = [_gold] call pickRandom;
		_items_list set [count _items_list, _el];
	};
	for [{_y=0},{_y<_num_rare_ammo},{_y=_y+1}] do {
		_el = [_rare_ammo] call pickRandom;
		_items_list set [count _items_list, _el];
	};
	for [{_y=0},{_y<_num_ammo},{_y=_y+1}] do {
		_el = [_ammo] call pickRandom;
		_items_list set [count _items_list, _el];
	};
	for [{_y=0},{_y<_num_tools},{_y=_y+1}] do {
		_el = [_tools] call pickRandom;
		_tools_list set [count _tools_list, _el];
	};
	for [{_y=0},{_y<_num_mats},{_y=_y+1}] do {
		_el = [_mats] call pickRandom;
		_items_list set [count _items_list, _el];
	};

	// Return the two lists as gear
	[ _items_list, _tools_list ]
};

createCenter east;
createCenter resistance;

// Alliances
//------------

// Bandits/Soldiers
EAST setFriend [WEST,0];
//EAST setFriend [RESISTANCE,0];

// Players
//WEST setFriend [RESISTANCE,1];
WEST setFriend [EAST,0];

// Soldiers
//RESISTANCE setFriend [EAST,0];
//RESISTANCE setFriend [WEST,1];

// Make AI Hostile to Zeds
EAST setFriend [CIVILIAN,0];
CIVILIAN setFriend [EAST,0];

WAIconfigloaded = False;
WAImissionconfig = False;

ai_ground_units = 0;
ai_emplacement_units = 0;
ai_air_units = 0;
ai_vehicle_units = 0;
ai_active_survivorcamps = 0;

//Load config
[] ExecVM "\z\addons\dayz_server\WAI\AIconfig.sqf";
//Wait for config
waitUntil {WAIconfigloaded};
diag_log "WAI: AI Config File Loaded";
[] spawn ai_monitor;
//Load custom spawns
[] ExecVM "\z\addons\dayz_server\WAI\customSpawns.sqf";
if (ai_mission_sysyem) then {
	//Load AI mission system
	[] ExecVM "\z\addons\dayz_server\WAI\missions\missionIni.sqf";
};

// Dynamic AI in the spawning cities
[] ExecVM "\z\addons\dayz_server\WAI\dynamic\dynamic_ai_monitor.sqf";

// Dynamic AI heli patrols around the map
[] ExecVM "\z\addons\dayz_server\WAI\dynamic\dynamic_ai_heli_patrol_monitor.sqf";

// Dynamic AI survivor camps
[] ExecVM "\z\addons\dayz_server\WAI\dynamic\dynamic_ai_camp_monitor.sqf";

// Boat transports Airport <-> Northern Island
[] ExecVM "\z\addons\dayz_server\WAI\transport\transporters.sqf";
