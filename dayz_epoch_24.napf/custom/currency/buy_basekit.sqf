private ["_buy","_base_kits","_cancel"];

//diag_log format["DEBUG TRADE METALS: %1", _x];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_103") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

{player removeAction _x} forEach s_player_parts;s_player_parts = [];
s_player_parts_crtl = 1;

_base_kits = [ 

	//["(vendors item)","(player item)",(vendorQty),playerQty),"buy","(player item description)","(vendor item description)",99]
	[
		["Ural_TK_CIV_EP1"],	// Basekit Carrier
		[
			["ItemSledge",1],
			["ItemEtool",1],
			["ItemHatchet",1],
			["ItemCrowbar",2],
			["ItemKnife",1],
			["ItemMatchbox",1],
			["ItemToolbox",2]
		],
		[
			["cinder_wall_kit", 10],
			["cinder_garage_kit",2],
			["metal_floor_kit", 12],
			["CinderBlocks", 54],
			["MortarBucket", 14],
			["ItemVault", 2],
			["ItemComboLock", 2],
			["ItemWoodWallGarageDoor", 2],
			["ItemWoodWallWithDoorLg", 2],
			["ItemWoodWallWithDoor", 2],
			["ItemWoodWallLg", 10],
			["ItemWoodWall", 10],
			["ItemWoodWallThird", 6],
			["ItemWoodFloor", 10],
			["ItemWoodFloorHalf", 5],
			["ItemWoodFloorQuarter", 5],
			["bulk_ItemTankTrap", 3],
			["bulk_PartGeneric", 4],
			["PartPlywoodPack",20],
			["PartPlankPack",20],
			["30m_plot_kit", 1],
			["ItemLightBulb", 2],
			["PartWoodPile",2]
		]
	],"ItemTopaz",1,1,"buy","Topaz","Large Base Kit",99],
	[
		["Ural_TK_CIV_EP1"],	// Basekit Carrier
		[
			["ItemSledge",1],
			["ItemEtool",1],
			["ItemHatchet",1],
			["ItemCrowbar",1],
			["ItemKnife",1],
			["ItemMatchbox",1],
			["ItemToolbox",1]
		],
		[
			["ItemVault", 1],
			["ItemComboLock", 2],
			["ItemWoodWallGarageDoor", 1],
			["ItemWoodWallWithDoorLg", 1],
			["ItemWoodWallWithDoor", 1],
			["ItemWoodWallLg", 6],
			["ItemWoodWall", 6],
			["ItemWoodWallThird", 2],
			["ItemWoodFloor", 4],
			["ItemWoodFloorHalf", 4],
			["ItemWoodFloorQuarter", 8],
			["bulk_ItemTankTrap", 1],
			["bulk_PartGeneric", 1],
			["PartPlywoodPack",20],
			["PartPlankPack",20],
			["30m_plot_kit", 1],
			["ItemLightBulb", 2],
			["PartWoodPile",2]
		]
	],"ItemBriefcase50oz",1,1,"buy","Half Briefcase","Small Base Kit",99]
];

// Static Menu
{
	//diag_log format["DEBUG TRADER: %1", _x];
	_buy = player addAction [format["Trade %1 %2 for %3 %4",(_x select 3),(_x select 5),(_x select 2),(_x select 6)], "custom/currency/trade_any_vehicle.sqf",[((_x select 0) select 0),(_x select 1),(_x select 2),(_x select 3),(_x select 4),(_x select 5),(_x select 6),((_x select 0) select 1), ((_x select 0) select 2)], (_x select 7), true, true, "",""];
	s_player_parts set [count s_player_parts,_buy];
				
} forEach _base_kits;

_cancel = player addAction ["Cancel", "\z\addons\dayz_code\actions\trade_cancel.sqf",["na"], 0, true, false, "",""];
s_player_parts set [count s_player_parts,_cancel];

DZE_ActionInProgress = false;

