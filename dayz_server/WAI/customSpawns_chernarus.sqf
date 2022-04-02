//Custom Spawns file//

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


[] spawn {
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects", "_rare_loot_items", "_result", "_positions","_pos", "_total_groups","_location","_prize_veh","_prize_veh_chute","_class","_units","_i"];
	while {true} do {

		[nil,nil,rTitleText,"Separatist military forces have set up a base to the far north west. Stay away from them... they are dangerous.", "PLAIN",5] call RE;
		_total_groups = [];

		// Spawn first wave

		[[[1856.1005, 14365.22, 0]], //position(s) (can be multiple).
		"DSHKM_CZ_EP1", //Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[1847.0702, 14371.853, 0]], //position(s) (can be multiple).
		"DSHKM_CZ_EP1", //Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[1951.1437, 14298.054, 0]], //position(s) (can be multiple).
		"DSHKM_CZ_EP1",	//Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[2042.8716, 14440.65, 0]], //position(s) (can be multiple).
		"ZU23_Ins",	//Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[1976.0135, 14432.809, 0]], //position(s) (can be multiple).
		"ZU23_Ins",	//Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[1936.2339, 14527.681, 0]], //position(s) (can be multiple).
		"DSHKM_CZ_EP1",	//Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		[[[1924.7823, 14534.535, 0]], //position(s) (can be multiple).
		"DSHKM_CZ_EP1",	//Classname of turret
		0.5,		//Skill level 0-1. Has no effect if using custom skills
		"Bandit2_DZ",	//Skin "" for random or classname here.
		1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
		2,		//Number of magazines. (not needed if ai_static_useweapon = False)
		"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
		"Random",	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
		false,
		_total_groups
		] call spawn_neutral_static;

		// Milbase north infantry
		_total_groups = _total_groups + [[[1930.6948, 14412.9541, 0.001], //position
		5,						  //Number Of units
		0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
		"Random",			      //Primary gun set number. "Random" for random weapon set.
		4,						  //Number of magazines
		"",						  //Backpack "" for random or classname here.
		"Bandit2_DZ",			  //Skin "" for random or classname here.
		"Random"                  //Gearset number. "Random" for random gear set.
		] call spawn_neutral_group];

		// Milbase north infantry
		_total_groups = _total_groups + [[[1956.0135, 14432.809, 0.001], //position
		5,						  //Number Of units
		0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
		"Random",			      //Primary gun set number. "Random" for random weapon set.
		4,						  //Number of magazines
		"",						  //Backpack "" for random or classname here.
		"Bandit2_DZ",			  //Skin "" for random or classname here.
		"Random"                  //Gearset number. "Random" for random gear set.
		] call spawn_neutral_group];

		// Milbase north infantry
		_total_groups = _total_groups + [[[1980.1245, 14410.9541, 0.001], //position
		5,						  //Number Of units
		0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
		"Random",			      //Primary gun set number. "Random" for random weapon set.
		4,						  //Number of magazines
		"",						  //Backpack "" for random or classname here.
		"Bandit2_DZ",			  //Skin "" for random or classname here.
		"Random"                  //Gearset number. "Random" for random gear set.
		] call spawn_neutral_group];

		// Milbase north infantry
		_total_groups = _total_groups + [[[1930.6948, 14500.4593, 0.001], //position
		5,						  //Number Of units
		0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
		"Random",			      //Primary gun set number. "Random" for random weapon set.
		4,						  //Number of magazines
		"",						  //Backpack "" for random or classname here.
		"Bandit2_DZ",			  //Skin "" for random or classname here.
		"Random"                  //Gearset number. "Random" for random gear set.
		] call spawn_neutral_group];

		// SPAWN HEAVY FORCES
		_entities = ["HMMWV_Armored", "HMMWV_M1151_M2_CZ_DES_EP1_DZ","BAF_Jackal2_L2A1_w","M113_TK_EP1"];

		//_entities = ["LAV25", "M1126_ICV_M2_EP1", "M1128_MGS_EP1", "AAV", "M2A2_EP1", "BAF_FV510_W"];
		_positions = 
		[
			[1955.6948, 14376.4593, 0.011580579],
			[1940.605, 14420.955, 0.011580579],
			[1970.072, 14390.773, 0.011580579]
		];

		sleep 0.1;

		for "_i" from 0 to (floor(random 3)+1) do {
			_pos = _positions call BIS_fnc_selectRandom;
			[_pos,   			// Position to patrol
			_pos,   		// Position to spawn at
			200,               	// Radius of patrol
			10,                     // Number of waypoints to give
			_entities call BIS_fnc_selectRandom, // Classname of vehicle (make sure it has driver and gunner)
			0.75,			// Skill level of units 
			_total_groups
			] call vehicle_patrol;
			sleep 0.1;
		};

		// Northern Heli patrol
		[[1950,14400,50],	//Position to patrol
		[1950,14400,50],	// Position to spawn chopper at
		500,			//Radius of patrol
		10,			//Number of waypoints to give
		"UH1Y",			//Classname of vehicle (make sure it has driver and two gunners)
		1,			//Skill level of units 
		_total_groups
		] spawn heli_patrol;

		// Wait until all groups are destroyed
		_proceed = false;
		_units = [];
		{ _units = _units + (units _x); } forEach _total_groups;
		waitUntil {sleep 10; ({(alive _x) && (([1940.605, 14420.955, 0.011580579] distance _x) < 800)} count _units) == 0};

		_location = [1931.6,14410,0.00144861];

		_class = "BAF_VehicleBox";
		_prize_veh = createVehicle [_class, _location, [], 0, "CAN_COLLIDE"];

		clearWeaponCargoGlobal  _prize_veh;
		clearMagazineCargoGlobal  _prize_veh;

		_prize_veh allowDamage false;

		sleep 1.0;

		_hidden_box_number_of_gold = 10;
		_hidden_box_random_items = [
			"ItemObsidian",
			"ItemObsidian",
			"ItemObsidian",
			"ItemObsidian",
			"ItemObsidian",
			"ItemObsidian",
			"ItemTopaz",
			"ItemTopaz",
			"ItemTopaz",
			"ItemSapphire",
			"ItemARM",
			"ItemORP",
			"ItemAVE",
			"ItemLRK",
			"ItemTNK",
			"ItemTruckORP",
			"ItemTruckAVE",
			"ItemTruckLRK",
			"ItemTruckTNK",
			"ItemTruckARM",
			"ItemTankORP",
			"ItemTankAVE",
			"ItemTankLRK",
			"ItemTankTNK",
			"ItemHeliAVE",
			"ItemHeliLRK",
			"ItemHeliTNK",
			"equip_metal_sheet",
			"equip_metal_sheet",
			"equip_metal_sheet",
			"equip_metal_sheet",
			"equip_metal_sheet",
			"ItemScrews",
			"ItemScrews",
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

		_rare_loot_items = [
			["ItemBriefcase100oz", 17],
			["ItemObsidian", 4],
			["ItemSapphire", 2],
			["ItemAmethyst", 1]
		];

		// Add the normal valuables...
		_numberofitems = (round (random 20)) + _hidden_box_number_of_gold;
		for "_i" from 1 to _numberofitems do {
			_item = _hidden_box_random_items call BIS_fnc_selectRandom;
			_prize_veh addMagazineCargoGlobal [_item,1];
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
		_prize_veh addMagazineCargoGlobal [(_result call BIS_fnc_selectRandom),1];

		[nil,nil,rTitleText,"The separatist forces have been eliminated! Don't wait too long... their friends might come to visit soon.", "PLAIN",5] call RE;
		sleep 1200;
		deleteVehicle _prize_veh;
		_entities = [1950, 14400, 1] nearObjects ["ZU23_Ins", 300];
		_entities = _entities + ([1950, 14400, 1] nearObjects ["DSHKM_CZ_EP1", 300]);
		_entities = _entities + ([1950, 14400, 1] nearObjects ["M252", 300]);
		{ deleteVehicle _x } count _entities;
		[nil,nil,rTitleText,"Separatist reinforcements are approaching... move away, and fast!", "PLAIN",5] call RE;
		sleep 90;
	};
};

// ---- Repositioned NMB (originally from Napf) military base #1 AI groups follow ----
// ---- Repositioned NMB (originally from Napf) military base #1 AI groups follow ----
// ---- Repositioned NMB (originally from Napf) military base #1 AI groups follow ----
[] spawn {
	Private ["_proceed","_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects","_rare_loot_items","_result","_positions","_pos", "_total_groups","_location","_prize_veh","_prize_veh_chute","_class","_units","_i","_mg_list","_gunner_list","_respawn_patrol_starting_point","_target_point","_sniper_groups","_sniper_group","_pair","_gunner_list_pos","_grp","_kent_waypoints"];


/*
        // BEGIN Spawn a temporary box with upgrades
        _thebox = createVehicle ["BAF_VehicleBox",[11660.92400,8086.45200,0.07719], [], 0, "CAN_COLLIDE"];
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

        _respawn_patrol_starting_point = [12941.09100,9988.63200,3.75620];
        _target_point = [13277.72200,10712.07300,0.00995];
        _gunner_list_pos = 0;

        // M2 gunner positions
        _mg_list = [
		[[12843.021, 10840.466, -0.062977515],[12838.845, 10825.981, -0.06380298]],
		[[12792.665, 10727.623, -0.062213071],[12799.13, 10740.295, -0.063726693]],
		[[12834.745, 10881.888, 20.021961],[12776.989, 10700.187, 20.070339]],
		[[13156.892, 10435.388, 9.4122572],[13137.673, 10416.334, 22.562397]],
		[[13365.432, 10946.678, 6.0473657],[13372.558, 10943.423, 6.0388107]],
		[[13102.193, 10458.679, 7.0551367],[13084.221, 10428.127, 7.1961102]],
		[[13151.945, 10340.884, 5.02529],[13163.217, 10339.424, 2.4741819]]
        ];

        _sniper_groups = [
                // [[<Sniper pair position>], <target position>],
                [[14458.41500,10694.03800,-0.00073],[14294.41900,10632.18500,-0.00040]],
                [[14456.83900,10692.70400,-0.00004],[12805.62800,10238.22600,-0.00019]],
                [[13810.08500,8754.24700,-0.00008],[13401.01100,9977.01100,-0.00125]],
                [[13214.95300,8978.54800,0.00004],[13203.54400,9697.16700,-0.00008]]
        ];

        // Static gunners that will remain after killed
        _gunner_list = [_mg_list, 7] call pick_n_positions;
        _respawn_patrol_starting_point = [12941.09100,9988.63200,3.75620];

        waitUntil {sleep 5; {isPlayer _x && _x distance [13277.72200,10712.07300,0.00995] <= 1000 } count playableunits > 0 };

        _radius = ai_patrol_radius;
        _wp = ai_patrol_radius_wp;
        ai_patrol_radius = 25;
        ai_patrol_radius_wp = 4;
        _thebox = objNull;

        // Guards 1
        _grp = [[13277.72200,10712.07300,0.00995], //position
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
        _grp = [[13225.20300,10708.42900,0.00995], //position
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
        _grp = [[13276.15600,10655.08900,0.00995], //position
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
        _grp = [[13279.10500,10743.65400,0.00995], //position
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
        _grp = [[13305.47600,10780.98000,0.00995], //position
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
        _grp = [[13224.49200,10673.11100,0.00995], //position
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
        [[[13155.76100,10759.62600,0.00010]], //position(s) (can be multiple).
        "SearchLight_TK_EP1",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // SearchLight 2
        [[[13156.51300,10753.82900,0.00010]], //position(s) (can be multiple).
        "SearchLight_TK_EP1",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 1
        [[[13217.45100,10751.14800,0.00001]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 2
        [[[13245.15600,10682.25300,0.00041]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 3
        [[[13227.20800,10660.32200,-0.00019]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        5              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // HMMWV1
        [[13099.82900,10823.50700,0.01153],   //Position to patrol
        [13099.82900,10823.50700,0.01153],   // Position to spawn at
        200,               //Radius of patrol
        10,                     //Number of waypoints to give
        "HMMWV_Armored",      //Classname of vehicle (make sure it has driver and gunner)
        1                  //Skill level of units
        ] spawn vehicle_patrol;

        // HMMWV2
        [[13101.82900,10808.50700,0.01153],   //Position to patrol
        [13101.82900,10808.50700,0.01153],   // Position to spawn at
        50,               //Radius of patrol
        10,                     //Number of waypoints to give
        "HMMWV_M1151_M2_CZ_DES_EP1_DZ",      //Classname of vehicle (make sure it has driver and gunner)
        1                  //Skill level of units
        ] spawn vehicle_patrol;

        // HMMWV3
        [[13399.29600,10624.32500,0.01153],   //Position to patrol
        [13399.29600,10624.32500,0.01153],   // Position to spawn at
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

        _thebox = createVehicle ["USOrdnanceBox",[13303.39800,10747.61800,-0.00012], [], 0, "CAN_COLLIDE"];
        _thebox setPos [13303.39800,10747.61800,-0.00012];
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
        keep_respawning set [BASE_NMB, false];  // Disable continuous patrol spawns

        _sniper_group = _sniper_groups call BIS_fnc_selectRandom;
        ["bandits", _sniper_group select 0, _sniper_group select 1, 2] call spawn_snipers;


        // Announce respawn!
        [nil,nil,rTitleText,"Reinforcements approaching Northern Military Base! ETA: 5 min", "PLAIN",3] call RE;
        sleep 300;

        // Delete old guns and search lights
        _objects = [13217.45100,10751.14800,0.00001] nearObjects ["M2StaticMG", 300];
        { deleteVehicle _x } forEach _objects;
        _objects = [13217.45100,10751.14800,0.00001] nearObjects ["M2StaticMG", 300];
        { deleteVehicle _x } forEach _objects;




        // ===============================
        // RESPAWN AI TIER 2 FOR THIS BASE
        // ===============================

        if (!isNull _thebox) then {
                deleteVehicle _thebox;
                sleep 0.1;
        };

        _thebox = createVehicle ["USOrdnanceBox",[13303.39800,10747.61800,-0.00012], [], 0, "CAN_COLLIDE"];
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
        _grp = [[13277.72200,10712.07300,0.00995], //position
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
        _grp = [[13225.20300,10708.42900,0.00995], //position
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
        _grp = [[13276.15600,10655.08900,0.00995], //position
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
        _grp = [[13279.10500,10743.65400,0.00995], //position
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
        _grp = [[13305.47600,10780.98000,0.00995], //position
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
        _grp = [[13224.49200,10673.11100,0.00995], //position
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
        [[[13155.76100,10759.62600,0.00010]], //position(s) (can be multiple).
        "SearchLight_TK_EP1",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // SearchLight 2
        [[[13156.51300,10753.82900,0.00010]], //position(s) (can be multiple).
        "SearchLight_TK_EP1",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        1,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 1
        [[[13217.45100,10751.14800,0.00001]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        4,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 2
        [[[13245.15600,10682.25300,0.00041]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        4,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M2staticMG 3
        [[[13227.20800,10660.32200,-0.00019]], //position(s) (can be multiple).
        "M2StaticMG",             //Classname of turret
        0.5,                 //Skill level 0-1. Has no effect if using custom skills
        "Bandit2_DZ",           //Skin "" for random or classname here.
        5,                    //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
        2,                    //Number of magazines. (not needed if ai_static_useweapon = False)
        "",                    //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
        "Random"              //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
        ] call spawn_neutral_static;

        // M113_1
        [[13099.82900,10823.50700,0.01153],   //Position to patrol
        [13099.82900,10823.50700,0.01153],   // Position to spawn at
        200,               //Radius of patrol
        10,                     //Number of waypoints to give
        "M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
        1                  //Skill level of units
        ] spawn vehicle_patrol;

        // M113_2
        [[13101.82900,10808.50700,0.01153],   //Position to patrol
        [13101.82900,10808.50700,0.01153],   // Position to spawn at
        50,               //Radius of patrol
        10,                     //Number of waypoints to give
        "M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
        1                  //Skill level of units
        ] spawn vehicle_patrol;

        // M113_3
        [[13399.29600,10624.32500,0.01153],   //Position to patrol
        [13399.29600,10624.32500,0.01153],   // Position to spawn at
        50,               //Radius of patrol
        10,                     //Number of waypoints to give
        "M113_TK_EP1",      //Classname of vehicle (make sure it has driver and gunner)
        1                  //Skill level of units
        ] spawn vehicle_patrol;

        // Paradrop just outside northern base entrance
        [[13141.76100+(random 20),10753.62600+(random 20),2.62917],  //Position that units will be dropped by
        [13532.22400,10763.55200,100.00012],                 //Starting position of the heli
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
        [[13151.76100,10663.62600,2.62917],  //Position that units will be dropped by
        [9532.22400,10763.55200,99.99995],                 //Starting position of the heli
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
        [[13245.15600,10682.25300,-0.00005],   //Position to patrol
        [16532.22400,9663.55200,19.99995],           // Position to spawn chopper at
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

        // [14377.32400,11121.75200,0.00156] <- Temporary position
        // [13218.52400,10754.25200,0.00136] <- Original position

        _kent_waypoints = [
                [13273.92400,10695.25200,0.00126],
                [13248.02400,10691.25200,0.00153],
                [13245.82400,10649.75200,0.09470],
                [13277.62400,10678.45200,0.00126],
                [13249.22400,10685.95200,0.00152],
                [13250.22400,10718.75200,0.00127],
                [13230.42400,10681.45200,0.00141],
                [13198.32400,10686.95200,0.00147],
                [13195.22400,10721.45200,0.00130],
                [13273.92400,10695.25200,0.00126]
        ];

        WAI_kentIsDead = false;
        [[13218.52400,10754.25200,0.00136], _kent_waypoints] spawn kent_kombat;

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
                MILBASE1_alarm_tower = nearestObject [[13217.45100,10751.14800,0.99995], "MAP_Ind_IlluminantTower"];
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
        _objects = [13217.45100,10751.14800,0.99995] nearObjects ["M2StaticMG", 300];
        { deleteVehicle _x } forEach _objects;
        _objects = [13217.45100,10751.14800,0.99995] nearObjects ["SearchLight_TK_EP1", 300];
        { deleteVehicle _x } forEach _objects;

        sleep 0.1;

        // SPAWN US HEAVY FORCES
        _entities = ["AAV", "M2A2_EP1", "BAF_FV510_W"];
        //_entities = ["LAV25", "M1126_ICV_M2_EP1", "M1128_MGS_EP1", "AAV", "M2A2_EP1", "BAF_FV510_W"];
        _positions =
        [
                [13099.82900,10823.50700,0.01153],
                [13101.82900,10808.50700,0.01153],
                [13399.29600,10624.32500,0.01153]
        ];
        _total_groups = [];

        sleep 0.1;

        for "_i" from 0 to 2 do {
                _pos = _positions select _i;
                [_pos,                          // Position to patrol
                _pos,                   // Position to spawn at
                200,                    // Radius of patrol
                10,                     // Number of waypoints to give
                _entities call BIS_fnc_selectRandom, // Classname of vehicle (make sure it has driver and gunner)
                0.75,                   // Skill level of units
                _total_groups
                ] call vehicle_patrol_3rd_faction;
                sleep 0.1;
        };

        // ZU23_CDF
        [[[13155.76100,10759.62600,0.00010]], //position(s) (can be multiple).
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
        [[[13156.51300,10753.82900,0.00010]], //position(s) (can be multiple).
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
        [[[13217.45100,10751.14800,0.00001]], //position(s) (can be multiple).
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
        [[[13245.15600,10682.25300,0.00041]], //position(s) (can be multiple).
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
        [[[13227.20800,10660.32200,-0.00019]], //position(s) (can be multiple).
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
        [[13151.76100,10763.62600,2.62917],  //Position that units will be dropped by
        [13532.22400,10763.55200,99.99995],                 //Starting position of the heli
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
        [[13245.15600,10682.25300,-0.00005],   //Position to patrol
        [14532.22400,11663.55200,99.99995],           // Position to spawn chopper at
        500,                        //Radius of patrol
        10,                         //Number of waypoints to give
        "AH64D_EP1",                //Classname of vehicle (make sure it has driver and two gunners)
        1,                           //Skill level of units
        _total_groups
        ] spawn heli_patrol_3rd_faction;

        keep_respawning set [BASE_NMB, true];
        ["us", _respawn_patrol_starting_point, _target_point, 300, BASE_NMB] spawn spawn_reinforcement_patrol;

        // [14377.32400,11121.75200,0.00156] <- Temporary position
        // [13218.52400,10754.25200,0.00136] <- Original position

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
        _location = [13291.82400,10709.55200,0.00140];

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

        _entities = [13217.45100,10751.14800,0.99995] nearObjects ["Base_WarfareBBarrier10xTall", 300];
        _entities = _entities + ([13217.45100,10751.14800,0.99995] nearObjects ["Land_Mil_Barracks_i", 300]);
        _entities = _entities + ([13217.45100,10751.14800,0.99995] nearObjects ["MAP_fort_watchtower", 300]);

        { "Bo_GBU12_LGB" createVehicle getPos _x; sleep ([0.3, 0.1, 0.5, 0.4, 0.6, 0.2] call BIS_fnc_selectRandom); } forEach _entities;
        if ([13217.45100,10751.14800,0.00001] distance _prize_veh < 150) then {
                _prize_veh setDamage 1.0;
        };
};


//Custom static weapon spawns Eg. (with mutiple positions)

//[[[911.21545,4532.7612,2.6292224],[921.21545,4532.7612,2.6292224]], //position(s) (can be multiple).
//"M2StaticMG",             //Classname of turret
//0.5,					  //Skill level 0-1. Has no effect if using custom skills
//"Bandit2_DZ",			  //Skin "" for random or classname here. 
//1,						  //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
//2,						  //Number of magazines. (not needed if ai_static_useweapon = False)
//"",						  //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
//"Random"				  //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
//] call spawn_static;

//Place your custom static weapon spawns below
//


// Create a Wicked AI gunner on top of devil's castle tower
//[[[6914.5566, 11430.487, 30.1]], //position(s) (can be multiple).
//"M2StaticMG",	//Classname of turret
//0.5,		//Skill level 0-1. Has no effect if using custom skills
//"Bandit2_DZ",	//Skin "" for random or classname here.
//1,		//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
//2,		//Number of magazines. (not needed if ai_static_useweapon = False)
//"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
//"Random"	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
//] call spawn_static;


/*
Custom Chopper Patrol spawn Eg.

[[725.391,4526.06,0],    //Position to patrol
[0,0,0],	             // Position to spawn chopper at
2000,					//Radius of patrol
10,                     //Number of waypoints to give
"UH1H_DZ",		        //Classname of vehicle (make sure it has driver and two gunners)
1						//Skill level of units 
] spawn heli_patrol;

Place your heli patrols below
*/

// Northeastern Heli patrol
[[13233.70800,10711.56600,0.00000],	//Position to patrol
[15300,10711.56600,20],			//Position to spawn chopper at
500,					//Radius of patrol
10,					//Number of waypoints to give
"UH1H_DZ",				//Classname of vehicle (make sure it has driver and two gunners)
1					//Skill level of units
] spawn heli_patrol;


/* 
Custom Vehicle patrol spawns Eg. (Watch out they are stupid)

[[725.391,4526.06,0],   //Position to patrol
[725.391,4526.06,0],	// Position to spawn at
200,					//Radius of patrol
10,                     //Number of waypoints to give
"HMMWV_Armored",		//Classname of vehicle (make sure it has driver and gunner)
1						//Skill level of units 
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
[[13151.76100,10763.62600,2.62917], //Position that units will be dropped by
[13532.22400,10763.55200,100.00012],      //Starting position of the heli
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
[[13151.76100,10663.62600,2.62917], //Position that units will be dropped by
[9532.22400,10763.55200,100.00012],      //Starting position of the heli
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
