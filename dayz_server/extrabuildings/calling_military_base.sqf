//
// Military base for universal mission
// Made by Calling and Pastorn 2014
//

Private ["_themags","_theweap","_thetool","_item","_thebox","_hidden_box_number_of_gold","_hidden_box_number_of_guns","_hidden_box_number_of_tools","_hidden_box_number_of_buildmats","_numberofguns","_numberoftools","_numberofitems","_numberofbuildmats","_hidden_box_random_items","_hidden_box_random_guns","_hidden_box_random_tools","_hidden_box_random_buildmats"];

if (isServer) then {

// Bas 1

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16714.58, 19103.107, 7.6293945e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 0.85547203;
  _this setPos [16714.58, 19103.107, 7.6293945e-005];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16730.096, 19103.061, -1.7166138e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setPos [16730.096, 19103.061, -1.7166138e-005];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16745.566, 19102.953, -2.6702881e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_4 = _this;
  _this setPos [16745.566, 19102.953, -2.6702881e-005];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16698.938, 19103.143, -0.00010871887], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setPos [16698.938, 19103.143, -0.00010871887];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16761.225, 19103, -8.9645386e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setPos [16761.225, 19103, -8.9645386e-005];
};

_vehicle_7 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16683.328, 19103.08, 0.00010681152], [], 0, "CAN_COLLIDE"];
  _vehicle_7 = _this;
  _this setPos [16683.328, 19103.08, 0.00010681152];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16667.666, 19102.98, 8.5830688e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_8 = _this;
  _this setPos [16667.666, 19102.98, 8.5830688e-005];
};

_vehicle_9 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16776.904, 19102.918, 1.7166138e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_9 = _this;
  _this setPos [16776.904, 19102.918, 1.7166138e-005];
};

_vehicle_10 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16783.949, 19096.111, 1.335144e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_10 = _this;
  _this setDir -92.832413;
  _this setPos [16783.949, 19096.111, 1.335144e-005];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16783.754, 19080.475, 3.8146973e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir 87.214577;
  _this setPos [16783.754, 19080.475, 3.8146973e-005];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16784.846, 19064.785, 0.00026321411], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setDir 86.974388;
  _this setPos [16784.846, 19064.785, 0.00026321411];
};

_vehicle_13 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16785.531, 19049.205, 0.00018310547], [], 0, "CAN_COLLIDE"];
  _vehicle_13 = _this;
  _this setDir 88.171761;
  _this setPos [16785.531, 19049.205, 0.00018310547];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16787.395, 19033.66, -5.531311e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir -92.755196;
  _this setPos [16787.395, 19033.66, -5.531311e-005];
};

_vehicle_15 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16787.195, 19017.826, -1.7166138e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_15 = _this;
  _this setDir 86.49115;
  _this setPos [16787.195, 19017.826, -1.7166138e-005];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16789.578, 19002.455], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setDir -94.707024;
  _this setPos [16789.578, 19002.455];
};

_vehicle_17 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16789.809, 18986.738, 9.9182129e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_17 = _this;
  _this setDir 84.653465;
  _this setPos [16789.809, 18986.738, 9.9182129e-005];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16783.77, 18978.801, 1.9073486e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setDir -3.3988094;
  _this setPos [16783.77, 18978.801, 1.9073486e-005];
};

_vehicle_19 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16768.719, 18977.98, -9.5367432e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_19 = _this;
  _this setDir -3.4244368;
  _this setPos [16768.719, 18977.98, -9.5367432e-006];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16753.156, 18977.09, 0.00014686584], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setDir -3.4853144;
  _this setPos [16753.156, 18977.09, 0.00014686584];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16737.373, 18976.197, -1.9073486e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setDir -3.4167421;
  _this setPos [16737.373, 18976.197, -1.9073486e-006];
};

_vehicle_22 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16721.867, 18975.215, -7.6293945e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_22 = _this;
  _this setDir -3.9457691;
  _this setPos [16721.867, 18975.215, -7.6293945e-006];
};

_vehicle_23 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16706.287, 18974.146, 9.3460083e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_23 = _this;
  _this setDir -4.1593838;
  _this setPos [16706.287, 18974.146, 9.3460083e-005];
};

_vehicle_24 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16690.611, 18972.928], [], 0, "CAN_COLLIDE"];
  _vehicle_24 = _this;
  _this setDir -4.4740524;
  _this setPos [16690.611, 18972.928];
};

_vehicle_25 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16675.09, 18971.674, 9.3460083e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_25 = _this;
  _this setDir -5.5168929;
  _this setPos [16675.09, 18971.674, 9.3460083e-005];
};

