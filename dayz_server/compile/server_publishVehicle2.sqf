private ["_activatingPlayer","_isOK","_object","_worldspace","_location","_dir","_class","_uid","_key","_query","_keySelected","_characterID","_donotusekey"];
//PVDZE_veh_Publish2 = [_veh,[_dir,_location],_part_out,false,_keySelected,_activatingPlayer];
_object = 		_this select 0;
_worldspace = 	_this select 1;
_class = 		_this select 2;
_donotusekey =	_this select 3;
_keySelected =  _this select 4;
_activatingPlayer =  _this select 5;

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

diag_log ("PUBLISH: Attempt " + str(_object));
_dir = 		_worldspace select 0;
_location = _worldspace select 1;

//Generate UID test using time
_uid = _worldspace call dayz_objectUID3;

// TODO: check if uid already exists && if so increment by 1 && check again as soon as we find nothing continue.

//Send request
_key = [dayZ_instance, _class, 0 , _characterID, format["'%1'", [_worldspace select 0, _worldspace select 1] call AN_fnc_formatWorldspace], "'[]'", "'[]'", 1, _uid];
_query = ["objectPublish", _key] call dayz_prepareDataForDB;
diag_log ("HIVE: WRITE: "+ str(_query)); 
_query call server_hiveWrite;

// Switched to spawn so we can wait a bit for the ID
[_object,_uid,_characterID,_class,_dir,_location,_donotusekey,_activatingPlayer] spawn {
   private ["_object","_uid","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class","_location","_object_para","_donotusekey","_activatingPlayer"];

   _object = _this select 0;
   _uid = _this select 1;
   _characterID = _this select 2;
   _class = _this select 3;
   //_dir = _this select 4;
   _location = _this select 5;
   _donotusekey = _this select 6;
   _activatingPlayer = _this select 7;

   _done = false;
	_retry = 0;
	// TODO: Needs major overhaul for 1.1
	while {_retry < 10} do {
		
		sleep 1;
		// GET DB ID
		_key = [_uid];
		_query = ["objectReturnID",_key] call dayz_prepareDataForDB;
		diag_log ("HIVE: WRITE: "+ str(_query));
		_result = _query call server_hiveReadWrite;
		_outcome = (count _result > 0);
		if (_outcome) then {
			_oid = (_result select 0) select 0;
			//_object setVariable ["ObjectID", _oid, true];
			diag_log("CUSTOM: Selected " + str(_oid));
			_done = true;
			_retry = 100;

		} else {
			diag_log("CUSTOM: trying again to get id for: " + str(_uid));
			_done = false;
			_retry = _retry + 1;
		};
	};

	// Remove marker
	deleteVehicle _object;

	if(!_done) exitWith { diag_log("CUSTOM: failed to get id for : " + str(_uid)); };

	if(DZE_TRADER_SPAWNMODE) then {
		_object_para = createVehicle ["ParachuteMediumWest", [0,0,0], [], 0, "CAN_COLLIDE"];
		_object_para setPos [_location select 0, _location select 1,(_location select 2) + 65];
		_object = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
	} else {
		_object = createVehicle [_class, _location, [], 0, "CAN_COLLIDE"];
	};

	if(!_donotusekey) then {
		// Lock vehicle
		//_object setVariable ["MF_Tow_Cannot_Tow",true,true];
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
	// _object setVehicleAmmo DZE_vehicleAmmo;

	_object setVariable ["ObjectID", _oid, true];
	
	_object setVariable ["lastUpdate",time];
	
	_object setVariable ["CharacterID", _characterID, true];

	if(DZE_TRADER_SPAWNMODE) then {
		_object attachTo [_object_para, [0,0,-1.6]];
		sleep 1.0;
		WaitUntil{(([_object] call FNC_GetPos) select 2) < 0.1};
		detach _object;
		deleteVehicle _object_para;
	};

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];

	_object call fnc_veh_ResetEH;
	
	// for non JIP users this should make sure everyone has eventhandlers for vehicles.
	PVDZE_veh_Init = _object;
	publicVariable "PVDZE_veh_Init";
	
	diag_log ("PUBLISH: " + str(_activatingPlayer) + " Bought " + (_class) + " with ID " + str(_uid));
};
