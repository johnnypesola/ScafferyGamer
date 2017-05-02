//
// Military base for universal mission
// Made by Pastorn 2014
//

Private ["_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats"];

if (isServer) then {

_vehicle_494 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10564.27, 2945.9492, -0.016701549], [], 0, "CAN_COLLIDE"];
  _vehicle_494 = _this;
  _this setDir -8.9522495;
  _this setPos [10564.27, 2945.9492, -0.016701549];
};

_vehicle_495 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10548.805, 2943.447, -0.13069576], [], 0, "CAN_COLLIDE"];
  _vehicle_495 = _this;
  _this setDir -8.9914932;
  _this setPos [10548.805, 2943.447, -0.13069576];
};

_vehicle_496 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10535.433, 2939.6067, 0.026246622], [], 0, "CAN_COLLIDE"];
  _vehicle_496 = _this;
  _this setDir -25.169197;
  _this setPos [10535.433, 2939.6067, 0.026246622];
};

_vehicle_497 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10520.702, 2934.9438, -0.052317373], [], 0, "CAN_COLLIDE"];
  _vehicle_497 = _this;
  _this setDir -10.622063;
  _this setPos [10520.702, 2934.9438, -0.052317373];
};

_vehicle_498 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10505.095, 2932.4934, 0.10039529], [], 0, "CAN_COLLIDE"];
  _vehicle_498 = _this;
  _this setDir -6.6764784;
  _this setPos [10505.095, 2932.4934, 0.10039529];
};

_vehicle_499 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10489.537, 2931.0552, -0.045893777], [], 0, "CAN_COLLIDE"];
  _vehicle_499 = _this;
  _this setDir -3.8018942;
  _this setPos [10489.537, 2931.0552, -0.045893777];
};

_vehicle_500 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10570.541, 2954.5032, -0.22861524], [], 0, "CAN_COLLIDE"];
  _vehicle_500 = _this;
  _this setDir -99.236542;
  _this setPos [10570.541, 2954.5032, -0.22861524];
};

_vehicle_501 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10547.044, 2964.3962, -0.012885272], [], 0, "CAN_COLLIDE"];
  _vehicle_501 = _this;
  _this setDir 23.023811;
  _this setPos [10547.044, 2964.3962, -0.012885272];
};

_vehicle_502 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10537.242, 2974.1577, 0.12672378], [], 0, "CAN_COLLIDE"];
  _vehicle_502 = _this;
  _this setDir -121.63286;
  _this setPos [10537.242, 2974.1577, 0.12672378];
};

_vehicle_503 = objNull;
if (true) then
{
  _this = createVehicle ["MetalPanel_DZ", [10566.61, 2962.8665, 1.8756404], [], 0, "CAN_COLLIDE"];
  _vehicle_503 = _this;
  _this setDir -2.9805884;
  _this setPos [10566.61, 2962.8665, 1.8756404];
};

_vehicle_504 = objNull;
if (true) then
{
  _this = createVehicle ["MetalPanel_DZ", [10563.639, 2962.7258, 2.1024592], [], 0, "CAN_COLLIDE"];
  _vehicle_504 = _this;
  _this setDir -2.4303284;
  _this setPos [10563.639, 2962.7258, 2.1024592];
};

_vehicle_505 = objNull;
if (true) then
{
  _this = createVehicle ["MetalPanel_DZ", [10568.493, 2961.5857, 1.9909285], [], 0, "NONE"];
  _vehicle_505 = _this;
  _this setDir -108.72323;
  _this setPos [10568.493, 2961.5857, 1.9909285];
};

_vehicle_506 = objNull;
if (true) then
{
  _this = createVehicle ["MetalPanel_DZ", [10569.225, 2958.7815, 2.3313837], [], 0, "CAN_COLLIDE"];
  _vehicle_506 = _this;
  _this setDir -104.69389;
  _this setPos [10569.225, 2958.7815, 2.3313837];
};

_vehicle_507 = objNull;
if (true) then
{
  _this = createVehicle ["DeerStand_DZ", [10565.223, 2957.8425, 1.0639697], [], 0, "CAN_COLLIDE"];
  _vehicle_507 = _this;
  _this setDir -140.8853;
  _this setPos [10565.223, 2957.8425, 1.0639697];
};

