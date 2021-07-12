class AH1Z_DZE {
	class Upgrades {
		ItemARM[] = {"AH1Z_DZE1",{"ItemToolbox","ItemSolder_DZE"},{},{{"ItemARM",1},{"ItemEmerald",2}}};
	};
	script = "";
};
class AH1Z_DZE1 {
	script = "_this removeWeapon ""M197"";_this removeWeapon ""SidewinderLaucher_AH1Z"";_this removeWeapon ""HellfireLauncher"";_this removeWeaponTurret [""FFARLauncher"", [-1]];_this addWeaponTurret [""M134"", [0]];_this addWeaponTurret [""MAAWS"", [-1]];_this addWeaponTurret [""Stinger"", [-1]];_this addMagazineTurret [""2000Rnd_762x51_M134"", [0]];";
};
