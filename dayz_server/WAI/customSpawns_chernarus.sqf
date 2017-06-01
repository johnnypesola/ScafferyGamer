//Custom Spawns file//

[] spawn {
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects", "_rare_loot_items", "_result", "_positions","_pos", "_total_groups","_location","_prize_veh","_prize_veh_chute","_class","_units","_i"];
	while {true} do {

		[nil,nil,rTitleText,"Separatist forces have set up a base somewhere to the north. Stay away from them... they are dangerous.", "PLAIN",5] call RE;
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
			_pos = _positions select _i;
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
		waitUntil {sleep 10; ({alive _x} count _units) == 0};

		_location = [1931.6,14410,0.00144861];

		_class = "BAF_VehicleBox";
		_prize_veh = createVehicle [_class, _location, [], 0, "CAN_COLLIDE"];

		clearWeaponCargoGlobal  _prize_veh;
		clearMagazineCargoGlobal  _prize_veh;

		sleep 1.0;

		_hidden_box_number_of_gold = 1;
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