_vehicle_508 = objNull;
if (true) then
{
  _this = createVehicle ["MetalPanel_DZ", [10569.7, 2955.8977, 2.6246343], [], 0, "CAN_COLLIDE"];
  _vehicle_508 = _this;
  _this setDir -91.901268;
  _this setPos [10569.7, 2955.8977, 2.6246343];
};

_vehicle_509 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E_EP1", [10559.021, 2961.6052, -0.20755345], [], 0, "CAN_COLLIDE"];
  _vehicle_509 = _this;
  _this setDir -93.074883;
  _this setPos [10559.021, 2961.6052, -0.20755345];
};

_vehicle_510 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E", [10569.232, 2951.0518, -0.12579194], [], 0, "CAN_COLLIDE"];
  _vehicle_510 = _this;
  _this setDir -10.793694;
  _this setPos [10569.232, 2951.0518, -0.12579194];
};

_vehicle_511 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10561.688, 2961.8323, -0.29771566], [], 0, "CAN_COLLIDE"];
  _vehicle_511 = _this;
  _this setDir -3.2776027;
  _this setPos [10561.688, 2961.8323, -0.29771566];
};

_vehicle_512 = objNull;
if (true) then
{
  _this = createVehicle ["RU_WarfareBFieldhHospital", [10471.93, 2977.0425, -0.157553], [], 0, "CAN_COLLIDE"];
  _vehicle_512 = _this;
  _this setDir -7.1510406;
  _this setPos [10471.93, 2977.0425, -0.157553];
};

_vehicle_513 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10511.409, 2966.4846, 0.0014696056], [], 0, "CAN_COLLIDE"];
  _vehicle_513 = _this;
  _this setDir -364.94247;
  _this setPos [10511.409, 2966.4846, 0.0014696056];
};

_vehicle_514 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10512.513, 2957.6936, -0.010839281], [], 0, "CAN_COLLIDE"];
  _vehicle_514 = _this;
  _this setDir -366.1131;
  _this setPos [10512.513, 2957.6936, -0.010839281];
};

_vehicle_515 = objNull;
if (true) then
{
  _this = createVehicle ["BAF_VehicleBox", [10562.068, 2953.7969, -0.081606433], [], 0, "CAN_COLLIDE"];
  _vehicle_515 = _this;
  _this setDir -4.5537548;
  _this setPos [10562.068, 2953.7969, -0.081606433];
};

_vehicle_516 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fort_rampart", [10555.873, 2951.4453, 0.39996946], [], 0, "CAN_COLLIDE"];
  _vehicle_516 = _this;
  _this setDir 84.183487;
  _this setPos [10555.873, 2951.4453, 0.39996946];
};

_vehicle_517 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10473.949, 2930.168, 0.14614442], [], 0, "CAN_COLLIDE"];
  _vehicle_517 = _this;
  _this setDir -4.0485053;
  _this setPos [10473.949, 2930.168, 0.14614442];
};

_vehicle_518 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10465.052, 2937.175, 0.097641669], [], 0, "CAN_COLLIDE"];
  _vehicle_518 = _this;
  _this setDir 81.793404;
  _this setPos [10465.052, 2937.175, 0.097641669];
};

_vehicle_519 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10470.882, 2949.1379, 0.048680991], [], 0, "CAN_COLLIDE"];
  _vehicle_519 = _this;
  _this setDir -97.3946;
  _this setPos [10470.882, 2949.1379, 0.048680991];
};

_vehicle_520 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10462.73, 2958.6707, -0.022692043], [], 0, "CAN_COLLIDE"];
  _vehicle_520 = _this;
  _this setDir -99.418228;
  _this setPos [10462.73, 2958.6707, -0.022692043];
};

_vehicle_521 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10461.445, 2973.7439, 0.023729887], [], 0, "CAN_COLLIDE"];
  _vehicle_521 = _this;
  _this setDir -89.055901;
  _this setPos [10461.445, 2973.7439, 0.023729887];
};

_vehicle_522 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10467.635, 2984.9092, 0.12742141], [], 0, "CAN_COLLIDE"];
  _vehicle_522 = _this;
  _this setDir -26.301834;
  _this setPos [10467.635, 2984.9092, 0.12742141];
};

