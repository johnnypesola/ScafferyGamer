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
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13246.80400,10766.65900,0.00003], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 0.85547203;
  _this setPos [13246.80400,10766.65900,0.00003];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13262.32000,10766.61300,-0.00007], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setPos [13262.32000,10766.61300,-0.00007];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13277.79000,10766.50500,-0.00007], [], 0, "CAN_COLLIDE"];
  _vehicle_4 = _this;
  _this setPos [13277.79000,10766.50500,-0.00007];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13231.16200,10766.69500,-0.00016], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setPos [13231.16200,10766.69500,-0.00016];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13293.44900,10766.55200,-0.00014], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setPos [13293.44900,10766.55200,-0.00014];
};

_vehicle_7 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13215.55200,10766.63200,0.00006], [], 0, "CAN_COLLIDE"];
  _vehicle_7 = _this;
  _this setPos [13215.55200,10766.63200,0.00006];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13199.89000,10766.53200,0.00004], [], 0, "CAN_COLLIDE"];
  _vehicle_8 = _this;
  _this setPos [13199.89000,10766.53200,0.00004];
};

_vehicle_9 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13309.12800,10766.47000,-0.00003], [], 0, "CAN_COLLIDE"];
  _vehicle_9 = _this;
  _this setPos [13309.12800,10766.47000,-0.00003];
};

_vehicle_10 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13316.17300,10759.66300,-0.00003], [], 0, "CAN_COLLIDE"];
  _vehicle_10 = _this;
  _this setDir -92.832413;
  _this setPos [13316.17300,10759.66300,-0.00003];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13315.97800,10744.02700,-0.00001], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir 87.214577;
  _this setPos [13315.97800,10744.02700,-0.00001];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13317.07000,10728.33700,0.00022], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setDir 86.974388;
  _this setPos [13317.07000,10728.33700,0.00022];
};

_vehicle_13 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13317.75500,10712.75700,0.00014], [], 0, "CAN_COLLIDE"];
  _vehicle_13 = _this;
  _this setDir 88.171761;
  _this setPos [13317.75500,10712.75700,0.00014];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13319.61900,10697.21200,-0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir -92.755196;
  _this setPos [13319.61900,10697.21200,-0.00010];
};

_vehicle_15 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13319.41900,10681.37800,-0.00007], [], 0, "CAN_COLLIDE"];
  _vehicle_15 = _this;
  _this setDir 86.49115;
  _this setPos [13319.41900,10681.37800,-0.00007];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13321.80200,10666.00700], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setDir -94.707024;
  _this setPos [13321.80200,10666.00700];
};

_vehicle_17 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13322.03300,10650.29000,0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_17 = _this;
  _this setDir 84.653465;
  _this setPos [13322.03300,10650.29000,0.00005];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13315.99400,10642.35300,-0.00003], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setDir -3.3988094;
  _this setPos [13315.99400,10642.35300,-0.00003];
};

_vehicle_19 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13300.94300,10641.53200,-0.00006], [], 0, "CAN_COLLIDE"];
  _vehicle_19 = _this;
  _this setDir -3.4244368;
  _this setPos [13300.94300,10641.53200,-0.00006];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13285.38000,10640.64200,0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setDir -3.4853144;
  _this setPos [13285.38000,10640.64200,0.00010];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13269.59700,10639.74900,-0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setDir -3.4167421;
  _this setPos [13269.59700,10639.74900,-0.00005];
};

_vehicle_22 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13254.09100,10638.76700,-0.00006], [], 0, "CAN_COLLIDE"];
  _vehicle_22 = _this;
  _this setDir -3.9457691;
  _this setPos [13254.09100,10638.76700,-0.00006];
};

_vehicle_23 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13238.51100,10637.69800,0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_23 = _this;
  _this setDir -4.1593838;
  _this setPos [13238.51100,10637.69800,0.00005];
};

_vehicle_24 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13222.83500,10636.48000], [], 0, "CAN_COLLIDE"];
  _vehicle_24 = _this;
  _this setDir -4.4740524;
  _this setPos [13222.83500,10636.48000];
};

_vehicle_25 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13207.31400,10635.22600,0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_25 = _this;
  _this setDir -5.5168929;
  _this setPos [13207.31400,10635.22600,0.00005];
};

_vehicle_26 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13198.53700,10641.62400,0.00229], [], 0, "CAN_COLLIDE"];
  _vehicle_26 = _this;
  _this setDir 82.719315;
  _this setPos [13198.53700,10641.62400,0.00229];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13196.66500,10656.94800,-0.00027], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setDir 84.006317;
  _this setPos [13196.66500,10656.94800,-0.00027];
};

