// For DayZ Epoch

// EPOCH CONFIG VARIABLES START //
#include "\z\addons\dayz_code\configVariables.sqf" // Don't remove this line
// See the above file for a full list including descriptions and default values

// Server only settings
if (isServer) then {
	dayZ_instance = 24; //Instance ID of this server
	dayz_POIs = false; //Adds Point of Interest map additions (negatively impacts FPS)
	MaxDynamicDebris = 500; // Max number of random road blocks to spawn around the map
	MaxVehicleLimit = 300; // Max number of random vehicles to spawn around the map
	spawnArea = 1400; // Distance around markers to find a safe spawn position
	spawnShoremode = 1; // Random spawn locations  1 = on shores, 0 = inland
	EpochEvents = [ //[year,month,day of month, minutes,name of file - .sqf] If minutes is set to -1, the event will run once immediately after server start.
		//["any","any","any","any",-1,"Infected_Camps"], // (negatively impacts FPS)
		["any","any","any","any",-1,"Care_Packages"],
		["any","any","any","any",-1,"CrashSites"]
	];
};

// Client only settings
if (!isDedicated) then {
	dayz_antihack = 1; // DayZ Antihack / 1 = enabled // 0 = disabled
	dayZ_serverName = "Scaffery - Napf "; //Shown to all players in the bottom left of the screen (country code + server number)
	dayz_enableRules = true; //Enables a nice little news/rules feed on player login (make sure to keep the lists quick).
	dayz_quickSwitch = false; //Turns on forced animation for weapon switch. (hotkeys 1,2,3) False = enable animations, True = disable animations
	dayz_randomMaxFuelAmount = 500; //Puts a random amount of fuel in all fuel stations.
	dayz_bleedingeffect = 2; //1 = blood on the ground (negatively impacts FPS), 2 = partical effect, 3 = both
	dayz_nutritionValuesSystem = true; //true, Enables nutrition system, false, disables nutrition system.
	dayz_DamageMultiplier = 2; //1 - 0 = Disabled, anything over 1 will multiply damage. Damage Multiplier for Zombies.
	dayz_maxGlobalZeds = 500; //Limit the total zeds server wide.
	dayz_temperature_override = false; // Set to true to disable all temperature changes.
	DZE_TwoPrimaries = 2; // 0 do not allow primary weapon on back. 1 allow primary weapon on back, but not when holding a primary weapon in hand. 2 allow player to hold two primary weapons, one on back and one in their hands.
	dayz_paraSpawn = false; // Halo spawn
	DZE_BackpackAntiTheft = true; // Prevent stealing from backpacks in trader zones
	DZE_BuildOnRoads = false; // Allow building on roads
	DZE_R3F_WEIGHT = true; // Enable R3F weight. Players carrying too much will be overburdened and forced to move slowly.
	DZE_StaticConstructionCount = 1; // Steps required to build. If greater than 0 this applies to all objects.
	DZE_requireplot = 1; // Require a plot pole to build  0 = Off, 1 = On
	DZE_PlotPole = [45,45]; // Radius owned by plot pole [Regular objects,Other plotpoles]. Difference between them is the minimum buffer between bases.
	DZE_BuildingLimit = 300; // Max number of built objects allowed in DZE_PlotPole radius
	DZE_SelfTransfuse = true; // Allow players to bloodbag themselves
	DZE_selfTransfuse_Values = [12000,15,120]; // [blood amount given, infection chance %, cooldown in seconds]
	dayz_maxMaxWeaponHolders = 120; // Maximum number of loot piles that can spawn within 200 meters of a player.

};

// Settings for both server and client
dayz_REsec = 1; // DayZ RE Security / 1 = enabled // 0 = disabled
dayz_infectiousWaterholes = false; //Randomly adds some bodies, graves and wrecks by ponds (negatively impacts FPS)
dayz_ForcefullmoonNights = true; // Forces night time to be full moon.
dayz_spawnselection = 0; //(Chernarus only) Turn on spawn selection 0 = random only spawns, 1 = spawn choice based on limits
dayz_classicBloodBagSystem = true; // disable blood types system and use the single classic ItemBloodbag
dayz_enableFlies = false; // Enable flies on dead bodies (negatively impacts FPS).
DZE_PlayerZed = false; // Enable spawning as a player zombie when players die with infected status
DZE_GodModeBase = false; // Make player built base objects indestructible
DZE_SafeZonePosArray = [[[8246,15485,0],100],[[15506,13229,0],100],[[12399,5074,0],100],[[10398,8279,0],100],[[5149,4864,0],100],[[15128,16421,0],100]]; // Format is [[[3D POS],RADIUS],[[3D POS],RADIUS]]; Stops loot and zed spawn, salvage and players being killed if their vehicle is destroyed in these zones.
DZE_Weather = 1; // Options: 1 - Summer Static, 2 - Summer Dynamic, 3 - Winter Static, 4 - Winter Dynamic. If static is selected, the weather settings will be set at server startup and not change. Weather settings can be adjusted with array DZE_WeatherVariables in configVariables.sqf.

