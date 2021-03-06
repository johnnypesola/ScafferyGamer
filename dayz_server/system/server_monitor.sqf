private ["_nul","_result","_pos","_wsDone","_dir","_isOK","_countr","_objWpnTypes","_objWpnQty","_dam","_selection","_totalvehicles","_object","_idKey","_type","_ownerID","_worldspace","_intentory","_hitPoints","_fuel","_damage","_key","_vehLimit","_hiveResponse","_objectCount","_codeCount","_data","_status","_val","_traderid","_retrader","_traderData","_id","_lockable","_debugMarkerPosition","_vehicle_0","_bQty","_vQty","_BuildingQueue","_objectQueue","_res","_outcome"];

dayz_versionNo = 		getText(configFile >> "CfgMods" >> "DayZ" >> "version");
dayz_hiveVersionNo = 	getNumber(configFile >> "CfgMods" >> "DayZ" >> "hiveVersion");

waitUntil{initialized}; //means all the functions are now defined

diag_log "HIVE: Starting";

waituntil{isNil "sm_done"}; // prevent server_monitor be called twice (bug during login of the first player)

auth_clients_idx = 0;
auth_enabled = false;

// Authorized clients
//if (isDedicated) then {
//	[] spawn {
//		private["_key","_result","_res","_result","_outcome"];
//		_key = format["CHILD:401:%1:",auth_clients_idx];
//		diag_log _key;
//		diag_log format["REQUEST AUTHDATA: %1",auth_clients_idx];
//		_result = [];
//		_key = format["\auth\%1\auth.sqf",auth_clients_idx];
//		diag_log format["LOADING AUTHDATA: %1"+_key];
//		auth_clients_idx = auth_clients_idx + 1;
//		sleep 3;
//		_res = preprocessFile _key;
//		if ((_res != "") and !(isNil "_res")) then {
//			_result = call compile _res;
//			_outcome = _result select 0;
//		} else {
//			_outcome = "FAIL";
//		};
//
//		if (_outcome == "PASS") then {
//			auth_clients = _result select 1;
//			diag_log ("HIVE: Whitelist clients loaded!");
//		} else {
//			diag_log ("HIVE: Whitelist clients failed to load!");
//		};
//	};
//};

// Time sync
if (isDedicated) then {
    _result = ["PASS",[2012,6,6,10,10]];
    _res    = preprocessFile "\cache\set_time.sqf";
    if ((_res != "") and !(isNil "_res")) then {
        _result = call compile _res;
    };
    _outcome = _result select 0;

    if (_outcome == "PASS") then {
        _date = _result select 1;
        setDate _date;
	PVDZE_plr_SetDate = _date;
	publicVariable "PVDZE_plr_SetDate";
        diag_log ("HIVE: Local Time set to " + str(_date));
    };
};
	
// Custom Configs
if(isnil "MaxVehicleLimit") then {
	MaxVehicleLimit = 50;
};

if(isnil "MaxDynamicDebris") then {
	MaxDynamicDebris = 100;
};
if(isnil "MaxAmmoBoxes") then {
	MaxAmmoBoxes = 3;
};
if(isnil "MaxMineVeins") then {
	MaxMineVeins = 50;
};
// Custon Configs End