_vehicle_523 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10478.451, 2995.3979, 0.2687065], [], 0, "CAN_COLLIDE"];
  _vehicle_523 = _this;
  _this setDir -63.927376;
  _this setPos [10478.451, 2995.3979, 0.2687065];
};

_vehicle_524 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10488.88, 3004.7783, 0.1241385], [], 0, "CAN_COLLIDE"];
  _vehicle_524 = _this;
  _this setDir -20.402332;
  _this setPos [10488.88, 3004.7783, 0.1241385];
};

_vehicle_525 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10516.116, 3009.3325, -0.041811526], [], 0, "CAN_COLLIDE"];
  _vehicle_525 = _this;
  _this setDir 6.4968715;
  _this setPos [10516.116, 3009.3325, -0.041811526];
};

_vehicle_526 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10526.403, 3001.7485, 0.17134055], [], 0, "CAN_COLLIDE"];
  _vehicle_526 = _this;
  _this setDir -105.58346;
  _this setPos [10526.403, 3001.7485, 0.17134055];
};

_vehicle_527 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10530.962, 2986.7437, 0.16763292], [], 0, "CAN_COLLIDE"];
  _vehicle_527 = _this;
  _this setDir -108.74254;
  _this setPos [10530.962, 2986.7437, 0.16763292];
};

_vehicle_528 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10478.82, 2942.2705, -0.011826773], [], 0, "CAN_COLLIDE"];
  _vehicle_528 = _this;
  _this setDir 0.010999456;
  _this setPos [10478.82, 2942.2705, -0.011826773];
};

_vehicle_529 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10493.809, 2942.9902, 0.076290511], [], 0, "CAN_COLLIDE"];
  _vehicle_529 = _this;
  _this setDir -6.1999903;
  _this setPos [10493.809, 2942.9902, 0.076290511];
};

_vehicle_530 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10520.322, 2941.7234, 0.094470724], [], 0, "CAN_COLLIDE"];
  _vehicle_530 = _this;
  _this setDir -77.431419;
  _this setPos [10520.322, 2941.7234, 0.094470724];
};

_vehicle_531 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10469.153, 2957.2021, -0.07129401], [], 0, "CAN_COLLIDE"];
  _vehicle_531 = _this;
  _this setDir -10.565346;
  _this setPos [10469.153, 2957.2021, -0.07129401];
};

_vehicle_532 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10528.313, 2950.478, 0.06911543], [], 0, "CAN_COLLIDE"];
  _vehicle_532 = _this;
  _this setDir -11.140292;
  _this setPos [10528.313, 2950.478, 0.06911543];
};

_vehicle_533 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10535.16, 2955.8723, 0.069691628], [], 0, "CAN_COLLIDE"];
  _vehicle_533 = _this;
  _this setDir -117.78663;
  _this setPos [10535.16, 2955.8723, 0.069691628];
};

_vehicle_534 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10528.485, 2968.5725, -0.1028493], [], 0, "CAN_COLLIDE"];
  _vehicle_534 = _this;
  _this setDir -116.00134;
  _this setPos [10528.485, 2968.5725, -0.1028493];
};

_vehicle_535 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10516.382, 2973.7798, 0.19280885], [], 0, "CAN_COLLIDE"];
  _vehicle_535 = _this;
  _this setDir -5.8689981;
  _this setPos [10516.382, 2973.7798, 0.19280885];
};

_vehicle_536 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10497.155, 2963.9075, -0.072392397], [], 0, "CAN_COLLIDE"];
  _vehicle_536 = _this;
  _this setDir -94.924797;
  _this setPos [10497.155, 2963.9075, -0.072392397];
};

_vehicle_537 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10489.621, 2960.4324, -0.050826915], [], 0, "CAN_COLLIDE"];
  _vehicle_537 = _this;
  _this setDir -7.6049018;
  _this setPos [10489.621, 2960.4324, -0.050826915];
};

_vehicle_538 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10501.062, 2971.9541, 0.088877499], [], 0, "CAN_COLLIDE"];
  _vehicle_538 = _this;
  _this setDir -6.7792921;
  _this setPos [10501.062, 2971.9541, 0.088877499];
};

_vehicle_539 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10485.663, 2970.2368, 0.0024493914], [], 0, "CAN_COLLIDE"];
  _vehicle_539 = _this;
  _this setDir -6.1812086;
  _this setPos [10485.663, 2970.2368, 0.0024493914];
};

