private ["_position","_base","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

_position = [getMarkerPos "center",0,5500,10,0,2000,0] call BIS_fnc_findSafePos;
diag_log format["WAI: Mission Weapon Cache Started At %1",_position];
_box = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];


_base [ 
_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fort_Watchtower", [13274.923, 6823.833, 0.036410742], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir -13.232791;
  _this setPos [13274.923, 6823.833, 0.036410742];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fort_Watchtower", [13292.655, 6828.1675, 0.39891818], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir -375.06522;
  _this setPos [13292.655, 6828.1675, 0.39891818];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fortified_nest_big", [13275.899, 6857.6157, 0.3023735], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setDir -12.707125;
  _this setPos [13275.899, 6857.6157, 0.3023735];
};

_vehicle_10 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13268.623, 6832.0684, 0.011639185], [], 0, "CAN_COLLIDE"];
  _vehicle_10 = _this;
  _this setDir -115.37936;
  _this setPos [13268.623, 6832.0684, 0.011639185];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13293.944, 6838.2769, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir -87.13678;
  _this setPos [13293.944, 6838.2769, -6.1035156e-005];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13293.209, 6846.8452], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setDir -98.966896;
  _this setPos [13293.209, 6846.8452];
};

_vehicle_13 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13265.697, 6839.9067, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_13 = _this;
  _this setDir -100.4359;
  _this setPos [13265.697, 6839.9067, -3.0517578e-005];
};

_vehicle_15 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLargeWall_DZ", [13288.471, 6826.0396, 0.096744098], [], 0, "CAN_COLLIDE"];
  _vehicle_15 = _this;
  _this setDir -27.662388;
  _this setPos [13288.471, 6826.0396, 0.096744098];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLargeWall_DZ", [13279.15, 6823.5664, -0.027878799], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setDir -0.42447338;
  _this setPos [13279.15, 6823.5664, -0.027878799];
};

_vehicle_17 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLargeWall_DZ", [13283.943, 6824.2476, -0.056923617], [], 0, "CAN_COLLIDE"];
  _vehicle_17 = _this;
  _this setDir -14.893218;
  _this setPos [13283.943, 6824.2476, -0.056923617];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13294.223, 6831.1514, 1.6211265], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setDir 85.588074;
  _this setPos [13294.223, 6831.1514, 1.6211265];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13272.232, 6825.8633, 1.6051357], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setDir -123.41905;
  _this setPos [13272.232, 6825.8633, 1.6051357];
};

_vehicle_22 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13269.515, 6830.6226, 1.6330091], [], 0, "CAN_COLLIDE"];
  _vehicle_22 = _this;
  _this setDir 64.264801;
  _this setPos [13269.515, 6830.6226, 1.6330091];
};

_vehicle_23 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13267.326, 6835.6816, 1.8023616], [], 0, "CAN_COLLIDE"];
  _vehicle_23 = _this;
  _this setDir 69.499596;
  _this setPos [13267.326, 6835.6816, 1.8023616];
};

_vehicle_24 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13294.034, 6836.6294, 1.5376753], [], 0, "CAN_COLLIDE"];
  _vehicle_24 = _this;
  _this setDir 90.289597;
  _this setPos [13294.034, 6836.6294, 1.5376753];
};

_vehicle_25 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13293.962, 6842.0518, 1.5903839], [], 0, "CAN_COLLIDE"];
  _vehicle_25 = _this;
  _this setDir 87.943153;
  _this setPos [13293.962, 6842.0518, 1.5903839];
};

_vehicle_26 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13265.741, 6840.9434, 1.959263], [], 0, "CAN_COLLIDE"];
  _vehicle_26 = _this;
  _this setDir 76.59436;
  _this setPos [13265.741, 6840.9434, 1.959263];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13293.508, 6847.5063, 1.6422349], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir 82.445724;
  _this setPos [13293.508, 6847.5063, 1.6422349];
};

_vehicle_29 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13291.365, 6855.1538, -2.0503998e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_29 = _this;
  _this setDir 75.340851;
  _this setPos [13291.365, 6855.1538, -2.0503998e-005];
};

