/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	24;				//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

s_player_packMachinegun = -1;
s_player_deploybike = -1;
s_player_deploybike2 = -1;
s_player_addAmmoOption = -1;
s_player_addAmmoOption2 = -1;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epochconfig
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500
// 
MaxVehicleLimit = 300; // Default = 50
MaxDynamicDebris = 500; // Default = 100
dayz_MapArea = 18000; // Default = 10000
dayz_maxLocalZombies = 30; // Default = 30 
DZE_PlotPole = [45,45]; // Default - [30,45]

DefaultWeapons = ["ItemRadio"];
DefaultBackpack = "";

staticMG_carryingMG = false;

DZE_SelfTransfuse = true;
DZE_DeathMsgGlobal = true;
DZE_PlayerZed   = false;
DZE_GodModeBase = false;

DZE_DiagFpsSlow = true;
DZE_DiagVerbose = false;
DZE_DiagFpsFast = false;
DZE_BuildingLimit = 500;
dayz_minpos = -1000; 
dayz_maxpos = 26000;
DZE_requireplot = 0;

//ESS
dayz_spawnselection = 0;
dayz_paraSpawn = false;

dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;

dayz_maxAnimals = 5; // Default: 8
dayz_tameDogs = true;
DynamicVehicleDamageLow = 0; // Default: 0
DynamicVehicleDamageHigh = 100; // Default: 100

DZE_BuildOnRoads = true; // Default: False
DZE_HeliLift = false; // Will use R3F logistics modified by nightmare

// ADDED FOR better view distance :P
setViewDistance 4000;
setTerrainGrid 25;

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];
dayz_fullMoonNights = true;

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
call compile preprocessFileLineNumbers "custom\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

DZE_isRemovable = ["Fence_corrugated_DZ","M240Nest_DZ","ParkBench_DZ","Plastic_Pole_EP1_DZ","FireBarrel_DZ","Scaffolding_DZ","Land_Barrel_water","Land_Barrel_empty"];
dayz_allowedObjects = ["TentStorage","TentStorageDomed","TentStorageDomed2", "VaultStorageLocked", "Hedgehog_DZ", "Sandbag1_DZ","BagFenceRound_DZ","TrapBear","Fort_RazorWire","WoodGate_DZ","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Land_HBarrier5_DZ","Fence_corrugated_DZ","M240Nest_DZ","CanvasHut_DZ","ParkBench_DZ","MetalGate_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","Plastic_Pole_EP1_DZ","Generator_DZ","StickFence_DZ","LightPole_DZ","FuelPump_DZ","DesertCamoNet_DZ","ForestCamoNet_DZ","DesertLargeCamoNet_DZ","ForestLargeCamoNet_DZ","SandNest_DZ","DeerStand_DZ","MetalPanel_DZ","WorkBench_DZ","WoodFloor_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","LockboxStorageLocked","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodStairs_DZ","WoodStairsSans_DZ","WoodStairsRails_DZ","WoodSmallWallThird_DZ","WoodLadder_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallSmallDoorway_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","MetalFloor_DZ","WoodRamp_DZ","GunRack_DZ","FireBarrel_DZ","WoodCrate_DZ","Scaffolding_DZ","Land_Ind_TankSmall2_EP1","Land_Ind_Garage01","Land_sara_hasic_zbroj","Land_SS_hangar","Explosive","M2StaticMG", "MAP_p_Helianthus", "Land_Barrel_empty", "Land_Barrel_water", "DSHKM_CDF", "Land_postel_panelak1"];
DZE_HeliAllowTowFrom = [
	"CH47_base_EP1",
	"CH_47F_EP1",
	"CH_47F_EP1_DZ",
	"CH_47F_EP1_DZE",
	"CH_47F_BAF",
	"BAF_Merlin_DZE",
	"BAF_Merlin_HC3_D",
	"USEC_ch53_E",
	"CH53_DZE",
	"MV22",
	"MV22_DZ"
];

DZE_HeliAllowToTow = [
	"hilux1_civil_1_open",
	"HMMWV_Base",
	"Lada_base",
	"Offroad_DSHKM_base",
	"Pickup_PK_base",
	"SkodaBase",
	"tractor",
	"VWGolf",
	"Volha_TK_CIV_Base_EP1",
	"S1203_TK_CIV_EP1",
	"SUV_Base_EP1",
	"ArmoredSUV_Base_PMC",
	"UAZ_Base",
	"LandRover_Base",
	"Ship",
	"C130J",
	"MV22",
	"An2_Base_EP1",
	"BAF_Merlin_HC3_D",
	"CH47_base_EP1",
	"Mi17_base",
	"UH1_Base",
	"UH1H_base",
	"UH1Y",
	"UH60_Base",
	"AH6_Base_EP1",
	"C130J_US_EP1",
	"USEC_ch53_E",
	"Wheeled_APC",
	"V3S_Base",
	"Ural_Base",
	"UralOpen_Base",
	"UralRefuel_TK_EP1",
	"Kamaz_Base",
	"KamazRefuel",
	"MtvrRefuel",
	"datsun1_civil_1_open",
	"TT650_Base",
	"M1030",
	"Tracked_APC",
	"MTVR",
	"Bus",
	"Ikarus",
	"TowingTractor",
	"ATV_Base_EP1",
	"BAF_Jackal2_BASE_D",
	"Old_moto_base",
	"AAV",
	"M1126_ICV_M2_EP1",
	"M1126_ICV_MK19_EP1",
	"M1133_MEV_EP1",
	"BAF_Jackal2_L2A1_w",
	"M113_Base"
];

if (isServer) then {
	//Compile vehicle configs
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\dynamic_vehicle.sqf";				
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\mission.sqf";

	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";

	// ESS
	execVM "dzgm\init.sqf";
	execVM "spawn\start.sqf";

	// Safe Zones
	[] execVM "custom\safezones\safezone.sqf";

	// Epoch Admin Tools
	call compile preprocessFileLineNumbers "admintools\AdminList.sqf";
	if ( !((getPlayerUID player) in AdminList) && !((getPlayerUID player) in ModList)) then 
	{
		//anti Hack
		//[] execVM "\z\addons\dayz_code\system\antihack.sqf";
		[] execVM "admintools\antihack.sqf";
	};


	//Lights
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	
	// ADDED FOR Custom Debug Monitor
	[] execVM "custom\gui\playerstats.sqf";

};

#include "\z\addons\dayz_code\system\REsec.sqf"

//Start Dynamic Weather
execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";

#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

// Service Point
if (!isDedicated) then {
    sleep 5;

    // ... some other stuff ...
    // add the next line somewhere in this block
    execVM "custom\service_point\service_point.sqf";
};

// Epoch Admin Tools
execVM "admintools\Activate.sqf";

// Preserve skin script
[] spawn {
	private ["_playerBody","_skin","_skinOk","_result"];
	waitUntil {r_player_dead};
	_playerBody = player;
	_skin = typeOf _playerBody;
	_skin = "Skin_" + _skin;
	_skinOk = isClass (configFile >> "CfgMagazines" >> _skin);
	if (_skinOk) then {
		_result = [_playerBody, _skin] call BIS_fnc_invAdd;
		if (!_result) then {
			(unitBackpack _playerBody) addMagazineCargoGlobal [_skin, 1];
		};
	};
};
