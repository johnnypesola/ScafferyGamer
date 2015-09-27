Private ["_radius","_wp"];
//Custom Spawns file//


/*
Custom group spawns Eg.

[[953.237,4486.48,0.001], //position
4,						  //Number Of units
1,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;

Place your custom group spawns below
*/

// ---- Sauerland AI groups follow ----


// Fahrenbrecht machine gunner maniac
[[2953.7463, 945.24078, 0.001], //position
1,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Priest_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_hero_group;


// Old Airfield hero group
[[17029.23, 1795.0348, 0.001], //position
5,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
0,			      //Primary gun set number. "Random" for random weapon set. Medium-close range weapons.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_hero_group;

// Old Airfield hero sniper
[[16744.246, 1908.9065, 0.001], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_hero_group;


// Wenden Airfield bandit infantry group
[[15199.844, 18601.998, 0.001], //position
5,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
0,			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;

// Wenden Airfield bandit sniper group
[[14931.38, 18539.029, 0.001], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;

_radius = ai_patrol_radius;
ai_patrol_radius = 100;

// Hero base group #1
[[16247.264, 21646.988, 0.001], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_hero_group;


// Hero base group #2
[[16225.811, 21639.168, 0.001], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_hero_group;


// Bandit base group #1
[[4163.9458, 832.62323, 0.001], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;

// Bandit base group #2
[[4210.6968, 812.16449, 0.001], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
"Random",		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_group;


// Universal base

_wp = ai_patrol_radius_wp;
ai_patrol_radius = 3;
ai_patrol_radius_wp = 4;

// Sniper in tower
[[25079.326, 6631.1914, 0.001],	//position
1,				//Number Of units
0.75,				//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
5,				//Primary gun set number. "Random" for random weapon set.
4,				//Number of magazines
"",				//Backpack "" for random or classname here.
"Soldier1_DZ",			//Skin "" for random or classname here.
"Random",			//Gearset number. "Random" for random gear set.
[25080.035, 6634.5835, 20.971701]	// Ending waypoint
] call spawn_neutral_group2;


// Guards of box #1
[[25113.236, 6575.2896, -0.00012207031], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;


// Guards of box #2
[[25115.154, 6582.5742, -0.00024414063], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
4,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;


// Guards # 1
[[25085.277, 6596.6948, 0.01], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;

// Guards # 2
[[25085.277, 6596.6948, 0.01], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;

// Guards # 3
[[25050.633, 6623.4902, 0.01], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;

// Guards # 4
[[25071.744, 6606.6699, 0.01], //position
2,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group2;

// Guards # 5
[[25058.207, 6631.8779, 0.01], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
1,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;

// Guards # 6
[[25090.705, 6639.3569, 0.01], //position
4,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
2,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;

// Guards # 7
[[25124.059, 6642.1987, 0.01], //position
3,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;

// Guards # 8
[[25055.662, 6654.9141, 0.01], //position
3,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;

// Guards # 7
[[25124.059, 6642.1987, 0.01], //position
3,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;

// Guards # 8
[[25055.662, 6654.9141, 0.01], //position
3,						  //Number Of units
0.75,					      //Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
3,		      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Soldier1_DZ",			  //Skin "" for random or classname here.
"Random"                  //Gearset number. "Random" for random gear set.
] call spawn_neutral_group;


// Vehicle #1
[[24979.693, 6655.3838,0],	// Position to patrol
[25029.693, 6650.3838,0],	// Position to spawn at
50,				// Radius of patrol
4,				// Number of waypoints to give
"HMMWV_M1151_M2_CZ_DES_EP1",	// Classname of vehicle (make sure it has driver and gunner)
1				//Skill level of units 
] spawn vehicle_patrol_neutral;

// Vehicle #2
[[25250.0, 6680.6357,0],	// Position to patrol
[25116.482, 6669.6357,0],	// Position to spawn at
100,				// Radius of patrol
10,				// Number of waypoints to give
"M113_TK_EP1",	// Classname of vehicle (make sure it has driver and gunner)
1				//Skill level of units 
] spawn vehicle_patrol_neutral;

ai_patrol_radius_wp = _wp;
ai_patrol_radius = _radius;



/*
Custom static weapon spawns Eg. (with one position)

[[[911.21545,4532.7612,2.6292224]], //position(s) (can be multiple).
"M2StaticMG",             //Classname of turret
0.5,					  //Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",			  //Skin "" for random or classname here.
1,						  //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,						  //Number of magazines. (not needed if ai_static_useweapon = False)
"",						  //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"				  //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_static;

Custom static weapon spawns Eg. (with mutiple positions)

[[[911.21545,4532.7612,2.6292224],[921.21545,4532.7612,2.6292224]], //position(s) (can be multiple).
"M2StaticMG",             //Classname of turret
0.5,					  //Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",			  //Skin "" for random or classname here. 
1,						  //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,						  //Number of magazines. (not needed if ai_static_useweapon = False)
"",						  //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"				  //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_static;

Place your custom static weapon spawns below
*/



// Create a Wicked AI gunner on top of Bandit Camp's tower
[[[4198.6572, 787.41888, 30.355]], //position(s) (can be multiple).
"M2StaticMG",	//Classname of turret
0.5,		//Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",	//Skin "" for random or classname here.
"Random",	//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,		//Number of magazines. (not needed if ai_static_useweapon = False)
"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_static;

// Create a Wicked AI gunner at the Hero Camp
[[[16225.658, 21648.205, 6.1035156e-005]], //position(s) (can be multiple).
"M2StaticMG",	//Classname of turret
0.5,		//Skill level 0-1. Has no effect if using custom skills
"Soldier1_DZ",	//Skin "" for random or classname here.
"Random",	//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,		//Number of magazines. (not needed if ai_static_useweapon = False)
"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_hero_static;


// Create a Wicked AI gunner at universal base
[[[25054.891, 6636.0156, -0.00039672852]], //position(s) (can be multiple).
"M2StaticMG",	//Classname of turret
0.75,		//Skill level 0-1. Has no effect if using custom skills
"Soldier1_DZ",	//Skin "" for random or classname here.
"Random",	//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,		//Number of magazines. (not needed if ai_static_useweapon = False)
"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_neutral_static;

// Create a Wicked AI gunner at universal base
[[[25064.758, 6628.3345, -0.00051879883]], //position(s) (can be multiple).
"M2StaticMG",	//Classname of turret
0.75,		//Skill level 0-1. Has no effect if using custom skills
"Soldier1_DZ",	//Skin "" for random or classname here.
"Random",	//Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,		//Number of magazines. (not needed if ai_static_useweapon = False)
"",		//Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random"	//Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
] call spawn_neutral_static;




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