_vehicle_26 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16666.313, 18978.072, 0.0023392101], [], 0, "CAN_COLLIDE"];
  _vehicle_26 = _this;
  _this setDir 82.719315;
  _this setPos [16666.313, 18978.072, 0.0023392101];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16664.441, 18993.396, -0.00022697449], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir 84.006317;
  _this setPos [16664.441, 18993.396, -0.00022697449];
};

_vehicle_30 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16662.961, 19008.945, 0.00049591064], [], 0, "CAN_COLLIDE"];
  _vehicle_30 = _this;
  _this setDir 85.312775;
  _this setPos [16662.961, 19008.945, 0.00049591064];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16661.883, 19024.289, -0.014130276], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir 86.153595;
  _this setPos [16661.883, 19024.289, -0.014130276];
};

_vehicle_34 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16660.732, 19039.576, -0.00014686584], [], 0, "CAN_COLLIDE"];
  _vehicle_34 = _this;
  _this setDir 85.312775;
  _this setPos [16660.732, 19039.576, -0.00014686584];
};

_vehicle_35 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16659.391, 19054.959, 0.036841232], [], 0, "CAN_COLLIDE"];
  _vehicle_35 = _this;
  _this setDir 86.153595;
  _this setPos [16659.391, 19054.959, 0.036841232];
};

_vehicle_38 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16658.117, 19070.58, -0.00017166138], [], 0, "CAN_COLLIDE"];
  _vehicle_38 = _this;
  _this setDir 85.312775;
  _this setPos [16658.117, 19070.58, -0.00017166138];
};

_vehicle_44 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [16680.479, 18979.273, 0.011806397], [], 0, "CAN_COLLIDE"];
  _vehicle_44 = _this;
  _this setDir -3.6342566;
  _this setPos [16680.479, 18979.273, 0.011806397];
};

_vehicle_52 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [16679.818, 18990.072, -0.038686752], [], 0, "CAN_COLLIDE"];
  _vehicle_52 = _this;
  _this setDir -3.6342566;
  _this setPos [16679.818, 18990.072, -0.038686752];
};

_vehicle_57 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [16679.305, 19002.203, -0.047868107], [], 0, "CAN_COLLIDE"];
  _vehicle_57 = _this;
  _this setDir -3.6822281;
  _this setPos [16679.305, 19002.203, -0.047868107];
};

_vehicle_59 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16657.314, 19081.496, 7.2479248e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_59 = _this;
  _this setDir 85.312775;
  _this setPos [16657.314, 19081.496, 7.2479248e-005];
};

_vehicle_62 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16652.125, 19102.357, 0.00016212463], [], 0, "CAN_COLLIDE"];
  _vehicle_62 = _this;
  _this setDir -4.486979;
  _this setPos [16652.125, 19102.357, 0.00016212463];
};

_vehicle_64 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16636.43, 19100.816, 0.00020027161], [], 0, "CAN_COLLIDE"];
  _vehicle_64 = _this;
  _this setDir -6.4669528;
  _this setPos [16636.43, 19100.816, 0.00020027161];
};

_vehicle_66 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16650.531, 19088.492, 5.1498413e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_66 = _this;
  _this setDir -7.8893862;
  _this setPos [16650.531, 19088.492, 5.1498413e-005];
};

_vehicle_68 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16638.508, 19086.873, 0.00016975403], [], 0, "CAN_COLLIDE"];
  _vehicle_68 = _this;
  _this setDir -5.4435587;
  _this setPos [16638.508, 19086.873, 0.00016975403];
};

_vehicle_72 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16673.332, 19079.805, -1.9073486e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_72 = _this;
  _this setDir 85.312775;
  _this setPos [16673.332, 19079.805, -1.9073486e-005];
};

_vehicle_73 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16671.99, 19095.188, 0.24463081], [], 0, "CAN_COLLIDE"];
  _vehicle_73 = _this;
  _this setDir 86.153595;
  _this setPos [16671.99, 19095.188, 0.24463081];
};

_vehicle_78 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16680.496, 19062.324, 0.00026702881], [], 0, "CAN_COLLIDE"];
  _vehicle_78 = _this;
  _this setDir -7.8893862;
  _this setPos [16680.496, 19062.324, 0.00026702881];
};

_vehicle_79 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16668.473, 19060.705, -0.31618118], [], 0, "CAN_COLLIDE"];
  _vehicle_79 = _this;
  _this setDir -5.4435587;
  _this setPos [16668.473, 19060.705, -0.31618118];
};

_vehicle_82 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16706.127, 19065.023, -0.00010108948], [], 0, "CAN_COLLIDE"];
  _vehicle_82 = _this;
  _this setDir -4.59373;
  _this setPos [16706.127, 19065.023, -0.00010108948];
};