_vehicle_30 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13195.18500,10672.49700,0.00045], [], 0, "CAN_COLLIDE"];
  _vehicle_30 = _this;
  _this setDir 85.312775;
  _this setPos [13195.18500,10672.49700,0.00045];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13194.10700,10687.84100,-0.01418], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir 86.153595;
  _this setPos [13194.10700,10687.84100,-0.01418];
};

_vehicle_34 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13192.95600,10703.12800,-0.00019], [], 0, "CAN_COLLIDE"];
  _vehicle_34 = _this;
  _this setDir 85.312775;
  _this setPos [13192.95600,10703.12800,-0.00019];
};

_vehicle_35 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13191.61500,10718.51100,0.03679], [], 0, "CAN_COLLIDE"];
  _vehicle_35 = _this;
  _this setDir 86.153595;
  _this setPos [13191.61500,10718.51100,0.03679];
};

_vehicle_38 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13190.34100,10734.13200,-0.00022], [], 0, "CAN_COLLIDE"];
  _vehicle_38 = _this;
  _this setDir 85.312775;
  _this setPos [13190.34100,10734.13200,-0.00022];
};

_vehicle_44 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [13212.70300,10642.82500,0.01176], [], 0, "CAN_COLLIDE"];
  _vehicle_44 = _this;
  _this setDir -3.6342566;
  _this setPos [13212.70300,10642.82500,0.01176];
};

_vehicle_52 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [13212.04200,10653.62400,-0.03873], [], 0, "CAN_COLLIDE"];
  _vehicle_52 = _this;
  _this setDir -3.6342566;
  _this setPos [13212.04200,10653.62400,-0.03873];
};

_vehicle_57 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [13211.52900,10665.75500,-0.04792], [], 0, "CAN_COLLIDE"];
  _vehicle_57 = _this;
  _this setDir -3.6822281;
  _this setPos [13211.52900,10665.75500,-0.04792];
};

_vehicle_59 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13189.53800,10745.04800,0.00002], [], 0, "CAN_COLLIDE"];
  _vehicle_59 = _this;
  _this setDir 85.312775;
  _this setPos [13189.53800,10745.04800,0.00002];
};

_vehicle_62 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13184.34900,10765.90900,0.00011], [], 0, "CAN_COLLIDE"];
  _vehicle_62 = _this;
  _this setDir -4.486979;
  _this setPos [13184.34900,10765.90900,0.00011];
};

_vehicle_64 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13168.65400,10764.36800,0.00015], [], 0, "CAN_COLLIDE"];
  _vehicle_64 = _this;
  _this setDir -6.4669528;
  _this setPos [13168.65400,10764.36800,0.00015];
};

_vehicle_66 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13182.75500,10752.04400,0.00000], [], 0, "CAN_COLLIDE"];
  _vehicle_66 = _this;
  _this setDir -7.8893862;
  _this setPos [13182.75500,10752.04400,0.00000];
};

_vehicle_68 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13170.73200,10750.42500,0.00012], [], 0, "CAN_COLLIDE"];
  _vehicle_68 = _this;
  _this setDir -5.4435587;
  _this setPos [13170.73200,10750.42500,0.00012];
};

_vehicle_72 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13205.55600,10743.35700,-0.00007], [], 0, "CAN_COLLIDE"];
  _vehicle_72 = _this;
  _this setDir 85.312775;
  _this setPos [13205.55600,10743.35700,-0.00007];
};

_vehicle_73 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13204.21400,10758.74000,0.24458], [], 0, "CAN_COLLIDE"];
  _vehicle_73 = _this;
  _this setDir 86.153595;
  _this setPos [13204.21400,10758.74000,0.24458];
};

_vehicle_78 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13212.72000,10725.87600,0.00022], [], 0, "CAN_COLLIDE"];
  _vehicle_78 = _this;
  _this setDir -7.8893862;
  _this setPos [13212.72000,10725.87600,0.00022];
};

_vehicle_79 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13200.69700,10724.25700,-0.31623], [], 0, "CAN_COLLIDE"];
  _vehicle_79 = _this;
  _this setDir -5.4435587;
  _this setPos [13200.69700,10724.25700,-0.31623];
};

_vehicle_82 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13238.35100,10728.57500,-0.00015], [], 0, "CAN_COLLIDE"];
  _vehicle_82 = _this;
  _this setDir -4.59373;
  _this setPos [13238.35100,10728.57500,-0.00015];
};

