/*
	Overkill config
*/

///////////////////////////////////////////////////////////////////////
// Do you want your players to gain humanity from killing mission AI?
OKMissHumanity = false;
OKGainHumanity = true;

// How Much Humanity?
OKCntHumanity = 15;

// Do you want AI kills to count as bandit kills?
OKCntBanditKls = false;

// Do you want AI that players run over to not have gear?
OKRunGear = true;

// How long before bodies disappear? (in seconds) (default = 2400)
OKBodyTime = 2400;

// How long before alive AI disappear after mission is completed (in seconds) (default = 1200)
OKDespawnTime = 1200;

//////////////////////////////////////////////////////////////////////////////////////////
// You can adjust the weapons that spawn in weapon crates inside DZMSWeaponCrateList.sqf
// You can adjust the AI's gear inside DZMSAIConfig.sqf in the ExtConfig folder also.
//////////////////////////////////////////////////////////////////////////////////////////

//Large Vehicles (Urals)
OKLargeVic = ["Ural_TK_CIV_EP1"];

//Patrol Vehicles
OKPatrolVeh = ["Offroad_DSHKM_Gue_DZ","Pickup_PK_GUE_DZ","Pickup_PK_INS","Pickup_PK_TK_GUE_EP1"];

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Do you want vehicles from missions to save to the Database? (this means they will stay after a restart)
// If False, vehicles will disappear on restart. It will warn a player who gets inside of a vehicle.
// This is experimental, and off by default in this version.
OKSaveVehicles = true;

/*
Below is the array of mission file names and the minimum and maximum times they run.
Do not edit the Arrays unless you know what you are doing.
*/
//"SM01","SM02","SM03"
//OKMajorArray = ["SM02", "SM03", "SM04"]; // Commented because cannot be used
OKMajorArray = ["SM02", "SM03"];

/////////////////////////////////////////////////////////////////////////////////////////////
// The Minumum time in seconds before a major mission will run.
// At least this much time will pass between major missions. Default = 650 (10.8 Minutes)
OKMajorMin = 60;

// Maximum time in seconds before a major mission will run.
// A major mission will always run before this much time has passed. Default = 2000 (33.33 Minutes)
OKMajorMax = 120;


/*=============================================================================================*/
// Do Not Edit Below This Line
/*=============================================================================================*/
OKVersion = "RC1.0";
OKConfigured = true;