_vehicle_30 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13264.229, 6848.2241, -7.8201294e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_30 = _this;
  _this setDir 82.095139;
  _this setPos [13264.229, 6848.2241, -7.8201294e-005];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13288.486, 6863.3423, -0.046051577], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir 70.284134;
  _this setPos [13288.486, 6863.3423, -0.046051577];
};

_vehicle_32 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13263.228, 6856.6333, -1.1444092e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_32 = _this;
  _this setDir 88.924591;
  _this setPos [13263.228, 6856.6333, -1.1444092e-005];
};

_vehicle_33 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13263.327, 6865.2393, -2.1934509e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_33 = _this;
  _this setDir -82.938255;
  _this setPos [13263.327, 6865.2393, -2.1934509e-005];
};

_vehicle_34 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13284.664, 6870.5537, 5.1498413e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_34 = _this;
  _this setDir 57.550354;
  _this setPos [13284.664, 6870.5537, 5.1498413e-005];
};

_vehicle_35 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13272.162, 6877.874, 8.2969666e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_35 = _this;
  _this setDir -11.599254;
  _this setPos [13272.162, 6877.874, 8.2969666e-005];
};

_vehicle_36 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13265.802, 6873.0693, -6.6280365e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_36 = _this;
  _this setDir -59.263561;
  _this setPos [13265.802, 6873.0693, -6.6280365e-005];
};

_vehicle_37 = objNull;
if (true) then
{
  _this = createVehicle ["Land_HBarrier_large", [13279.578, 6876.396, -3.9100647e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_37 = _this;
  _this setDir 39.492119;
  _this setPos [13279.578, 6876.396, -3.9100647e-005];
};

_vehicle_39 = objNull;
if (true) then
{
  _this = createVehicle ["Concrete_Wall_EP1", [13288.687, 6832.6724, -8.4877014e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_39 = _this;
  _this setPos [13288.687, 6832.6724, -8.4877014e-005];
};

_vehicle_40 = objNull;
if (true) then
{
  _this = createVehicle ["Concrete_Wall_EP1", [13286.29, 6832.521, 0.028367065], [], 0, "CAN_COLLIDE"];
  _vehicle_40 = _this;
  _this setDir -7.8449616;
  _this setPos [13286.29, 6832.521, 0.028367065];
};

_vehicle_41 = objNull;
if (true) then
{
  _this = createVehicle ["Concrete_Wall_EP1", [13276.93, 6829.5996, 2.9087067e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_41 = _this;
  _this setDir -25.101988;
  _this setPos [13276.93, 6829.5996, 2.9087067e-005];
};

_vehicle_42 = objNull;
if (true) then
{
  _this = createVehicle ["Concrete_Wall_EP1", [13279.171, 6830.5088, -1.8596649e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_42 = _this;
  _this setDir -18.653072;
  _this setPos [13279.171, 6830.5088, -1.8596649e-005];
};

_vehicle_47 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fortified_nest_small", [13283.058, 6865.9741, -0.051393151], [], 0, "CAN_COLLIDE"];
  _vehicle_47 = _this;
  _this setDir -25.112892;
  _this setPos [13283.058, 6865.9741, -0.051393151];
};

_vehicle_48 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fortified_nest_small", [13265.676, 6861.7852, -6.1988831e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_48 = _this;
  _this setDir -0.93892062;
  _this setPos [13265.676, 6861.7852, -6.1988831e-006];
};

_vehicle_49 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fort_Watchtower_EP1", [13273.221, 6871.9438, 2.6226044e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_49 = _this;
  _this setDir -11.899776;
  _this setPos [13273.221, 6871.9438, 2.6226044e-005];
};

_vehicle_52 = objNull;
if (true) then
{
  _this = createVehicle ["ArmoredSUV_PMC_DZ", [13268.448, 6853.5542, -0.00022506714], [], 0, "CAN_COLLIDE"];
  _vehicle_52 = _this;
  _this setDir -191.39719;
  _this setPos [13268.448, 6853.5542, -0.00022506714];
};

_vehicle_53 = objNull;
if (true) then
{
  _this = createVehicle ["ArmoredSUV_PMC_DZ", [13284.915, 6857.2109, -7.390976e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_53 = _this;
  _this setDir -193.19594;
  _this setPos [13284.915, 6857.2109, -7.390976e-005];
};

_vehicle_56 = objNull;
if (true) then
{
  _this = createVehicle ["HMMWV_M1151_M2_CZ_DES_EP1_DZ", [13278.192, 6849.856, -0.00012922287], [], 0, "CAN_COLLIDE"];
  _vehicle_56 = _this;
  _this setDir -191.79446;
  _this setPos [13278.192, 6849.856, -0.00012922287];
};

_vehicle_57 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13292.545, 6852.895, 1.8039215], [], 0, "CAN_COLLIDE"];
  _vehicle_57 = _this;
  _this setDir 77.802193;
  _this setPos [13292.545, 6852.895, 1.8039215];
};

_vehicle_58 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13290.929, 6858.0801, 1.5982641], [], 0, "CAN_COLLIDE"];
  _vehicle_58 = _this;
  _this setDir 67.501312;
  _this setPos [13290.929, 6858.0801, 1.5982641];
};

_vehicle_59 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13288.672, 6863.0786, 1.3982598], [], 0, "CAN_COLLIDE"];
  _vehicle_59 = _this;
  _this setDir 63.80875;
  _this setPos [13288.672, 6863.0786, 1.3982598];
};