_vehicle_83 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13227.98600,10727.66100,-0.18899], [], 0, "CAN_COLLIDE"];
  _vehicle_83 = _this;
  _this setDir -5.4435587;
  _this setPos [13227.98600,10727.66100,-0.18899];
};

_vehicle_90 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13230.99400,10737.05000,0.00446], [], 0, "CAN_COLLIDE"];
  _vehicle_90 = _this;
  _this setDir 85.312775;
  _this setPos [13230.99400,10737.05000,0.00446];
};

_vehicle_91 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13229.65200,10752.43300,-0.32372], [], 0, "CAN_COLLIDE"];
  _vehicle_91 = _this;
  _this setDir 86.153595;
  _this setPos [13229.65200,10752.43300,-0.32372];
};

_vehicle_97 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fort_watchtower", [13195.16300,10729.13600,0.00004], [], 0, "CAN_COLLIDE"];
  _vehicle_97 = _this;
  _this setDir -5.8465366;
  _this setPos [13195.16300,10729.13600,0.00004];
};

_vehicle_105 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fort_watchtower", [13198.47400,10685.85100,-0.23325], [], 0, "CAN_COLLIDE"];
  _vehicle_105 = _this;
  _this setDir -4.3343425;
  _this setPos [13198.47400,10685.85100,-0.23325];
};

_vehicle_109 = objNull;
if (true) then
{
  _this = createVehicle ["Land_fort_watchtower", [13316.63400,10646.22000,-0.00009], [], 0, "CAN_COLLIDE"];
  _vehicle_109 = _this;
  _this setDir -93.679733;
  _this setPos [13316.63400,10646.22000,-0.00009];
};

_vehicle_113 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [13156.72600,10750.45800,0.00020], [], 0, "CAN_COLLIDE"];
  _vehicle_113 = _this;
  _this setDir 4.7647281;
  _this setPos [13156.72600,10750.45800,0.00020];
};

_vehicle_114 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [13150.98000,10755.32700,0.00026], [], 0, "CAN_COLLIDE"];
  _vehicle_114 = _this;
  _this setDir 79.794266;
  _this setPos [13150.98000,10755.32700,0.00026];
};

_vehicle_115 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_dragonTeethBig", [13155.55400,10762.25700,0.00008], [], 0, "CAN_COLLIDE"];
  _vehicle_115 = _this;
  _this setDir -7.483532;
  _this setPos [13155.55400,10762.25700,0.00008];
};

_vehicle_116 = objNull;
if (true) then
{
  _this = createVehicle ["US_WarfareBAntiAirRadar_EP1", [13303.52100,10749.93500,-0.50518], [], 0, "CAN_COLLIDE"];
  _vehicle_116 = _this;
  _this setDir -209.68384;
  _this setPos [13303.52100,10749.93500,-0.50518];
};

_vehicle_118 = objNull;
if (true) then
{
  _this = createVehicle ["US_WarfareBFieldhHospital_EP1", [13251.53300,10650.06800,-0.00011], [], 0, "CAN_COLLIDE"];
  _vehicle_118 = _this;
  _this setDir 85.471596;
  _this setPos [13251.53300,10650.06800,-0.00011];
};

_vehicle_123 = objNull;
if (true) then
{
  _this = createVehicle ["ZavoraAnim", [13161.91900,10760.55800,0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_123 = _this;
  _this setDir -93.989891;
  _this setPos [13161.91900,10760.55800,0.00005];
};

_vehicle_125 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [13170.64600,10753.31000,0.00025], [], 0, "CAN_COLLIDE"];
  _vehicle_125 = _this;
  _this setDir 73.418365;
  _this setPos [13170.64600,10753.31000,0.00025];
};

_vehicle_141 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Fire_barrel_burning", [13169.43500,10762.31600,-0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_141 = _this;
  _this setDir 73.418365;
  _this setPos [13169.43500,10762.31600,-0.00010];
};

_vehicle_160 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [13225.49500,10660.45400,0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_160 = _this;
  _this setDir 110.96899;
  _this setPos [13225.49500,10660.45400,0.00005];
};

_vehicle_162 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [13225.96800,10649.49100,-0.00014], [], 0, "CAN_COLLIDE"];
  _vehicle_162 = _this;
  _this setDir 110.96899;
  _this setPos [13225.96800,10649.49100,-0.00014];
};

