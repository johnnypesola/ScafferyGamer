// [_object,_type] spawn server_updateObject;
#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"
if (isNil "sm_done") exitWith {};
private ["_class","_objectID","_objectUID","_object_position","_isNotOk","_object","_type","_recorddmg","_forced","_lastUpdate","_needUpdate","_object_inventory","_object_damage","_objWallDamage","_object_killed","_object_maintenance","_object_variables","_totalDmg"];

_object = _this select 0;
_type = _this select 1;
_recorddmg = false;
_isNotOk = false;
_forced = if (count _this > 2) then {_this select 2} else {false};
_totalDmg = if (count _this > 3) then {_this select 3} else {false};
_objectID = "0";
_objectUID = "0";

if ((isNil "_object") || {isNull _object}) exitWith {diag_log "server_updateObject.sqf _object null or nil, could not update object"};
_objectID = _object getVariable ["ObjectID","0"];
_objectUID = _object getVariable ["ObjectUID","0"];
_class = typeOf _object;

if (typeName _objectID != "STRING" or (typeName _objectUID != "STRING")) then {
	#ifdef OBJECT_DEBUG
		diag_log (format["Non-string Object: ID %1 UID %2", _objectID, _objectUID]);
	#endif
	//force fail
	_objectID = nil;
	_objectUID = nil;
};

// Epoch Admin Tools
if ((_object getVariable ["MalSar", 0]) == 1) exitWith {};

// Do not update MGs, let them expire
if (_class in ["M2StaticMG","DSHKM_CDF"]) exitWith {};

if (!(_class in DZE_safeVehicle) && !locked _object) then {
	//diag_log format["Object: %1, ObjectID: %2, ObjectUID: %3",_object,_objectID,_objectUID];
	if (!(_objectID in dayz_serverIDMonitor) && isNil {_objectUID}) then { 
		//force fail
		_objectID = nil;
		_objectUID = nil;		
	};
	if ((isNil {_objectID}) && (isNil {_objectUID})) then {
		_object_position = getPosATL _object;
		#ifdef OBJECT_DEBUG
			diag_log format["Object %1 with invalid ID at pos %2",_class,_object_position];
		#endif
		_isNotOk = true;
	};
};

if (_isNotOk) exitWith {
	//deleteVehicle _object;
};

_lastUpdate = _object getVariable ["lastUpdate",diag_tickTime];
_needUpdate = _object in needUpdate_objects;

// TODO ----------------------
_object_position = {
	private ["_position","_worldspace","_fuel","_key","_query"];	// extDB2
	_position = getPosATL _object;
	//_worldspace = [round (direction _object),_position];
	//_worldspace = [getDir _object, _position] call AN_fnc_formatWorldspace; // Precise Base Building 1.0.5	// extDB2
	_worldspace = [getDir _object, _position];
	_fuel = if (_class isKindOf "AllVehicles") then {fuel _object} else {0};

	// extDB2
	//_key = format["CHILD:305:%1:%2:%3:",_objectID,_worldspace,_fuel];
	//_key call server_hiveWrite;	
	_key = [
		_objectID,
		((_worldspace select 1) select 0) call KK_fnc_floatToString,	// x
		((_worldspace select 1) select 1) call KK_fnc_floatToString,	// y
		((_worldspace select 1) select 2) call KK_fnc_floatToString,	// z
		(_worldspace select 0) call KK_fnc_floatToString,		// dir
		_fuel
	];
	_query = ["vehicleMoved",_key] call dayz_prepareDataForDB;
	_query call server_hiveWrite;

	#ifdef OBJECT_DEBUG
		//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
		//diag_log ("HIVE: WRITE: "+ str(_query));
	#endif
};

