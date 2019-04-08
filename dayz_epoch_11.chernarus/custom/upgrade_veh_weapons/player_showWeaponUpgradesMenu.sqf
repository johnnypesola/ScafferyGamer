player_vehicleWeaponUpgradeMenu = [
	["", true],
	["Gun >>", [], "#USER:player_vehicleWeaponGunUpgrades", -5, [["expression", ""]], "1", "1"],
	["AT >>", [], "#USER:player_vehicleWeaponAtUpgrades", -5, [["expression", ""]], "1", "1"],
	["AA >>", [], "#USER:player_vehicleWeaponAaUpgrades", -5, [["expression", ""]], "1", "1"]
];

player_vehicleWeaponGunUpgrades = [
	["", true],
	["7.62mm", [],"",-5,[["expression","[0, 1] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"],
	[".50 cal", [],"",-5,[["expression","[0, 2] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"],
	["12.7x108", [],"",-5,[["expression","[0, 4] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"],
	["40mm", [],"",-5,[["expression","[0, 7] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"]
];

player_vehicleWeaponAtUpgrades = [
	["", true],
	["NATO", [],"",-5,[["expression","[1, 1] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"],
	["Russia", [],"",-5,[["expression","[1, 2] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"]
];

player_vehicleWeaponAaUpgrades = [
	["", true],
	["NATO", [],"",-5,[["expression","[2, 1] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"],
	["Russia", [],"",-5,[["expression","[2, 2] execVM ""custom\upgrade_veh_weapons\player_upgradeVehicleWeapons.sqf"""]], "1", "1"]
];

showCommandingMenu "#USER:player_vehicleWeaponUpgradeMenu";