_vehicle_60 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13286.301, 6868.0591, 1.6948181], [], 0, "CAN_COLLIDE"];
  _vehicle_60 = _this;
  _this setDir 65.160507;
  _this setPos [13286.301, 6868.0591, 1.6948181];
};

_vehicle_61 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13283.612, 6872.7754, 1.8059227], [], 0, "CAN_COLLIDE"];
  _vehicle_61 = _this;
  _this setDir 55.795395;
  _this setPos [13283.612, 6872.7754, 1.8059227];
};

_vehicle_62 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13279.877, 6876.6636, 1.6671157], [], 0, "CAN_COLLIDE"];
  _vehicle_62 = _this;
  _this setDir 36.809097;
  _this setPos [13279.877, 6876.6636, 1.6671157];
};

_vehicle_63 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13274.959, 6878.0835, 1.4044997], [], 0, "CAN_COLLIDE"];
  _vehicle_63 = _this;
  _this setDir -4.5276399;
  _this setPos [13274.959, 6878.0835, 1.4044997];
};

_vehicle_64 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13269.785, 6876.6245, 1.4915886], [], 0, "CAN_COLLIDE"];
  _vehicle_64 = _this;
  _this setDir -29.239729;
  _this setPos [13269.785, 6876.6245, 1.4915886];
};

_vehicle_65 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13266.159, 6872.8516, 1.4968432], [], 0, "CAN_COLLIDE"];
  _vehicle_65 = _this;
  _this setDir -62.106644;
  _this setPos [13266.159, 6872.8516, 1.4968432];
};

_vehicle_66 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13264.153, 6867.8013, 1.6570799], [], 0, "CAN_COLLIDE"];
  _vehicle_66 = _this;
  _this setDir -74.799637;
  _this setPos [13264.153, 6867.8013, 1.6570799];
};

_vehicle_67 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13263.173, 6862.4541, 1.9444389], [], 0, "CAN_COLLIDE"];
  _vehicle_67 = _this;
  _this setDir -84.475601;
  _this setPos [13263.173, 6862.4541, 1.9444389];
};

_vehicle_68 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13263.07, 6856.9839, 1.6942445], [], 0, "CAN_COLLIDE"];
  _vehicle_68 = _this;
  _this setDir -93.677086;
  _this setPos [13263.07, 6856.9839, 1.6942445];
};

_vehicle_69 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13263.645, 6851.5195, 1.5991865], [], 0, "CAN_COLLIDE"];
  _vehicle_69 = _this;
  _this setDir -98.351852;
  _this setPos [13263.645, 6851.5195, 1.5991865];
};