_vehicle_164 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [13251.18500,10653.29600,0.00009], [], 0, "CAN_COLLIDE"];
  _vehicle_164 = _this;
  _this setDir 110.96899;
  _this setPos [13251.18500,10653.29600,0.00009];
};

_vehicle_166 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [13159.27300,10765.33300,-0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_166 = _this;
  _this setDir 110.96899;
  _this setPos [13159.27300,10765.33300,-0.00005];
};

_vehicle_168 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierGermany_EP1", [13161.45300,10748.15700,0.00017], [], 0, "CAN_COLLIDE"];
  _vehicle_168 = _this;
  _this setDir 110.96899;
  _this setPos [13161.45300,10748.15700,0.00017];
};

_vehicle_174 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13235.67500,10645.37200,-0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_174 = _this;
  _this setDir -93.737816;
  _this setPos [13235.67500,10645.37200,-0.00010];
};

_vehicle_178 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13234.68500,10660.98000,-0.00819], [], 0, "CAN_COLLIDE"];
  _vehicle_178 = _this;
  _this setDir -93.737816;
  _this setPos [13234.68500,10660.98000,-0.00819];
};

_vehicle_184 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13233.66900,10676.24000,0.00038], [], 0, "CAN_COLLIDE"];
  _vehicle_184 = _this;
  _this setDir -93.737816;
  _this setPos [13233.66900,10676.24000,0.00038];
};

_vehicle_186 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13225.58700,10678.50100,0.00013], [], 0, "CAN_COLLIDE"];
  _vehicle_186 = _this;
  _this setDir -2.6216772;
  _this setPos [13225.58700,10678.50100,0.00013];
};

_vehicle_188 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13213.85300,10677.94300,0.00006], [], 0, "CAN_COLLIDE"];
  _vehicle_188 = _this;
  _this setDir -2.6865101;
  _this setPos [13213.85300,10677.94300,0.00006];
};

_vehicle_190 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13232.67300,10691.83900,0.00009], [], 0, "CAN_COLLIDE"];
  _vehicle_190 = _this;
  _this setDir -93.737816;
  _this setPos [13232.67300,10691.83900,0.00009];
};

_vehicle_192 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13231.83900,10707.25900,-0.00008], [], 0, "CAN_COLLIDE"];
  _vehicle_192 = _this;
  _this setDir -93.737816;
  _this setPos [13231.83900,10707.25900,-0.00008];
};

_vehicle_194 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13239.15000,10715.15700,0.00011], [], 0, "CAN_COLLIDE"];
  _vehicle_194 = _this;
  _this setDir -185.48915;
  _this setPos [13239.15000,10715.15700,0.00011];
};

_vehicle_200 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13306.38000,10650.35100,0.00001], [], 0, "CAN_COLLIDE"];
  _vehicle_200 = _this;
  _this setDir 84.653465;
  _this setPos [13306.38000,10650.35100,0.00001];
};

_vehicle_205 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13304.96600,10665.89400,0.00000], [], 0, "CAN_COLLIDE"];
  _vehicle_205 = _this;
  _this setDir 84.653465;
  _this setPos [13304.96600,10665.89400,0.00000];
};

_vehicle_207 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13311.81800,10681.16500,-0.00001], [], 0, "CAN_COLLIDE"];
  _vehicle_207 = _this;
  _this setDir 172.91092;
  _this setPos [13311.81800,10681.16500,-0.00001];
};

_vehicle_209 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13302.67900,10679.99300,-0.00005], [], 0, "CAN_COLLIDE"];
  _vehicle_209 = _this;
  _this setDir 172.41264;
  _this setPos [13302.67900,10679.99300,-0.00005];
};

_vehicle_211 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13296.34100,10672.45200,-0.00003], [], 0, "CAN_COLLIDE"];
  _vehicle_211 = _this;
  _this setDir 84.825813;
  _this setPos [13296.34100,10672.45200,-0.00003];
};

_vehicle_213 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13297.70100,10657.42700,0.00002], [], 0, "CAN_COLLIDE"];
  _vehicle_213 = _this;
  _this setDir 84.653465;
  _this setPos [13297.70100,10657.42700,0.00002];
};

_vehicle_215 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13213.58500,10737.45200,-0.00001], [], 0, "CAN_COLLIDE"];
  _vehicle_215 = _this;
  _this setDir 173.78943;
  _this setPos [13213.58500,10737.45200,-0.00001];
};

_vehicle_222 = objNull;
if (true) then
{
  _this = createVehicle ["HeliHCivil", [13291.89800,10709.51900,-0.00006], [], 0, "CAN_COLLIDE"];
  _vehicle_222 = _this;
  _this setPos [13291.89800,10709.51900,-0.00006];
};

