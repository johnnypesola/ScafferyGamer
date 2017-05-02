// Time between missions (seconds)
wai_mission_timer = 300;

// How long before a mission times out (seconds)
wai_mission_timeout = 3600;

// missions used when selecting the next random mission
wai_missions = [
"armed_vehicle",
"armed_vehicle",
"armed_vehicle",
//"crash_spawner",
"disabled_civchopper",
"disabled_civchopper",
"disabled_civchopper",
"disabled_milchopper",
"disabled_milchopper",
"disabled_milchopper",
"MV22",
"MV22",
"MV22",
"weapon_cache",
"weapon_cache",
"weapon_cache",
"convoy",
"convoy",
"convoy",
"treasure_hunt"
];

wai_missions_bandit = [
"armed_vehicle_bandit",
//"crash_spawner_bandit",
"disabled_civchopper_bandit",
"disabled_milchopper_bandit",
"MV22_bandit",
"weapon_cache_bandit",
"convoy_bandit"
//"treasure_hunt_bandit"
];


// fuel the mission vehicles spawn with 0-100.
wai_mission_fuel = 5;

// armed vehicles to spawn in missions
armed_vehicle = [
"ArmoredSUV_PMC_DZE",
"HMMWV_M998A2_SOV_DES_EP1_DZE",
"HMMWV_M1151_M2_CZ_DES_EP1_DZE",
"LandRover_Special_CZ_EP1_DZE",
"GAZ_Vodnik_DZE",
"LandRover_MG_TK_EP1_DZE",
"Offroad_DSHKM_Gue_DZE",
"Pickup_PK_GUE_DZE",
"Pickup_PK_INS_DZE",
"Pickup_PK_TK_GUE_EP1_DZE",
"UAZ_MG_TK_EP1_DZE"
];

//armed helis to spawn in missions
armed_chopper = [
"CH_47F_EP1_DZE",
"Mi17_DZE",
"UH1H_DZE",
"UH1Y_DZE",
"UH60M_EP1_DZE"
];

// civilian aircraft to spawn in missions
civil_aircraft = [
"AH6X_DZ",
"MH6J_DZ",
"Mi17_Civilian_DZ",
"AN2_DZ",
"MV22_DZ",
"CH53_DZE"
];

// military unarmed vehicles to spawn in missions
military_unarmed = [
"GAZ_Vodnik_MedEvac",
"HMMWV_Ambulance",
"HMMWV_Ambulance_CZ_DES_EP1",
"HMMWV_DES_EP1",
"HMMWV_DZ",
"HMMWV_M1035_DES_EP1",
"LandRover_CZ_EP1",
"LandRover_TK_CIV_EP1",
"UAZ_CDF",
"UAZ_INS",
"UAZ_RU",
"UAZ_Unarmed_TK_CIV_EP1",
"UAZ_Unarmed_TK_EP1",
"UAZ_Unarmed_UN_EP1"
];

// cargo trucks to spawn in missions
cargo_trucks = [
"Kamaz",
"MTVR_DES_EP1",
"Ural_CDF",
"Ural_TK_CIV_EP1",
"Ural_UN_EP1",
"V3S_Open_TK_CIV_EP1",
"V3S_Open_TK_EP1"
];

// refuel trucks to spawn in missions
refuel_trucks = [
"V3S_Refuel_TK_GUE_EP1_DZ",
"UralRefuel_TK_EP1_DZ",
"MtvrRefuel_DES_EP1_DZ",
"KamazRefuel_DZ"
];

// civilian vehicles to spawn in missions
civil_vehicles = [
"hilux1_civil_1_open",
"hilux1_civil_2_covered",
"hilux1_civil_3_open_EP1",
"SUV_Camo",
"SUV_TK_CIV_EP1",
"SUV_Blue",
"SUV_Charcoal",
"SUV_Green",
"SUV_Orange",
"SUV_Pink",
"SUV_Red",
"SUV_Silver",
"SUV_White",
"SUV_Yellow"
];

