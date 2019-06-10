private ["_activatingPlayer","_object","_worldspace","_location","_dir","_class","_uid","_key","_keySelected","_characterID","_donotusekey","_result","_outcome","_oid","_objectID","_objectUID","_newobject","_weapons","_magazines","_backpacks","_clientKey","_exitReason","_playerUID","_weaponUpgrade","_upgradeArray","_currentLvl","_gunType","_calOrType","_upgradeArrayCloned"];	// extDB2
#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

if (count _this < 7) exitWith {
	diag_log "Server_PublishVehicle3 error: Wrong parameter format";
	dze_waiting = "fail";
	(owner (_this select 5)) publicVariableClient "dze_waiting";
};

_object = 		_this select 0;
_worldspace = 	_this select 1;
_class = 		_this select 2;
_donotusekey =	_this select 3;
_keySelected =  _this select 4;
_activatingPlayer =  _this select 5;
_clientKey = _this select 6;
if (8 == count _this) then {
	_weaponUpgrade = _this select 7;
} else {
	_weaponUpgrade = [];
};
_playerUID = getPlayerUID _activatingPlayer;
_characterID = _keySelected;

_exitReason = [_this,"PublishVehicle3",(_worldspace select 1),_clientKey,_playerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {
	diag_log _exitReason;
	dze_waiting = "fail";
	(owner _activatingPlayer) publicVariableClient "dze_waiting";
};

if (!(isClass(configFile >> "CfgVehicles" >> _class)) || isNull _object) exitWith {
	diag_log ("HIVE-PublishVehicle3 Error: Vehicle does not exist: "+ str(_class));
	dze_waiting = "fail";
	(owner _activatingPlayer) publicVariableClient "dze_waiting";
};

#ifdef OBJECT_DEBUG
diag_log ("PUBLISH: Attempt " + str(_object));
#endif

_dir = 		_worldspace select 0;
_location = _worldspace select 1;
_uid = _worldspace call dayz_objectUID2;

// Weapons upgrade pre-calculation (for database)
_upgradeArray = _object getVariable ["upgradeArray", [[0,0],[0,0],[0,0],[0,0]]];
if (0 < count _weaponUpgrade) then {

	diag_log format["_weaponUpgrade = %1", _weaponUpgrade];

	_gunType = _weaponUpgrade select 0;
	_calOrType = _weaponUpgrade select 1; 

	diag_log format ["Precalculating upgrade level to store in DB for vehicle %1, gun type %2, caliber %3", typeOf _object, _gunType, _calOrType];

	_upgradeArrayCloned = +_upgradeArray;
	if (count _upgradeArrayCloned == 0) then {
		diag_log format["upgradeArray is uninitialized: %1 - Resetting array.", _upgradeArrayCloned];
		_upgradeArrayCloned = [[0,0],[0,0],[0,0],[0,0]];
	};
	diag_log format ["Current upgradeArray is %1", _upgradeArrayCloned];
	if (((_upgradeArrayCloned select _gunType) select 1) != _calOrType) then {
		_upgradeArrayCloned = [[0,0],[0,0],[0,0],[0,0]];	// Upgrading new gun type, reset to 0!
		diag_log format["Caliber is new (%1), resetting array to %2", _calOrType, _upgradeArrayCloned];
	};
	_currentLvl = (_upgradeArrayCloned select _gunType) select 0;
	_upgradeArrayCloned set [_gunType, [_currentLvl+1, _calOrType]];	// This might modify the variable in place on the vehicle!

	diag_log format["Setting level to %1 and caliber to %2. Final array: %3", _currentLvl+1, _calOrType, _upgradeArrayCloned];
};

// extDB2
//_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _class, 0 , _characterID, _worldspace, [], [], 1,_uid];
//#ifdef OBJECT_DEBUG
//diag_log ("HIVE: WRITE: "+ str(_key)); 
//#endif

// extDB2
//Send request
_key = [
	dayZ_instance,
	_class,
	0,	// damage
	_characterID,
	((_worldspace select 1) select 0) call KK_fnc_floatToString,	// x
	((_worldspace select 1) select 1) call KK_fnc_floatToString,	// y
	((_worldspace select 1) select 2) call KK_fnc_floatToString,	// z
	(_worldspace select 0) call KK_fnc_floatToString,		// dir
	"0",
	[[0,0,0],[0,0,0]],
	[], // inv magazines
	[], // inv weapons
	[], // inv backpacks
	[], // hitpoints
	1,  // fuel
	_upgradeArrayCloned, // upgrade level
	_uid
];
_query = ["objectPublish",_key] call dayz_prepareDataForDB;
#ifdef OBJECT_DEBUG
diag_log ("HIVE: WRITE: "+ str(_query)); 
#endif

//_key call server_hiveWrite;	// extDB2
_result = _query call server_hiveReadWrite;

// Switched to spawn so we can wait a bit for the ID
[_object,_uid,_characterID,_class,_dir,_location,_donotusekey,_activatingPlayer,_playerUID,_weaponUpgrade] spawn {
   private ["_object","_uid","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class","_location","_donotusekey","_activatingPlayer","_countr","_objectID","_objectUID","_dir","_newobject","_weapons","_magazines","_backpacks","_objWpnTypes","_objWpnQty","_playerUID","_weaponUpgrade","_upgradeArray3"];

	_object = _this select 0;
	_objectID 	= _object getVariable ["ObjectID","0"];
	_objectUID	= _object getVariable ["ObjectUID","0"];
	_uid = _this select 1;
	_characterID = _this select 2;
	_class = _this select 3;
	_dir = _this select 4;
	// _location = _this select 5;
	_location = getPosATL _object;
	_donotusekey = _this select 6;
	_activatingPlayer = _this select 7;
	_playerUID = _this select 8;
	_weaponUpgrade = _this select 9;
	_upgradeArray3 = _object getVariable ["upgradeArray", [[0,0],[0,0],[0,0],[0,0]]];

	_oid = "0";

	_done = false;
	_retry = 0;
	// TODO: Needs major overhaul for 1.1
	while {_retry < 10} do {
		// GET DB ID
		//_key = format["CHILD:388:%1:",_uid];	// extDB2
		_key = [_uid];
		_query = ["objectReturnID",_key] call dayz_prepareDataForDB;
		#ifdef OBJECT_DEBUG
		//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
		diag_log ("HIVE: WRITE: "+ str(_query));
		#endif
		
		//_result = _key call server_hiveReadWrite;	// extDB2
		_result = _query call server_hiveReadWrite;
		//_outcome = _result select 0;	// extDB2
		//if (_outcome == "PASS") then 
		_outcome = (count _result > 0);
		if (_outcome) then {
			//_oid = _result select 1;	// extDB2
			_oid = (_result select 0) select 0;
			//_object setVariable ["ObjectID", _oid, true];
			#ifdef OBJECT_DEBUG
			diag_log("CUSTOM: Selected " + str(_oid));
			#endif
			
			_done = true;
			_retry = 100;

		} else {
			diag_log("CUSTOM: trying again to get id for: " + str(_uid));
			_done = false;
			_retry = _retry + 1;
			uiSleep 1;
		};
	};

	if (!_done) exitWith {
		diag_log("HIVE-pv3: failed to get id for : " + str(_uid));
		// extDB2
		//_key = format["CHILD:310:%1:",_uid];
		//_key call server_hiveWrite;
		_key = [_uid];
		_query = ["objectDeleteByUID", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		
		dze_waiting = "fail";
		(owner _activatingPlayer) publicVariableClient "dze_waiting";
	};

	// add items from previous vehicle here
	_weapons = getWeaponCargo _object;
	_magazines = getMagazineCargo _object;
	_backpacks = getBackpackCargo _object;

	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	deleteVehicle _object;
	[_objectID,_objectUID] call server_deleteObjDirect;

	// Wait 1 sec here to make object not spawn over deleted one, while having desync (old vehicle still present)
	sleep 0.5;

	//_newobject = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
	_newobject = _class createVehicle [0,0,0];

	// switch var to new vehicle at this point.
	_object = _newobject;

	_object setVariable ["ObjectID", _oid, true];
	_object setVariable ["lastUpdate",diag_tickTime];
	_object setVariable ["CharacterID", _characterID, true];
	_object setVariable ["upgradeArray", _upgradeArray3];

	// Upgrade vehicle weapons!
	[_object, _activatingPlayer, _upgradeArray3, _weaponUpgrade select 0, _weaponUpgrade select 1] call server_upgradeVehWeapons;

	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];

	// Lift object 20cm up in the air to avoid crazy stuff
	_location set [2, (_location select 2) + 0.2];
	_object setDir _dir;
	_object setPosATL _location;
	_object setVectorUp surfaceNormal _location;

	[_weapons,_magazines,_backpacks,_object] call fn_addCargo;

	_object call fnc_veh_ResetEH;
	// for non JIP users this should make sure everyone has eventhandlers for vehicles.
	PVDZE_veh_Init = _object;
	publicVariable "PVDZE_veh_Init";

	dze_waiting = "success";
	(owner _activatingPlayer) publicVariableClient "dze_waiting";

	diag_log format["PUBLISH: %1(%2) upgraded %3 with UID %4 @%5",(_activatingPlayer call fa_plr2str),_playerUID,_class,_uid,(_location call fa_coor2str)];
};