_vehicle_83 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16695.762, 19064.109, -0.18894196], [], 0, "CAN_COLLIDE"];
  _vehicle_83 = _this;
  _this setDir -5.4435587;
  _this setPos [16695.762, 19064.109, -0.18894196];
};

_vehicle_90 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16698.77, 19073.498, 0.0045046727], [], 0, "CAN_COLLIDE"];
  _vehicle_90 = _this;
  _this setDir 85.312775;
  _this setPos [16698.77, 19073.498, 0.0045046727];
};

_vehicle_91 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16697.428, 19088.881, -0.32367209], [], 0, "CAN_COLLIDE"];
  _vehicle_91 = _this;
  _this setDir 86.153595;
  _this setPos [16697.428, 19088.881, -0.32367209];
};

_vehicle_97 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_fort_watchtower", [16662.939, 19065.584, 8.392334e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_97 = _this;
  _this setDir -5.8465366;
  _this setPos [16662.939, 19065.584, 8.392334e-005];
};

_vehicle_105 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_fort_watchtower", [16666.25, 19022.299, -0.23320158], [], 0, "CAN_COLLIDE"];
  _vehicle_105 = _this;
  _this setDir -4.3343425;
  _this setPos [16666.25, 19022.299, -0.23320158];
};

_vehicle_109 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_fort_watchtower", [16784.41, 18982.668, -3.8146973e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_109 = _this;
  _this setDir -93.679733;
  _this setPos [16784.41, 18982.668, -3.8146973e-005];
};

_vehicle_113 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [16624.502, 19086.906, 0.00024795532], [], 0, "CAN_COLLIDE"];
  _vehicle_113 = _this;
  _this setDir 4.7647281;
  _this setPos [16624.502, 19086.906, 0.00024795532];
};

_vehicle_114 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [16618.756, 19091.775, 0.00030517578], [], 0, "CAN_COLLIDE"];
  _vehicle_114 = _this;
  _this setDir 79.794266;
  _this setPos [16618.756, 19091.775, 0.00030517578];
};

_vehicle_115 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [16623.33, 19098.705, 0.00012779236], [], 0, "CAN_COLLIDE"];
  _vehicle_115 = _this;
  _this setDir -7.483532;
  _this setPos [16623.33, 19098.705, 0.00012779236];
};

_vehicle_116 = objNull;
if (true) then
{
  _this = createVehicle ["US_WarfareBAntiAirRadar_EP1", [16771.297, 19086.383, -0.50513673], [], 0, "CAN_COLLIDE"];
  _vehicle_116 = _this;
  _this setDir -209.68384;
  _this setPos [16771.297, 19086.383, -0.50513673];
};

_vehicle_118 = objNull;
if (true) then
{
  _this = createVehicle ["US_WarfareBFieldhHospital_EP1", [16719.309, 18986.516, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_118 = _this;
  _this setDir 85.471596;
  _this setPos [16719.309, 18986.516, -6.1035156e-005];
};

_vehicle_123 = objNull;
if (true) then
{
  _this = createVehicle ["ZavoraAnim", [16629.695, 19097.006, 9.3460083e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_123 = _this;
  _this setDir -93.989891;
  _this setPos [16629.695, 19097.006, 9.3460083e-005];
};

_vehicle_125 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [16638.422, 19089.758, 0.00029373169], [], 0, "CAN_COLLIDE"];
  _vehicle_125 = _this;
  _this setDir 73.418365;
  _this setPos [16638.422, 19089.758, 0.00029373169];
};

_vehicle_141 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [16637.211, 19098.764, -5.531311e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_141 = _this;
  _this setDir 73.418365;
  _this setPos [16637.211, 19098.764, -5.531311e-005];
};

_vehicle_160 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [16693.271, 18996.902, 9.9182129e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_160 = _this;
  _this setDir 110.96899;
  _this setPos [16693.271, 18996.902, 9.9182129e-005];
};

_vehicle_162 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [16693.744, 18985.939, -9.3460083e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_162 = _this;
  _this setDir 110.96899;
  _this setPos [16693.744, 18985.939, -9.3460083e-005];
};

_vehicle_164 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [16718.961, 18989.744, 0.0001335144], [], 0, "CAN_COLLIDE"];
  _vehicle_164 = _this;
  _this setDir 110.96899;
  _this setPos [16718.961, 18989.744, 0.0001335144];
};

_vehicle_166 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [16627.049, 19101.781, -1.9073486e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_166 = _this;
  _this setDir 110.96899;
  _this setPos [16627.049, 19101.781, -1.9073486e-006];
};

_vehicle_168 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [16629.229, 19084.605, 0.0002155304], [], 0, "CAN_COLLIDE"];
  _vehicle_168 = _this;
  _this setDir 110.96899;
  _this setPos [16629.229, 19084.605, 0.0002155304];
};

