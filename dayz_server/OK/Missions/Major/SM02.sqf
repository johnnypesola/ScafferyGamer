/*																					//
	Villa ambush by bap (Original Full Code by TheSzerdi & TAW_Tonic)
	New Mission Format by Vampire
*/																					//

private ["_missName","_coords","_crate","_crate1","_vehicle","_variant","_villa","_nu","_pu","_sw","_loc","_poc","_amb","_unit1","_unit2","_unit3","_unit4","_unit5","_loot"];

//////////////////////////////////////////////////////////////////////////////////////////////
// Rides

OKLoot = ["weapons","medical","supply","secret","cloth"];
OKRideList = ["ArmoredSUV_PMC_DZE","BTR60_TK_EP1","BRDM2_Gue","GAZ_Vodnik_DZE","BMP2_Ambul_INS","BTR40_TK_GUE_EP1","HMMWV_M1151_M2_CZ_DES_EP1_DZE","M113Ambul_TK_EP1_DZ","MAZ_543_SCUD_TK_EP1","GAZ_Vodnik_MedEvac","hilux1_civil_1_open","hilux1_civil_2_covered","hilux1_civil_3_open_EP1","HMMWV_Ambulance","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_M1035_DES_EP1","HMMWV_DZ","Kamaz","KamazOpen_DZE","KamazRefuel_DZ","LandRover_CZ_EP1","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","MTVR","MtvrRefuel_DES_EP1_DZ","Offroad_DSHKM_Gue_DZE","Pickup_PK_GUE_DZE","Pickup_PK_TK_GUE_EP1_DZE","S1203_ambulance_EP1","SUV_Camo","SUV_Charcoal","UAZ_MG_TK_EP1_DZE","UralCivil2_DZE","UralCivil_DZE","UralRefuel_TK_EP1_DZ","Ural_CDF","V3S_Civ","V3S_Open_TK_CIV_EP1","V3S_RA_TK_GUE_EP1_DZE","VolhaLimo_TK_CIV_EP1","Volha_1_TK_CIV_EP1","Volha_2_TK_CIV_EP1","VWGolf"];

//Name of the Mission
_missName = "Abandoned villa";//land_a_villa_ep1

//OKFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call OKFindPos;

[nil,nil,rTitleText,"After pandemy struck Napf months ago, local kingpin has left his villa. Sure it's worth to take a look. C'mon, I've marked the point.", "PLAIN",10] call RE;

//OKAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM OKAddMajMarker;

//Spawning scene
_villa = createVehicle ["land_a_villa_ep1",_coords,[], 0, "CAN_COLLIDE"];
_villa setDir (random 360);
//_villa setVectorUp [0,0,1];
//diag_log format ["[OK]: Abandoned mansion spawned."];

//Setting variation
_variant = round (random 3); // 0 - empty, 1 - preoccupied, 2 - ambush

diag_log format ["[OK]: Abandoned mansion variant:%1",_variant];

//We create random vehicle based on list
_scount = count OKRideList;
_sSelect = floor(random _sCount);
_item = OKRideList select _sSelect;
_vehicle = createVehicle [_item,[(_coords select 0) + 30, (_coords select 1) - 30,0],[], 0, "CAN_COLLIDE"];

//OKSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call OKSetupVehicle;
diag_log format ["[OK]: Abandoned mansion vehicle %1 spawned",_item];

//Create boxes
_crate = createVehicle ["USVehicleBox",[(_coords select 0) + 2, (_coords select 1) - 2,0],[], 0, "CAN_COLLIDE"];
_crate1 = createVehicle ["USVehicleBox",[(_coords select 0) - 2, (_coords select 1) + 2,0],[], 0, "CAN_COLLIDE"];
//diag_log format ["[OK]: Abandoned mansion boxes spawned"];

//OKBoxFill fills the box, OKProtectObj prevents it from disappearing
_loot = OKLoot select floor random count OKLoot;
[_crate,_loot] ExecVM OKBoxSetup;
[_crate] call OKProtectObj;
_loot = OKLoot select floor random count OKLoot;
[_crate1,_loot] ExecVM OKBoxSetup;
[_crate1] call OKProtectObj;
//diag_log format ["[OK]: Abandoned mansion boxes filled"];

//Applying variations

switch (_variant) do
    {
        case 0:
            { _poc = 0; _amb = 0; _sw = 0;};
        case 1:
            { _poc = 1; _amb = 0; _sw = 0;};
        case 2:
            { _poc = 0; _amb = 1; _sw = 0;};
        case 3:
            { _poc = 1; _amb = 1; _sw = 0;};
        case 4:
            { _poc = 1; _amb = 1; _sw = 1;};
    };

//Occupants
//OKAISpawn2 spawns AI to the mission
//Usage: [_coords, count, skillLevel, skin]
if (_poc == 1) then
    {
        _unit1 = [_coords,(round(random 12))+1,(round(random 2))+1,(round(random 2))+1] ExecVM OKAISpawn2;
    };


//Wait until the player is within 10 meters
waitUntil {sleep 3; {isPlayer _x && _x distance _coords <= 15 } count playableunits > 0 };

//Visitors have arrived
//[nil,nil,rTitleText,"Here we are!", "PLAIN",6] call RE;
diag_log format["[OK]: Abandoned mansion visited."];

if (_amb == 1) then
    {
        _unit2 = [_coords,(round(random 12))+1,(round(random 2))+1,(round(random 2))+1] ExecVM OKAISpawn2;
        sleep 15;
        _unit3 = [_coords,(round(random 12))+1,(round(random 2))+1,(round(random 2))+1] ExecVM OKAISpawn2;
        sleep 15;
        _unit4 = [_coords,(round(random 12))+1,(round(random 2))+1,(round(random 2))+1] ExecVM OKAISpawn2;
        sleep 15;
        _unit5 = [_coords,(round(random 12))+1,(round(random 2))+1,(round(random 2))+1] ExecVM OKAISpawn2;
        sleep 15;
    };

//Call OKSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] ExecVM OKSaveVeh;

//Wait until all the players left area
waitUntil {sleep 3; _nu = {isPlayer _x && _x distance _coords > 30} count playableunits; _pu = count playableunits; _nu == _pu};
      
//Let everyone know the mission is over
[nil,nil,rTitleText,"Abandoned villa was visited.", "PLAIN",6] call RE;
diag_log format["[OK]: Abandoned mansion mission have ended."];
deleteMarker "OKMajMarker";
deleteMarker "OKMajDot";

//Let the timer know the mission is over
OKMajDone = true;
OKMissionIdActive = OKMissionIdActive + 1;