_object_inventory = {
	private ["_inventory","_key","_query","_isNormal","_coins"];
	if (_class isKindOf "TrapItems") then {
		_inventory = [["armed",_object getVariable ["armed",false]]];
	} else {
		_isNormal = true;
		
		if (DZE_permanentPlot && (_class == "Plastic_Pole_EP1_DZ")) then {
			_isNormal = false;
			_inventory = _object getVariable ["plotfriends", []]; //We're replacing the inventory with UIDs for this item
		};
		
		if (DZE_doorManagement && (_class in DZE_DoorsLocked)) then {
			_isNormal = false;
			_inventory = _object getVariable ["doorfriends", []]; //We're replacing the inventory with UIDs for this item
		};

		if (_isNormal) then {
			_inventory = [getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object];
		};
		//diag_log format["DEBUG: %1 inv: %2", _objectID, _inventory];
	};
	
	_previous = str(_object getVariable["lastInventory",[]]);
	if (str _inventory != _previous) then {
		_object setVariable["lastInventory",_inventory];
		if (_objectID == "0") then {
			// extDB2
			//_key = format["CHILD:309:%1:",_objectUID] + str _inventory + ":";
			if (Z_SingleCurrency) then {
				_coins = _object getVariable [Z_MoneyVariable, -1];
			} else {
				_coins = -1;
			};
			if (_isNormal) then {
				_key = [_objectUID, _inventory select 1, _inventory select 0, _inventory select 2, _coins];
			} else {
				_key = [_objectID, _inventory, [[],[]], [[],[]], _coins];
			};
			_query = ["objectInventoryByUID",_key] call dayz_prepareDataForDB;
		} else {
			// extDB2
			//_key = format["CHILD:303:%1:",_objectID] + str _inventory + ":";
			if (Z_SingleCurrency) then {
				_coins = _object getVariable [Z_MoneyVariable, -1]; //set to invalid value if getVariable fails to prevent overwriting of coins in DB
				//_key = _key + str _coins + ":";	// extDB2
			} else {
				_coins = -1;
			};
			if (_isNormal) then {
				_key = [_objectID, _inventory select 1, _inventory select 0, _inventory select 2, _coins];
			} else {
				_key = [_objectID, _inventory, [[],[]], [[],[]], _coins];
			};
			_query = ["objectInventoryByID",_key] call dayz_prepareDataForDB;
		};
		
		#ifdef OBJECT_DEBUG
			//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
			diag_log ("HIVE: WRITE: "+ str(_query));
		#endif
		
		//_key call server_hiveWrite;	// extDB2
		_query call server_hiveWrite;
	};
};

_object_damage = {
	//Allow dmg process
	private ["_hitpoints","_array","_hit","_selection","_key","_query","_damage","_allFixed"];	// extDB2
	_hitpoints = _object call vehicle_getHitpoints;
	_damage = damage _object;
	_array = [];
	_allFixed = true;
	
	{
		_hit = [_object,_x] call object_getHit;
		_selection = getText (configFile >> "CfgVehicles" >> _class >> "HitPoints" >> _x >> "name");
		if (_hit > 0) then {
			_allFixed = false;
			_array set [count _array,[_selection,_hit]];
			//diag_log format ["Section Part: %1, Dmg: %2",_selection,_hit]; 
		} else {
			_array set [count _array,[_selection,0]]; 
		};
	} forEach _hitpoints;
	
	if (_allFixed && !_totalDmg) then {_object setDamage 0;};
	
	if (_forced) then {        
		if (_object in needUpdate_objects) then {needUpdate_objects = needUpdate_objects - [_object];};
		_recorddmg = true;	       
	} else {
		//Prevent damage events for the first 10 seconds of the servers live.
		if (diag_ticktime - _lastUpdate > 10) then {
			if !(_object in needUpdate_objects) then {
				//diag_log format["DEBUG: Monitoring: %1",_object];
				needUpdate_objects set [count needUpdate_objects, _object];
				_recorddmg = true;
			};
		};
	};
	
	if (_recorddmg) then {
		if (_objectID == "0") then {
			//_key = format["CHILD:306:%1:",_objectUID] + str _array + ":" + str _damage + ":";	// extDB2
			_key = [_objectUID, _array,_damage];
			_query = ["vehicleDamagedByID",_key] call dayz_prepareDataForDB;
		} else {
			//_key = format["CHILD:306:%1:",_objectID] + str _array + ":" + str _damage + ":";	// extDB2
			_key = [_objectID, _array,_damage];
			_query = ["vehicleDamagedByID",_key] call dayz_prepareDataForDB;
		};
		#ifdef OBJECT_DEBUG
		//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
		diag_log ("HIVE: WRITE: "+ str(_query));
		#endif

		//_key call server_hiveWrite;	// extDB2
		_query call server_hiveWrite;
	};
};