_vehicle_174 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16703.451, 18981.82, -4.7683716e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_174 = _this;
  _this setDir -93.737816;
  _this setPos [16703.451, 18981.82, -4.7683716e-005];
};

_vehicle_178 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16702.461, 18997.428, -0.008146286], [], 0, "CAN_COLLIDE"];
  _vehicle_178 = _this;
  _this setDir -93.737816;
  _this setPos [16702.461, 18997.428, -0.008146286];
};

_vehicle_184 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16701.445, 19012.688, 0.00042533875], [], 0, "CAN_COLLIDE"];
  _vehicle_184 = _this;
  _this setDir -93.737816;
  _this setPos [16701.445, 19012.688, 0.00042533875];
};

_vehicle_186 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16693.363, 19014.949, 0.00017547607], [], 0, "CAN_COLLIDE"];
  _vehicle_186 = _this;
  _this setDir -2.6216772;
  _this setPos [16693.363, 19014.949, 0.00017547607];
};

_vehicle_188 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16681.629, 19014.391, 0.00011253357], [], 0, "CAN_COLLIDE"];
  _vehicle_188 = _this;
  _this setDir -2.6865101;
  _this setPos [16681.629, 19014.391, 0.00011253357];
};

_vehicle_190 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16700.449, 19028.287, 0.00013923645], [], 0, "CAN_COLLIDE"];
  _vehicle_190 = _this;
  _this setDir -93.737816;
  _this setPos [16700.449, 19028.287, 0.00013923645];
};

_vehicle_192 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16699.615, 19043.707, -3.2424927e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_192 = _this;
  _this setDir -93.737816;
  _this setPos [16699.615, 19043.707, -3.2424927e-005];
};

_vehicle_194 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16706.926, 19051.605, 0.00015830994], [], 0, "CAN_COLLIDE"];
  _vehicle_194 = _this;
  _this setDir -185.48915;
  _this setPos [16706.926, 19051.605, 0.00015830994];
};

_vehicle_200 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16774.156, 18986.799, 5.531311e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_200 = _this;
  _this setDir 84.653465;
  _this setPos [16774.156, 18986.799, 5.531311e-005];
};

_vehicle_205 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16772.742, 19002.342, 5.1498413e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_205 = _this;
  _this setDir 84.653465;
  _this setPos [16772.742, 19002.342, 5.1498413e-005];
};

_vehicle_207 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16779.594, 19017.613, 3.6239624e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_207 = _this;
  _this setDir 172.91092;
  _this setPos [16779.594, 19017.613, 3.6239624e-005];
};

_vehicle_209 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16770.455, 19016.441, 1.9073486e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_209 = _this;
  _this setDir 172.41264;
  _this setPos [16770.455, 19016.441, 1.9073486e-006];
};

_vehicle_211 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16764.117, 19008.9, 1.5258789e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_211 = _this;
  _this setDir 84.825813;
  _this setPos [16764.117, 19008.9, 1.5258789e-005];
};

_vehicle_213 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16765.477, 18993.875, 6.4849854e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_213 = _this;
  _this setDir 84.653465;
  _this setPos [16765.477, 18993.875, 6.4849854e-005];
};

_vehicle_215 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16681.361, 19073.9, 4.0054321e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_215 = _this;
  _this setDir 173.78943;
  _this setPos [16681.361, 19073.9, 4.0054321e-005];
};

