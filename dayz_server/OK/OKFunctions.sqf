/*
	DayZ Mission System Functions
	by Vampire
*/

OKMajTimer = "\z\addons\dayz_server\OK\Scripts\OKMajTimer.sqf";
OKMarkerLoop = "\z\addons\dayz_server\OK\Scripts\OKMarkerLoop.sqf";

OKAddMajMarker = "\z\addons\dayz_server\OK\Scripts\OKAddMajMarker.sqf";

OKAISpawn = compile preprocessfilelinenumbers "\z\addons\dayz_server\OK\Scripts\OKAISpawn.sqf";
OKAISpawn2 = compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\Scripts\OKAISpawn2.sqf";
OKVehiclePatrol = compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\Scripts\OKVehiclePatrol.sqf";
OKAIKilled = "\z\addons\dayz_server\OK\Scripts\OKAIKilled.sqf";
OKAIPinata = "\z\addons\dayz_server\OK\Scripts\OKAIPinata.sqf";

OKBoxSetup = "\z\addons\dayz_server\OK\Scripts\OKBox.sqf";
OKSaveVeh = "\z\addons\dayz_server\OK\Scripts\OKSaveToHive.sqf";

//Attempts to find a mission location
//If findSafePos fails it searches again until a position is found
//This fixes the issue with missions spawning in Novy Sobor on Chernarus
OKFindPos = {
	private["_findRun","_pos","_centerPos","_mapHardCenter","_hardX","_hardY","_posX","_posY","_fin","_list"];
	
	//Lets try to use map specific "Novy Sobor Fixes".
	//If the map is unrecognised this function will still work.
	if (OKWorldName in ["chernarus","utes","zargabad","fallujah","takistan","tavi","lingor","namalsk","mbg_celle2","oring","panthera2","isladuala","smd_sahrani_a2","trinity"]) then
	{
		_mapHardCenter = true;
		
		//We have a supported map so lets set the center
		//New map support can easily be added to these
		if (OKWorldName == "chernarus") then {
			_centerPos = [7100, 7750, 0];
		};		
	}
	else
	{
		//We don't have a supported map. Let's use the norm.
		//_pos = [getMarkerPos "center",0,10000,200,0,20,0] call BIS_fnc_findSafePos;
		_mapHardCenter = false;

		_findRun = true;
		while {_findRun} do {

			_pos = [getMarkerPos "center",0,5000,50,0,1,0] call BIS_fnc_findSafePos;

			_list = [
				getTerrainHeightASL [(_pos select 0)+20, (_pos select 1)+20],
				getTerrainHeightASL [(_pos select 0)+20, (_pos select 1)-20],
				getTerrainHeightASL [(_pos select 0)-20, (_pos select 1)+20],
				getTerrainHeightASL [(_pos select 0)-20, (_pos select 1)-20]
			];

			_findRun = false;
			for [{_i=1}, {_i<4}, {_i=_i+1}] do {

				// Is the height difference too big?
				if (abs ((_list select 0) - (_list select _i)) > 3) then {

					// Yes, keep looking 
					_findRun = true;
				};
			};
			sleep 0.2;
		};
	};
	
	//If we have a hardcoded center, then we need to loop for a location
	//Else we can ignore this block of code and just return the position
	if (_mapHardCenter) then {
	
		_hardX = _centerPos select 0;
		_hardY = _centerPos select 1;
	
		//We need to loop findSafePos until it doesn't return the map center
		_findRun = true;
		while {_findRun} do
		{
			_pos = [_centerPos,0,7600,0,0,30,0] call BIS_fnc_findSafePos;
			
			//Apparently you can't compare two arrays and must compare values
			_posX = _pos select 0;
			_posY = _pos select 1;
			
			if (_posX != _hardX) then {
				if (_posY != _hardY) then {
					if (!surfaceIsWater _pos) then {
						_findRun = false;
					};
				};
			};
			sleep 2;
		};
		
	};
	
	_fin = [(_pos select 0), (_pos select 1), 0];
	_fin
};

