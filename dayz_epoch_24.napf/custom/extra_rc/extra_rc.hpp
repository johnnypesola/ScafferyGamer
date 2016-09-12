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
 };
 class 50Rnd_127x107_DSHKM {
  class buildM2Static {
    text = "Place DShKM Static Machine Gun";
    script = "[""DSHKM_CDF""] execVM ""custom\staticmg\place_machinegun.sqf"";";
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
   text = "Make an M240 belt";
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
   text = "Merge to 200rnd M249";
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
 };
};