_vehicle_235 = objNull;
if (true) then
{
  _this = createVehicle ["Gue_WarfareBLightFactory", [13307.01100,10693.27500,-0.15135], [], 0, "CAN_COLLIDE"];
  _vehicle_235 = _this;
  _this setDir -236.26051;
  _this setPos [13307.01100,10693.27500,-0.15135];
};

_vehicle_239 = objNull;
if (true) then
{
  _this = createVehicle ["WarfareBMGNest_PK_TK_EP1", [13292.10300,10655.74100,0.00001], [], 0, "CAN_COLLIDE"];
  _vehicle_239 = _this;
  _this setDir 331.1059;
  _this setPos [13292.10300,10655.74100,0.00001];
  _this setVariable ["ObjectID","1",true];

};

_vehicle_243 = objNull;
if (true) then
{
  _this = createVehicle ["WarfareBMGNest_PK_TK_EP1", [13198.91200,10719.68500,0.00021], [], 0, "CAN_COLLIDE"];
  _vehicle_243 = _this;
  _this setDir 114.86234;
  _this setPos [13198.91200,10719.68500,0.00021];
  _this setVariable ["ObjectID","1",true];
};

_vehicle_244 = objNull;
if (true) then
{
  _this = createVehicle ["T72Wreck", [13136.66700,10774.48400,0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_244 = _this;
  _this setPos [13136.66700,10774.48400,0.00010];
};

_vehicle_246 = objNull;
if (true) then
{
  _this = createVehicle ["UH60_wreck_EP1", [13162.89000,10801.55800,0.00010], [], 0, "CAN_COLLIDE"];
  _vehicle_246 = _this;
  _this setPos [13162.89000,10801.55800,0.00010];
};

_vehicle_247 = objNull;
if (true) then
{
  _this = createVehicle ["BRDMWreck", [13264.04200,10727.31200,0.00012], [], 0, "CAN_COLLIDE"];
  _vehicle_247 = _this;
  _this setPos [13264.04200,10727.31200,0.00012];
};

_vehicle_251 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [13233.70800,10711.56600,0.00000], [], 0, "CAN_COLLIDE"];
  _vehicle_251 = _this;
  _this setDir -273.51862;
  _this setPos [13233.70800,10711.56600,0.00000];
  MILBASE1_alarm_tower = _this;
};

_vehicle_252 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [13209.96600,10739.77100,-0.00004], [], 0, "CAN_COLLIDE"];
  _vehicle_252 = _this;
  _this setDir -4.8020239;
  _this setPos [13209.96600,10739.77100,-0.00004];
};

_vehicle_253 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [13238.69100,10641.52300,0.00000], [], 0, "CAN_COLLIDE"];
  _vehicle_253 = _this;
  _this setDir -4.0724912;
  _this setPos [13238.69100,10641.52300,0.00000];
};

_vehicle_254 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [13315.62600,10713.69800,0.00004], [], 0, "CAN_COLLIDE"];
  _vehicle_254 = _this;
  _this setDir -93.00618;
  _this setPos [13315.62600,10713.69800,0.00004];
};

_vehicle_256 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_ControlTower", [13223.14400,10688.28800,-0.08840], [], 0, "CAN_COLLIDE"];
  _vehicle_256 = _this;
  _this setDir -271.73486;
  _this setPos [13223.14400,10688.28800,-0.08840];
};

_vehicle_265 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13262.68500,10677.33700,0.00016], [], 0, "CAN_COLLIDE"];
  _vehicle_265 = _this;
  _this setDir -4.1344051;
  _this setPos [13262.68500,10677.33700,0.00016];
};

_vehicle_267 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13262.70400,10688.18100,0.00016], [], 0, "CAN_COLLIDE"];
  _vehicle_267 = _this;
  _this setDir -4.5986214;
  _this setPos [13262.70400,10688.18100,0.00016];
};