_vehicle_70 = objNull;
if (true) then
{
  _this = createVehicle ["CinderWall_DZ", [13264.574, 6846.2017, 1.6819175], [], 0, "CAN_COLLIDE"];
  _vehicle_70 = _this;
  _this setDir 78.118134;
  _this setPos [13264.574, 6846.2017, 1.6819175];
};

_vehicle_71 = objNull;
if (true) then
{
  _this = createVehicle ["DeerStand_DZ", [13268.396, 6844.6006, 0.86012399], [], 0, "CAN_COLLIDE"];
  _vehicle_71 = _this;
  _this setDir -15.483667;
  _this setPos [13268.396, 6844.6006, 0.86012399];
};

_vehicle_72 = objNull;
if (true) then
{
  _this = createVehicle ["DeerStand_DZ", [13289.386, 6849.7959, 0.72774756], [], 0, "CAN_COLLIDE"];
  _vehicle_72 = _this;
  _this setDir -12.375456;
  _this setPos [13289.386, 6849.7959, 0.72774756];
};




[_box] call spawn_ammo_box;


_rndnum = round (random 3) + 4;
[[_position select 0, _position select 1, 0],                  //position
_rndnum,						  //Number Of units
1,					      //Skill level 0-1. Has no effect if using custom skills
"Random",			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",						  //Skin "" for random or classname here.
5,				  //Gearset number. "Random" for random gear set.
true
] call spawn_group;

[[_position select 0, _position select 1, 0],                  //position
4,						  //Number Of units
1,					      //Skill level 0-1. Has no effect if using custom skills
"Random",			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"Bandit2_DZ",						  //Skin "" for random or classname here.
5,				  //Gearset number. "Random" for random gear set.
true
] call spawn_group;

[[[(_position select 0), (_position select 1) + 10, 0],[(_position select 0) + 10, (_position select 1), 0]], //position(s) (can be multiple).
"M2StaticMG",             //Classname of turret
0.5,					  //Skill level 0-1. Has no effect if using custom skills
"Bandit2_DZ",				          //Skin "" for random or classname here.
0,						  //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,						  //Number of magazines. (not needed if ai_static_useweapon = False)
"",						  //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
5,				  //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
true
] call spawn_static;


[_position,"Weapon cache"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";
[nil,nil,rTitleText,"Bandits have obtained a weapon crate! Check your map for the location!", "PLAIN",10] call RE;

_missiontimeout = true;
_cleanmission = false;
_playerPresent = false;
_starttime = floor(time);
while {_missiontimeout} do {
	sleep 5;
	_currenttime = floor(time);
	{if((isPlayer _x) AND (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
	if (_currenttime - _starttime >= wai_mission_timeout) then {_cleanmission = true;};
	if ((_playerPresent) OR (_cleanmission)) then {_missiontimeout = false;};
};
if (_playerPresent) then {
	waitUntil
	{
		sleep 5;
		_playerPresent = false;
		{if((isPlayer _x) AND (_x distance _position <= 30)) then {_playerPresent = true};}forEach playableUnits;
		(_playerPresent)
	};
	diag_log format["WAI: Mission Wepaon cache Ended At %1",_position];
	[nil,nil,rTitleText,"Survivors have secured the Wepaon Cache!", "PLAIN",10] call RE;
} else {
	clean_running_mission = True;
	deleteVehicle _box;
	{_cleanunits = _x getVariable "missionclean";
	if (!isNil "_cleanunits") then {
		switch (_cleanunits) do {
			case "ground" : {ai_ground_units = (ai_ground_units -1);};
			case "air" : {ai_air_units = (ai_air_units -1);};
			case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
			case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
		};
		deleteVehicle _x;
		sleep 0.05;
	};	
	} forEach allUnits;
	
	diag_log format["WAI: Mission Wepaon cache timed out At %1",_position];
	[nil,nil,rTitleText,"Survivors did not secure the Wepaon Cache in time!", "PLAIN",10] call RE;
};

missionrunning = false;
