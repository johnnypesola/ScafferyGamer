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

_hidden_box_number_of_buildmats = 0;
_hidden_box_random_buildmats = [
"CinderBlocks"
];

_hidden_box_number_of_guns = 0;
_hidden_box_random_guns = [
"DMR",
"m107_DZ"
];

_hidden_box_number_of_tools = 0;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "Chainsaw" or "ItemToolbox")
_hidden_box_random_tools =[
"ItemToolbox",
"ItemKnife",
"ItemCrowbar",
"ItemEtool",
"ItemHatchet_DZE",
"Binocular_Vector",
"ItemGPS",
"NVGoggles",
"chainsaw",
"ItemSledge"
];

_numberofguns = 0;// (round (random 2)) + _hidden_box_number_of_guns;
_numberoftools = 0;// (round (random 2)) + _hidden_box_number_of_tools;
_numberofitems = (round (random 5)) + _hidden_box_number_of_gold;
_numberofbuildmats = 0;//(round (random 5)) + _hidden_box_number_of_buildmats;
//for "_i" from 1 to _numberofguns do {
//	_theweap = _hidden_box_random_guns call BIS_fnc_selectRandom;
//	_themags = getArray (configFile >> "cfgWeapons" >> _theweap >> "magazines");
//	_thebox addWeaponCargoGlobal [_theweap,1];
//	_thebox addMagazineCargoGlobal [(_themags select 0),round(random 2) + 1];
//};
//for "_i" from 1 to _numberoftools do {
//	_thetool = _hidden_box_random_tools call BIS_fnc_selectRandom;
//	_thebox addWeaponCargoGlobal [_thetool,2];
//};

for "_i" from 1 to _numberofitems do {
	_item = _hidden_box_random_items call BIS_fnc_selectRandom;
	_thebox addMagazineCargoGlobal [_item,1];
};
//for "_i" from 1 to _numberofbuildmats do {
//	_item = _hidden_box_random_buildmats call BIS_fnc_selectRandom;
//	_thebox addMagazineCargoGlobal [_item,1];
//};

activeTier = 1;
publicVariable "activeTier";

// Loot monitor
[_theBox] spawn {
	Private ["_proceed", "_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats","_objects"];
	_thebox = _this select 0;
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

	// RESPAWN AI TIER 2 FOR THIS BASE

	clearWeaponCargoGlobal _thebox;
	clearMagazineCargoGlobal _thebox;

	_hidden_box_number_of_gold = 2;
	_hidden_box_random_items = [
		"ItemTopaz"
	];
	_numberofitems = (round (random 1)) + _hidden_box_number_of_gold;
	for "_i" from 1 to _numberofitems do {
		_item = _hidden_box_random_items call BIS_fnc_selectRandom;
		_thebox addMagazineCargoGlobal [_item,1];
	};

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

	[[16686.3,19090.7,0.0014099]] spawn kent_kombat;

	// [17845.1,19458.2,0.00160302] <- Temporary position
	// [16686.3,19090.7,0.0014099] <- Original position
};


	

// ---- Napf military base #1 AI groups end ----
// ---- Napf military base #1 AI groups end ----
// ---- Napf military base #1 AI groups end ----


// ---- Napf military base #2 AI groups start ----
// ---- Napf military base #2 AI groups start ----
// ---- Napf military base #2 AI groups start ----

_radius = ai_patrol_radius;
_wp = ai_patrol_radius_wp;
ai_patrol_radius = 10;
ai_patrol_radius_wp = 4;

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

ai_patrol_radius_wp = _wp;
ai_patrol_radius = _radius;


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



// Base 2 (ammo)



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


