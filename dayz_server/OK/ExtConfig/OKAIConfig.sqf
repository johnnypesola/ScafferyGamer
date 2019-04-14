/*
	OKAIConfig.sqf
	This is a configuration for the AI that spawn at missions.
	This includes their skin, weapons, gear, and skills.
	You can adjust these to your liking, but it is for advanced users.
*/

///////////////////////////////////////////////
// Array of skin classnames for the AI to use

OKBanditSkins1 = ["TK_INS_Bonesetter_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_4_EP1","TK_INS_Soldier_AT_EP1","TK_INS_Soldier_EP1"];
//OKBanditSkins2 = ["MVD_Soldier","RUS_Commander","RU_Soldier"];
OKBanditSkins2 = ["Bandit1_DZ","BanditW1_DZ"];
//OKBanditSkins3 = ["INS_Lopotev","INS_Bardak","INS_Commander","INS_Soldier_1","INS_Soldier_2","INS_Soldier_Medic"];
OKBanditSkins3 = ["TK_GUE_Soldier_Sniper_EP1","TK_INS_Soldier_AAT_EP1","TK_GUE_Bonesetter_EP1","TK_GUE_Soldier_3_EP1"];
//OKBanditSkins4 = ["INS_Villager3","INS_Villager4","INS_Woodlander1","INS_Woodlander2","INS_Woodlander3","GUE_Commander","GUE_Soldier_Sniper"];
OKBanditSkins4 = ["Bandit2_DZ", "BanditW2_DZ"];

////////////////////////
// Array of AI Skills
//0 - Recon
OKSkills1 = [
["aimingAccuracy",0.80],
["aimingShake",0.80],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];
//1 - Grunts
OKSkills2 = [
["aimingAccuracy",0.80],
["aimingShake",0.80],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];
//2 - Launchers and MG's
OKSkills3 = [
["aimingAccuracy",0.80],
["aimingShake",0.80],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];
//3 - Marksmen
OKSkills4 = [
["aimingAccuracy",0.80],
["aimingShake",0.80],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];


//////////////////////////////////////////////////////////////
// This is the primary weaponlist that can be assigned to AI
// These are assigned based on AI difficulty level
OKWeps1 = [
"M4A1_AIM_SD_camo",
"AKS_74_UN_Kobra",
"AKS_74_U",
"M1014_DZ",
"Remington870_FL_DZ",
"MP5_DZ",
"MP5_SD_DZ",
"G36_C_SD_Eotech",
"M4A1_HWS_GL_SD_CAMO",
"VSS_vintorez",
"SCAR_H_LNG_Sniper_SD",
"Bizon_SD_DZ",
"SCAR_H_CQC_CCO_SD"
];

OKWeps2 = [
"FNFAL_DZ",
"AK74_DZ",
"M4A1_CCO_DZ",
"AK74_Kobra_DZ",
"AKM_DZ",
"M16A4_ACOG_DZ",
"M4A3_CCO_EP1",
"Sa58V_RCO_EP1",
"Sa58V_CCO_EP1",
"Sa58P_EP1",
"Sa58V_EP1",
"M14_CCO_DZ",
"Pecheneg_DZ",
"M249_EP1_DZ",
"M240_DZ",
"DMR_DZ"
];

OKWeps3 = [
"M79_EP1",
"M32_EP1",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"SCAR_H_STD_EGLM_Spect",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M4A1_HWS_GL_camo",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"M16A2_GL_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Mk48_CCO_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"Pecheneg_DZ",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE",
"m240_scoped_EP1_DZE"
];

OKWeps4 = [
"FN_FAL_ANPVS4_DZE",
"FN_FAL_ANPVS4_DZE",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"SCAR_H_LNG_Sniper",
"M107_DZ",
"BAF_LRR_scoped",
"BAF_LRR_scoped",
"M40A3_DZ",
"M40A3_DZ",
"M40A3_DZ",
"M40A3_DZ",
"M24_DZ",
"M24_DZ",
"M24_DZ",
"M24_DZ",
"M24_des_EP1",
"M24_des_EP1",
"M24_des_EP1",
"M24_des_EP1",
"KSVK_DZE",
"SVD_DZ",
"SVD_DZ",
"SVD_DZ",
"SVD_Gh_DZ",
"SVD_Gh_DZ",
"SVD_Gh_DZ",
"SVD_PSO1_DZ",
"SVD_PSO1_DZ",
"SVD_PSO1_DZ"
];

/////////////////////////////////////////////////////////////
// These are gear sets that will be randomly given to the AI
// They are all the same, but can be customized.
// "Binocular_Vector","NVGoggles","ItemMap","ItemCompass","ItemGPS","ItemWatch","ItemKnife","Itemtoolbox","ItemCrowbar","Itemetool","ItemHatchet"
OKGear0 = [
["ItemBandage","ItemBandage","ItemPainkiller","ItemJerrycan","PartEngine","ItemMorphine","ItemGoldBar4oz"],
["ItemKnife","NVGoggles","ItemHatchet"]
];

OKGear1 = [
["ItemBandage","ItemBandage","PartFueltank","PartGlass","PartVRotor","ItemPainkiller","FoodMRE","ItemSodaCoke","ItemGoldBar2oz"],
["ItemMap","ItemCompass","ItemFlashlight","Binocular_Vector"]
];

OKGear2 = [
["ItemBandage","ItemBandage","PartWheel","ItemMorphine","ItemEpinephrine","ItemPainkiller","FoodMRE","ItemSodaCoke","ItemGoldBar4oz"],
["ItemKnife","ItemFlashlight","ItemGPS","ItemWatch"]
];

OKGear3 = [
["ItemBandage","ItemBandage","ItemPainkiller","PartGlass","PartVRotor","PartWheel","ItemSodaCoke","ItemAntibiotic","ItemBloodbag","ItemGoldBar3oz"],
["ItemKnife","ItemFlashlight","ItemRadio","Itemtoolbox","ItemCrowbar"]
];

OKGear4 = [
["ItemBandage","ItemBandage","ItemPainkiller","ItemMorphine","ItemEpinephrine","ItemPainkiller","ItemAntibiotic","ItemBloodbag","ItemGoldBar3oz"],
["ItemKnife","ItemFlashlight","ItemCompass","Itemetool","ItemHatchet"]
];

////////////////////////////////////////////////////////////
// These are the backpacks that can be assigned to AI units.
OKPacklist = [
"DZ_Czech_Vest_Pouch"
];