_vehicle_222 = objNull;
if (true) then
{
  _this = createVehicle ["HeliHCivil", [16759.674, 19045.967, -1.335144e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_222 = _this;
  _this setPos [16759.674, 19045.967, -1.335144e-005];
};

_vehicle_235 = objNull;
if (true) then
{
  _this = createVehicle ["Gue_WarfareBLightFactory", [16774.787, 19029.723, -0.15129885], [], 0, "CAN_COLLIDE"];
  _vehicle_235 = _this;
  _this setDir -236.26051;
  _this setPos [16774.787, 19029.723, -0.15129885];
};

_vehicle_239 = objNull;
if (true) then
{
  _this = createVehicle ["WarfareBMGNest_PK_TK_EP1", [16759.879, 18992.189, 5.531311e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_239 = _this;
  _this setDir 331.1059;
  _this setPos [16759.879, 18992.189, 5.531311e-005];
  _this setVariable ["ObjectID","1",true];

};

_vehicle_243 = objNull;
if (true) then
{
  _this = createVehicle ["WarfareBMGNest_PK_TK_EP1", [16666.688, 19056.133, 0.00025558472], [], 0, "CAN_COLLIDE"];
  _vehicle_243 = _this;
  _this setDir 114.86234;
  _this setPos [16666.688, 19056.133, 0.00025558472];
  _this setVariable ["ObjectID","1",true];
};

_vehicle_244 = objNull;
if (true) then
{
  _this = createVehicle ["T72Wreck", [16604.443, 19110.932, 0.00014877319], [], 0, "CAN_COLLIDE"];
  _vehicle_244 = _this;
  _this setPos [16604.443, 19110.932, 0.00014877319];
};

_vehicle_246 = objNull;
if (true) then
{
  _this = createVehicle ["UH60_wreck_EP1", [16630.666, 19138.006, 0.00014877319], [], 0, "CAN_COLLIDE"];
  _vehicle_246 = _this;
  _this setPos [16630.666, 19138.006, 0.00014877319];
};

_vehicle_247 = objNull;
if (true) then
{
  _this = createVehicle ["BRDMWreck", [16731.818, 19063.76, 0.00016593933], [], 0, "CAN_COLLIDE"];
  _vehicle_247 = _this;
  _this setPos [16731.818, 19063.76, 0.00016593933];
};

_vehicle_251 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [16701.484, 19048.014, 4.5776367e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_251 = _this;
  _this setDir -273.51862;
  _this setPos [16701.484, 19048.014, 4.5776367e-005];
  MILBASE1_alarm_tower = _this;
};

_vehicle_252 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [16677.742, 19076.219, 3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_252 = _this;
  _this setDir -4.8020239;
  _this setPos [16677.742, 19076.219, 3.8146973e-006];
};

_vehicle_253 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [16706.467, 18977.971, 4.5776367e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_253 = _this;
  _this setDir -4.0724912;
  _this setPos [16706.467, 18977.971, 4.5776367e-005];
};

_vehicle_254 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [16783.402, 19050.146, 8.5830688e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_254 = _this;
  _this setDir -93.00618;
  _this setPos [16783.402, 19050.146, 8.5830688e-005];
};

_vehicle_256 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_ControlTower", [16690.92, 19024.736, -0.088352017], [], 0, "CAN_COLLIDE"];
  _vehicle_256 = _this;
  _this setDir -271.73486;
  _this setPos [16690.92, 19024.736, -0.088352017];
};

_vehicle_265 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16730.461, 19013.785, 0.00020599365], [], 0, "CAN_COLLIDE"];
  _vehicle_265 = _this;
  _this setDir -4.1344051;
  _this setPos [16730.461, 19013.785, 0.00020599365];
};

_vehicle_267 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16730.48, 19024.629, 0.0002040863], [], 0, "CAN_COLLIDE"];
  _vehicle_267 = _this;
  _this setDir -4.5986214;
  _this setPos [16730.48, 19024.629, 0.0002040863];
};

_vehicle_269 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [16729.912, 19035.381, -2.6702881e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_269 = _this;
  _this setDir -4.5288258;
  _this setPos [16729.912, 19035.381, -2.6702881e-005];
};



// Bas 2


_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [10489.563, 19066.932, 0.00018978119], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir -138.28922;
  _this setPos [10489.563, 19066.932, 0.00018978119];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [10461.269, 19091.039, -6.0469747], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir -14.128201;
  _this setPos [10461.269, 19091.039, -6.0469747];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockTower", [10420.952, 19126.773, 0.00012779236], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir 118.7126;
  _this setPos [10420.952, 19126.773, 0.00012779236];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_Rock1", [10409.139, 19140.797, 9.8228455e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setDir 32.774162;
  _this setPos [10409.139, 19140.797, 9.8228455e-005];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_Rock1", [10381.988, 19195.705, 0.0001707077], [], 0, "CAN_COLLIDE"];
  _vehicle_8 = _this;
  _this setDir 32.774162;
  _this setPos [10381.988, 19195.705, 0.0001707077];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [10402.973, 19167.736, -8.9178762], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir -122.04684;
  _this setPos [10402.973, 19167.736, -8.9178762];
};

_vehicle_19 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_Rock1", [10372.763, 19209.898, -0.00050163269], [], 0, "CAN_COLLIDE"];
  _vehicle_19 = _this;
  _this setDir -292.31717;
  _this setPos [10372.763, 19209.898, -0.00050163269];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [10358.89, 19228.719, -5.0072408], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setDir -122.04684;
  _this setPos [10358.89, 19228.719, -5.0072408];
};

_vehicle_24 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_plot_istan1_rovny_gate", [10427.556, 19120.705, 1.8596649e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_24 = _this;
  _this setDir 40.561115;
  _this setPos [10427.556, 19120.705, 1.8596649e-005];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [10449.68, 19099.412, 6.4849854e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir -134.9115;
  _this setPos [10449.68, 19099.412, 6.4849854e-005];
};

