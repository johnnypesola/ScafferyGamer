//
// Military base for universal mission
// Made by Calling and Pastorn 2014
//

Private ["_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats"];

if (isServer) then {

// Bas 1
_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [18281.596, 17406.4, 5.7220459e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir 91.332802;
  _this setPos [18281.596, 17406.4, 5.7220459e-005];
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Donjon", [18268.605, 17389.795, -1.5258789e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 0.88227212;
  _this setPos [18268.605, 17389.795, -1.5258789e-005];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Gate", [18250.848, 17389.936, -9.9182129e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir 0.49902052;
  _this setPos [18250.848, 17389.936, -9.9182129e-005];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Wall1_20", [18273.9, 17425.564, -0.11345911], [], 0, "CAN_COLLIDE"];
  _vehicle_4 = _this;
  _this setDir 93.84124;
  _this setPos [18273.9, 17425.564, -0.11345911];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [18283.201, 17444.867, 1.1615568], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setDir 92.017128;
  _this setPos [18283.201, 17444.867, 1.1615568];
};

_vehicle_9 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Donjon", [18236.066, 17390.602, -0.0053975098], [], 0, "CAN_COLLIDE"];
  _vehicle_9 = _this;
  _this setDir 0.88227212;
  _this setPos [18236.066, 17390.602, -0.0053975098];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [18223.617, 17407.545, 2.2888184e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setDir -91.473289;
  _this setPos [18223.617, 17407.545, 2.2888184e-005];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Wall1_20", [18231.939, 17427.959, 1.3103738], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir 270.84064;
  _this setPos [18231.939, 17427.959, 1.3103738];
};

_vehicle_17 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [18223.641, 17446.381, 1.9472563], [], 0, "CAN_COLLIDE"];
  _vehicle_17 = _this;
  _this setDir -91.473289;
  _this setPos [18223.641, 17446.381, 1.9472563];
};

_vehicle_19 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bergfrit", [18237.719, 17461.482, -10.154936], [], 0, "CAN_COLLIDE"];
  _vehicle_19 = _this;
  _this setDir -88.59745;
  _this setPos [18237.719, 17461.482, -10.154936];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bergfrit", [18268.77, 17460.697, -10.11814], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setDir -87.966576;
  _this setPos [18268.77, 17460.697, -10.11814];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Gate", [18253.922, 17461.445, 0.36984283], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setDir -178.59433;
  _this setPos [18253.922, 17461.445, 0.36984283];
};

_vehicle_26 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier5x", [18252.342, 17430.551, 0.30738127], [], 0, "CAN_COLLIDE"];
  _vehicle_26 = _this;
  _this setDir 1.5286117;
  _this setPos [18252.342, 17430.551, 0.30738127];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier5x", [18246.363, 17425.225, -4.5776367e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir 92.91684;
  _this setPos [18246.363, 17425.225, -4.5776367e-005];
};

_vehicle_29 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier5x", [18252.268, 17419.775, -1.1444092e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_29 = _this;
  _this setDir -0.86123049;
  _this setPos [18252.268, 17419.775, -1.1444092e-005];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier5x", [18258.002, 17425.047, 0.00011444092], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir -87.899033;
  _this setPos [18258.002, 17425.047, 0.00011444092];
};

_thebox = createVehicle ["BAF_VehicleBox",[18253.564, 17426.363, 2.6702881e-005], [], 0, "CAN_COLLIDE"];
_thebox setPos [18253.564, 17426.363, 2.6702881e-005];
clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;
_thebox setVariable ["ObjectID","1",true];
_thebox setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_thebox];

clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;

_hidden_box_number_of_gold = 1;
_hidden_box_random_items = [
"ItemBriefcase100oz"
];

_hidden_box_number_of_buildmats = 0;
_hidden_box_random_buildmats = [
];

_hidden_box_number_of_guns = 1;
_hidden_box_random_guns = [
"DMR"
];

_hidden_box_number_of_tools = 0;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "Chainsaw" or "ItemToolbox")
_hidden_box_random_tools =[
];


_numberofguns = 1;// (round (random 2)) + _hidden_box_number_of_guns;
_numberoftools = 0;// (round (random 2)) + _hidden_box_number_of_tools;
_numberofitems = 1;//(round (random 5)) + _hidden_box_number_of_gold;
_numberofbuildmats = 0;//(round (random 5)) + _hidden_box_number_of_buildmats;
for "_i" from 1 to _numberofguns do {
	_theweap = _hidden_box_random_guns call BIS_fnc_selectRandom;
	_themags = getArray (configFile >> "cfgWeapons" >> _theweap >> "magazines");
	_thebox addWeaponCargoGlobal [_theweap,1];
	_thebox addMagazineCargoGlobal [(_themags select 0),round(random 2) + 1];
};
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


// Unhabited castle 1

_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [6702.7373, 2449.2854], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir 157.25282;
  _this setPos [6702.7373, 2449.2854];
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bastion", [6689.2793, 2479.9133, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir -22.330994;
  _this setPos [6689.2793, 2479.9133, -3.0517578e-005];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Gate", [6708.5352, 2470.6226, 0.37853244], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir 65.227509;
  _this setPos [6708.5352, 2470.6226, 0.37853244];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Bergfrit", [6692.2397, 2455.5188, 0.7181859], [], 0, "CAN_COLLIDE"];
  _vehicle_4 = _this;
  _this setDir 157.58086;
  _this setPos [6692.2397, 2455.5188, 0.7181859];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Wall1_End", [6674.9297, 2465.8232, -0.17649165], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir -19.536306;
  _this setPos [6674.9297, 2465.8232, -0.17649165];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Wall2_30", [6674.3877, 2452.3315, -0.83549219], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setDir 249.98853;
  _this setPos [6674.3877, 2452.3315, -0.83549219];
};

_vehicle_7 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Gate", [6685.1475, 2439.9739, 1.0712094], [], 0, "CAN_COLLIDE"];
  _vehicle_7 = _this;
  _this setDir -19.247715;
  _this setPos [6685.1475, 2439.9739, 1.0712094];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_A_Castle_Stairs_A", [6700.4429, 2451.7878, -0.15281472], [], 0, "CAN_COLLIDE"];
  _vehicle_8 = _this;
  _this setDir -111.82343;
  _this setPos [6700.4429, 2451.7878, -0.15281472];
};

};
