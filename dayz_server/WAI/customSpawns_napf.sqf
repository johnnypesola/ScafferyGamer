Private ["_radius","_wp","_entities","_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats"];

//Custom Spawns file//


/*
Custom group spawns Eg.

[[953.237,4486.48,0.001], //position
4,                    //Number Of units
1,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",               //Primary gun set number. "Random" for random weapon set.
4,                    //Number of magazines
"",                    //Backpack "" for random or classname here.
"Bandit2_DZ",           //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;

Place your custom group spawns below
*/

BASE_NMB = 0;
BASE_SMB = 1;
keep_respawning = [false, false];

pick_n_positions = {
	private ["_input_list", "_cloned_list", "_item", "_nof_groups","_result_array","_item2"];
	_input_list = _this select 0;
	_nof_groups = _this select 1;
	_cloned_list = +_input_list;
	_result_array = [];
	for "_i" from 1 to _nof_groups do {
		_item = _cloned_list call BIS_fnc_selectRandom;
		for "_j" from 0 to (count _cloned_list)-1 do {
			_item2 = _cloned_list select _j;
			if ([_item2, _item] call BIS_fnc_areEqual) then {
				_cloned_list set [_j, -1];
			};
		};
		// Remove picked element from cloned list
		_cloned_list = _cloned_list - [-1];
		_result_array set [count _result_array, _item];
	};
	_result_array
};

add_launchers = {
	private ["_group","_unit","_launcherClass","_launcherAmmoClass"];
	_group = _this select 0;
	_launcherClass = _this select 1;
	_launcherAmmoClass = _this select 2;
	// These guys might have some AT weapons + ammo.
	{
		_unit = _x;
		if ((random 1) > .5) exitWith {	// 50% chance
			_unit addWeapon _launcherClass;
			_unit addMagazine _launcherAmmoClass;
		};
	} forEach units _group;
};

spawn_reinforcement_patrol = {
	private ["_starting_point","_group_alive","_group","_groups","_actual_point","_faction","_target_point","_timeout","_nofUnits","_unit","_base_idx","_launchers"];
	_group_alive = false;
	_faction = _this select 0;
	_starting_point = _this select 1;
	_target_point = _this select 2;
	_timeout = _this select 3;
	_base_idx = _this select 4;
	_nofUnits = 3;
	if ((count _this) == 6) then {
		_launchers = _this select 5;
	} else {
		if (_faction == "us") then {
			_launchers = ["MAAWS", "MAAWS_HEAT"];
		} else {
			_launchers = ["M136", "M136"];
		};
	};
	if (count _this == 7) then {
		_groups = _this select 6;
	} else {
		_groups = [];
	};
	_group = grpNull;

	while {keep_respawning select _base_idx} do {

		_actual_point = [_starting_point,0,900,10,0,1,0,[],_starting_point] call BIS_fnc_findSafePos;
		_actual_point set [2, 0];

		if (_faction == "us") then {
			// Respawn patrol
			_group = [
				_actual_point,    //position
				_nofUnits,        //Number Of units
				0.75,             //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
				4,                //Primary gun set number. "Random" for random weapon set.
				4,                //Number of magazines
				"",               //Backpack "" for random or classname here.
				"Soldier1_DZ",    //Skin "" for random or classname here.
				5,                //Gearset number. "Random" for random gear set.
				_groups,
				_target_point,
				false
			] call spawn_3rd_faction_group;
			[_group, _launchers select 0, _launchers select 1] call add_launchers;

		} else {
			// Respawn patrol
			_group = [
				_actual_point,    //position
				_nofUnits,        //Number Of units
				0.75,             //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
				4,                //Primary gun set number. "Random" for random weapon set.
				4,                //Number of magazines
				"",               //Backpack "" for random or classname here.
				"Bandit2_DZ",     //Skin "" for random or classname here.
				5,                //Gearset number. "Random" for random gear set.
				false,
				_target_point,
				false
			] call spawn_neutral_group;
			[_group, _launchers select 0, _launchers select 1] call add_launchers;
		};

		_group_alive = true;

		while {_group_alive} do {
			_group_alive = ({alive _x} count units _group) > 0;
			if (!(keep_respawning select _base_idx)) exitWith {
				diag_log format ["WAI: Stopping respawning of units..."];
			};
			for "_i" from 1 to 10 do {
				if (!(keep_respawning select _base_idx)) exitWith {
					diag_log format ["WAI: Stopping respawning of units..."];
				};
				sleep 1;
			};
		};
		for "_i" from 1 to (_timeout) do {
			if (!(keep_respawning select _base_idx)) exitWith {
				diag_log format ["WAI: Stopping respawning of units..."];
			};
			sleep 1;
		};
	};
};

spawn_snipers = {
	private ["_starting_point","_groups","_faction","_target_point","_units"];
	_faction = _this select 0;
	_starting_point = _this select 1;
	_target_point = _this select 2;
	_units = _this select 3;
	if (count _this == 5) then {
		_groups = _this select 4;
	} else {
		_groups = [];
	};
	if (_faction == "us") then {
		// Respawn patrol
		[
			_starting_point,  //position
			_units,           //Number Of units
			0.75,             //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
			7,                //Primary gun set number. "Random" for random weapon set.
			4,                //Number of magazines
			"",               //Backpack "" for random or classname here.
			"GUE_Soldier_Sniper_DZ",    //Skin "" for random or classname here.
			5,                //Gearset number. "Random" for random gear set.
			_groups,
			_target_point,
			false
		] call spawn_3rd_faction_sniper_group;
	} else {
		// Respawn patrol
		[
			_starting_point,  //position
			_units,           //Number Of units
			0.75,             //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
			7,                //Primary gun set number. "Random" for random weapon set.
			4,                //Number of magazines
			"",               //Backpack "" for random or classname here.
			"GUE_Soldier_Sniper_DZ",     //Skin "" for random or classname here.
			5,                //Gearset number. "Random" for random gear set.
			_target_point,
			false
		] call spawn_neutral_sniper_group;
	};
};

spawn_usable_static_gunners = {
	private ["_positions","_groups","_faction","_guntype"];
	_faction = _this select 0;
	_positions = _this select 1;
	_guntype = _this select 2;
	if (count _this == 4) then {
		_groups = _this select 3;
	} else {
		_groups = [];
	};
	if (_faction == "us") then {
		// US gunner 1
		[
			[_positions select 0], //position
			_guntype,         //Classname of turret
			0.5,              //Skill level 0-1. Has no effect if using custom skills
			"Soldier1_DZ",    //Skin "" for random or classname here.
			1,                //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
			2,                //Number of magazines. (not needed if ai_static_useweapon = False)
			"",               //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
			5,                //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
			-1,               // Use scalar to indicate gun persistence
			_groups
		] call spawn_3rd_faction_static;
		// US gunner 2
		[
			[_positions select 1], //position
			_guntype,         //Classname of turret
			0.5,              //Skill level 0-1. Has no effect if using custom skills
			"Soldier1_DZ",    //Skin "" for random or classname here.
			1,                //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
			2,                //Number of magazines. (not needed if ai_static_useweapon = False)
			"",               //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
			5,                //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
			-1,               // Use scalar to indicate gun persistence
			_groups
		] call spawn_3rd_faction_static;
	} else {
		// Bandit gunner 1
		[
			[_positions select 0], //position
			_guntype,         //Classname of turret
			0.5,              //Skill level 0-1. Has no effect if using custom skills
			"Bandit2_DZ",     //Skin "" for random or classname here.
			1,                //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
			2,                //Number of magazines. (not needed if ai_static_useweapon = False)
			"",               //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
			5,                //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
			-1                // Use scalar to indicate gun persistence
		] call spawn_neutral_static;
		// Bandit gunner 2
		[
			[_positions select 1], //position
			_guntype,         //Classname of turret
			0.5,              //Skill level 0-1. Has no effect if using custom skills
			"Bandit2_DZ",     //Skin "" for random or classname here.
			1,                //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
			2,                //Number of magazines. (not needed if ai_static_useweapon = False)
			"",               //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
			5,                //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
			-1                // Use scalar to indicate gun persistence
		] call spawn_neutral_static;
	};
};

