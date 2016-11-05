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


// ---- Napf military base #1 AI groups follow ----
// ---- Napf military base #1 AI groups follow ----
// ---- Napf military base #1 AI groups follow ----
[] spawn {
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects", "_rare_loot_items", "_result", "_positions","_pos", "_total_groups","_location","_prize_veh","_prize_veh_chute","_class","_units","_i"];

	waitUntil {sleep 5; {isPlayer _x && _x distance [16745.498, 19048.521, 0.01] <= 1000 } count playableunits > 0 };

	_radius = ai_patrol_radius;
	_wp = ai_patrol_radius_wp;
	ai_patrol_radius = 25;
	ai_patrol_radius_wp = 4;

	// Guards 1
	[[16745.498, 19048.521, 0.01], //position
	4,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 4
	[[16692.979, 19044.877, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 10
	[[16743.932, 18991.537, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 13
	[[16746.881, 19080.102, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 19
	[[16773.252, 19117.428, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 22
	[[16692.268, 19009.559, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

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


	// LOOT

	_thebox = createVehicle ["USOrdnanceBox",[16771.174, 19084.066, -7.0571899e-005], [], 0, "CAN_COLLIDE"];
	_thebox setPos [16771.174, 19084.066, -7.0571899e-005];
	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;
	_thebox setVariable ["ObjectID","1",true];
	_thebox setVariable ["permaLoot",true];
	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_thebox];

	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;

	_hidden_box_number_of_gold = 5;
	_hidden_box_random_items = [
	"ItemBriefcase100oz"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 94],
		["ItemTopaz", 5],
		["ItemSapphire", 1]
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

	// Announce respawn!
	[nil,nil,rTitleText,"Reinforcements approaching Northern Military Base! ETA: 3 min", "PLAIN",3] call RE;
	sleep 300;

	// Delete old guns and search lights
	_objects = [16685.227, 19087.596, 5.9127808e-005] nearObjects ["M2StaticMG", 300];
	{ deleteVehicle _x } forEach _objects;
	_objects = [16685.227, 19087.596, 5.9127808e-005] nearObjects ["M2StaticMG", 300];
	{ deleteVehicle _x } forEach _objects;




	// ===============================
	// RESPAWN AI TIER 2 FOR THIS BASE
	// ===============================

	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;

	_hidden_box_number_of_gold = 2;
	_hidden_box_random_items = [
		"ItemTopaz"
	];

	_rare_loot_items = [
		["ItemBriefcase100oz", 17],
		["ItemTopaz", 2],
		["ItemSapphire", 1]
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
	[[16745.498, 19048.521, 0.01], //position
	4,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	5,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 4
	[[16692.979, 19044.877, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 10
	[[16743.932, 18991.537, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 13
	[[16746.881, 19080.102, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 19
	[[16773.252, 19117.428, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	4,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

	// Guards 22
	[[16692.268, 19009.559, 0.01], //position
	3,                    //Number Of units
	0.75,                     //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	1,            //Primary gun set number. "Random" for random weapon set.
	4,                    //Number of magazines
	"",                    //Backpack "" for random or classname here.
	"Bandit2_DZ",           //Skin "" for random or classname here.
	5                  //Gearset number. "Random" for random gear set.
	] call spawn_neutral_group;

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
	True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire. 
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
	True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire. 
	] spawn heli_para;

	// Northern Heli patrol
	[[16712.932,19018.701,0],   //Position to patrol
	[20000,18000,20],           // Position to spawn chopper at
	500,                        //Radius of patrol
	10,                         //Number of waypoints to give
	"UH1Y",                     //Classname of vehicle (make sure it has driver and two gunners)
	1                           //Skill level of units 
	] spawn heli_patrol;


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



	// [17845.1,19458.2,0.00160302] <- Temporary position
	// [16686.3,19090.7,0.0014099] <- Original position

	WAI_kentIsDead = false;
	[[16686.3,19090.7,0.0014099]] spawn kent_kombat;

	_proceed = false;

	while {!WAI_kentIsDead} do {sleep 5;};

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
	_entities = ["LAV25", "M1126_ICV_M2_EP1", "M1128_MGS_EP1", "AAV", "M2A2_EP1", "BAF_FV510_W"];
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
	false,
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

	// Wait until all groups are destroyed
	_proceed = false;
	_units = [];
	{ _units = _units + (units _x); } forEach _total_groups;
	waitUntil {({alive _x} count _units) == 0};

	// Spawn prize vehicle at this position:
	_class = [
		"M113_TK_EP1","AH6J_EP1","UH1Y","pook_H13_gunship",
		"pook_H13_transport_GUE","AAV","BTR90_HQ_DZE","LAV25_HQ_DZE",
		"M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","BAF_Jackal2_L2A1_w",
		"M1133_MEV_EP1","M113Ambul_UN_EP1"
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
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects"];

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
True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire. 
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
5,                                 //Gearset number. "Random" for random gear set.
True                               //True: Heli will stay at position and fight. False: Heli will leave if not under fire. 
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