_vehicle_540 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [10499.969, 2964.8577, 0.4272919], [], 0, "CAN_COLLIDE"];
  _vehicle_540 = _this;
  _this setDir -5.3175368;
  _this setPos [10499.969, 2964.8577, 0.4272919];
};

_vehicle_542 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10524.682, 2995.5361, 0.77145308], [], 0, "CAN_COLLIDE"];
  _vehicle_542 = _this;
  _this setDir 48.359219;
  _this setPos [10524.682, 2995.5361, 0.77145308];
};

_vehicle_543 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10474.698, 2988.4829, 1.3521585], [], 0, "CAN_COLLIDE"];
  _vehicle_543 = _this;
  _this setDir -42.410336;
  _this setPos [10474.698, 2988.4829, 1.3521585];
};

_vehicle_544 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10500.863, 3008.2761, 0.84445417], [], 0, "CAN_COLLIDE"];
  _vehicle_544 = _this;
  _this setDir -10.314906;
  _this setPos [10500.863, 3008.2761, 0.84445417];
};

_vehicle_545 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10462.725, 2961.3181, 0.87085479], [], 0, "CAN_COLLIDE"];
  _vehicle_545 = _this;
  _this setDir -96.291618;
  _this setPos [10462.725, 2961.3181, 0.87085479];
};

_vehicle_546 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10467.326, 2931.8342, 0.86880046], [], 0, "CAN_COLLIDE"];
  _vehicle_546 = _this;
  _this setDir -95.847458;
  _this setPos [10467.326, 2931.8342, 0.86880046];
};

_vehicle_547 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10494.047, 2933.2129, 0.9916063], [], 0, "CAN_COLLIDE"];
  _vehicle_547 = _this;
  _this setDir -188.51582;
  _this setPos [10494.047, 2933.2129, 0.9916063];
};

_vehicle_548 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10528.444, 2937.6519, -0.89319485], [], 0, "CAN_COLLIDE"];
  _vehicle_548 = _this;
  _this setDir -186.62677;
  _this setPos [10528.444, 2937.6519, -0.89319485];
};

_vehicle_549 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_vez", [10543.259, 2965.9119, 0.25960505], [], 0, "CAN_COLLIDE"];
  _vehicle_549 = _this;
  _this setDir 28.071865;
  _this setPos [10543.259, 2965.9119, 0.25960505];
};

_vehicle_550 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10487.976, 2986.7883, 0.037771169], [], 0, "CAN_COLLIDE"];
  _vehicle_550 = _this;
  _this setDir 84.096138;
  _this setPos [10487.976, 2986.7883, 0.037771169];
};

_vehicle_551 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10501.122, 2987.7217, -0.0022282861], [], 0, "CAN_COLLIDE"];
  _vehicle_551 = _this;
  _this setDir 83.644279;
  _this setPos [10501.122, 2987.7217, -0.0022282861];
};

_vehicle_552 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10514.121, 2989.6245, -0.013372763], [], 0, "CAN_COLLIDE"];
  _vehicle_552 = _this;
  _this setDir 83.599236;
  _this setPos [10514.121, 2989.6245, -0.013372763];
};

_vehicle_553 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10503.854, 3008.9714, 0.00067498907], [], 0, "CAN_COLLIDE"];
  _vehicle_553 = _this;
  _this setDir -8.2444553;
  _this setPos [10503.854, 3008.9714, 0.00067498907];
};

_vehicle_556 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Barricade_EP1", [10294.869, 2677.5151], [], 0, "CAN_COLLIDE"];
  _vehicle_556 = _this;
  _this setDir 38.377789;
  _this setPos [10294.869, 2677.5151];
};

_vehicle_557 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Barricade_EP1", [10027.299, 2957.4775, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_557 = _this;
  _this setDir -39.20092;
  _this setPos [10027.299, 2957.4775, -6.1035156e-005];
};

_vehicle_561 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_1L_Noentry", [10026.397, 2962.1013, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_561 = _this;
  _this setDir 132.55128;
  _this setPos [10026.397, 2962.1013, -3.0517578e-005];
};

_vehicle_565 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_1L_Noentry", [10287.866, 2677.4504], [], 0, "CAN_COLLIDE"];
  _vehicle_565 = _this;
  _this setDir 16.188038;
  _this setPos [10287.866, 2677.4504];
};