_vehicle_32 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_Rock1", [10428.275, 19119.445, 10.169169], [], 0, "CAN_COLLIDE"];
  _vehicle_32 = _this;
  _this setDir 32.774162;
  _this setPos [10428.275, 19119.445, 10.169169];
};

_vehicle_124 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_deutshe_mini", [10488.723, 19233.643, -2.2888184e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_124 = _this;
  _this setDir -236.68962;
  _this setPos [10488.723, 19233.643, -2.2888184e-005];
};

_vehicle_129 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_HouseV2_02_Interier_dam", [10512.121, 19209.99, -1.7166138e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_129 = _this;
  _this setDir -37.904289;
  _this setPos [10512.121, 19209.99, -1.7166138e-005];
};

_vehicle_131 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Misc_Boogieman", [10495.067, 19244.434, -0.00017166138], [], 0, "CAN_COLLIDE"];
  _vehicle_131 = _this;
  _this setDir -94.480682;
  _this setPos [10495.067, 19244.434, -0.00017166138];
};

_vehicle_132 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_ChickenCoop", [10488.306, 19221.926, 5.4359436e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_132 = _this;
  _this setDir -118.9278;
  _this setPos [10488.306, 19221.926, 5.4359436e-005];
};

_vehicle_133 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_misc_deerstand", [10476.613, 19198.848, -4.4822693e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_133 = _this;
  _this setDir 51.676846;
  _this setPos [10476.613, 19198.848, -4.4822693e-005];
};

_vehicle_196 = objNull;
if (true) then
{
  _this = createVehicle ["Land_MBG_GER_ESTATE_1", [10936.671, 19718.564, 0.00024414063], [], 0, "CAN_COLLIDE"];
  _vehicle_196 = _this;
  _this setDir 219.96031;
  _this setPos [10936.671, 19718.564, 0.00024414063];
};

_vehicle_200 = objNull;
if (true) then
{
  _this = createVehicle ["Land_MBG_Beach_Chair_2", [10944.333, 19711.65, -2.7656555e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_200 = _this;
  _this setDir -52.280037;
  _this setPos [10944.333, 19711.65, -2.7656555e-005];
};

_vehicle_206 = objNull;
if (true) then
{
  _this = createVehicle ["Land_MBG_Outdoortable", [10978.188, 19700.682, 3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_206 = _this;
  _this setDir 117.16093;
  _this setPos [10978.188, 19700.682, 3.8146973e-006];
};

_vehicle_207 = objNull;
if (true) then
{
  _this = createVehicle ["Land_MBG_Outdoortable", [10975.457, 19701.91, -0.00019645691], [], 0, "CAN_COLLIDE"];
  _vehicle_207 = _this;
  _this setDir -60.855431;
  _this setPos [10975.457, 19701.91, -0.00019645691];
};


_thebox = createVehicle ["BAF_BasicAmmunitionBox",[10933.985, 19715.463, 0.50062436], [], 0, "CAN_COLLIDE"];
_thebox setPos [10933.985, 19715.463, 0.50062436];
_thebox setDir 38.480148;
clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;
_thebox setVariable ["ObjectID","1",true];
_thebox setVariable ["permaLoot",true];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_thebox];

clearWeaponCargoGlobal _thebox;
clearMagazineCargoGlobal _thebox;

_hidden_box_number_of_gold = 1;
_hidden_box_random_items = [
"ItemBriefcase100oz"
];

_hidden_box_number_of_buildmats = 0;
_hidden_box_random_buildmats = [
"CinderBlocks"
];

_hidden_box_number_of_guns = 1;
_hidden_box_random_guns = [
"DMR"
];

_hidden_box_number_of_tools = 0;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "Chainsaw" or "ItemToolbox")
_hidden_box_random_tools =[
"ItemToolbox",
"ItemKnife",
"ItemCrowbar",
"ItemEtool",
"ItemHatchet",
"Binocular_Vector",
"ItemGPS",
"NVGoggles",
"chainsaw",
"ItemSledge"
];


_numberofguns = 1;// (round (random 2)) + _hidden_box_number_of_guns;
_numberoftools = 0;// (round (random 2)) + _hidden_box_number_of_tools;
_numberofitems = 1;//(round (random 1)) + _hidden_box_number_of_gold;
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




// Bas 3




_vehicle_0 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10310.843, 7174.6929, 2.6702881e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_0 = _this;
  _this setDir -147.4567;
  _this setPos [10310.843, 7174.6929, 2.6702881e-005];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10322.991, 7166.6675, 0.00010681152], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir -146.77754;
  _this setPos [10322.991, 7166.6675, 0.00010681152];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10335.906, 7158.1914, -4.196167e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir -146.77754;
  _this setPos [10335.906, 7158.1914, -4.196167e-005];
};

