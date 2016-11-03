class ExtraRc {
 class ItemFuelBarrelEmpty {
  class buildFuelTank {
    text = "Build Fuel Tank";
    script = "[""Land_Ind_TankSmall2_EP1"",[""ItemToolbox"",""ItemEtool""],[[""ItemBriefcase100oz"", 1],[""ItemFuelBarrelEmpty"", 4],[""PartGeneric"", 6]],[0,4.0,2.5]] execVM ""custom\snap_build\player_build.sqf"";";
  };
  class buildWaterBarrel {
    text = "Build Water Barrel";
    script = "[""Land_Barrel_water"",[""ItemEtool""],[[""ItemFuelBarrelEmpty"", 1]],[0,1.5,0.05]] execVM ""custom\waterbarrel\player_setupWaterBarrel.sqf"";";
  };
 };
 class cinder_garage_kit {
  class buildSmallGarage {
    text = "Build Small Garage";
    script = "[""Land_Ind_Garage01"",[""ItemToolbox"",""ItemCrowbar"",""ItemEtool""],[[""cinder_wall_kit"", 4],[""cinder_garage_kit"", 1],[""ItemTankTrap"", 4],[""cinder_door_kit"",1]],[0,6.5,2.5]] execVM ""custom\snap_build\player_build.sqf"";";
  };
  class buildLargeGarage {
    text = "Build Large Garage";
    script = "[""Land_sara_hasic_zbroj"",[""ItemToolbox"",""ItemCrowbar"",""ItemEtool""],[[""cinder_wall_kit"", 6],[""cinder_garage_kit"", 1],[""ItemTankTrap"", 3]],[0,6.0,2.5]] execVM ""custom\snap_build\player_build.sqf"";";
  };
 };
 class ItemCorrugated {
  class buildHangar {
    text = "Build Hangar";
    script = "[""Land_SS_hangar"",[""ItemToolbox"",""ItemCrowbar"",""ItemEtool""],[[""ItemSapphire"", 1],[""ItemCorrugated"", 9],[""bulk_ItemTankTrap"", 2]],[0,30.0,2.5]] execVM ""custom\snap_build\player_build.sqf"";";
  };
 };
 class PipeBomb {
  class buildTripwireBomb {
    text = "Build Tripwire Bomb";
    script = "[""Explosive"",[""ItemToolbox""],[[""PipeBomb"",1],[""ItemWire"",1]],[0,1.5,0.05]] execVM ""custom\proximitybomb\player_setTripwire.sqf"";";
  };
 };
 class 100Rnd_127x99_M2 {
  class buildM2Static {
    text = "Place M2 Static Machine Gun";
    script = "[""M2StaticMG""] execVM ""custom\staticmg\place_machinegun.sqf"";";
  };
  class convertToM107 {
   text = "Split to 10xM107";
   script = "[[""100Rnd_127x99_M2""],[""10Rnd_127x99_M107""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 50Rnd_127x107_DSHKM {
  class buildM2Static {
    text = "Place DShKM Static Machine Gun";
    script = "[""DSHKM_CDF""] execVM ""custom\staticmg\place_machinegun.sqf"";";
  };
  class convertToKSVK {
    text = "Split to 10xKSVK";
    script = "[[""50Rnd_127x107_DSHKM""],[""5Rnd_127x108_KSVK""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class ItemRadio {
  class GroupManagement {
   text = "Group Management";
   script = "execVM 'dzgm\loadGroupManagement.sqf'";
  };
 };
 class FoodSunFlowerSeed {
  class plantSunflowerSeeds {
   text = "Plant sunflower seeds";
   script = "[""MAP_p_Helianthus"",[""ItemEtool""],[[""FoodSunFlowerSeed"", 1]],[0,1.5,0.05], ""sunflower seed""] execVM ""custom\plant\player_plantStuff.sqf"";";
  };
 };
 class 20Rnd_762x51_DMR {
  class convertToM240 {
   text = "Make M240 belt";
   script = "[[""20Rnd_762x51_DMR""],[""100Rnd_762x51_M240""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 30Rnd_9x19_UZI {
  class convertToMP5 {
   text = "Convert for MP5";
   script = "[[""30Rnd_9x19_UZI""],[""30Rnd_9x19_MP5""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 30Rnd_9x19_MP5 {
  class convertToUZI {
   text = "Convert for PDW";
   script = "[[""30Rnd_9x19_MP5""],[""30Rnd_9x19_UZI""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 100Rnd_556x45_M249 {
  class convertToMG36 {
   text = "Convert for MG36";
   script = "[[""100Rnd_556x45_M249""],[""100Rnd_556x45_BetaCMag""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
  class convertTo200Rnd {
   text = "Merge to 200rnd M249";
   script = "[[""100Rnd_556x45_M249""],[""200Rnd_556x45_M249""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 100Rnd_556x45_BetaCMag {
  class convertToM249 {
   text = "Convert to 100rnd M249";
   script = "[[""100Rnd_556x45_BetaCMag""],[""100Rnd_556x45_M249""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
  class convertTo200Rnd {
   text = "Make 200rnd M249 belt";
   script = "[[""100Rnd_556x45_BetaCMag""],[""200Rnd_556x45_M249""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 8Rnd_B_Saiga12_74Slug {
  class convertToM1014 {
   text = "Convert for M1014";
   script = "[[""8Rnd_B_Saiga12_74Slug""],[""8Rnd_B_Beneli_74Slug""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 8Rnd_B_Beneli_74Slug {
  class convertToSaiga12K {
   text = "Convert for Saiga12k";
   script = "[[""8Rnd_B_Beneli_74Slug""],[""8Rnd_B_Saiga12_74Slug""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 8Rnd_B_Saiga12_Pellets {
  class convertToM1014 {
   text = "Convert for M1014";
   script = "[[""8Rnd_B_Saiga12_Pellets""],[""8Rnd_B_Beneli_Pellets""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 8Rnd_B_Beneli_Pellets {
  class convertToSaiga12K {
   text = "Convert for Saiga12k";
   script = "[[""8Rnd_B_Beneli_Pellets""],[""8Rnd_B_Saiga12_Pellets""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 200Rnd_556x45_M249 {
  class convertTo100Rnd {
   text = "Split to 2x100";
   script = "[[""200Rnd_556x45_M249""],[""100Rnd_556x45_M249""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
  class convertToMG36 {
   text = "Split to 2x100 MG36";
   script = "[[""200Rnd_556x45_M249""],[""100Rnd_556x45_BetaCMag""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 100Rnd_762x51_M240 {
  class convertToDMR {
   text = "Split into DMR mags";
   script = "[[""100Rnd_762x51_M240""],[""20Rnd_762x51_DMR""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
  class convertToFNFAL {
   text = "Split into FNFAL mags";
   script = "[[""100Rnd_762x51_M240""],[""20Rnd_762x51_FNFAL""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 1Rnd_HE_M203 {
  class convertTo6Rnd {
   text = "Combine into M32 shells";
   script = "[[""1Rnd_HE_M203""],[""6Rnd_HE_M203""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 6Rnd_HE_M203 {
  class convertTo1Rnd {
   text = "Split into 6x1 HE M203";
   script = "[[""6Rnd_HE_M203""],[""1Rnd_HE_M203""], %1] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 20Rnd_762x51_FNFAL {
  class convertToM240 {
   text = "Make M240 belt";
   script = "[[""20Rnd_762x51_FNFAL""],[""100Rnd_762x51_M240""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 10Rnd_127x99_M107 {
  class convertToM2 {
   text = "Make M2 belt";
   script = "[[""10Rnd_127x99_M107""],[""100Rnd_127x99_M2""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };
 class 5Rnd_127x108_KSVK {
  class convertToDShKM {
   text = "Make DShKM belt";
   script = "[[""5Rnd_127x108_KSVK""],[""50Rnd_127x107_DSHKM""]] execVM ""custom\ammo_tools\player_convertMags.sqf"";";
  };
 };

 class ItemObsidian {
  class buildBed {
   text = "Build Spawn Bed";
   script = "[""MAP_F_postel_manz_kov"",[""ItemToolbox"",""ItemCrowbar"",""ItemHatchet_DZE""],[[""ItemObsidian"", 1],[""PartGeneric"", 1],[""PartWoodLumber"", 5]],[-1.0,1.5,0.05]] execVM ""custom\spawn_bed\player_setupSpawnBed.sqf"";";
  };
 };
 class ItemRuby {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };    
 class ItemEmerald {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };    
 class ItemSapphire {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };    
 class ItemTopaz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };    
 class ItemGoldBar {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };    
 class ItemGoldBar2oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar3oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar4oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar5oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar6oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar7oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar8oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar9oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemGoldBar10oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar2oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar3oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar4oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar5oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar6oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar7oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar8oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar9oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemSilverBar10oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseEmpty {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase10oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase20oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase30oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase40oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase50oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase60oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase70oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase80oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase90oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcase100oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS10oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS20oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS30oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS40oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS50oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS60oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS70oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS80oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS90oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
 class ItemBriefcaseS100oz {
  class Combine {
   text = "COMBINE ALL";
   script = "execVM 'custom\currency\combineCurrency.sqf'";
  };
 };
};