_vehicle_570 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7247.5869, 3168.3931, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_570 = _this;
  _this setDir -21.150343;
  _this setPos [7247.5869, 3168.3931, -6.1035156e-005];
};

_vehicle_571 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7257.1133, 3177.6389, 0.00024414063], [], 0, "CAN_COLLIDE"];
  _vehicle_571 = _this;
  _this setDir -69.828278;
  _this setPos [7257.1133, 3177.6389, 0.00024414063];
};

_vehicle_572 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7233.3267, 3167.6147, -9.1552734e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_572 = _this;
  _this setDir 13.643285;
  _this setPos [7233.3267, 3167.6147, -9.1552734e-005];
};

_vehicle_573 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7223.5815, 3176.5188, -0.00028991699], [], 0, "CAN_COLLIDE"];
  _vehicle_573 = _this;
  _this setDir 68.902657;
  _this setPos [7223.5815, 3176.5188, -0.00028991699];
};

_vehicle_574 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7220.2622, 3191.2102, -0.12356409], [], 0, "CAN_COLLIDE"];
  _vehicle_574 = _this;
  _this setDir -90.446457;
  _this setPos [7220.2622, 3191.2102, -0.12356409];
};

_vehicle_575 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7258.0747, 3192.3999, -0.062501416], [], 0, "CAN_COLLIDE"];
  _vehicle_575 = _this;
  _this setDir -101.76743;
  _this setPos [7258.0747, 3192.3999, -0.062501416];
};

_vehicle_576 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7252.6587, 3206.9006, 1.5258789e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_576 = _this;
  _this setDir 61.445179;
  _this setPos [7252.6587, 3206.9006, 1.5258789e-005];
};

_vehicle_577 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7241.6948, 3212.9607, -9.1552734e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_577 = _this;
  _this setDir -3.2877603;
  _this setPos [7241.6948, 3212.9607, -9.1552734e-005];
};

_vehicle_578 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [7224.2998, 3204.2495, -0.35948306], [], 0, "CAN_COLLIDE"];
  _vehicle_578 = _this;
  _this setDir -52.6161;
  _this setPos [7224.2998, 3204.2495, -0.35948306];
};

_vehicle_579 = objNull;
if (true) then
{
  _this = createVehicle ["HMMWV_M1151_M2_CZ_DES_EP1_DZ", [7240.4561, 3190.2446, 0.35948306], [], 0, "CAN_COLLIDE"];
  _vehicle_579 = _this;
  _this setDir 0.1;
  _this setPos [7240.4561, 3190.2446, 0.35948306];
  _this setVariable ["MalSar", "1", true];
};

_thebox = createVehicle ["BAF_VehicleBox",[7240.4561, 3186.2446, -0.00015258789], [], 0, "CAN_COLLIDE"];
_thebox setPos [7240.4561, 3186.2446, -0.00015258789];
clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;
_thebox setVariable ["ObjectID","1",true];
_thebox setVariable ["permaLoot",true];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;

_hidden_box_number_of_gold = 10;
_hidden_box_random_items = [
"1Rnd_HE_M203",
"15Rnd_9x19_M9SD",
"30Rnd_556x45_StanagSD",
"30Rnd_9x19_MP5SD",
"30Rnd_9x19_UZI_SD",
"5Rnd_86x70_L115A1"
];

_hidden_box_number_of_buildmats = 0;
_hidden_box_random_buildmats = [
];

_hidden_box_number_of_guns = 0;
_hidden_box_random_guns = [
];

_hidden_box_number_of_tools = 1;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "Chainsaw" or "ItemToolbox")
_hidden_box_random_tools =[
"chainsaw"
];


_numberofguns = 0;//(round (random 2)) + _hidden_box_number_of_guns;
_numberoftools = 1;//(round (random 1)) + _hidden_box_number_of_tools;
_numberofitems = (round (random 5)) + _hidden_box_number_of_gold;
_numberofbuildmats = 0;//(round (random 1)) + _hidden_box_number_of_buildmats;
for "_i" from 1 to _numberofguns do {
	_theweap = _hidden_box_random_guns call BIS_fnc_selectRandom;
	_themags = getArray (configFile >> "cfgWeapons" >> _theweap >> "magazines");
	_thebox addWeaponCargoGlobal [_theweap,1];
	_thebox addMagazineCargoGlobal [(_themags select 0),round(random 2) + 1];
};
for "_i" from 1 to _numberoftools do {
	_thetool = _hidden_box_random_tools call BIS_fnc_selectRandom;
	_thebox addWeaponCargoGlobal [_thetool,2];
};