//Walls
_objWallDamage = {
	private ["_key","_query","_damage"];	// extDB2
	_damage = (damage _object);

	if (_objectID == "0") then {
		// extDB2
		//_key = format["CHILD:306:%1:%2:%3:",_objectUID,[],_damage];
		_key = [_objectUID, [], _damage];
		_query = ["vehicleDamagedByUID", _key] call dayz_prepareDataForDB;
	} else {
		// extDB2
		//_key = format["CHILD:306:%1:%2:%3:",_objectID,[],_damage];
		_key = [_objectID, [], _damage];
		_query = ["vehicleDamagedByID", _key] call dayz_prepareDataForDB;
	};
	#ifdef OBJECT_DEBUG
	//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
	diag_log ("HIVE: WRITE: "+ str(_query));
	#endif
	
	//_key call server_hiveWrite;	// extDB2
	_query call server_hiveWrite;
};

_object_killed = {
	private ["_clientKey","_exitReason","_index","_key","_query","_playerUID"];	// extDB2

	if (count _this != 6) exitWith {
		diag_log "Server_UpdateObject error: wrong parameter format";
	};

	_playerUID = _this select 4;
	_clientKey = _this select 5;
	_index = dayz_serverPUIDArray find _playerUID;

	_exitReason = switch true do {
		//Can't use owner because player may already be dead, can't use distance because player may be far from vehicle wreck
		case (_clientKey == dayz_serverKey): {""};
		case (_index < 0): {
			format["Server_UpdateObject error: PUID NOT FOUND ON SERVER. PV ARRAY: %1",_this]
		};
		case ((dayz_serverClientKeys select _index) select 1 != _clientKey): {
			format["Server_UpdateObject error: CLIENT AUTH KEY INCORRECT OR UNRECOGNIZED. PV ARRAY: %1",_this]
		};
		case (alive _object && {!(_class isKindOf "TentStorage_base" or _class isKindOf "IC_Tent")}): {
			format["Server_UpdateObject error: object kill request on living object. PV ARRAY: %1",_this]
		};
		default {""};
	};

	if (_exitReason != "") exitWith {diag_log _exitReason};
	_object setDamage 1;
	
	if (_objectID == "0") then {
		//Need to update hive to make a new call to allow UID to be updated for a killed event
		//_key = format["CHILD:306:%1:%2:%3:",_objectUID,[],1];
		//_key = format["CHILD:310:%1:",_objectUID];	// extDB2
		_key = [_objectUID];
		_query = ["objectDeleteByUID", _key] call dayz_prepareDataForDB;
	} else {
		//_key = format["CHILD:306:%1:%2:%3:",_objectID,[],1];	// extDB2
		_key = [_objectID];	// extDB2
		_query = ["objectDeleteByID", _key] call dayz_prepareDataForDB;
	};
	//_key call server_hiveWrite;	// extDB2
	_query call server_hiveWrite;

	if (_playerUID == "SERVER") then {
		#ifdef OBJECT_DEBUG
		diag_log format["DELETE: Server requested destroy on object %1 ID:%2 UID:%3",_class,_objectID,_objectUID];
		#endif
	} else {
		diag_log format["DELETE: PUID(%1) requested destroy on object %2 ID:%3 UID:%4",_playerUID,_class,_objectID,_objectUID];
	};

	if (_class in DayZ_removableObjects or (_class in DZE_isRemovable)) then {[_objectID,_objectUID] call server_deleteObjDirect;};
};