OKFindPos2 = {
	private["_centerPos","_findRun","_pos","_mapHardCenter","_hardX","_hardY","_posX","_posY","_fin"];
	_centerPos = [_this select 0,_this select 1,0];
    diag_log format["[OK] _centerpos is %1",_centerPos];
	_mapHardCenter = true;
		
	//If we have a hardcoded center, then we need to loop for a location
	//Else we can ignore this block of code and just return the position
	if (_mapHardCenter) then {
	
		_hardX = _centerPos select 0;
		_hardY = _centerPos select 1;
	
		//We need to loop findSafePos until it doesn't return the map center
		_findRun = true;
		while {_findRun} do
		{
			_pos = [_centerPos,150,300,0,0,30,0] call BIS_fnc_findSafePos;
			
			//Apparently you can't compare two arrays and must compare values
			_posX = _pos select 0;
			_posY = _pos select 1;
			
			if (_posX != _hardX) then {
				if (_posY != _hardY) then {
					if (!surfaceIsWater _pos) then {
						_findRun = false;
					};
				};
			};
			sleep 2;
		};
		
	};
	
	_fin = [(_pos select 0), (_pos select 1), 0];
	_fin
};

//Clears the cargo and sets fuel, direction, and orientation
//Direction stops the awkwardness of every vehicle bearing 0
OKSetupVehicle = {
	private ["_object","_objectID"];
	_object = _this select 0;

	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	
	if (OKEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};
	
	waitUntil {(!isNull _object)};
	
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	
	_ranFuel = random 1;
	if (_ranFuel < .1) then {_ranFuel = .1;};
	_object setFuel _ranFuel;
	_object setvelocity [0,0,1];
	_object setDir (round(random 360));
	
	//If saving vehicles to the database is disabled, lets warn players it will disappear
	if (!(OKSaveVehicles)) then {
		_object addEventHandler ["GetIn",{
			_nil = [nil,(_this select 2),"loc",rTITLETEXT,"Warning: This vehicle will disappear on server restart!","PLAIN DOWN",5] call RE;
		}];
	};

	true
};

//Fills the ammo and fuel, sets direction, and orientation
//Direction stops the awkwardness of every vehicle bearing 0
OKSetupVehicleArmed = {
	private ["_object","_objectID"];
	_object = _this select 0;

	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	
	if (OKEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};
	
	waitUntil {(!isNull _object)};
	
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	
	_object setFuel 1;
	_object setvelocity [0,0,1];
	_object setDir (round(random 360));
    _object setvehicleammo 1;
    
	
	//If saving vehicles to the database is disabled, lets warn players it will disappear
	if (!(OKSaveVehicles)) then {
		_object addEventHandler ["GetIn",{
			_nil = [nil,(_this select 2),"loc",rTITLETEXT,"Warning: This vehicle will disappear on server restart!","PLAIN DOWN",5] call RE;
		}];
	};

	true
};

//Prevents an object being cleaned up by the server anti-hack
OKProtectObj = {
	private ["_object","_objectID"];
	_object = _this select 0;
	
	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	_object setvelocity [0,0,1];
	
	if (_object isKindOf "ReammoBox") then {
		// PermaLoot on top of ObjID because that "arma logic"
		_object setVariable ["permaLoot",true];
	};

	if (OKEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};

	true
};

//Gets the weapon and magazine based on skill level
OKGetWeapon = {
	private ["_skill","_aiweapon","_weapon","_magazine","_fin"];
	
	_skill = _this select 0;
	
	//diag_log format ["[OK]: AI Skill Func:%1",_skill];
	
	switch (_skill) do {
		case 0: {_aiweapon = OKWeps1;};
		case 1: {_aiweapon = OKWeps2;};
		case 2: {_aiweapon = OKWeps3;};
        case 3: {_aiweapon = OKWeps4;};
	};
	_weapon = _aiweapon call BIS_fnc_selectRandom;
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	
	_fin = [_weapon,_magazine];
	
	_fin
};


//------------------------------------------------------------------//
diag_log format ["[OK]: Mission Functions Script Loaded!"];