dayz_groupSystem = true; // Enable group system
dayz_markGroup = 2; // Players can see their group members on the map 0=never, 1=always, 2=With GPS only
dayz_markSelf = 2; // Players can see their own position on the map 0=never, 1=always, 2=With GPS only
dayz_markBody = 1; // Players can see their corpse position on the map 0=never, 1=always, 2=With GPS only
dayz_requireRadio = false; // Require players to have a radio on their toolbelt to create a group, be in a group and receive invites.
MaxMineVeins = 2;
DZE_GemOccurance = [["ItemTopaz",1000], ["ItemObsidian",50], ["ItemSapphire",25], ["ItemAmethyst",12], ["ItemEmerald",6], ["ItemCitrine",2], ["ItemRuby",1]]; //Sets how rare each gem is in the order shown when mining (whole numbers only)
DZE_GemWorthArray = [["ItemTopaz",50000], ["ItemObsidian",100000], ["ItemSapphire",500000], ["ItemAmethyst",1000000], ["ItemEmerald",5000000], ["ItemCitrine",10000000], ["ItemRuby",50000000]]; // Array of gem prices, only works with config traders. Set DZE_GemWorthArray=[]; to disable return change in gems.

// Uncomment the lines below to change the default loadout
//DefaultMagazines = ["HandRoadFlare","ItemBandage","ItemPainkiller","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov"];
//DefaultWeapons = ["Makarov_DZ","ItemFlashlight"];
//DefaultBackpack = "DZ_Patrol_Pack_EP1";
//DefaultBackpackItems = []; // Can include both weapons and magazines i.e. ["PDW_DZ","30Rnd_9x19_UZI"];

// EPOCH CONFIG VARIABLES END //

enableRadio false;
enableSentences false;
setTerrainGrid 25;

diag_log 'dayz_preloadFinished reset';
dayz_preloadFinished=nil;
onPreloadStarted "diag_log [diag_tickTime,'onPreloadStarted']; dayz_preloadFinished = false;";
onPreloadFinished "diag_log [diag_tickTime,'onPreloadFinished']; dayz_preloadFinished = true;";
with uiNameSpace do {RscDMSLoad=nil;}; // autologon at next logon

if (!isDedicated) then {
	enableSaving [false, false];
	startLoadingScreen ["","RscDisplayLoadCustom"];
	dayz_progressBarValue = 0;
	dayz_loadScreenMsg = localize 'str_login_missionFile';
	progress_monitor = [] execVM "\z\addons\dayz_code\system\progress_monitor.sqf";
	0 cutText ['','BLACK',0];
	0 fadeSound 0;
	0 fadeMusic 0;
};