_vehicle_7 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10348.886, 7149.7827, 0.00014877319], [], 0, "CAN_COLLIDE"];
  _vehicle_7 = _this;
  _this setDir -146.77754;
  _this setPos [10348.886, 7149.7827, 0.00014877319];
};

_vehicle_9 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10361.908, 7141.1846, 3.4332275e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_9 = _this;
  _this setDir -146.77754;
  _this setPos [10361.908, 7141.1846, 3.4332275e-005];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10363.514, 7131.6943, -0.12366571], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir -240.00751;
  _this setPos [10363.514, 7131.6943, -0.12366571];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10355.708, 7118.1646, 7.6293945e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir -240.00751;
  _this setPos [10355.708, 7118.1646, 7.6293945e-006];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10348.102, 7104.8223, -7.6293945e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setDir -240.00751;
  _this setPos [10348.102, 7104.8223, -7.6293945e-005];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10340.285, 7091.2344, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setDir -240.00751;
  _this setPos [10340.285, 7091.2344, -6.1035156e-005];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10332.688, 7077.916, 0.00015258789], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setDir -240.00751;
  _this setPos [10332.688, 7077.916, 0.00015258789];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10270.332, 7104.9429, -0.014081623], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir -148.88553;
  _this setPos [10270.332, 7104.9429, -0.014081623];
};

_vehicle_28 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10283.4, 7097.2583, 0.10202091], [], 0, "CAN_COLLIDE"];
  _vehicle_28 = _this;
  _this setDir -150.57491;
  _this setPos [10283.4, 7097.2583, 0.10202091];
};

_vehicle_29 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10296.781, 7089.73, 0.11847883], [], 0, "CAN_COLLIDE"];
  _vehicle_29 = _this;
  _this setDir -151.28398;
  _this setPos [10296.781, 7089.73, 0.11847883];
};

_vehicle_30 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10310.353, 7082.1631, 0.12321024], [], 0, "CAN_COLLIDE"];
  _vehicle_30 = _this;
  _this setDir -150.93913;
  _this setPos [10310.353, 7082.1631, 0.12321024];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10324.006, 7074.6133, -0.09275651], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir -151.02757;
  _this setPos [10324.006, 7074.6133, -0.09275651];
};

_vehicle_43 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10300.266, 7172.0479, 6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_43 = _this;
  _this setDir -240.00751;
  _this setPos [10300.266, 7172.0479, 6.1035156e-005];
};

_vehicle_44 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10292.591, 7158.7979, -0.30298615], [], 0, "CAN_COLLIDE"];
  _vehicle_44 = _this;
  _this setDir -240.00751;
  _this setPos [10292.591, 7158.7979, -0.30298615];
};

_vehicle_46 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10275.389, 7129.0063, -0.095299155], [], 0, "CAN_COLLIDE"];
  _vehicle_46 = _this;
  _this setDir -240.76262;
  _this setPos [10275.389, 7129.0063, -0.095299155];
};

_vehicle_47 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [10267.844, 7115.4863, -0.295784], [], 0, "CAN_COLLIDE"];
  _vehicle_47 = _this;
  _this setDir -240.00751;
  _this setPos [10267.844, 7115.4863, -0.295784];
};

_vehicle_56 = objNull;
if (true) then
{
  _this = createVehicle ["USMC_WarfareBHeavyFactory", [10347.377, 7128.5698, -0.31137475], [], 0, "CAN_COLLIDE"];
  _vehicle_56 = _this;
  _this setDir 93.215881;
  _this setPos [10347.377, 7128.5698, -0.31137475];
};

_vehicle_57 = objNull;
if (true) then
{
  _this = createVehicle ["USMC_WarfareBFieldhHospital", [10327.111, 7095.0337, 0.088569835], [], 0, "CAN_COLLIDE"];
  _vehicle_57 = _this;
  _this setDir 42.183594;
  _this setPos [10327.111, 7095.0337, 0.088569835];
};

_vehicle_59 = objNull;
if (true) then
{
  _this = createVehicle ["CDF_WarfareBAntiAirRadar", [10314.581, 7152.835, -0.33457512], [], 0, "CAN_COLLIDE"];
  _vehicle_59 = _this;
  _this setDir -461.31006;
  _this setPos [10314.581, 7152.835, -0.33457512];
};

_vehicle_61 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10276.704, 7116.813, 3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_61 = _this;
  _this setDir 298.3497;
  _this setPos [10276.704, 7116.813, 3.8146973e-006];
};

_vehicle_62 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [10286.279, 7111.0298, 1.9073486e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_62 = _this;
  _this setDir -60.94994;
  _this setPos [10286.279, 7111.0298, 1.9073486e-005];
};

_vehicle_63 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Ind_IlluminantTower", [10306.958, 7102.0469, -3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_63 = _this;
  _this setPos [10306.958, 7102.0469, -3.8146973e-006];
};

