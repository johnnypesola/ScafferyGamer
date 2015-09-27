/*																					//
	Blackhawk down Mission by bap
	Based on New Mission Format by Vampire
*/																					//

private ["_missName","_coords","_survivor","_blackhawk","_patrol","_patrol2"];


//////////////////////////////////////////////////////////////////////////////////////////////
// Rides

OKRideList = ["ArmoredSUV_PMC_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE"];
OKGunsList =[];
OKSARList = ["UH1H_TK_GUE_EP1","UH1Y","Mi17_CDF","MH60S","CH_47F_EP1","Mi17_Ins","Mi24_P","Mi171Sh_CZ_EP1","Mi17_TK_EP1","UH1H_TK_EP1","UH60M_EP1","KA60_GL_PMC"];
OKCoords=[[4600,10300,0],[4500,10200,0]];

//Name of the Mission
_missName = "OK Blackhawk down";

//OKFindPos loops BIS_fnc_findSafePos until it gets a valid result
//_coords = OKCoords call BIS_fnc_selectRandom;
_coords = call OKFindPos;

[nil,nil,rTitleText,"OK Blackop evac was downed while trying to left Chernarus airspace. SAR is on the way. Don't let any survivors get away with Chernarusian gold and secret documents.", "PLAIN",10] call RE;

//OKAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM OKAddMajMarker;

//Create ground vehicles
//_vehicle = createVehicle ["ArmoredSUV_PMC_DZE",[2300,15300,0],[], 0, "CAN_COLLIDE"];
//_vehicle1 = createVehicle ["HMMWV_M998A2_SOV_DES_EP1_DZE",[2310,15300,0],[], 0, "CAN_COLLIDE"];
//_vehicle2 = createVehicle ["HMMWV_M1151_M2_CZ_DES_EP1_DZE",[2290,15300,0],[], 0, "CAN_COLLIDE"];

//Create choppers
//_SAR = createVehicle ["UH1H_TK_GUE_EP1",[2300,15330,0],[], 0, "CAN_COLLIDE"];
//_guns1 = "AH6J_EP1" createUnit [[2350,15330,100]];
//_guns2 = "AH6J_EP1" createUnit [[2250,15330,100]];

//OKSetupVehicle prevents the vehicle from disappearing and sets fuel and such
//[_vehicle] call OKSetupVehicleArmed;
//[_vehicle1] call OKSetupVehicleArmed;
//[_vehicle2] call OKSetupVehicleArmed;
//[_SAR] call OKSetupVehicleArmed;



//setting up scene
_blackhawk = createVehicle ["UH60_wreck_EP1",_coords,[], 0, "CAN_COLLIDE"];
[_blackhawk] call OKSetupVehicle;

//Spawn patrol
_patrol = OKSARList select floor (random (count OKSARList));
[_coords,   //Position to patrol
_coords, // Position to spawn
200, //Radius of patrol
10,                     //Number of waypoints to give
_patrol, //Classname of vehicle (make sure it has driver and gunner)
1 //Skill level of units 
] call OKVehiclePatrol;

sleep 30;

_patrol2 = OKSARList select floor (random (count OKSARList));
[_coords,   //Position to patrol
_coords, // Position to spawn
200, //Radius of patrol
10,                     //Number of waypoints to give
_patrol2, //Classname of vehicle (make sure it has driver and gunner)
1 //Skill level of units 
] call OKVehiclePatrol;

//OKAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, skin]
_survivor = [_coords,(round(random 7))+1,(round(random 3)),(round(random 3))] ExecVM OKAISpawn2;
//_survivor = [_coords,1,0,2] ExecVM OKAISpawn;


//Wait until the player is within 5 meters
waitUntil{ {isPlayer _x && _x distance _coords <= 5 } count playableunits > 0 }; 

//Call OKSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
//[_vehicle] ExecVM OKSaveVeh;
//[_vehicle1] ExecVM OKSaveVeh;
//[_vehicle2] ExecVM OKSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"There's no survivors!", "PLAIN",6] call RE;
diag_log format["[OK]: Blackhawk Mission has Ended."];
deleteMarker "OKMajMarker";
deleteMarker "OKMajDot";

//Let the timer know the mission is over
OKMajDone = true;