initialized = false;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";
DayZ_SafeObjects = ["Base_Fire_DZ","Land_Fire_DZ","TentStorage","TentStorage0","TentStorage1","TentStorage2","TentStorage3","TentStorage4","StashSmall","StashSmall1","StashSmall2","StashSmall3","StashSmall4","StashMedium","StashMedium1","StashMedium2","StashMedium3","StashMedium4","Wire_cat1","Sandbag1_DZ","Fence_DZ","Generator_DZ","Hedgehog_DZ","BearTrap_DZ","DomeTentStorage","DomeTentStorage0","DomeTentStorage1","DomeTentStorage2","DomeTentStorage3","DomeTentStorage4","CamoNet_DZ","Trap_Cans","TrapTripwireFlare","TrapBearTrapSmoke","TrapTripwireGrenade","TrapTripwireSmoke","TrapBearTrapFlare","TentStorageDomed","VaultStorageLocked","VaultStorage2Locked","BagFenceRound_DZ","TrapBear","Fort_RazorWire","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Land_HBarrier5_DZ","Fence_corrugated_DZ","M240Nest_DZ","CanvasHut_DZ","ParkBench_DZ","MetalGate_DZ","OutHouse_DZ","Wooden_shed_DZ","Wooden_shed2_DZ","WoodShack_DZ","WoodShack2_DZ","StorageShed_DZ","StorageShed2_DZ","Plastic_Pole_EP1_DZ","StickFence_DZ","LightPole_DZ","FuelPump_DZ","DesertCamoNet_DZ","ForestCamoNet_DZ","WinterCamoNet_DZ","DesertLargeCamoNet_DZ","ForestLargeCamoNet_DZ","WinterLargeCamoNet_DZ","SandNest_DZ","DeerStand_DZ","MetalPanel_DZ","WorkBench_DZ","WoodFloor_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","LockboxStorageLocked","LockboxStorage2Locked","LockboxStorageWinterLocked","LockboxStorageWinter2Locked","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodStairs_DZ","WoodStairsSans_DZ","WoodStairsRails_DZ","WoodSmallWallThird_DZ","WoodLadder_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallSmallDoorway_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","MetalFloor_DZ","WoodRamp_DZ","GunRack_DZ","GunRack2_DZ","FireBarrel_DZ","WoodCrate_DZ","WoodCrate2_DZ","Scaffolding_DZ","DesertTentStorage","DesertTentStorage0","DesertTentStorage1","DesertTentStorage2","DesertTentStorage3","DesertTentStorage4","WoodenFence_1_foundation_DZ","WoodenFence_1_frame_DZ","WoodenFence_quaterpanel_DZ","WoodenFence_halfpanel_DZ","WoodenFence_thirdpanel_DZ","WoodenFence_1_DZ","WoodenFence_2_DZ","WoodenFence_3_DZ","WoodenFence_4_DZ","WoodenFence_5_DZ","WoodenFence_6_DZ","WoodenFence_7_DZ","MetalFence_1_foundation_DZ","MetalFence_1_frame_DZ","MetalFence_halfpanel_DZ","MetalFence_thirdpanel_DZ","MetalFence_1_DZ","MetalFence_2_DZ","MetalFence_3_DZ","MetalFence_4_DZ","MetalFence_5_DZ","MetalFence_6_DZ","MetalFence_7_DZ","WoodenGate_foundation_DZ","WoodenGate_1_DZ","WoodenGate_2_DZ","WoodenGate_3_DZ","WoodenGate_4_DZ","WoodGateFrame_DZ","Land_DZE_WoodGate","Land_DZE_WoodGateLocked","CinderGateFrame_DZ","CinderGate_DZ","CinderGateLocked_DZ","Metal_Drawbridge_DZ","Metal_DrawbridgeLocked_DZ","WoodTriangleWall_DZ","WoodHandrail_DZ","WoodFloorStairs_DZ","WoodPillar_DZ","Land_DZE_WoodOpenTopGarageDoor","Land_DZE_WoodOpenTopGarageLocked","CinderGarageOpenTopFrame_DZ","CinderGarageOpenTop_DZ","CinderGarageOpenTopLocked_DZ","DoorFrame_DZ","Door_DZ","DoorLocked_DZ","CinderWallWindow_DZ","CinderWallWindowLocked_DZ","CinderDoorHatch_DZ","CinderDoorHatchLocked_DZ","MetalPillar_DZ","MetalFloor_Half_DZ","MetalFloor_Quarter_DZ","GlassFloor_DZ","Concrete_Bunker_DZ","Concrete_Bunker_Locked_DZ","TallSafeLocked","Advanced_WorkBench_DZ","CookTripod_DZ","Stoneoven_DZ","Commode_DZ","Wardrobe_DZ","Fridge_DZ","Washing_Machine_DZ","Server_Rack_DZ","ATM_DZ","Armchair_DZ","Sofa_DZ","Arcade_DZ","Vendmachine1_DZ","Vendmachine2_DZ","Notebook_DZ","Water_Pump_DZ","Greenhouse_DZ","Bed_DZ","Table_DZ","Office_Chair_DZ","MetalFloor4x_DZ","GlassFloor_Half_DZ","GlassFloor_Quarter_DZ","WoodFloor4x_DZ","WoodTriangleFloor_DZ","CinderWallHalf_Gap_DZ","TentStorageWinter","TentStorageWinter0","TentStorageWinter1","TentStorageWinter2","TentStorageWinter3","TentStorageWinter4","WinterDomeTentStorage","WinterDomeTentStorage0","WinterDomeTentStorage1","WinterDomeTentStorage2","WinterDomeTentStorage3","WinterDomeTentStorage4","VaultStorageBroken","VaultStorageBroken2","TallSafeBroken","LockboxStorageBroken","LockboxStorage2Broken","LockboxStorageWinterBroken","LockboxStorageWinter2Broken","StorageCrate_DZ","CamoStorageCrate_DZ","Garage_Green_DZ","Garage_White_DZ","Garage_Brown_DZ","Garage_Grey_DZ","Helipad_Civil_DZ","Helipad_Rescue_DZ","Helipad_Army_DZ","Helipad_Cross_DZ","Helipad_ParkBorder_DZ","CCTV_DZ","Land_Barrel_water","MAP_F_postel_manz_kov"];
DZE_safeVehicle = ["ParachuteWest","ParachuteC","ParachuteEast","UH60_wreck_EP1"];
DZE_Workshops = ["Wooden_shed_DZ","Wooden_shed2_DZ","WoodShack_DZ","WoodShack2_DZ","WorkBench_DZ","Advanced_WorkBench_DZ","WorkBench","C130j","C130j_US_EP1","C130j_US_EP1_DZ"];
dayz_progressBarValue = 0.05;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";
dayz_progressBarValue = 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
dayz_progressBarValue = 0.15;
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
call compile preprocessFileLineNumbers "custom\compiles.sqf";
dayz_progressBarValue = 0.25;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\mission\napf.sqf"; //Add trader city objects locally on every machine early
call compile preprocessFileLineNumbers "server_traders.sqf"; //Add trader city objects locally on every machine early

