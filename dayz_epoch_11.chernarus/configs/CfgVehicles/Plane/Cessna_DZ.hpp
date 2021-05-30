class GNT_C185T_DZE
{
	class Upgrades
	{
		ItemARM[] = {"GNT_C185T_TwinM60_DZ",{"ItemToolbox","ItemSolder_DZE"},{{"ItemARM",1},{"equip_metal_sheet",2},{"ItemScrews",1},{"ItemTinBar",1},{"equip_scrapelectronics",2},{"equip_floppywire",2}}};
	};
};

class GNT_C185T_TwinM60_DZ: GNT_C185T_DZE
{
	displayname = $STR_VEH_NAME_CESSNA_M60;
	weapons[] = {"pook_M60_dual_DZ"};
	magazines[] = {"pook_1300Rnd_762x51_M60"};
};