// Number of guns to spawn in ammo boxes 
wai_mission_numberofguns = 8;
// classnames of guns to spawn in ammo boxes (only class weapons)
ammo_box_guns = [
"M9SD",
"M9",
"AK74_Kobra_SD_DZ",
"AK_107_pso",
"M4A1_CCO_DZ",
"M4A1_AIM_SD_camo",
"M16A4_ACG",
"VSS_vintorez",
"M8_sharpshooter",
"M40A3",
"Mk48_CCO_DZ",
"M240_DZ",
"M249_DZ",
"Pecheneg_DZ",
"RPK_DZ",
"BAF_LRR_scoped",
"DMR",
"SVD_Camo",
"SCAR_H_LNG_Sniper_SD",
"M110_NVG_EP1",
"Sa58V_RCO_EP1",
"KSVK_DZE",
"BAF_L86A2_ACOG",
"M14_CCO_DZ",
"Sa58V_CCO_EP1"
];

// Number of tools to spawn in ammo boxes 
wai_mission_numberoftools = 1;
// classnames of tools to spawn in ammo boxes (only toolbelt items or weapon class Eg. "ChainSaw" or "ItemToolbox")
ammo_box_tools =[
"ItemToolbox",
"ItemKnife",
"ItemCrowbar",
"ItemEtool",
"Binocular",
"Binocular_Vector",
"ItemCompass",
"ItemFishingPole",
"ItemFlashlightRed",
"ItemGPS",
"ItemHatchet",
"ItemMachete",
"ItemMatchbox",
"NVGoggles",
"ChainSaw"
];

// Number of items to spawn in ammo boxes 
wai_mission_numberofitems = 10;
// classnames of items to spawn in ammo boxes (only type magazine will work here)
ammo_box_items =[
"ItemBandage",
"ItemBandage",
"ItemBandage",
"ItemBandage",
"ItemBandage",
"ItemBandage",
"ItemBandage",
"ItemBandage",
"FoodCanFrankBeans",
"FoodCanFrankBeans",
"FoodCanBakedBeans",
"FoodCanBakedBeans",
"FoodCanSardines",
"FoodCanSardines",
"FoodCanPasta",
"FoodCanPasta",
"FoodMRE",
"FoodMRE",
"ItemBloodbag",
"ItemBloodbag",
"ItemBloodbag",
"ItemBloodbag",
"ItemMorphine",
"ItemMorphine",
"ItemMorphine",
"ItemMorphine",
"ItemMorphine",
"ItemMorphine",
"ItemSodaCoke",
"ItemSodaPepsi",
"ItemSodaMdew",
"ItemSodaPepsi",
"ItemSodaCoke",
"ItemSodaPepsi",
"ItemSodaOrangeSherbet",
"ItemSodaPepsi",
"ItemSodaRbull",
"ItemSodaPepsi",
"ItemBriefcase100oz"
];

wai_mission_noftreasureguns = 1;
treasure_box_random_guns = [
"DMR",
"M4A3_CCO_EP1",
"KSVK_DZE",
"VSS_vintorez",
"M240_DZ",
"Pecheneg_DZ",
"SVD_CAMO",
"M4A1_AIM_SD_camo",
"BAF_LRR_scoped",
"M110_NVG_EP1"
];

wai_mission_noftreasureitems = 4;
treasure_box_random_items = [
"ItemBriefcase100oz",
"ItemBriefcase50oz",
"ItemBriefcase20oz",
"ItemBriefcase20oz",
"ItemGoldBar10oz",
"ItemGoldBar10oz",
"ItemGoldBar10oz",
"ItemGoldBar10oz",
"ItemBloodbag",
"ItemBloodbag",
"ItemMorphine",
"ItemMorphine",
"FoodCanFrankBeans",
"FoodCanBakedBeans",
"ItemSodaCoke",
"ItemSodaPepsi",
"ItemSodaCoke",
"ItemSodaCoke"
];


//////////////////////////////////////////////////////////////////////
WAImissionconfig = True;
