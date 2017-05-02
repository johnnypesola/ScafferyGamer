private ["_activatingPlayer","_isOK","_object","_worldspace","_location","_dir","_class","_uid","_key","_query","_keySelected","_characterID","_donotusekey","_result","_oid"];	// extDB2
//PVDZE_veh_Publish2 = [[_dir,_location],_part_out,false,_keySelected,_activatingPlayer];
#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

_worldspace = 	_this select 0;
_class = 		_this select 1;
_donotusekey =	_this select 2;
_keySelected =  _this select 3;
_activatingPlayer =  _this select 4;

if(_donotusekey) then {
	_isOK = true;
} else {
	_isOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
};

if(!_isOK) exitWith { diag_log ("HIVE: CARKEY DOES NOT EXIST: "+ str(_keySelected));  };

if(_donotusekey) then {
	_characterID = _keySelected;
} else {
	_characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
};

_dir = 		_worldspace select 0;
_location = _worldspace select 1;
_uid = _worldspace call dayz_objectUID2;

//Send request
// extDB2
//_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _class, 0 , _characterID, _worldspace, [], [], 1,_uid];
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
	_uid
];
_query = ["objectPublish", _key] call dayz_prepareDataForDB;

#ifdef OBJECT_DEBUG
//diag_log ("HIVE: WRITE: "+ str(_key));	// extDB2
diag_log ("HIVE: WRITE: "+ str(_query)); 
#endif

// extDB2
//_key call server_hiveWrite;
_result = _query call server_hiveReadWrite;

// extDB2
// Try to get object ID already here
if (0 < count _result) then {
	_oid = str (_result select 0);
	//_object setVariable ["ObjectID", _oid, true];
};
// Switched to spawn so we can wait a bit for the ID
[_uid,_characterID,_class,_dir,_location,_donotusekey,_activatingPlayer, _oid] spawn {
   private ["_object","_uid","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class","_location","_object_para","_donotusekey","_activatingPlayer"];

   _uid = _this select 0;
   _characterID = _this select 1;
   _class = _this select 2;
   //_dir = _this select 3;
   _location = _this select 4;
   _donotusekey = _this select 5;
   _activatingPlayer = _this select 6;
   _oid = _this select 7;	// extDB2

   _done = false;
	_retry = 0;
	// extDB2
	if (!isNil "_oid") then {

		_retry = 100;
		_done = true;
	};

	// TODO: Needs major overhaul for 1.1
	while {_retry < 10} do {
		// GET DB ID
		// extDB2
		//_key = format["CHILD:388:%1:",_uid];
		_key = [_uid];
		_query = ["objectReturnID",_key] call dayz_prepareDataForDB;
		#ifdef OBJECT_DEBUG
		diag_log ("HIVE: WRITE: "+ str(_query));
		#endif
		
		// extDB2
		//_result = _key call server_hiveReadWrite;
		//_outcome = _result select 0;
		_result = _query call server_hiveReadWrite;
		_outcome = (count _result > 0);
		//if (_outcome == "PASS") then {	// extDB2
		if (_outcome) then {
			//_oid = _result select 1;	// extDB2
			_oid = (_result select 0) select 0;
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

	if(!_done) exitWith { diag_log("CUSTOM: failed to get id for : " + str(_uid)); };

	if(DZE_TRADER_SPAWNMODE) then {
		//_object_para = createVehicle ["ParachuteMediumWest", [0,0,0], [], 0, "CAN_COLLIDE"];
		_object_para = "ParachuteMediumWest" createVehicle [0,0,0];
		_object_para setPos [_location select 0, _location select 1,(_location select 2) + 65];
		//_object = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
		_object = _class createVehicle [0,0,0];
	} else {
		//_object = createVehicle [_class, _location, [], 0, "CAN_COLLIDE"];
		// Don't use setPos or CAN_COLLIDE here. It will spawn inside other vehicles
		_object = _class createVehicle _location;
	};

	if(!_donotusekey) then {
		// Lock vehicle
		_object setvehiclelock "locked";
	};

	switch (_class) do {
		case "M113_TK_EP1": {
			//_object removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
		};
		case "AH6J_EP1": {
			//_object removeMagazinesTurret ["4000Rnd_762x51_M134", [-1]];
			_object removeMagazinesTurret ["14Rnd_FFAR", [-1]];
		};
		case "UH1Y": {
			_object removeMagazinesTurret ["14Rnd_FFAR", [-1]];
		};
		case "Ka60_PMC": {
			_object setVehicleAmmo 0;
		};
		case "pook_H13_gunship": {
			//_object removeMagazinesTurret ["pook_1300Rnd_762x51_M60", [-1]];
		};
		case "pook_H13_transport_GUE": {
			//_object removeMagazinesTurret ["pook_250Rnd_762x51", [0]];
		};
		case "M1126_ICV_M2_EP1": {
			//_object removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
		};
		case "M1126_ICV_mk19_EP1": {
			//_object removeMagazinesTurret ["48Rnd_40mm_MK19", [0]];
		};
	};

	clearWeaponCargoGlobal  _object;
	clearMagazineCargoGlobal  _object;
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
	_object setVariable ["ObjectID", _oid, true];
	_object setVariable ["lastUpdate",time];
	_object setVariable ["CharacterID", _characterID, true];
	//_object setVelocity [0,0,1];

	if(DZE_TRADER_SPAWNMODE) then {
		_object attachTo [_object_para, [0,0,-1.6]];
		uiSleep 1;
		WaitUntil{(([_object] call FNC_GetPos) select 2) < 0.1};
		detach _object;
		deleteVehicle _object_para;
	};
	
	_object call fnc_veh_ResetEH;
	
	// for non JIP users this should make sure everyone has eventhandlers for vehicles.
	PVDZE_veh_Init = _object;
	publicVariable "PVDZE_veh_Init";
	
	diag_log format["PUBLISH: %1(%2) bought %3 with ObjectUID %4",if (alive _activatingPlayer) then {name _activatingPlayer} else {"DeadPlayer"},getPlayerUID _activatingPlayer,_class,_uid];
};
