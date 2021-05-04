#include "\z\addons\dayz_code\util\Math.hpp"
#include "\z\addons\dayz_code\util\Vector.hpp"
#include "\z\addons\dayz_code\loot\Loot.hpp"

//Spawn frequency and variance in minutes
#define SPAWN_FREQUENCY 25
#define SPAWN_VARIANCE 20

//The higher the number, the more accurate the timer is.
//Must be positive and non-zero.
#define TIMER_RESOLUTION 10

//Chance to spawn a crash site
#define SPAWN_CHANCE 0.75

//Parameters for finding a suitable position to spawn the crash site

//Number of crash sites to spawn at the beginning of the mission
#define INITIAL_NUM 1

//Number of loot items to spawn per site
#define LOOT_MIN 5
#define LOOT_MAX 8

private
[
	"_spawnCrashSite",
	"_type",
	"_class",
	"_lootGroup",
	"_position",
	"_vehicle",
	"_dir",
	"_mag",
	"_lootNum",
	"_lootPos",
	"_lootVeh",
	"_time"
];

_position = _this select 0;

_spawnCrashSite =
{
	_type = Loot_SelectSingle(Loot_GetGroup("CrashSiteType"));
	_class = _type select 1;
	_lootGroup = Loot_GetGroup(_type select 2);
	
	_position = _this;
	_position set [2, 0];
	
	_lootNum = round Math_RandomRange(LOOT_MIN, LOOT_MAX);
	
	diag_log format ["WAI CRASHLOOT: Spawning crash loot (%1) at %2 with %3 items.", _class, _position, _lootNum];
	
	_vehicle = "ClutterCutter_small_2_EP1" createVehicle _position;

	{
		_dir = random 360;
		_mag = (random 15)+6;
		_lootPos = [(_mag * sin _dir)+(_position select 0), (_mag * cos _dir)+(_position select 1), 0];
		
		_lootVeh = Loot_Spawn(_x, _lootPos, "");
		_lootVeh setVariable ["permaLoot", true];
		
		switch (dayz_spawnCrashSite_clutterCutter) do
		{
			case 1: //Lift loot up by 5cm
			{
				_lootPos set [2, 0.05];
				_lootVeh setPosATL _lootPos;
			};
			
			case 2: //Clutter cutter
			{
				//createVehicle ["ClutterCutter_small_2_EP1", _lootPos, [], 0, "CAN_COLLIDE"];
				"ClutterCutter_small_2_EP1" createVehicle _lootPos;
			};
			
			case 3: //Debug sphere
			{
				//createVehicle ["Sign_sphere100cm_EP1", _lootPos, [], 0, "CAN_COLLIDE"];
				"Sign_sphere100cm_EP1" createVehicle _lootPos;
			};
		};
	}
	forEach Loot_Select(_lootGroup, _lootNum);
};

_position call _spawnCrashSite;