// ---- Napf military base #1 AI groups follow ----
// ---- Napf military base #1 AI groups follow ----
// ---- Napf military base #1 AI groups follow ----
[] spawn {
	Private ["_proceed","_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects","_rare_loot_items","_result","_positions","_pos", "_total_groups","_location","_prize_veh","_prize_veh_chute","_class","_units","_i","_mg_list","_gunner_list","_respawn_patrol_starting_point","_target_point","_sniper_groups","_sniper_group","_pair","_gunner_list_pos","_grp","_kent_waypoints"];

/*
	// BEGIN Spawn a temporary box with upgrades
	_thebox = createVehicle ["BAF_VehicleBox",[15128.7,16422.9,0.0772419], [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;
	_thebox setVariable ["ObjectID","1",true];
	_thebox setVariable ["permaLoot",true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

	_thebox allowDamage false;

	_hidden_box_random_items = [
		"ItemARM",
		"ItemARM",
		"ItemARM",
		"ItemARM",
		"ItemORP",
		"ItemORP",
		"ItemORP",
		"ItemORP",
		"ItemAVE",
		"ItemAVE",
		"ItemAVE",
		"ItemAVE",
		"ItemLRK",
		"ItemLRK",
		"ItemLRK",
		"ItemLRK",
		"ItemTNK",
		"ItemTNK",
		"ItemTNK",
		"ItemTNK",
		"ItemTruckORP",
		"ItemTruckORP",
		"ItemTruckORP",
		"ItemTruckORP",
		"ItemTruckAVE",
		"ItemTruckAVE",
		"ItemTruckAVE",
		"ItemTruckAVE",
		"ItemTruckLRK",
		"ItemTruckLRK",
		"ItemTruckLRK",
		"ItemTruckLRK",
		"ItemTruckTNK",
		"ItemTruckTNK",
		"ItemTruckTNK",
		"ItemTruckTNK",
		"ItemTruckARM",
		"ItemTruckARM",
		"ItemTruckARM",
		"ItemTruckARM",
		"ItemTankORP",
		"ItemTankORP",
		"ItemTankORP",
		"ItemTankORP",
		"ItemTankAVE",
		"ItemTankAVE",
		"ItemTankAVE",
		"ItemTankAVE",
		"ItemTankLRK",
		"ItemTankLRK",
		"ItemTankLRK",
		"ItemTankLRK",
		"ItemTankTNK",
		"ItemTankTNK",
		"ItemTankTNK",
		"ItemTankTNK",
		"ItemHeliAVE",
		"ItemHeliAVE",
		"ItemHeliAVE",
		"ItemHeliAVE",
		"ItemHeliLRK",
		"ItemHeliLRK",
		"ItemHeliLRK",
		"ItemHeliLRK",
		"ItemHeliTNK",
		"ItemHeliTNK",
		"ItemHeliTNK",
		"ItemHeliTNK",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"equip_metal_sheet",
		"ItemScrews",
		"ItemScrews",
		"ItemTinBar",
		"ItemTinBar",
		"equip_scrapelectronics",
		"equip_scrapelectronics",
		"equip_scrapelectronics",
		"equip_scrapelectronics",
		"equip_floppywire",
		"equip_floppywire",
		"equip_floppywire",
		"equip_floppywire"
	];
	_hidden_box_random_tools = [
		"ItemToolbox",
		"ItemSolder_DZE"
	];

	{
		_thebox addMagazineCargoGlobal [_x,1];
	} forEach _hidden_box_random_items;
	{
		_thebox addWeaponCargoGlobal [_x,1];
	} forEach _hidden_box_random_tools;
*/
	// END Spawn a temporary box with upgrades

	_respawn_patrol_starting_point = [16408.867, 18325.08, 3.7562463];
	_target_point = [16745.498, 19048.521, 0.01];
	_gunner_list_pos = 0;

	// M2 gunner positions
	_mg_list = [
		[[16394.445, 18400.254, 8.9207115],[16386.613, 18393.176, 8.8817167]],
		[[16438.412, 18328.098, 5.9698877],[16417.037, 18296.625, 5.9706712]],
		[[16102.933, 18761.24, 6.6767454], [16093.552, 18749.891, 6.889411]],
		[[16466.064, 18405.842, 11.65085], [16455.637, 18414.383, 11.663869]],
		[[16478.484, 18395.828, 12.105547], [16490.365, 18385.664, 11.715808]],
		[[16542.553, 18225.869, 15.263895], [16544.762, 18227.645, 11.650205]],
		[[16613.752, 18233.564, 15.419233], [16615.773, 18235.254, 11.519668]],
		[[16895.002, 18368.586, 8.3367281], [16906.025, 18376.975, 4.8012056]],
		[[17107.875, 18799.629, 9.5566349], [17099.396, 18794.455, 9.049469]],
		[[16322.931, 18836.68, 5.7220459e-005], [16329.277, 18830.129, -0.96573746]],
		[[16112.576, 19474.26, 10.973132], [16113.663, 19468.738, 11.959474]],
		[[17754.354, 18946.91, -0.12465555], [17745.424, 18939.453, -0.13854066]]
	];

	_sniper_groups = [
		// [[<Sniper pair position>], <target position>],
		[[17926.191, 19030.486, -0.00067901611],[17762.195, 18968.633, -0.0003528595]],
		[[17924.615, 19029.152, 3.8146973e-006],[16273.404, 18574.674, -0.0001449585]],
		[[17277.861, 17090.695, -2.9563904e-005],[16868.787, 18313.459, -0.0012016296]],
		[[16682.729, 17314.996, 8.2969666e-005],[16671.32, 18033.615, -3.4332275e-005]]
	];

	// Static gunners that will remain after killed
	_gunner_list = [_mg_list, 7] call pick_n_positions;
	_respawn_patrol_starting_point = [16408.867, 18325.08, 3.7562463];

	waitUntil {sleep 5; {isPlayer _x && _x distance [16745.498, 19048.521, 0.01] <= 1000 } count playableunits > 0 };

	_radius = ai_patrol_radius;
	_wp = ai_patrol_radius_wp;
	ai_patrol_radius = 25;
	ai_patrol_radius_wp = 4;
	_thebox = objNull;

	// Guards 1
	_grp = [[16745.498, 19048.521, 0.01], //position
	4,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;


	// Guards 4
	_grp = [[16692.979, 19044.877, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 10
	_grp = [[16743.932, 18991.537, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 13
	_grp = [[16746.881, 19080.102, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 19
	_grp = [[16773.252, 19117.428, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 22
	_grp = [[16692.268, 19009.559, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	ai_patrol_radius_wp = _wp;
	ai_patrol_radius = _radius;

	// SearchLight 1
	[[[16623.537, 19096.074, 0.00014305115]], //position(s) (can be multiple).
	"SearchLight_TK_EP1",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// SearchLight 2
	[[[16624.289, 19090.277, 0.00014305115]], //position(s) (can be multiple).
	"SearchLight_TK_EP1",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 1
	[[[16685.227, 19087.596, 5.9127808e-005]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 2
	[[[16712.932, 19018.701, 0.00045967102]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 3
	[[[16694.984, 18996.77, -0.0001411438]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// HMMWV1
	[[16567.605, 19159.955, 0.011580579],   //Position to patrol
	[16567.605, 19159.955, 0.011580579],   // Position to spawn at
	200,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_Armored",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;

	// HMMWV2
	[[16569.605, 19144.955, 0.011580579],   //Position to patrol
	[16569.605, 19144.955, 0.011580579],   // Position to spawn at
	50,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;

	// HMMWV3
	[[16867.072, 18960.773, 0.011580579],   //Position to patrol
	[16867.072, 18960.773, 0.011580579],   // Position to spawn at
	50,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;


	// Spawn gunner pair
	_pair = _gunner_list select _gunner_list_pos;
	["bandits", _pair, "M2StaticMG"] call spawn_usable_static_gunners;
	_gunner_list_pos = _gunner_list_pos + 1;

	// LOOT

	_thebox = createVehicle ["USOrdnanceBox",[16771.174, 19084.066, -7.0571899e-005], [], 0, "CAN_COLLIDE"];
	_thebox setPos [16771.174, 19084.066, -7.0571899e-005];
	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;
	_thebox setVariable ["ObjectID","1",true];
	_thebox setVariable ["permaLoot",true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;

	_thebox allowDamage false;

	_hidden_box_number_of_gold = 5;
	_hidden_box_random_items = [
	"ItemBriefcase100oz"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 94],
		["ItemObsidian", 5],
		["ItemAmethyst", 1]
	];

	_numberofitems = (round (random 5)) + _hidden_box_number_of_gold;

	for "_i" from 1 to _numberofitems do {
		_item = _hidden_box_random_items call BIS_fnc_selectRandom;
		_thebox addMagazineCargoGlobal [_item,1];
	};

        // Add 1 item from the rare loot item list
        _result = [];
        {
            _item = _x select 0;
            _numberofitems = _x select 1;
            for "_i" from  1 to _numberofitems do {
                _result set [count _result, _item];
            };
        } forEach _rare_loot_items;
        _thebox addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];


	activeTier = 1;
	publicVariable "activeTier";


	keep_respawning set [BASE_NMB, true];
	["bandits", _respawn_patrol_starting_point, _target_point, 600, BASE_NMB] spawn spawn_reinforcement_patrol;

	// Loot monitor
	_proceed = false;
	while {!_proceed} do {
		// When player loots the box
		if (count ((getMagazineCargo _thebox) select 0) == 0) then {
			if (count ((getWeaponCargo _thebox) select 0) == 0) then {
				_proceed = true;
			};
		};
		sleep 5;
	};
	keep_respawning set [BASE_NMB, false];	// Disable continuous patrol spawns

	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;


	// Announce respawn!
	[nil,nil,rTitleText,"Reinforcements approaching Northern Military Base! ETA: 5 min", "PLAIN",3] call RE;
	sleep 300;

	// Delete old guns and search lights
	_objects = [16685.227, 19087.596, 5.9127808e-005] nearObjects ["M2StaticMG", 300];
	{ deleteVehicle _x } forEach _objects;
	_objects = [16685.227, 19087.596, 5.9127808e-005] nearObjects ["M2StaticMG", 300];
	{ deleteVehicle _x } forEach _objects;




	// ===============================
	// RESPAWN AI TIER 2 FOR THIS BASE
	// ===============================

	if (!isNull _thebox) then {
		deleteVehicle _thebox;
		sleep 0.1;
	};

	_thebox = createVehicle ["USOrdnanceBox",[16771.174, 19084.066, -7.0571899e-005], [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;
	_thebox setVariable ["ObjectID","1",true];
	_thebox setVariable ["permaLoot",true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

	_thebox allowDamage false;

	_hidden_box_number_of_gold = 2;
	_hidden_box_random_items = [
		"ItemObsidian"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 17],
		["ItemObsidian", 2],
		["ItemAmethyst", 1]
	];

	// Add the normal valuables...
	_numberofitems = (round (random 1)) + _hidden_box_number_of_gold;
	for "_i" from 1 to _numberofitems do {
		_item = _hidden_box_random_items call BIS_fnc_selectRandom;
		_thebox addMagazineCargoGlobal [_item,1];
	};

        // Add 1 item from the rare loot item list
        _result = [];
        {
            _item = _x select 0;
            _numberofitems = _x select 1;
            for "_i" from  1 to _numberofitems do {
                _result set [count _result, _item];
            };
        } forEach _rare_loot_items;
        _thebox addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];



	_radius = ai_patrol_radius;
	_wp = ai_patrol_radius_wp;
	ai_patrol_radius = 25;
	ai_patrol_radius_wp = 4;

	// Guards 1
	_grp = [[16745.498, 19048.521, 0.01], //position
	4,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	5,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 4
	_grp = [[16692.979, 19044.877, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 10
	_grp = [[16743.932, 18991.537, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 13
	_grp = [[16746.881, 19080.102, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 19
	_grp = [[16773.252, 19117.428, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	// Guards 22
	_grp = [[16692.268, 19009.559, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;
	[_grp,"M136","M136"] call add_launchers;

	ai_patrol_radius_wp = _wp;
	ai_patrol_radius = _radius;

	// SearchLight 1
	[[[16623.537, 19096.074, 0.00014305115]], //position(s) (can be multiple).
	"SearchLight_TK_EP1",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// SearchLight 2
	[[[16624.289, 19090.277, 0.00014305115]], //position(s) (can be multiple).
	"SearchLight_TK_EP1",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 1
	[[[16685.227, 19087.596, 5.9127808e-005]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	4,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 2
	[[[16712.932, 19018.701, 0.00045967102]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	4,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M2staticMG 3
	[[[16694.984, 18996.77, -0.0001411438]], //position(s) (can be multiple).
	"M2StaticMG",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// M113_1
	[[16567.605, 19159.955, 0.011580579],   //Position to patrol
	[16567.605, 19159.955, 0.011580579],   // Position to spawn at
	200,               //Radius of patrol
	10,                     //Number of waypoints to give
	"M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;

	// M113_2
	[[16569.605, 19144.955, 0.011580579],   //Position to patrol
	[16569.605, 19144.955, 0.011580579],   // Position to spawn at
	50,               //Radius of patrol
	10,                     //Number of waypoints to give
	"M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;

	// M113_3
	[[16867.072, 18960.773, 0.011580579],   //Position to patrol
	[16867.072, 18960.773, 0.011580579],   // Position to spawn at
	50,               //Radius of patrol
	10,                     //Number of waypoints to give
	"M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
	1                  //Skill level of units
	] spawn vehicle_patrol;

	// Paradrop just outside northern base entrance
	[[16609.537+(random 20),19090.074+(random 20),2.6292224],  //Position that units will be dropped by
	[17000,19100,100],                 //Starting position of the heli
	50,                                //Radius from drop position a player has to be to spawn chopper
	"CH_47F_EP1_DZ",                   //Classname of chopper (Make sure it has 2 gunner seats!)
	5,                                 //Number of units to be para dropped
	1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,                                 //Primary gun set number. "Random" for random weapon set.
	4,                                 //Number of magazines
	"DZ_British_ACU",                  //Backpack "" for random or classname here.
	"Bandit2_DZ",                      //Skin "" for random or classname here.
	4,                                 //Gearset number. "Random" for random gear set.
	True,                              //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
	["M136","M136"]
	] spawn heli_para;

	// Paradrop just outside northern base entrance
	[[16619.537,19000.074,2.6292224],  //Position that units will be dropped by
	[13000,19100,100],                 //Starting position of the heli
	300,                               //Radius from drop position a player has to be to spawn chopper
	"CH_47F_EP1_DZ",                   //Classname of chopper (Make sure it has 2 gunner seats!)
	5,                                //Number of units to be para dropped
	1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,                                 //Primary gun set number. "Random" for random weapon set.
	4,                                 //Number of magazines
	"DZ_British_ACU",                  //Backpack "" for random or classname here.
	"Bandit2_DZ",                      //Skin "" for random or classname here.
	4,                                 //Gearset number. "Random" for random gear set.
	True,                              //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
	["M136","M136"]
	] spawn heli_para;

	// Northern Heli patrol
	[[16712.932,19018.701,0],   //Position to patrol
	[20000,18000,20],           // Position to spawn chopper at
	500,                        //Radius of patrol
	10,                         //Number of waypoints to give
	"UH1Y",                     //Classname of vehicle (make sure it has driver and two gunners)
	1                           //Skill level of units
	] spawn heli_patrol;

	// Spawn static gunner pairs that will remain after killed
	for "_i" from _gunner_list_pos to _gunner_list_pos+1 do {
		_pair = _gunner_list select _i;
		["bandits", _pair, "M2StaticMG"] call spawn_usable_static_gunners;
	};
	_gunner_list_pos = _gunner_list_pos + 2;

	_proceed = false;

	while {!_proceed} do {
		// When player loots the box the second time
		if (count ((getMagazineCargo _thebox) select 0) == 0) then {
			if (count ((getWeaponCargo _thebox) select 0) == 0) then {
				_proceed = true;
			};
		};
		sleep 5;
	};

	keep_respawning set [BASE_NMB, true];
	["bandits", _respawn_patrol_starting_point, _target_point, 300, BASE_NMB] spawn spawn_reinforcement_patrol;

	// [17845.1,19458.2,0.00160302] <- Temporary position
	// [16686.3,19090.7,0.0014099] <- Original position

	_kent_waypoints = [
		[16741.7,19031.7,0.0013069],
		[16715.8,19027.7,0.00157854],
		[16713.6,18986.2,0.0947464],
		[16745.4,19014.9,0.0013117],
		[16717,19022.4,0.00156709],
		[16718,19055.2,0.00131504],
		[16698.2,19017.9,0.00145858],
		[16666.1,19023.4,0.00151472],
		[16663,19057.9,0.00134756],
		[16741.7,19031.7,0.0013069]
	];

	WAI_kentIsDead = false;
	[[16686.3,19090.7,0.0014099], _kent_waypoints] spawn kent_kombat;

	_proceed = false;

	while {!WAI_kentIsDead} do {sleep 5;};

	keep_respawning set [BASE_NMB, false];

	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;
	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;

	[nil,nil,rTitleText,"Kent has been defeated! Still, something is not right... maybe better take cover somewhere safe...", "PLAIN",5] call RE;
	sleep 300;

	if (isNil "MILBASE1_alarm_tower") then {
		MILBASE1_alarm_tower = nearestObject [[16685.227, 19087.596, 1.0], "MAP_Ind_IlluminantTower"];
	};

	[nil,MILBASE1_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 8;
	[nil,MILBASE1_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 8;
	[nil,MILBASE1_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 8;

	[nil,nil,rTitleText,"All right, survivors, you've cleared the bandit scum outta that base. Now all your base are belong to US", "PLAIN",5] call RE;
	sleep 15;

	// Delete old guns and search lights
	_objects = [16685.227, 19087.596, 1] nearObjects ["M2StaticMG", 300];
	{ deleteVehicle _x } forEach _objects;
	_objects = [16685.227, 19087.596, 1] nearObjects ["SearchLight_TK_EP1", 300];
	{ deleteVehicle _x } forEach _objects;

	sleep 0.1;

	// SPAWN US HEAVY FORCES
	_entities = ["AAV", "M2A2_EP1", "BAF_FV510_W"];
	//_entities = ["LAV25", "M1126_ICV_M2_EP1", "M1128_MGS_EP1", "AAV", "M2A2_EP1", "BAF_FV510_W"];
	_positions =
	[
		[16567.605, 19159.955, 0.011580579],
		[16569.605, 19144.955, 0.011580579],
		[16867.072, 18960.773, 0.011580579]
	];
	_total_groups = [];

	sleep 0.1;

	for "_i" from 0 to 2 do {
		_pos = _positions select _i;
		[_pos,   			// Position to patrol
		_pos,   		// Position to spawn at
		200,               	// Radius of patrol
		10,                     // Number of waypoints to give
		_entities call BIS_fnc_selectRandom, // Classname of vehicle (make sure it has driver and gunner)
		0.75,			// Skill level of units
		_total_groups
		] call vehicle_patrol_3rd_faction;
		sleep 0.1;
	};

	// ZU23_CDF
	[[[16623.537, 19096.074, 0.00014305115]], //position(s) (can be multiple).
	"ZU23_CDF",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Soldier1_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5,              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	false,
	_total_groups
	] call spawn_3rd_faction_static;

	// ZU23_CDF
	[[[16624.289, 19090.277, 0.00014305115]], //position(s) (can be multiple).
	"ZU23_CDF",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Soldier1_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5,              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	false,
	_total_groups
	] call spawn_3rd_faction_static;

	// ZU23_CDF
	[[[16685.227, 19087.596, 5.9127808e-005]], //position(s) (can be multiple).
	"ZU23_CDF",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Soldier1_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5,              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	false,
	_total_groups
	] call spawn_3rd_faction_static;

	// ZU23_CDF
	[[[16712.932, 19018.701, 0.00045967102]], //position(s) (can be multiple).
	"ZU23_CDF",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Soldier1_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	"Random",              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	false,
	_total_groups
	] call spawn_3rd_faction_static;

	// ZU23_CDF
	[[[16694.984, 18996.77, -0.0001411438]], //position(s) (can be multiple).
	"ZU23_CDF",             //Classname of turret
	0.5,                 //Skill level 0-1. Has no effect if using custom skills
	"Soldier1_DZ",           //Skin "" for random or classname here.
	1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
	"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5,              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	false,
	_total_groups
	] call spawn_3rd_faction_static;

	// Paradrop just outside northern base entrance
	[[16619.537,19100.074,2.6292224],  //Position that units will be dropped by
	[17000,19100,100],                 //Starting position of the heli
	400,                                //Radius from drop position a player has to be to spawn chopper
	"UH60M_EP1",                       //Classname of chopper (Make sure it has 2 gunner seats!)
	10,                                 //Number of units to be para dropped
	1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,                                 //Primary gun set number. "Random" for random weapon set.
	4,                                 //Number of magazines
	"DZ_British_ACU",                  //Backpack "" for random or classname here.
	"Soldier1_DZ",                      //Skin "" for random or classname here.
	5,                                 //Gearset number. "Random" for random gear set.
	True,                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
	["M136","M136"],
	_total_groups
	] spawn heli_para_3rd_faction;

	// Northern Heli patrol
	[[16712.932,19018.701,0],   //Position to patrol
	[18000,20000,100],           // Position to spawn chopper at
	500,                        //Radius of patrol
	10,                         //Number of waypoints to give
	"AH64D_EP1",                //Classname of vehicle (make sure it has driver and two gunners)
	1,                           //Skill level of units
	_total_groups
	] spawn heli_patrol_3rd_faction;

	keep_respawning set [BASE_NMB, true];
	["us", _respawn_patrol_starting_point, _target_point, 300, BASE_NMB] spawn spawn_reinforcement_patrol;

	// [17845.1,19458.2,0.00160302] <- Temporary position
	// [16686.3,19090.7,0.0014099] <- Original position

	// Spawn static gunner pairs that will remain after killed
	for "_i" from _gunner_list_pos to _gunner_list_pos+3 do {
		_pair = _gunner_list select _i;
		["us", _pair, "M2StaticMG"] call spawn_usable_static_gunners;
	};
	_gunner_list_pos = _gunner_list_pos + 4;

	// Wait until all groups are destroyed
	_proceed = false;
	_units = [];
	{ _units = _units + (units _x); } forEach _total_groups;
	while {not _proceed} do {
		_proceed = ({alive _x} count _units) == 0;
		sleep 30;
	};

	keep_respawning set [BASE_NMB, false];

	// Spawn prize vehicle at this position:
	_class = [
		"M113_TK_EP1","AH6J_EP1","UH1Y","pook_H13_gunship",
		"pook_H13_transport_GUE","AAV","BTR90_HQ_DZE","LAV25_HQ_DZE",
		"M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","BAF_Jackal2_L2A1_w",
		"M1133_MEV_EP1","M113Ambul_TK_EP1"
	] call BIS_fnc_selectRandom;
	_location = [16759.6,19046,0.00144861];

	_prize_veh_chute = createVehicle ["ParachuteMediumWest", [0,0,0], [], 0, "CAN_COLLIDE"];
	_prize_veh_chute setPos [_location select 0, _location select 1,(_location select 2) + 100];
	_prize_veh = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
	_prize_veh setvehiclelock "LOCKED";
	switch (_class) do {
		case "M113_TK_EP1": {
			//_prize_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
		};
		case "AH6J_EP1": {
			//_prize_veh removeMagazinesTurret ["4000Rnd_762x51_M134", [-1]];
			_prize_veh removeMagazinesTurret ["14Rnd_FFAR", [-1]];
		};
		case "UH1Y": {
			_prize_veh removeMagazinesTurret ["14Rnd_FFAR", [-1]];
		};
		case "Ka60_PMC": {
			_prize_veh setVehicleAmmo 0;
		};
		case "pook_H13_gunship": {
			//_prize_veh removeMagazinesTurret ["pook_1300Rnd_762x51_M60", [-1]];
		};
		case "pook_H13_transport_GUE": {
			//_prize_veh removeMagazinesTurret ["pook_250Rnd_762x51", [0]];
		};
		case "M1126_ICV_M2_EP1": {
			//_prize_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
		};
		case "M1126_ICV_mk19_EP1": {
			//_prize_veh removeMagazinesTurret ["48Rnd_40mm_MK19", [0]];
		};
	};
	clearWeaponCargoGlobal  _prize_veh;
	clearMagazineCargoGlobal  _prize_veh;

	_prize_veh attachTo [_prize_veh_chute, [0,0,-1.6]];
	sleep 1.0;
	WaitUntil{(([_prize_veh] call FNC_GetPos) select 2) < 0.1};
	detach _prize_veh;
	deleteVehicle _prize_veh_chute;
	_prize_veh setvehiclelock "UNLOCKED";

	// This shall not happen until forces are defeated!
	[_prize_veh,[getDir _prize_veh,getPosATL _prize_veh],_class,false,"0"] call server_publishVeh;

	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["us", _sniper_group select 0, _sniper_group select 1, 2, _total_groups] call spawn_snipers;
	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["us", _sniper_group select 0, _sniper_group select 1, 2, _total_groups] call spawn_snipers;
	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["us", _sniper_group select 0, _sniper_group select 1, 2, _total_groups] call spawn_snipers;
	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["us", _sniper_group select 0, _sniper_group select 1, 2, _total_groups] call spawn_snipers;

	[nil,nil,rTitleText,"Greedy bastards! You have now 120 seconds to leave. Mwahahaha...", "PLAIN",5] call RE;
	sleep 30;
	[nil,nil,rTitleText,"90 seconds...", "PLAIN",5] call RE;
	sleep 30;
	[nil,nil,rTitleText,"60 seconds...", "PLAIN",5] call RE;
	sleep 30;
	[nil,nil,rTitleText,"30 seconds...", "PLAIN",5] call RE;
	sleep 20;
	[nil,nil,rTitleText,"10 seconds...", "PLAIN",5] call RE;
	sleep 5;
	[nil,nil,rTitleText,"5 seconds...", "PLAIN",5] call RE;
	sleep 5;

	_entities = [16685.227, 19087.596, 1.0] nearObjects ["Base_WarfareBBarrier10xTall", 300];
	_entities = _entities + ([16685.227, 19087.596, 1.0] nearObjects ["Land_Mil_Barracks_i", 300]);
	_entities = _entities + ([16685.227, 19087.596, 1.0] nearObjects ["MAP_fort_watchtower", 300]);

	{ "Bo_GBU12_LGB" createVehicle getPos _x; sleep ([0.3, 0.1, 0.5, 0.4, 0.6, 0.2] call BIS_fnc_selectRandom); } forEach _entities;
	if ([16685.227, 19087.596, 5.9127808e-005] distance _prize_veh < 150) then {
		_prize_veh setDamage 1.0;
	};
};


// ---- Napf military base #1 AI groups end ----
// ---- Napf military base #1 AI groups end ----
// ---- Napf military base #1 AI groups end ----


// ---- Napf military base #2 AI groups start ----
// ---- Napf military base #2 AI groups start ----
// ---- Napf military base #2 AI groups start ----

//_radius = ai_patrol_radius;
//_wp = ai_patrol_radius_wp;
//ai_patrol_radius = 10;
//ai_patrol_radius_wp = 4;

// M2staticMG 2
//[[[10749.708, 19712.582, 0.00011444092]], //position(s) (can be multiple).
//"M2StaticMG",             //Classname of turret
//0.5,                 //Skill level 0-1. Has no effect if using custom skills
//"Bandit2_DZ",           //Skin "" for random or classname here.
//1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
//2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
//"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
//5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
//] call spawn_neutral_static;

// Boss
//[[10951.353, 19711.912, 0.01], //position
//1,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//4,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"TK_Commander_EP1_DZ",           //Skin "" for random or classname here.
//5,                  //Gearset number. "Random" for random gear set.
//[10951.353, 19711.912, 0.01]   // Ending waypoint
//] call spawn_neutral_group2;

// Bodyguard 1
//[[10954.316, 19725.916, 0.01], //position
//4,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5,                  //Gearset number. "Random" for random gear set.
//[10950.316, 19720.916, 0.01]   // Ending waypoint
//] call spawn_neutral_group2;

// Guards 16
//[[10611.979, 19423.982, 0.01], //position
//1,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group2;

// Guards 17
//[[10792.086, 19302.066, 0.01], //position
//1,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group2;


// ---- Napf military base #2 AI groups end ----
// ---- Napf military base #2 AI groups end ----
// ---- Napf military base #2 AI groups end ----

//ai_patrol_radius_wp = _wp;
//ai_patrol_radius = _radius;


// ---- Napf military base #3 AI groups start ----
// ---- Napf military base #3 AI groups start ----
// ---- Napf military base #3 AI groups start ----

//[[18239.393, 17417.959, 0.011580579],   //Position to patrol
//[18239.393, 17417.959, 0.011580579],   // Position to spawn at
//100,               //Radius of patrol
//10,                     //Number of waypoints to give
//"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
//1                  //Skill level of units
//] spawn vehicle_patrol;

// Guards 1
//[[18242.215, 17411.465, 0.01], //position
//3,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// Guards 2
//[[18264.297, 17412.629, 0.01], //position
//3,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// Guards 3
//[[18254.424, 17487.816, 0.01], //position
//3,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// Guards 4
//[[18300.744, 17372.27, 0.01], //position
//3,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//0,            //Primary gun set number. "Random" for random weapon set.
//4,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// ---- Napf military base #3 AI groups end ----
// ---- Napf military base #3 AI groups end ----
// ---- Napf military base #3 AI groups end ----

// ---- Napf military base #4 (Rambo) AI groups start ----
// ---- Napf military base #4 (Rambo) AI groups start ----
// ---- Napf military base #4 (Rambo) AI groups start ----


// Base 1 (rambo)

[] spawn {
	Private ["_proceed","_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects","_sniper_groups","_armored","_total_groups","_entities","_start_positions","_target_point","_respawn_patrol_starting_point","_gunner_list_pos","_mg_list","_gunner_list","_fake_prize_box","_prize_box","_prize_box_chute","_location","_result","_rare_loot_items","_launchers"];

	waitUntil {sleep 5; {isPlayer _x && _x distance [10462.832, 2943.3831, 0.01] <= 1000 } count playableunits > 0 };

	// Gate guard 1
	[[10462.832, 2943.3831, 0.01], //position
	1,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	[10462.832, 2943.3831, 0.01] // target position
	] call spawn_neutral_group2;

	// Gate guard 2
	[[10461.204, 2951.3208, 0.01], // target position
	1,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	[10462.832, 2943.3831, 0.01] //position
	] call spawn_neutral_group2;

	// Guards 5
	[[10524.751, 2982.8923, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	2,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 6
	[[10561.786, 2950.842, 0.01], //position
	2,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 7
	[[10528.676, 2943.4734, 0.01], //position
	2,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Sniper 2
	[[10501.552, 2966.0142, 0.259837], //position
	1,                    //Number Of units
	1,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	5,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"GUE_Soldier_Sniper_DZ",           //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	[10501.552, 2966.0142, 0.259837]
	] call spawn_neutral_group2;

	// Static 0
	[[[10500.552, 2966.0142, 20.259837]], //position(s) (can be multiple).
	"M2StaticMG",   //Classname of turret
	1,      //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",   //Skin "" for random or classname here.
	"Random",   //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,      //Number of magazines. (not needed if ai_static_useweapon = False)
	"",      //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5   //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	// Guards 8
	[[10483.693, 3039.9656, 0.01], //position
	2,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 10
	[[10568.737, 3022.5857, 0.01], //position
	2,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 11
	[[10530.094, 2863.3848, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Humvee 1
	[[10460.26, 2934.8992],   //Position to patrol
	[10460.26, 2934.8992],   // Position to spawn at
	100,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
	0.75                  //Skill level of units
	] spawn vehicle_patrol;

	// Humvee 2
	[[10456.087, 2958.6243],   //Position to patrol
	[10456.087, 2958.6243],   // Position to spawn at
	100,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
	0.75                  //Skill level of units
	] spawn vehicle_patrol;

	// Static 1
	[[[10480.543, 2950.6602, -0.053607285]], //position(s) (can be multiple).
	"M2StaticMG",   //Classname of turret
	0.75,      //Skill level 0-1. Has no effect if using custom skills
	"Bandit2_DZ",   //Skin "" for random or classname here.
	"Random",   //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
	2,      //Number of magazines. (not needed if ai_static_useweapon = False)
	"",      //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
	5   //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
	] call spawn_neutral_static;

	_respawn_patrol_starting_point = [10526, 3386, 0];
	_target_point = [10526, 2986, 0];
	_launchers = ["MAAWS", "MAAWS_HEAT"];

	_thebox = createVehicle ["BAF_VehicleBox",[10562.068, 2953.7969, -0.081606433], [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;
	_thebox setVariable ["ObjectID","1",true];
	_thebox setVariable ["permaLoot",true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

	_thebox allowDamage false;

	_hidden_box_number_of_gold = 2;
	_hidden_box_random_items = [
		"ItemTopaz",
		"ItemBriefcase100oz"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 17],
		["ItemObsidian", 2],
		["ItemAmethyst", 1]
	];

	// Add the normal valuables...
	_numberofitems = (round (random 1)) + _hidden_box_number_of_gold;
	for "_i" from 1 to _numberofitems do {
		_item = _hidden_box_random_items call BIS_fnc_selectRandom;
		_thebox addMagazineCargoGlobal [_item,1];
	};

        // Add 1 item from the rare loot item list
        _result = [];
        {
            _item = _x select 0;
            _numberofitems = _x select 1;
            for "_i" from  1 to _numberofitems do {
                _result set [count _result, _item];
            };
        } forEach _rare_loot_items;
        _thebox addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];

	// Wait until prize box is looted
	_proceed = false;
	while {!_proceed} do {
		// When player loots the box the second time
		if (count ((getMagazineCargo _thebox) select 0) == 0) then {
			if (count ((getWeaponCargo _thebox) select 0) == 0) then {
				_proceed = true;
			};
		};
		sleep 5;
	};

	if (isNil "MILBASE2_alarm_tower") then {
		MILBASE2_alarm_tower = nearestObject [[10526.189, 2986.717, 0], "MAP_Ind_IlluminantTower"];
	};

	[nil,nil,rTitleText,"Warning! Heavy forces approaching SMB base location!", "PLAIN",5] call RE;

	[nil,MILBASE2_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 4;
	[nil,MILBASE2_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 4;
	[nil,MILBASE2_alarm_tower,rSAY,"tornado_siren"] call RE;
	sleep 4;

	keep_respawning set [BASE_SMB, true];
	["bandits", _respawn_patrol_starting_point, _target_point, 400, BASE_SMB, _launchers] spawn spawn_reinforcement_patrol;

	// SPAWN BANDIT HEAVY FORCES
	//_entities = ["AAV", "M2A2_EP1", "BAF_FV510_W"];
	_entities = ["LAV25", "M1126_ICV_M2_EP1", "M1128_MGS_EP1", "AAV", "M2A2_EP1", "BAF_FV510_W"];
	_start_positions =
	[
		[9681.8457, 3260.7495, 0.011580579],
		[10172.721, 2542.8733, 0.011580579]
	];

	_total_groups = [];

	sleep 0.1;

	for "_i" from 0 to 1 do {
		_armored = _entities call BIS_fnc_selectRandom;
		_pos = _start_positions select _i;
		[_target_point,   	// Position to patrol
		_pos,   		// Position to spawn at
		200,               	// Radius of patrol
		10,                     // Number of waypoints to give
		_armored,		// Classname of vehicle (make sure it has driver and gunner)
		0.5,			// Skill level of units
		_total_groups
		] call vehicle_patrol;
		sleep 0.1;
	};

	_sniper_groups = [
		// [[<Sniper pair position>], <target position>],
		[[9856.3633, 3597.2336, -0.00067901611],_target_point],
		[[10472.338, 3427.1274, 3.8146973e-006],_target_point],
		[[10860.322, 2698.6404, -2.9563904e-005],_target_point],
		[[9892.0303, 1969.6088, 8.2969666e-005],_target_point]
	];

	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;
	_sniper_group = _sniper_groups call BIS_fnc_selectRandom;
	["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;

	_gunner_list_pos = 0;

	// M2 gunner positions
	_mg_list = [
		[[10765.557, 2605.0125, 6.1035156e-005],[10736.538, 2584.99, 0.00012207031]],
		[[10709.454, 2556.3533, 0],[10268.984, 2733.3899]],
		[[9947.2041, 2804.8247, -3.0517578e-005],[10004.696, 2741.1111, -6.1035156e-005]],
		[[9697.9014, 2936.4451, -0.00018310547],[10402.753, 2550.926, 0.00012207031]]
	];
	_gunner_list = [_mg_list, 4] call pick_n_positions;
	_pair = _gunner_list select _gunner_list_pos;
	["bandits", _pair, "M2StaticMG"] call spawn_usable_static_gunners;
	_gunner_list_pos = _gunner_list_pos + 1;
	_pair = _gunner_list select _gunner_list_pos;
	["bandits", _pair, "M2StaticMG"] call spawn_usable_static_gunners;

	// Wait until the heavy unit groups are destroyed
	_proceed = false;
	_units = [];
	{ _units = _units + (units _x); } forEach _total_groups;
	while {not _proceed} do {
		_proceed = ({alive _x} count _units) == 0;
		sleep 30;
	};

	[nil,nil,rTitleText,"Well done! The heavy units have been destroyed!", "PLAIN",5] call RE;
	sleep 6;

	_fake_prize_box = createVehicle ["BAF_VehicleBox",[0, 0, 0], [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _fake_prize_box;
	clearMagazineCargoGlobal _fake_prize_box;
	_fake_prize_box setVariable ["ObjectID","1",true];
	_fake_prize_box setVariable ["permaLoot",true];
	_fake_prize_box allowDamage false;

	_location = [10526, 2986, 0];
	_prize_box_chute = createVehicle ["ParachuteMediumWest", [0,0,0], [], 0, "CAN_COLLIDE"];
	_prize_box_chute setPos [_location select 0, _location select 1,(_location select 2) + 100];
	_fake_prize_box attachTo [_prize_box_chute, [0,0,-1.6]];
	sleep 1.0;
	WaitUntil{(([_fake_prize_box] call FNC_GetPos) select 2) < 0.1};
	detach _fake_prize_box;
	deleteVehicle _prize_box_chute;
	keep_respawning set [BASE_SMB, false];

	_prize_box = createVehicle ["BAF_VehicleBox",getPos (_fake_prize_box), [], 0, "CAN_COLLIDE"];
	deleteVehicle _fake_prize_box;
	clearWeaponCargoGlobal _prize_box;
	clearMagazineCargoGlobal _prize_box;
	_prize_box setVariable ["ObjectID","1",true];
	_prize_box setVariable ["permaLoot",true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_prize_box];
	_prize_box allowDamage false;

	_hidden_box_number_of_gold = 4;
	_hidden_box_random_items = [
		"ItemObsidian",
		"ItemBriefcase100oz"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 17],
		["ItemObsidian", 2],
		["ItemAmethyst", 1]
	];

	// Add the normal valuables...
	_numberofitems = (round (random 1)) + _hidden_box_number_of_gold;
	for "_i" from 1 to _numberofitems do {
		_item = _hidden_box_random_items call BIS_fnc_selectRandom;
		_prize_box addMagazineCargoGlobal [_item,1];
	};

        // Add 1 item from the rare loot item list
        _result = [];
        {
            _item = _x select 0;
            _numberofitems = _x select 1;
            for "_i" from  1 to _numberofitems do {
                _result set [count _result, _item];
            };
        } forEach _rare_loot_items;
        _prize_box addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];
        _prize_box addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];

	// Add more loot
	_hidden_box_number_of_buildmats = 20;
	_hidden_box_random_buildmats = [
		"half_cinder_wall_kit",
		"half_cinder_wall_kit",
		"half_cinder_wall_kit",
		"half_cinder_wall_kit",
		"cinder_garage_kit",
		"cinder_garage_kit",
		"cinder_garage_kit",
		"cinder_garage_kit",
		"metal_floor_kit",
		"metal_floor_kit",
		"metal_floor_kit",
		"metal_floor_kit",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"CinderBlocks",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"MortarBucket",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"ItemTanktrap",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"PartGeneric",
		"ItemComboLock",
		"ItemComboLock",
		"ItemComboLock",
		"ItemComboLock"
	];

	_hidden_box_number_of_guns = 5;
	_hidden_box_random_guns = [
		"DMR",
		"DMR",
		"KSVK_DZE",
		"KSVK_DZE",
		"Pecheneg_DZ",
		"Pecheneg_DZ",
		"M4A1_AIM_SD_camo",
		"M4A1_AIM_SD_camo",
		"M4A1_AIM_SD_camo",
		"M4A1_AIM_SD_camo",
		"M4A1_AIM_SD_camo",
		"BAF_LRR_scoped",
		"BAF_LRR_scoped",
		"BAF_LRR_scoped",
		"BAF_LRR_scoped",
		"M110_NVG_EP1",
		"M110_NVG_EP1",
		"M110_NVG_EP1",
		"SCAR_H_LNG_Sniper_SD",
		"SCAR_H_LNG_Sniper_SD",
		"SCAR_H_LNG_Sniper_SD",
		"MAAWS",
		"MAAWS",
		"MAAWS",
		"FN_FAL_ANPVS4",
		"FN_FAL_ANPVS4",
		"BAF_L85A2_RIS_CWS",
		"m107_DZ"
	];

	_numberofguns = (round (random 2)) + _hidden_box_number_of_guns;
	_numberoftools = 0;//(round (random 1)) + _hidden_box_number_of_tools;
	_numberofitems = (round (random 2)) + _hidden_box_number_of_gold;
	_numberofbuildmats = (round (random 5)) + _hidden_box_number_of_buildmats;
	for "_i" from 1 to _numberofguns do {
		_theweap = _hidden_box_random_guns call BIS_fnc_selectRandom;
		_themags = getArray (configFile >> "cfgWeapons" >> _theweap >> "magazines");
		_prize_box addWeaponCargoGlobal [_theweap,1];
		_prize_box addMagazineCargoGlobal [(_themags select 0),round(random 3) + 2];
	};
	for "_i" from 1 to _numberofbuildmats do {
		_item = _hidden_box_random_buildmats call BIS_fnc_selectRandom;
		_prize_box addMagazineCargoGlobal [_item,1];
	};
};

// Base 2 (ammo)

[] spawn {
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects"];

	waitUntil {sleep 5; {isPlayer _x && _x distance [7228.2642, 3221.6611, 0.01] <= 1000 } count playableunits > 0 };

	// Guards 1
	[[7228.2642, 3221.6611, 0.01], //position
	6,                    //Number Of units
	1,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	2,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Humvee 1
	[[7234.813, 3199.3315],   //Position to patrol
	[7234.813, 3199.3315],   // Position to spawn at
	100,               //Radius of patrol
	10,                     //Number of waypoints to give
	"HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
	0.75                  //Skill level of units
	] spawn vehicle_patrol;
};

// ---- Napf military base #4 (Rambo) AI groups end ----
// ---- Napf military base #4 (Rambo) AI groups end ----
// ---- Napf military base #4 (Rambo) AI groups end ----

// ---- Napf military base #5 AI groups start ----
// ---- Napf military base #5 AI groups start ----
// ---- Napf military base #5 AI groups start ----


// Guards 1
//[[10332.625, 7135.6719, -7.6293945e-006], //position
//2,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//1,            //Primary gun set number. "Random" for random weapon set.
//2,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// Guards 2
//[[10292.479, 7095.813, 2.2888184e-005], //position
//2,                    //Number Of units
//0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
//3,            //Primary gun set number. "Random" for random weapon set.
//2,                    //Number of magazines
//"",                    //Backpack "" for random or classname here.
//"Bandit2_DZ",           //Skin "" for random or classname here.
//5                  //Gearset number. "Random" for random gear set.
//] call spawn_neutral_group;

// ---- Napf military base #5 AI groups end ----
// ---- Napf military base #5 AI groups end ----
// ---- Napf military base #5 AI groups end ----

/*
Custom static weapon spawns Eg. (with one position)

[[[911.21545,4532.7612,2.6292224]], //position(s) (can be multiple).
"M2StaticMG",             //Classname of turret
0.5,                 //Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",           //Skin "" for random or classname here.
1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_static;

Custom static weapon spawns Eg. (with mutiple positions)

[[[911.21545,4532.7612,2.6292224],[921.21545,4532.7612,2.6292224]], //position(s) (can be multiple).
"M2StaticMG",             //Classname of turret
0.5,                 //Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",           //Skin "" for random or classname here.
1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
"",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_static;

Place your custom static weapon spawns below
*/

/*
Custom Chopper Patrol spawn Eg.

[[725.391,4526.06,0],    //Position to patrol
[0,0,0],                // Position to spawn chopper at
2000,               //Radius of patrol
10,                     //Number of waypoints to give
"UH1H_DZ",              //Classname of vehicle (make sure it has driver and two gunners)
1                  //Skill level of units
] spawn heli_patrol;

Place your heli patrols below
*/


// Northern Heli patrol
[[16712.932,19018.701,0],   //Position to patrol
[20000,18000,20],           // Position to spawn chopper at
500,                        //Radius of patrol
10,                         //Number of waypoints to give
"UH1H_DZ",                  //Classname of vehicle (make sure it has driver and two gunners)
1                           //Skill level of units
] spawn heli_patrol;

// Southern Heli patrol
//[[10482.937,2943.074,0],    //Position to patrol
//[10000,0,20],               // Position to spawn chopper at
//500,                        //Radius of patrol
//10,                         //Number of waypoints to give
//"UH1H_DZ",                  //Classname of vehicle (make sure it has driver and two gunners)
//1                           //Skill level of units
//] spawn heli_patrol;






/*
Custom Vehicle patrol spawns Eg. (Watch out they are stupid)

[[725.391,4526.06,0],   //Position to patrol
[725.391,4526.06,0],   // Position to spawn at
200,               //Radius of patrol
10,                     //Number of waypoints to give
"HMMWV_Armored",      //Classname of vehicle (make sure it has driver and gunner)
1                  //Skill level of units
] spawn vehicle_patrol;

Place your vehicle patrols below this line
*/





/*
Paradropped unit custom spawn Eg.

[[911.21545,4532.7612,2.6292224],  //Position that units will be dropped by
[0,0,0],                           //Starting position of the heli
400,                               //Radius from drop position a player has to be to spawn chopper
"UH1H_DZ",                         //Classname of chopper (Make sure it has 2 gunner seats!)
5,                                 //Number of units to be para dropped
1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",                          //Primary gun set number. "Random" for random weapon set.
4,                                 //Number of magazines
"",                                //Backpack "" for random or classname here.
"Bandit2_DZ",                      //Skin "" for random or classname here.
"Random",                          //Gearset number. "Random" for random gear set.
True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
] spawn heli_para;

Place your paradrop spawns under this line
*/

// Paradrop just outside northern base entrance
[[16619.537,19100.074,2.6292224],  //Position that units will be dropped by
[17000,19100,100],                 //Starting position of the heli
50,                                //Radius from drop position a player has to be to spawn chopper
"UH1H_DZ",                         //Classname of chopper (Make sure it has 2 gunner seats!)
5,                                 //Number of units to be para dropped
1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,                                 //Primary gun set number. "Random" for random weapon set.
4,                                 //Number of magazines
"DZ_British_ACU",                  //Backpack "" for random or classname here.
"Bandit2_DZ",                      //Skin "" for random or classname here.
5,                                 //Gearset number. "Random" for random gear set.
True,                              //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
["M136","M136"]
] spawn heli_para;

// Paradrop just outside northern base entrance
[[16619.537,19000.074,2.6292224],  //Position that units will be dropped by
[13000,19100,100],                 //Starting position of the heli
300,                               //Radius from drop position a player has to be to spawn chopper
"CH_47F_EP1_DZ",                   //Classname of chopper (Make sure it has 2 gunner seats!)
5,                                 //Number of units to be para dropped
1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,                                 //Primary gun set number. "Random" for random weapon set.
4,                                 //Number of magazines
"DZ_British_ACU",                  //Backpack "" for random or classname here.
"Bandit2_DZ",                      //Skin "" for random or classname here.
5,                                 //Gearset number. "Random" for random gear set.
True,                              //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
["M136","M136"]
] spawn heli_para;


// Paradrop just outside southern base entrance
[[10462.937,2903.074,2.6292224],   //Position that units will be dropped by
[10500,0,100],                     //Starting position of the heli
50,                                //Radius from drop position a player has to be to spawn chopper
"UH1H_DZ",                         //Classname of chopper (Make sure it has 2 gunner seats!)
5,                                 //Number of units to be para dropped
1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,                                 //Primary gun set number. "Random" for random weapon set.
4,                                 //Number of magazines
"DZ_British_ACU",                  //Backpack "" for random or classname here.
"Bandit2_DZ",                      //Skin "" for random or classname here.
5,                                 //Gearset number. "Random" for random gear set.
True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
] spawn heli_para;

// Paradrop just outside southern base entrance
[[10402.937,2943.074,2.6292224],   //Position that units will be dropped by
[10500,20,100],                    //Starting position of the heli
150,                               //Radius from drop position a player has to be to spawn chopper
"CH_47F_EP1_DZ",                   //Classname of chopper (Make sure it has 2 gunner seats!)
5,                                //Number of units to be para dropped
1,                                 //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,                                 //Primary gun set number. "Random" for random weapon set.
4,                                 //Number of magazines
"DZ_British_ACU",                  //Backpack "" for random or classname here.
"Bandit2_DZ",                      //Skin "" for random or classname here.
5,                                 //Gearset number. "Random" for random gear set.
True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire.
] spawn heli_para;