if (isServer && isNil "sm_done") then {

	serverVehicleCounter = [];
        diag_log ("LOAD OBJECTS");

        _objectArray = [];
	
        _res = preprocessFile "\cache\objects.sqf";
        if ((_res == "") or (isNil "_res")) then {
            diag_log ("OBJECTS NOT FOUND!");
        } else {
            _objectArray = call compile _res;
        };
        _res = nil;
        diag_log format["FOUND %1 OBJECTS", str(count _objectArray)];
		
	// # NOW SPAWN OBJECTS #
	_totalvehicles = 0;
	{
		_idKey = 		_x select 1;
		_type =			_x select 2;
		_ownerID = 		_x select 3;

		_worldspace = 	_x select 4;
		_intentory =	_x select 5;
		_hitPoints =	_x select 6;
		_fuel =			_x select 7;
		_damage = 		_x select 8;
		
		_dir = 0;
		_pos = [0,0,0];
		_wsDone = false;
		if (count _worldspace >= 2) then
		{
			_dir = _worldspace select 0;
			if (count (_worldspace select 1) == 3) then {
				_pos = _worldspace select 1;
				_wsDone = true;
			}
		};			
		
		if (!_wsDone) then {
			if (count _worldspace >= 1) then { _dir = _worldspace select 0; };
			_pos = [getMarkerPos "center",0,4000,10,0,2000,0] call BIS_fnc_findSafePos;
			if (count _pos < 3) then { _pos = [_pos select 0,_pos select 1,0]; };
			diag_log ("MOVED OBJ: " + str(_idKey) + " of class " + _type + " to pos: " + str(_pos));
		};
		

		if (_damage < 1) then {
			//diag_log format["OBJ: %1 - %2", _idKey,_type];
			
			//Create it
			_object = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
			_object setVariable ["lastUpdate",time];
			_object setVariable ["ObjectID", _idKey, true];

			_lockable = 0;
			if(isNumber (configFile >> "CfgVehicles" >> _type >> "lockable")) then {
				_lockable = getNumber(configFile >> "CfgVehicles" >> _type >> "lockable");
			};

			switch (_type) do {
				case "DSHKM_CDF": {
					_object removeMagazinesTurret ["50Rnd_127x107_DSHKM", [0]];
				};
				case "M2StaticMG": {
					_object removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
				};
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

			// fix for leading zero issues on safe codes after restart
			if (_lockable == 4) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 3) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 2) then {
					_ownerID = format["00%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["000%1", _ownerID];
				};
			};

			if (_lockable == 3) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 2) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["00%1", _ownerID];
				};
			};

			_object setVariable ["CharacterID", _ownerID, true];
			
			clearWeaponCargoGlobal  _object;
			clearMagazineCargoGlobal  _object;
			// _object setVehicleAmmo DZE_vehicleAmmo;
			
			_object setdir _dir;
			_object setposATL _pos;
			_object setDamage _damage;
			
			if ((typeOf _object) in dayz_allowedObjects) then {
				if (DZE_GodModeBase) then {
					_object addEventHandler ["HandleDamage", {false}];
				} else {
					_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];
				};
				// Test disabling simulation server side on buildables only.
				_object enableSimulation false;
				// used for inplace upgrades && lock/unlock of safe
				_object setVariable ["OEMPos", _pos, true];
				
			};

			if (count _intentory > 0) then {
				if (_type in DZE_LockedStorage) then {
					// Fill variables with loot
					_object setVariable ["WeaponCargo", (_intentory select 0),true];
					_object setVariable ["MagazineCargo", (_intentory select 1),true];
					_object setVariable ["BackpackCargo", (_intentory select 2),true];
				} else {

					//Add weapons
					_objWpnTypes = (_intentory select 0) select 0;
					_objWpnQty = (_intentory select 0) select 1;
					_countr = 0;					
					{
						if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
							_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
						};
						_isOK = 	isClass(configFile >> "CfgWeapons" >> _x);
						if (_isOK) then {
							_object addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} count _objWpnTypes; 
				
					//Add Magazines
					_objWpnTypes = (_intentory select 1) select 0;
					_objWpnQty = (_intentory select 1) select 1;
					_countr = 0;
					{
						if (_x == "BoltSteel") then { _x = "WoodenArrow" }; // Convert BoltSteel to WoodenArrow
						if (_x == "ItemTent") then { _x = "ItemTentOld" };
						_isOK = 	isClass(configFile >> "CfgMagazines" >> _x);
						if (_isOK) then {
							_object addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} count _objWpnTypes;

					//Add Backpacks
					_objWpnTypes = (_intentory select 2) select 0;
					_objWpnQty = (_intentory select 2) select 1;
					_countr = 0;
					{
						_isOK = 	isClass(configFile >> "CfgVehicles" >> _x);
						if (_isOK) then {
							_object addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} count _objWpnTypes;
				};
			};
			
			if (_object isKindOf "AllVehicles") then {
				{
					_selection = _x select 0;
					_dam = _x select 1;
					if (_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};
					[_object,_selection,_dam] call object_setFixServer;
				} count _hitpoints;

				_object setFuel _fuel;

				if (!((typeOf _object) in dayz_allowedObjects)) then {
					
					//_object setvelocity [0,0,1];
					_object call fnc_veh_ResetEH;		
					
					if(_ownerID != "0" && !(_object isKindOf "Bicycle")) then {
						//_object setVariable ["MF_Tow_Cannot_Tow",true,true];
						_object setvehiclelock "locked";
					};
					
					_totalvehicles = _totalvehicles + 1;

					// total each vehicle
					serverVehicleCounter set [count serverVehicleCounter,_type];
				};
			};

			if ("Explosive" == typeOf _object) then {
				_trig = createTrigger ["EmptyDetector", (getPos _object)];
				_trig setTriggerArea [2, 2, 0, false];
				_trig setTriggerActivation ["ANY", "PRESENT", false];
				_trig setTriggerTimeout [0, 0, 0, true]; 
				_trig setTriggerStatements ["this", "[(nearestObject [thisTrigger, ""Explosive""]), ""Small""] exec ""custom\proximitybomb\ied.sqs""" , ""];
			};

			//Monitor the object
			PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
		};
	} forEach _objectArray;
	// # END SPAWN OBJECTS #

	// preload server traders menu data into cache
	if !(DZE_ConfigTrader) then {
		{
			// get tids
			_traderData = call compile format["menu_%1;",_x];
			if(!isNil "_traderData") then {
			    {
			        _traderid = _x select 1;
				//_key = format["CHILD:399:%1:",_traderid];
				_key = format["\cache\traders\%1.sqf", _traderid];
                                diag_log ("LOAD TRADER: "+_key);
                                _res = preprocessFile _key;

                                if ((_res == "") or (isNil "_res")) then {
                                    diag_log ("TRADER NOT FOUND");
                                } else {
                                    call compile format["ServerTcache_%1 = [];", _traderid];
					
                                    _retrader = call compile _res;
                                     diag_log format["Count: %1", str(count _retrader)];
            
                                    {
                                        call compile format["ServerTcache_%1 set [count ServerTcache_%1,%2]", _traderid, _x];
                                    } forEach _retrader;

                                    _retrader = nil;
                                };
                                _res = nil;

				} forEach (_traderData select 0);
			};
		} forEach serverTraders;
	};

	//  spawn_vehicles
	_vehLimit = MaxVehicleLimit - _totalvehicles;
	if(_vehLimit > 0) then {
		diag_log ("HIVE: Spawning # of Vehicles: " + str(_vehLimit));
		for "_x" from 1 to _vehLimit do {
			//[] spawn spawn_vehicles;
			[] call spawn_vehicles;	// Better not run in parallel to avoid race conditions
		};
	} else {
		diag_log "HIVE: Vehicle Spawn limit reached!";
	};
	
	//  spawn_roadblocks
	diag_log ("HIVE: Spawning # of Debris: " + str(MaxDynamicDebris));
	for "_x" from 1 to MaxDynamicDebris do {
		[] spawn spawn_roadblocks;
	};
	//  spawn_ammosupply at server start 1% of roadblocks
	diag_log ("HIVE: Spawning # of Ammo Boxes: " + str(MaxAmmoBoxes));
	for "_x" from 1 to MaxAmmoBoxes do {
		[] spawn spawn_ammosupply;
	};
	// call spawning mining veins
	diag_log ("HIVE: Spawning # of Veins: " + str(MaxMineVeins));
	for "_x" from 1 to MaxMineVeins do {
		[] spawn spawn_mineveins;
	};

	if(isnil "dayz_MapArea") then {
		dayz_MapArea = 10000;
	};
	if(isnil "HeliCrashArea") then {
		HeliCrashArea = dayz_MapArea / 2;
	};
	if(isnil "OldHeliCrash") then {
		OldHeliCrash = false;
	};

        // WAI missions
        [] ExecVM "\z\addons\dayz_server\WAI\init.sqf";

	// OK Missions framework
	[] ExecVM "\z\addons\dayz_server\OK\OKInit.sqf";

	allowConnection = true;

	// [_guaranteedLoot, _randomizedLoot, _frequency, _variance, _spawnChance, _spawnMarker, _spawnRadius, _spawnFire, _fadeFire]
	if(OldHeliCrash) then {
		_nul = [3, 4, (50 * 60), (15 * 60), 0.75, 'center', HeliCrashArea, true, false] spawn server_spawnCrashSite;
	};
	if (isDedicated) then {
		// Epoch Events
		_id = [] spawn server_spawnEvents;
		// server cleanup
		[] spawn {
			private ["_id"];
			sleep 200; //Sleep Lootcleanup, don't need directly cleanup on startup + fix some performance issues on serverstart
			waitUntil {!isNil "server_spawnCleanAnimals"};
			_id = [] execFSM "\z\addons\dayz_server\system\server_cleanup.fsm";
		};

		// spawn debug box
		_debugMarkerPosition = getMarkerPos "respawn_west";
		_debugMarkerPosition = [(_debugMarkerPosition select 0),(_debugMarkerPosition select 1),1];
		_vehicle_0 = createVehicle ["DebugBox_DZ", _debugMarkerPosition, [], 0, "CAN_COLLIDE"];
		_vehicle_0 setPos _debugMarkerPosition;
		_vehicle_0 setVariable ["ObjectID","1",true];

		// max number of spawn markers
		if(isnil "spawnMarkerCount") then {
			spawnMarkerCount = 10;
		};
		actualSpawnMarkerCount = 0;
		// count valid spawn marker positions
		for "_i" from 0 to spawnMarkerCount do {
			if (!([(getMarkerPos format["spawn%1", _i]), [0,0,0]] call BIS_fnc_areEqual)) then {
				actualSpawnMarkerCount = actualSpawnMarkerCount + 1;
			} else {
				// exit since we did not find any further markers
				_i = spawnMarkerCount + 99;
			};
			
		};
		diag_log format["Total Number of spawn locations %1", actualSpawnMarkerCount];
		
		endLoadingScreen;
	};

	allowConnection = true;	
	sm_done = true;
	publicVariable "sm_done";
};