_object_maintenance = {
	private ["_ownerArray","_key","_query"];	// extDB2

	_ownerArray = _object getVariable ["ownerArray",[]];
	_accessArray = _object getVariable ["dayz_padlockCombination",[]];
	_variables set [count _variables, ["ownerArray", _ownerArray]];
	_variables set [count _variables, ["padlockCombination", _accessArray]];

	_object setDamage 0;

	if (_objectID == "0") then {
		//_key = format["CHILD:309:%1:%2:",_objectUID,_ownerArray];
		//_key = format["CHILD:306:%1:%2:%3:",_objectUID,[],0]; //Wont work just now.
		_key = [_objectUID,[],0]; // extDB2
		_query = ["vehicleDamagedByUID", _key] call dayz_prepareDataForDB;
	} else {
		//_key = format["CHILD:303:%1:%2:",_objectID,_ownerArray];
		//_key = format["CHILD:306:%1:%2:%3:",_objectID,[],0];
		_key = [_objectID,[],0]; // extDB2
		_query = ["vehicleDamagedByID", _key] call dayz_prepareDataForDB;
	};

//	#ifdef OBJECT_DEBUG
		//diag_log ("HIVE: WRITE: Maintenance, "+ str(_key));	// extDB2
		diag_log ("HIVE: WRITE: Maintenance, "+ str(_query));
//	#endif
	//_key call server_hiveWrite;	// extDB2
	_query call server_hiveWrite;
};

_object_variables = {
	private ["_ownerArray","_key","_query","_accessArray","_variables","_coins"];	// extDB2

	_ownerArray = _object getVariable ["ownerArray",[]];
	_accessArray = _object getVariable ["dayz_padlockCombination",[]];
	_lockedArray = _object getVariable ["BuildLock",false];
	
	//diag_log format ["[%1,%2]",_ownerArray,_accessArray];
	_variables = [];
	_variables set [count _variables, ["ownerArray", _ownerArray]];
	_variables set [count _variables, ["padlockCombination", _accessArray]];
	_variables set [count _variables, ["BuildLock", _lockedArray]];

	if (_objectID == "0") then {
		//_key = format["CHILD:309:%1:%2:",_objectUID,_variables];	// extDB2
		_key = [_objectUID,_variables];
		_query = ["objectInventoryByUID", _key] call dayz_prepareDataForDB;
	} else {
		//_key = format["CHILD:303:%1:%2:",_objectID,_variables];	// extDB2
		_key = [_objectID,_variables];
		_query = ["objectInventoryByID", _key] call dayz_prepareDataForDB;
	};
	if (Z_SingleCurrency) then {
		_coins = _object getVariable [Z_MoneyVariable, -1];
		//_key = _key + str _coins + ":";	// extDB2
		_query = _query + ":" + str _coins;
	};
	//_key call server_hiveWrite;	// extDB2
	_query call server_hiveWrite;
};

_object setVariable ["lastUpdate",diag_ticktime,true];
switch (_type) do {
	case "all": {
		call _object_position;
		call _object_inventory;
		call _object_damage;
	};
	case "position": {
		call _object_position;
	};
	case "gear": {
		call _object_inventory;
	};
	case "maintenance": {
		call _object_maintenance;
	};
	case "damage"; case "repair" : {
		call _object_damage;
	};
	case "killed": {
		_this call _object_killed;
	};
	case "accessCode"; case "buildLock" : {
		call _object_variables;
	};
	case "objWallDamage": {
		call _objWallDamage;
	};
	case "coins": {
		_object setVariable ["lastInventory",["forceUpdate"]];
		call _object_inventory;
	};
};
