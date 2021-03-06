private["_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_dyn_id","_pos","_alive","_data","_y","_unit","_tmp_patrol_radius","_tmp_patrol_wp","_heliPatrolParams","_heliPatrolList","_heliClass","_startTime","_elapsedTime", "_heliPatrolCallParams", "_i"];

if(!isServer) exitWith { };

// This is a list of all dynamic AI on the map.
dyn_ai_list = [
[
	false, 
	[[5165.8394, 4469.9219, 0.01], //AiAirbase1
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	0
	]
],
[
	false, 
	[[4723.9019, 4811.4233, 0.01], //AiAirbase2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	1
	]
],
[
	false, 
	[[3885.1987, 4560.3779, 0.01], //AiAirbase3
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	2
	]
],
[
	false, 
	[[18221.836, 2147.1143, 0.01], //AiSouthAirstrip
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	3
	]
],
[
	false, 
	[[18092.02, 2543.2104, 0.01], //AiSouthAirstripMilBaseNorth
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	4
	]
],
[
	false, 
	[[16366.377, 18359.223, 0.01], //AiSuhrenfeld1
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	5
	]
],
[
	false, 
	[[16461.492, 18379.238, 0.01], //AiSuhrenfeld2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	3,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	6
	]
],
[
	false, 
	[[17148.594, 18730.047, 0.01], //AiSuhrenfeld3
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	7
	]
],
[
	false, 
	[[8574.9023, 16139.772, 0.01], //AiLenzburg1
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	8
	]
],
[
	false, 
	[[9228.5068, 15794.415, 0.01], //AiLenzburgInd1
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	9
	]
],
[
	false, 
	[[9015.4033, 16250.197, 0.01], //AiLenzburg2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	10
	]
],
[
	false, 
	[[8963.5459, 16625.605, 0.01], //AiLenzburg3
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	11
	]
],
[
	false, 
	[[14304.469, 16954.207, 0.01], //AiAirport1
	2,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	12
	]
],
[
	false, 
	[[14411.985, 16851.197, 0.01], //AiAirport2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	13
	]
],
[
	false, 
	[[14756.067, 13699.046, 0.01], //AiLuzernInd2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	14
	]
],
[
	false, 
	[[14586.058, 14231.967, 0.01], //AiLuzern1
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	15
	]
],
[
	false, 
	[[15773.251, 13246.546, 0.01], //AiEmmenPort
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	16
	]
],
[
	false, 
	[[6475.2368, 9775.0908, 0.01], //AiMunchenstein1
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	17
	]
],
[
	false, 
	[[6600.7964, 9486.6035, 0.01], //AiMunchenstein2
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	18
	]
],
[
	false, 
	[[7356.041, 14796.133, 0.01], //AiTruebInd
	1,			//Number Of units
	0.5,			//Skill level 0-1 or skill array number if using custom skills "Random" for random Skill array.
	6,		      //Primary gun set number. "Random" for random weapon set.
	3,						  //Number of magazines
	"DZ_Patrol_Pack_EP1",						  //Backpack "" for random or classname here.
	"Survivor2_DZ",			  //Skin "" for random or classname here.
	5,                  //Gearset number. "Random" for random gear set.
	false,
	19
	]
]
];



while { true } do {

	{ // For every dynamic AI defined
		for [{_y=0},{_y<(count playableUnits)},{_y=_y+1}] do {
			_unit = (playableUnits select _y);
			if (alive _unit) then {
				_alive = _x select 0;
				_data = _x select 1;
				_pos = _data select 0;

				if (_unit distance _pos < 1000 && (!_alive)) exitWith {
					_tmp_patrol_radius = ai_patrol_radius;
					ai_patrol_radius = 100;
					
					_data call spawn_neutral_group;
					ai_patrol_radius = _tmp_patrol_radius;
					_x set [0, true];
				};
			};
		};
		sleep 1;
	} count dyn_ai_list;

	sleep 10;
};

