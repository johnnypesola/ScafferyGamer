/*
delete object from db with extra waiting by [VB]AWOL
parameters: _obj
*/
private ["_activatingPlayer","_obj","_objectID","_objectUID","_started","_finished","_animState","_isMedic","_isOk","_proceed","_counter","_limit","_objType","_sfx","_dis","_itemOut","_countOut","_selectedRemoveOutput","_friendlies","_nearestPole","_ownerID","_refundpart","_isWreck","_isMilitaryWreck","_findNearestPoles","_findNearestPole","_IsNearPlot","_brokenTool","_removeTool","_isDestructable","_isRemovable","_objOwnerID","_isOwnerOfObj","_preventRefund","_ipos","_item","_radius","_isWreckBuilding","_nameVehicle","_isModular"];

// normally in variables.sqf, ADDED for deconstructible
//DZE_isRemovable = ["Fence_corrugated_DZ","M240Nest_DZ","ParkBench_DZ","Plastic_Pole_EP1_DZ","FireBarrel_DZ","Scaffolding_DZ"];
DZE_isRemovable = ["Fence_corrugated_DZ","M240Nest_DZ","ParkBench_DZ","Plastic_Pole_EP1_DZ","FireBarrel_DZ","Scaffolding_DZ","CanvasHut_DZ","DeerStand_DZ","DesertCamoNet_DZ","DesertLargeCamoNet_DZ","ForestCamoNet_DZ","ForestLargeCamoNet_DZ","GunRack_DZ","LightPole_DZ","MetalGate_DZ","OutHouse_DZ","StickFence_DZ","StorageShed_DZ","Wooden_shed_DZ","WoodShack_DZ","Land_Barrel_water","Land_Barrel_empty"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_88") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

player removeAction s_player_deleteBuild;
s_player_deleteBuild = 1;

_obj = _this select 3;

_activatingPlayer = player;

_objOwnerID = _obj getVariable["CharacterID","0"];
_isOwnerOfObj = (_objOwnerID == dayz_characterID);

// ADDED FOR deconstructable
_isModularItem = _obj isKindOf "ModularItems" or _obj isKindOf "Land_DZE_WoodDoor_Base" or _obj isKindOf "CinderWallDoor_DZ_Base";
_isLockableDoor = _obj isKindOf "Land_DZE_WoodDoorLocked_Base" or _obj isKindOf "CinderWallDoorLocked_DZ_Base";
if(_isModularItem and (!_isOwnerOfObj and !((getPlayerUID player) in ["139051526"]))) exitWith {TradeInprogress = false; DZE_ActionInProgress = false; cutText ["Cannot remove item: You're not the owner.", "PLAIN DOWN"];};

if (_obj in DZE_DoorsLocked) exitWith { DZE_ActionInProgress = false; cutText [(localize "STR_EPOCH_ACTIONS_20"), "PLAIN DOWN"];};
if(_obj getVariable ["GeneratorRunning", false]) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_89"), "PLAIN DOWN"];};

_objectID 	= _obj getVariable ["ObjectID","0"];
_objectUID	= _obj getVariable ["ObjectUID","0"];

_isOk = true;
_proceed = false;
_objType = typeOf _obj;

// Chance to break tools
_isDestructable = _obj isKindOf "BuiltItems";
_isWreck = _objType in DZE_isWreck;
_isMilitaryWreck = _objType in ["HMMWVWreck"];
_isRemovable = _objType in DZE_isRemovable;
_isWreckBuilding = _objType in DZE_isWreckBuilding;
_isMine = _objType in ["Land_iron_vein_wreck","Land_silver_vein_wreck","Land_gold_vein_wreck"];
_isModular = _obj isKindOf "ModularItems";

_limit = 3;
if (DZE_StaticConstructionCount > 0) then {
	_limit = DZE_StaticConstructionCount;
}
else {
	if (isNumber (configFile >> "CfgVehicles" >> _objType >> "constructioncount")) then {
		_limit = getNumber(configFile >> "CfgVehicles" >> _objType >> "constructioncount");
	};
};

_findNearestPoles = nearestObjects[player, ["Plastic_Pole_EP1_DZ"], 30];
_findNearestPole = [];
{if (alive _x) then {_findNearestPole set [(count _findNearestPole),_x];};} count _findNearestPoles;

_IsNearPlot = count (_findNearestPole);

if(_IsNearPlot >= 1) then {

	_nearestPole = _findNearestPole select 0;

	// Find owner
	_ownerID = _nearestPole getVariable["CharacterID","0"];

	// check if friendly to owner
	if(dayz_characterID != _ownerID) then {

		_friendlies		= player getVariable ["friendlyTo",[]];
		// check if friendly to owner
		if(!(_ownerID in _friendlies)) then {
			_limit = round(_limit*2);
		};
	};
};

_nameVehicle = getText(configFile >> "CfgVehicles" >> _objType >> "displayName");

cutText [format[(localize "str_epoch_player_162"),_nameVehicle], "PLAIN DOWN"];

if (_isModular) then {
     //allow previous cutText to show, then show this if modular.
     cutText [(localize "STR_EPOCH_ACTIONS_21"), "PLAIN DOWN"];
};

// Alert zombies once.
[player,50,true,(getPosATL player)] spawn player_alertZombies;

_brokenTool = false;

// Start de-construction loop
_counter = 0;
while {_isOk} do {

	// if object no longer exits this should return true.
	if(isNull(_obj)) exitWith {
		_isOk = false;
		_proceed = false;
	};
	[1,1] call dayz_HungerThirst;
	player playActionNow "Medic";
	_dis=20;
	[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

	r_interrupt = false;
	_animState = animationState player;
	r_doLoop = true;
	_started = false;
	_finished = false;

	while {r_doLoop} do {
		_animState = animationState player;
		_isMedic = ["medic",_animState] call fnc_inString;
		if (_isMedic) then {
			_started = true;
		};
		if (_started && !_isMedic) then {
			r_doLoop = false;
			_finished = true;
			_sfx = "repair";
			[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		};
		if (r_interrupt) then {
			r_doLoop = false;
		};

		sleep 0.1;

	};

	if(!_finished) exitWith {
		_isOk = false;
		_proceed = false;
	};

	if(_finished) then {
		_counter = _counter + 1;
		// 10% chance to break a required tool each pass
		if((_isDestructable || _isRemovable) && !_isOwnerOfObj) then {
			if((random 10) <= 1) then {
				_brokenTool = true;
			};
		};
	};
	if(_brokenTool) exitWith {
		_isOk = false;
		_proceed = false;
	};

	cutText [format[(localize "str_epoch_player_163"), _nameVehicle, _counter,_limit], "PLAIN DOWN"];

	if(_counter == _limit) exitWith {
		_isOk = false;
		_proceed = true;
	};

};



if(_brokenTool) then {
	if(_isWreck) then {
		_removeTool = "ItemToolbox";
	} else {
		_removeTool = ["ItemCrowbar","ItemToolbox"] call BIS_fnc_selectRandom;
	};
	if(([player,_removeTool,1] call BIS_fnc_invRemove) > 0) then {
		cutText [format[(localize "str_epoch_player_164"),getText(configFile >> "CfgWeapons" >> _removeTool >> "displayName"),_nameVehicle], "PLAIN DOWN"];
	};
};

// Remove only if player waited
if (_proceed) then {

	// Double check that object is not null
	if(!isNull(_obj)) then {

		_ipos = getPosATL _obj;
		// ADDED FOR deconstructable
		if (_isLockableDoor and {_obj animationPhase "Open_hinge" == 0}) exitWith {TradeInprogress = false; cutText ["Cannot remove locked door.", "PLAIN DOWN"];};

		deleteVehicle _obj;

		if(!_isWreck) then {
			PVDZE_obj_Delete = [_objectID,_objectUID,_activatingPlayer];
			publicVariableServer "PVDZE_obj_Delete";
		};

		cutText [format[(localize "str_epoch_player_165"),_nameVehicle], "PLAIN DOWN"];

		_preventRefund = false;

		_selectedRemoveOutput = [];
		if(_isWreck) then {

			if(_isMilitaryWreck) then {
				// Find one random part to give back + chance to get M2 ammo
				_refundpart = ["PartEngine","PartGeneric","PartFueltank","PartWheel","PartGlass","ItemJerrycan","PartEngine","PartGeneric","PartFueltank","PartWheel","PartGlass","ItemJerrycan","100Rnd_127x99_M2"] call BIS_fnc_selectRandom;
			} else {
				// Find one random part to give back
				_refundpart = ["PartEngine","PartGeneric","PartFueltank","PartWheel","PartGlass","ItemJerrycan"] call BIS_fnc_selectRandom;
			};
			_selectedRemoveOutput set [count _selectedRemoveOutput,[_refundpart,1]];
		} else {
			if(_isWreckBuilding) then {
				_selectedRemoveOutput = getArray (configFile >> "CfgVehicles" >> _objType >> "removeoutput");
			} else {
				switch (_objType) do
				{
					// MODULAR BUILDABLES

					case "BagFenceRound_DZ":
					{                                                
						_selectedRemoveOutput = [["BagFenceRound_DZ_kit",1]];
						hint format ["Deconstruction found Round Sandbag - %1",_objType];
					};
					case "CanvasHut_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemCanvas",1],["PartWoodLumber",4]];
						hint format ["Deconstruction found Sun Shade Hut - %1",_objType];
					};
					case "CinderWall_DZ":
					{                                            
						_selectedRemoveOutput = [["CinderBlocks",7],["MortarBucket",2]];
						hint format ["Deconstruction found Cinder Wall - %1",_objType];
					};
					case "CinderWallDoor_DZ":
					{                                                
						_selectedRemoveOutput = [["CinderBlocks",3],["MortarBucket",1],["ItemTankTrap",4],["PartGeneric",6]];
						hint format ["Deconstruction found Cinder Garage Door - %1",_objType];
					};
					case "CinderWallDoorSmall_DZ":
					{                                                
						_selectedRemoveOutput = [["CinderBlocks",3],["MortarBucket",1],["ItemTankTrap",2],["PartGeneric",2]];
						hint format ["Deconstruction found Cinder Small Wall Door - %1",_objType];
					};
					case "CinderWallDoorway_DZ":
					{                                                
						_selectedRemoveOutput = [["CinderBlocks",3],["MortarBucket",1],["ItemTankTrap",1]];
						hint format ["Deconstruction found Cinder Garage Doorway - %1",_objType];
					};
					case "CinderWallHalf_DZ":
					{                                                
						_selectedRemoveOutput = [["CinderBlocks",3],["MortarBucket",1]];
						hint format ["Deconstruction found Cinder Half Wall - %1",_objType];
					};
					case "CinderWallSmallDoorway_DZ":
					{                                                
						_selectedRemoveOutput = [["CinderBlocks",4],["MortarBucket",1],["ItemTankTrap",1]];
						hint format ["Deconstruction found Cinder Small Wall Doorway - %1",_objType];
					};
					case "DeerStand_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",8],["PartWoodPile",2]];
						hint format ["Deconstruction found Deer Stand - %1",_objType];
					};
					case "Fence_corrugated_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",2],["ItemTankTrap",1],["PartWoodLumber",1]];
						hint format ["Deconstruction found Corrugated Fence - %1",_objType];
					};
					case "FireBarrel_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemFuelBarrelEmpty",1]];
						hint format ["Deconstruction found Fire Barrel - %1",_objType];
					};
					case "Fort_RazorWire":
					{                                                
						_selectedRemoveOutput = [["ItemWire",1]];
						hint format ["Deconstruction found Razor Wire - %1",_objType];
					};
					case "FuelPump_DZ":
					{                                                
						_selectedRemoveOutput = [["fuel_pump_kit",1]];
						hint format ["Deconstruction found Fuel Tank Pump - %1",_objType];
					};
					case "Generator_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemGenerator",1]];
						hint format ["Deconstruction found Power Generator - %1",_objType];
					};
					case "GunRack_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",6]];
						hint format ["Deconstruction found Gunrack - %1",_objType];
					};
					case "Hedgehog_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemTankTrap",1]];
						hint format ["Deconstruction found Tank Trap - %1",_objType];
					};
					case "Land_DZE_GarageWoodDoor":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10],["PartWoodPlywood",10]];
						hint format ["Deconstruction found Wood Garage Door - %1",_objType];
					};
					case "Land_DZE_LargeWoodDoor":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",11],["PartWoodPlywood",11]];
						hint format ["Deconstruction found Large Wood Wall with Door - %1",_objType];
					};
					case "Land_DZE_WoodDoor":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",11],["PartWoodPlywood",9]];
						hint format ["Deconstruction found Small Wood Wall with Door - %1",_objType];
					};                                                                             
					case "Land_HBarrier1_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemSandbag",3],["ItemTankTrap",1],["ItemWire",1]];
						hint format ["Deconstruction found H Barrier 1 - %1",_objType];
					};
					case "Land_HBarrier3_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemSandbag",9],["ItemTankTrap",3],["ItemWire",3]];
						hint format ["Deconstruction found H Barrier 3 - %1",_objType];
					};
					case "Land_HBarrier5_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemSandbagExLarge5x",1]];
						hint format ["Deconstruction found H Barrier 5 - %1",_objType];
					};
					case "LightPole_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",6],["PartGeneric",1],["ItemLightBulb",1]];
						hint format ["Deconstruction found Light Pole - %1",_objType];
					};
					case "MetalFloor_DZ":
					{                                                
						_selectedRemoveOutput = [["bulk_PartGeneric",2],["bulk_ItemTankTrap",2],["PartGeneric",8],["ItemTankTrap",2]];
						hint format ["Deconstruction found Metal Floor - %1",_objType];
					};
					case "MetalGate_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",6],["ItemTankTrap",1]];
						hint format ["Deconstruction found Rusty Metal Gate - %1",_objType];
					};
					case "MetalPanel_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",8],["ItemTankTrap",4]];
						hint format ["Deconstruction found  Metal Panel - %1",_objType];
					};
					case "OutHouse_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",2],["ItemTankTrap",1],["PartWoodLumber",2],["PartWoodPlywood",1],["ItemTrashToiletpaper",1]];
						hint format ["Deconstruction found Outhouse - %1",_objType];
					};
					case "ParkBench_DZ":
					{                                                
						_selectedRemoveOutput = [["park_bench_kit",1]];
						hint format ["Deconstruction found Park Bench - %1",_objType];
					};
					case "Sandbag1_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemSandbag",1]];
						hint format ["Deconstruction found Sandbag - %1",_objType];
					};
					case "SandNest_DZ":
					{                                                
						_selectedRemoveOutput = [["ItemSandbag",4],["PartWoodPlywood",2],["PartWoodLumber",4]];
						hint format ["Deconstruction found Sandbag Nest - %1",_objType];
					};
					case "StickFence_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodPile",6]];
						hint format ["Deconstruction found Stick Fence - %1",_objType];
					};
					case "StorageShed_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",8],["ItemTankTrap",4],["PartWoodLumber",6],["PartWoodPlywood",2]];
						hint format ["Deconstruction found Storage Shed - %1",_objType];
					};
					case "Wooden_shed_DZ":
					{                                                
						_selectedRemoveOutput = [["PartGeneric",8],["ItemTankTrap",4],["PartWoodLumber",8],["PartWoodPlywood",4]];
						hint format ["Deconstruction found Wooden Shed - %1",_objType];
					};
					case "WoodFloor_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",12],["PartWoodPlywood",12]];
						hint format ["Deconstruction found Wooden Floor - %1",_objType];
					};
					case "WoodFloorHalf_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",6],["PartWoodPlywood",6]];
						hint format ["Deconstruction found Wood Floor 1/2 - %1",_objType];
					};
					case "WoodFloorQuarter_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",3],["PartWoodPlywood",3]];
						hint format ["Deconstruction found Wood Floor 1/4 - %1",_objType];
					};                                                                             
					case "WoodLadder_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",8]];
						hint format ["Deconstruction found Wood Ladder - %1",_objType];
					};
					case "WoodLargeWall_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10],["PartWoodPlywood",10]];
						hint format ["Deconstruction found Large Wood Wall - %1",_objType];
					};
					case "WoodLargeWallDoor_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10],["PartWoodPlywood",10]];
						hint format ["Deconstruction found Large Wood Wall with Doorway - %1",_objType];
					};
					case "WoodLargeWallWin_DZ ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10],["PartWoodPlywood",10],["PartGlass",1]];
						hint format ["Deconstruction found Large Wood Wall with Window - %1",_objType];
					};
					case "WoodRamp_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",8]];
						hint format ["Deconstruction found Wood Ramp - %1",_objType];
					};
					case "WoodShack_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",4],["PartWoodPlywood",4]];
						hint format ["Deconstruction found Wood Shack - %1",_objType];
					};
					case "WoodSmallWall_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",9],["PartWoodPlywood",9]];
						hint format ["Deconstruction found Small Wood Wall - %1",_objType];
					};
					case "WoodSmallWallDoor_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10],["PartWoodPlywood",10]];
						hint format ["Deconstruction found Small Wood Wall with Doorway - %1",_objType];
					};
					case "WoodSmallWallThird_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",3],["PartWoodPlywood",3]];
						hint format ["Deconstruction found Wood Wall 1/3 - %1",_objType];
					};
					case "WoodSmallWallWin_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",9],["PartWoodPlywood",9],["PartGlass",1]];
						hint format ["Deconstruction found Small Wood Wall with Window - %1",_objType];
					};
					case "WoodStairs_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",10]];
						hint format ["Deconstruction found Wood Stairs with Supports - %1",_objType];
					};
					case "WoodStairsSans_DZ":
					{                                                
						_selectedRemoveOutput = [["PartWoodLumber",8]];
						hint format ["Deconstruction found Wood Stairs without Supports - %1",_objType];
					};
					case "Plastic_Pole_EP1_DZ":
					{
						_selectedRemoveOutput = [["30m_plot_kit",1]];
						hint format ["Deconstruction found 30m Plot Pole - %1",_objType];
					};
					case "WorkBench_DZ":
					{
						_selectedRemoveOutput = [["PartWoodLumber",2],["PartWoodPlywood",1]];
						hint format ["Deconstruction found Workbench - %1",_objType];
					};
					case "M2StaticMG":
					{
						_selectedRemoveOutput = [["100Rnd_127x99_M2",1],["ItemPole",3],["PartGeneric",1],["ItemTankTrap",1]];
						hint format ["Deconstruction found M2 Machine gun - %1",_objType];
					};
					case "Land_Barrel_water":
					{
						_selectedRemoveOutput = [["ItemFuelBarrelEmpty", 1]];
						hint format ["Deconstruction found Empty Barrel - %1",_objType];
					};
					//case "Land_Ind_TankSmall2_EP1":
					//{
					//	_selectedRemoveOutput = [["ItemFuelBarrel", 4],["PartGeneric", 6]];
					//	hint format ["Deconstruction found Fuel Tank - %1",_objType];
					//};
					//case "Land_Ind_Garage01":
					//{
					//	_selectedRemoveOutput = [["cinder_wall_kit", 4],["cinder_garage_kit", 1],["ItemTankTrap", 4],["cinder_door_kit",1]];
					//	hint format ["Deconstruction found Small Garage - %1",_objType];
					//};
					//case "Land_sara_hasic_zbroj":
					//{
					//	_selectedRemoveOutput = [["cinder_wall_kit", 6],["cinder_garage_kit", 1],["ItemTankTrap", 3]];
					//	hint format ["Deconstruction found Large Garage - %1",_objType];
					//};
					//case "Land_SS_hangar":
					//{
					//	_selectedRemoveOutput = [["ItemSapphire", 1],["ItemCorrugated", 9],["bulk_ItemTankTrap", 2]];
					//	hint format ["Deconstruction found Hangar - %1",_objType];
					//};

					// BUILDABLES - WITH COMBINATION LOCK
					// OTHER BUILDABLES

					//fuel_pump_kit (no fuel tank requirement)
					//ItemFuelPump (requires fuel tank within 30m)
				};
				//_selectedRemoveOutput = getArray (configFile >> "CfgVehicles" >> _objType >> "removeoutput");
				//_preventRefund = (_objectID == "0" && _objectUID == "0");

			};
		};

		if((count _selectedRemoveOutput) <= 0) then {
			cutText [(localize "str_epoch_player_90"), "PLAIN DOWN"];
		};

		if (_ipos select 2 < 0) then {
			_ipos set [2,0];
		};

		_radius = 1;

		if (_isMine) then {
			if((random 1000) <= 1) then {
				_selectedRemoveOutput set [(count _selectedRemoveOutput),["ItemRuby",1]];
			} else {
				if ((random 500) <= 1) then {
					_selectedRemoveOutput set [(count _selectedRemoveOutput),["ItemEmerald",1]];
				} else {
					if ((random 200) <= 1) then {
						_selectedRemoveOutput set [(count _selectedRemoveOutput),["ItemSapphire",1]];
					} else {
						if ((random 100) <= 1) then {
							_selectedRemoveOutput set [(count _selectedRemoveOutput),["ItemTopaz",1]];
						} else {
							if ((random 50) <= 4) then {
								_gems = ["ItemObsidian","ItemAmethyst","ItemCitrine"];
								_gem = _gems select (floor(random (count _gems)));
								_selectedRemoveOutput set [(count _selectedRemoveOutput),[_gem,1]];
							};
						};
					};
				};
			};
		};
		// give refund items
		if((count _selectedRemoveOutput) > 0 && !_preventRefund) then {
			_item = createVehicle ["WeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
			{
				_itemOut = _x select 0;
				_countOut = _x select 1;
				if (typeName _countOut == "ARRAY") then {
					_countOut = round((random (_countOut select 1)) + (_countOut select 0));
				};
				_item addMagazineCargoGlobal [_itemOut,_countOut];
			} count _selectedRemoveOutput;

			_item setposATL _iPos;

			player reveal _item;

			player action ["Gear", _item];
		};
	} else {
		cutText [(localize "str_epoch_player_91"), "PLAIN DOWN"];
	};

} else {
	r_interrupt = false;
	if (vehicle player == player) then {
		[objNull, player, rSwitchMove,""] call RE;
		player playActionNow "stop";
	};
};
DZE_ActionInProgress = false;
s_player_deleteBuild = -1;