_vehicle_269 = objNull;
if (true) then
{
  _this = createVehicle ["Base_WarfareBBarrier10xTall", [13262.13600,10698.93300,-0.00007], [], 0, "CAN_COLLIDE"];
  _vehicle_269 = _this;
  _this setDir -4.5288258;
  _this setPos [13262.13600,10698.93300,-0.00007];
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["Land_deutshe_mini", [12787.766, 10750.956, 0.89399379], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 120.75343;
  _this setVehicleInit "_this setDir(getDir _this);";
  _this setPos [12787.766, 10750.956, 0.89399379];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Land_bouda2_vnitrek", [12798.491, 10765.742, 5.3405762e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir 31.025427;
  _this setPos [12798.491, 10765.742, 5.3405762e-005];
};

_vehicle_128 = objNull;
if (true) then
{
  _this = createVehicle ["Land_water_tank", [12812.059, 10759.271, -3.4332275e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_128 = _this;
  _this setDir -67.863464;
  _this setPos [12812.059, 10759.271, -3.4332275e-005];
};

_vehicle_140 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [12835.199, 10882.838, 7.6293945e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_140 = _this;
  _this setDir 100.75535;
  _this setPos [12835.199, 10882.838, 7.6293945e-006];
};

_vehicle_142 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_IlluminantTower", [12776.65, 10701.7, 0.039322291], [], 0, "CAN_COLLIDE"];
  _vehicle_142 = _this;
  _this setDir -63.257992;
  _this setPos [12776.65, 10701.7, 0.039322291];
};

_vehicle_181 = objNull;
if (true) then
{
  _this = createVehicle ["FootBridge_0_ACR", [13084.343, 10427.652, 7.0723529], [], 0, "CAN_COLLIDE"];
  _vehicle_181 = _this;
  _this setDir 19.190796;
  _this setPos [13084.343, 10427.652, 7.0723529];
};

_vehicle_183 = objNull;
if (true) then
{
  _this = createVehicle ["FootBridge_0_ACR", [13085.455, 10427.318, 7.072526], [], 0, "CAN_COLLIDE"];
  _vehicle_183 = _this;
  _this setDir 199.24754;
  _this setPos [13085.455, 10427.318, 7.072526];
};

_vehicle_193 = objNull;
if (true) then
{
  _this = createVehicle ["Land_ladderEP1", [13084.768, 10425.229, 0.37523538], [], 0, "CAN_COLLIDE"];
  _vehicle_193 = _this;
  _this setDir 18.275312;
  _this setPos [13084.768, 10425.229, 0.37523538];
};

_vehicle_198 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [13144.514, 10446.543, 9.502492], [], 0, "CAN_COLLIDE"];
  _vehicle_198 = _this;
  _this setDir 17.90099;
  _this setPos [13144.514, 10446.543, 9.502492];
};

_vehicle_200 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [13146.812, 10445.813, 9.5089502], [], 0, "CAN_COLLIDE"];
  _vehicle_200 = _this;
  _this setDir -160.13612;
  _this setPos [13146.812, 10445.813, 9.5089502];
};

_vehicle_202 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [13148.504, 10444.995, 9.4810143], [], 0, "CAN_COLLIDE"];
  _vehicle_202 = _this;
  _this setPos [13148.504, 10444.995, 9.4810143];
};

_vehicle_204 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [13149.684, 10444.764, 9.4862375], [], 0, "CAN_COLLIDE"];
  _vehicle_204 = _this;
  _this setDir 145.32478;
  _this setPos [13149.684, 10444.764, 9.4862375];
};

_vehicle_206 = objNull;
if (true) then
{
  _this = createVehicle ["FootBridge_30_ACR", [13165.244, 10336.577, 2.3365021e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_206 = _this;
  _this setDir -69.154694;
  _this setPos [13165.244, 10336.577, 2.3365021e-005];
};

_vehicle_208 = objNull;
if (true) then
{
  _this = createVehicle ["FootBridge_30_ACR", [13159.948, 10338.861, 2.5848212], [], 0, "CAN_COLLIDE"];
  _vehicle_208 = _this;
  _this setDir -70.501961;
  _this setPos [13159.948, 10338.861, 2.5848212];
};

_vehicle_221 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [13359.175, 10940.219, -26.031029], [], 0, "CAN_COLLIDE"];
  _vehicle_221 = _this;
  _this setDir 15.913928;
  _this setPos [13359.175, 10940.219, -26.031029];
};

_vehicle_223 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Scaffolding", [13368.816, 10946.003, -0.0020747799], [], 0, "CAN_COLLIDE"];
  _vehicle_223 = _this;
  _this setDir 114.57135;
  _this setPos [13368.816, 10946.003, -0.0020747799];
};

_vehicle_232 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_R2_RockWall", [13374.594, 10952.051, -16.24964], [], 0, "CAN_COLLIDE"];
  _vehicle_232 = _this;
  _this setDir 207.74423;
  _this setPos [13374.594, 10952.051, -16.24964];
};

};