// ADMINTOOLS
call compile preprocessFileLineNumbers "admintools\config.sqf"; // Epoch admin Tools config file
call compile preprocessFileLineNumbers "admintools\variables.sqf"; // Epoch admin Tools variables


initialized = true;

if (dayz_REsec == 1) then {call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\REsec.sqf";};

if (isServer) then {
	if (dayz_POIs) then {call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\mission\chernarus\poi\init.sqf";};
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\system\dynamic_vehicle.sqf";
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\system\server_monitor.sqf";
	execVM "\z\addons\dayz_server\traders\napf.sqf"; //Add trader agents
	
	//Get the server to setup what waterholes are going to be infected and then broadcast to everyone.
	if (dayz_infectiousWaterholes) then {execVM "\z\addons\dayz_code\system\mission\chernarus\infectiousWaterholes\init.sqf";};
	
	// Lootable objects from CfgTownGeneratorDefault.hpp
	if (dayz_townGenerator) then { execVM "\z\addons\dayz_code\system\mission\chernarus\MainLootableObjects.sqf"; };
};

if (!isDedicated) then {
	//call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\mission\server_traders\napf.sqf";

	if (toLower worldName in ["chernarus","chernarus_winter"]) then {
		execVM "\z\addons\dayz_code\system\mission\chernarus\hideGlitchObjects.sqf";
	};
	
	// Enables Plant lib fixes
	//execVM "\z\addons\dayz_code\system\antihack.sqf";
	if ( !((getPlayerUID player) in AdminList) && !((getPlayerUID player) in ModList)) then 
	{
		execVM "\z\addons\dayz_code\system\antihack.sqf";
	} else {
		dayz_antihack = 0;
	};


	if (dayz_townGenerator) then {execVM "\z\addons\dayz_code\compile\client_plantSpawner.sqf";};

	// ESS v3
	call compile preprocessFileLineNumbers "spawn\init.sqf";

	execFSM "\z\addons\dayz_code\system\player_monitor.fsm";
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	//[600,.15,30] execVM "\z\addons\dayz_code\compile\fn_chimney.sqf"; // Smoking chimney effects.
	if (DZE_R3F_WEIGHT) then {execVM "\z\addons\dayz_code\external\R3F_Realism\R3F_Realism_Init.sqf";};
	waitUntil {scriptDone progress_monitor};
	cutText ["","BLACK IN", 3];
	3 fadeSound 1;
	3 fadeMusic 1;
	endLoadingScreen;
};

if (!isServer) then {

	// ADMINTOOLS
	[] execVM "admintools\Activate.sqf"; // Epoch admin tools

	// Safe Zones
	[] execVM "custom\safezones\safezone.sqf";

	// Start custom debug monitor
	execVM "custom\gui\playerstats.sqf";

	// Service Point
	sleep 5;

	// ... some other stuff ...
	// add the next line somewhere in this block
	execVM "custom\service_point\service_point.sqf";
};
