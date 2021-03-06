/*																					//
	Blackhawk down Mission by bap
	Based on New Mission Format by Vampire
*/																					//

private ["_missName","_coords","_survivors","_blackhawk","_patrol","_patrol2", "_patrolPos1", "_patrolPos2", "_patrolCrew1", "_patrolCrew2", "_startTime", "_wp"];


//////////////////////////////////////////////////////////////////////////////////////////////
// Rides

OKRideList = ["ArmoredSUV_PMC_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE"];
OKGunsList =[];
OKSARList = ["Mi17_DZ", "UH1H_DZ", "UH60M_EP1_DZ", "UH1Y_DZ", "CH_47F_EP1_DZ"]; //["UH1H_TK_GUE_EP1","UH1Y","Mi17_CDF","MH60S","CH_47F_EP1","Mi17_Ins","Mi24_P","Mi171Sh_CZ_EP1","Mi17_TK_EP1","UH1H_TK_EP1","UH60M_EP1","KA60_GL_PMC"];
OKCoords=[[4600,10300,0],[4500,10200,0]];

//Name of the Mission
_missName = "OK Blackhawk down";

//OKFindPos loops BIS_fnc_findSafePos until it gets a valid result
//_coords = OKCoords call BIS_fnc_selectRandom;
_coords = call OKFindPos;

[nil,nil,rTitleText,"OK Blackop evac was downed while trying to left Napf airspace. SAR is on the way. Don't let any survivors get away with swiss gold and secret documents.", "PLAIN",10] call RE;

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
_patrolPos1 = [100, (_coords select 1), 500];
_patrol = OKSARList select floor (random (count OKSARList));
_patrolCrew1 = [_coords,   //Position to patrol
_patrolPos1, // Position to spawn
200, //Radius of patrol
10,                     //Number of waypoints to give
_patrol, //Classname of vehicle (make sure it has driver and gunner)
1 //Skill level of units 
] call OKVehiclePatrol;

sleep 30;

_patrolPos2 = [(_coords select 0), 100, 500];
_patrol2 = OKSARList select floor (random (count OKSARList));
_patrolCrew2 = [_coords,   //Position to patrol
_patrolPos2, // Position to spawn
200, //Radius of patrol
10,                     //Number of waypoints to give
_patrol2, //Classname of vehicle (make sure it has driver and gunner)
1 //Skill level of units 
] call OKVehiclePatrol;

//OKAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, skin]
_survivors = [_coords,(round(random 7))+1,(round(random 3)),(round(random 3))] call OKAISpawn2;
//_survivors = [_coords,1,0,2] ExecVM OKAISpawn;


//Wait until the player is within 5 meters
waitUntil {sleep 3; {isPlayer _x && _x distance _coords <= 5 } count playableunits > 0 }; 

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

sleep OKDespawnTime;

// Once timed out, if anyone is alive then just delete them.
{
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach units _survivors;

{ deleteWaypoint [_patrolCrew1, 0]; } count waypoints _patrolCrew1;
{ deleteWaypoint [_patrolCrew2, 0]; } count waypoints _patrolCrew2;

_patrolCrew1 setCombatMode "BLUE";
_patrolCrew1 setBehaviour "CARELESS";
_wp = _patrolCrew1 addWaypoint [[10000,0,0], 200];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 200;

_patrolCrew2 setCombatMode "BLUE";
_patrolCrew2 setBehaviour "CARELESS";
_wp = _patrolCrew2 addWaypoint [[0,10000,0], 200];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 200;

// Send away helis to off bounds and destroy them there.
_startTime = time;
waitUntil { sleep 1; ((vehicle (leader _patrolCrew1)) distance [10000,0,100]) < 250 || (time - _startTime) > 450};
waitUntil { sleep 1; ((vehicle (leader _patrolCrew2)) distance [0,10000,100]) < 250 || (time - _startTime) > 450};
{
	if (alive _x) then {
		if (_x != vehicle _x) then {
			(vehicle _x) setDamage 1;
		};
		deleteVehicle _x;
		sleep 0.05;
	};
} forEach ((units _patrolCrew1) + (units _patrolCrew2) + (units _survivors));