for "_i" from 1 to _numberofitems do {
	_item = _hidden_box_random_items call BIS_fnc_selectRandom;
	_thebox addMagazineCargoGlobal [_item,1];
};
for "_i" from 1 to _numberofbuildmats do {
	_item = _hidden_box_random_buildmats call BIS_fnc_selectRandom;
	_thebox addMagazineCargoGlobal [_item,1];
};


_thebox = createVehicle ["BAF_VehicleBox",[10562.068, 2953.7969, -0.081606433], [], 0, "CAN_COLLIDE"];
_thebox setPos [10562.068, 2953.7969, -0.081606433];
clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;
_thebox setVariable ["ObjectID","1",true];
_thebox setVariable ["permaLoot",true];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;

_hidden_box_number_of_gold = floor (random 4) + 3;
_hidden_box_random_items = [
"ItemBriefcase100oz"
];

_hidden_box_number_of_buildmats = 10;
_hidden_box_random_buildmats = [
"half_cinder_wall_kit",
"half_cinder_wall_kit",
"half_cinder_wall_kit",
"half_cinder_wall_kit",
"cinder_garage_kit",
"cinder_garage_kit",
"cinder_garage_kit",
"cinder_garage_kit",
"metal_floor_kit",
"metal_floor_kit",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"CinderBlocks",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"MortarBucket",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"ItemTanktrap",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"PartGeneric",
"ItemComboLock",
"ItemComboLock",
"ItemComboLock",
"ItemComboLock"
];

_hidden_box_number_of_guns = 5;
_hidden_box_random_guns = [
"DMR",
"DMR",
"KSVK_DZE",
"KSVK_DZE",
"Pecheneg_DZ",
"Pecheneg_DZ",
"M4A1_AIM_SD_camo",
"M4A1_AIM_SD_camo",
"M4A1_AIM_SD_camo",
"M4A1_AIM_SD_camo",
"M4A1_AIM_SD_camo",
"BAF_LRR_scoped",
"BAF_LRR_scoped",
"BAF_LRR_scoped",
"BAF_LRR_scoped",
"M110_NVG_EP1",
"M110_NVG_EP1",
"M110_NVG_EP1",
"SCAR_H_LNG_Sniper_SD",
"SCAR_H_LNG_Sniper_SD",
"SCAR_H_LNG_Sniper_SD",
"FN_FAL_ANPVS4",
"FN_FAL_ANPVS4",
"BAF_L85A2_RIS_CWS",
"m107_DZ"
];

_hidden_box_number_of_tools = 1;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "Chainsaw" or "ItemToolbox")
_hidden_box_random_tools =[
];


_numberofguns = (round (random 2)) + _hidden_box_number_of_guns;
_numberoftools = 0;//(round (random 1)) + _hidden_box_number_of_tools;
_numberofitems = (round (random 2)) + _hidden_box_number_of_gold;
_numberofbuildmats = (round (random 5)) + _hidden_box_number_of_buildmats;
for "_i" from 1 to _numberofguns do {
	_theweap = _hidden_box_random_guns call BIS_fnc_selectRandom;
	_themags = getArray (configFile >> "cfgWeapons" >> _theweap >> "magazines");
	_thebox addWeaponCargoGlobal [_theweap,1];
	_thebox addMagazineCargoGlobal [(_themags select 0),round(random 2) + 1];
};
for "_i" from 1 to _numberoftools do {
	_thetool = _hidden_box_random_tools call BIS_fnc_selectRandom;
	_thebox addWeaponCargoGlobal [_thetool,2];
};

for "_i" from 1 to _numberofitems do {
	_item = _hidden_box_random_items call BIS_fnc_selectRandom;
	_thebox addMagazineCargoGlobal [_item,1];
};
for "_i" from 1 to _numberofbuildmats do {
	_item = _hidden_box_random_buildmats call BIS_fnc_selectRandom;
	_thebox addMagazineCargoGlobal [_item,1];
};

};