_vehicle_68 = objNull;
if (true) then
{
  _this = createVehicle ["C130J_wreck_EP1", [10272.537, 7068.6245, -0.11267966], [], 0, "CAN_COLLIDE"];
  _vehicle_68 = _this;
  _this setDir -57.466347;
  _this setPos [10272.537, 7068.6245, -0.11267966];
};

_vehicle_71 = objNull;
if (true) then
{
  _this = createVehicle ["Hhedgehog_concrete", [10285.62, 7148.7554, 7.2479248e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_71 = _this;
  _this setDir -58.565495;
  _this setPos [10285.62, 7148.7554, 7.2479248e-005];
};

_vehicle_73 = objNull;
if (true) then
{
  _this = createVehicle ["Hhedgehog_concrete", [10280.761, 7140.6758, -1.5258789e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_73 = _this;
  _this setDir -58.565495;
  _this setPos [10280.761, 7140.6758, -1.5258789e-005];
};

_vehicle_83 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [10290.135, 7150.167, 5.7220459e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_83 = _this;
  _this setPos [10290.135, 7150.167, 5.7220459e-005];
};

_vehicle_85 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [10281.101, 7136.0757, 1.1444092e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_85 = _this;
  _this setPos [10281.101, 7136.0757, 1.1444092e-005];
};

_vehicle_89 = objNull;
if (true) then
{
  _this = createVehicle ["HeliHCivil", [10320.28, 7122.375, -3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_89 = _this;
  _this setPos [10320.28, 7122.375, -3.8146973e-006];
};

//_vehicle_92 = objNull;
//if (true) then
//{
//  _this = createVehicle ["land_ibr_hangar", [10301.21, 7135.0112, 1.9073486e-005], [], 0, "CAN_COLLIDE"];
//  _vehicle_92 = _this;
//  _this setPos [10301.21, 7135.0112, 1.9073486e-005];
//};

_vehicle_105 = objNull;
if (true) then
{
  _this = createVehicle ["WarfareBDepot", [10297.829, 7134.9277, -0.33766255], [], 0, "CAN_COLLIDE"];
  _vehicle_105 = _this;
  _this setDir -238.73465;
  _this setPos [10297.829, 7134.9277, -0.33766255];
};

_vehicle_90 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLadder_DZ", [16443.238,18330.797,3.36], [], 0, "CAN_COLLIDE"];
  _vehicle_90 = _this;
  _this setDir 35.912;
  _this setPos [16443.238,18330.797,3.36];
};
_vehicle_91 = objNull;
if (true) then
{
  _this = createVehicle ["WoodFloorQuarter_DZ", [16442.639,18330.109,5.801], [], 0, "CAN_COLLIDE"];
  _vehicle_91 = _this;
  _this setDir 305.96;
  _this setPos [16442.639,18330.109,5.801];
};
_vehicle_92 = objNull;
if (true) then
{
  _this = createVehicle ["WoodFloorQuarter_DZ", [16442.846,18330.047,2.301], [], 0, "CAN_COLLIDE"];
  _vehicle_92 = _this;
  _this setDir 307.17;
  _this setPos [16442.846,18330.047,2.301];
};
_vehicle_93 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLadder_DZ", [16442.771,18330.119,0.001], [], 0, "CAN_COLLIDE"];
  _vehicle_93 = _this;
  _this setDir 34.559;
  _this setPos [16442.771,18330.119,0.001];
};
_vehicle_94 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLadder_DZ", [16419.48,18296.426,3.56], [], 0, "CAN_COLLIDE"];
  _vehicle_94 = _this;
  _this setDir 36.349;
  _this setPos [16419.48,18296.426,3.56];
};
_vehicle_95 = objNull;
if (true) then
{
  _this = createVehicle ["WoodFloorQuarter_DZ", [16419.025,18295.912,6.101], [], 0, "CAN_COLLIDE"];
  _vehicle_95 = _this;
  _this setDir 305.668;
  _this setPos [16419.025,18295.912,6.101];
};
_vehicle_96 = objNull;
if (true) then
{
  _this = createVehicle ["WoodLadder_DZ", [16418.592,18295.264,0.201], [], 0, "CAN_COLLIDE"];
  _vehicle_96 = _this;
  _this setDir 36.16;
  _this setPos [16418.592,18295.264,0.201];
};
_vehicle_97 = objNull;
if (true) then
{
  _this = createVehicle ["WoodFloorQuarter_DZ", [16418.873,18295.781,3.001], [], 0, "CAN_COLLIDE"];
  _vehicle_97 = _this;
  _this setDir 305.781;
  _this setPos [16418.873,18295.781,3.001];
};

};
