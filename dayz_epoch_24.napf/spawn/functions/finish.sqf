Scaffery_enableTestMode = false;

if (player distance respawn_west_original < 100) then {

	if ((PVCDZ_plr_Login2 select 4) && Scaffery_enableTestMode) then {
		local _allowedUIDs = ["76561198058567747", "76561198045692848"];
		local _bikeClasses = ["Old_bike_TK_CIV_EP1_DZE","MMT_Civ_DZE"];
		if (((getPlayerUID player) in _allowedUIDs)) then {
			_bikeClasses = ["CSJ_GyroC"];
		};
		
		local _bikePos = ([_grid,0,25,10,0,1,0] call BIS_fnc_findSafePos);
		local _veh = createVehicle [_bikeClasses call BIS_fnc_selectRandom, _bikePos, [], 0, "CAN_COLLIDE"];
		_veh setDir round(random 360);
		_veh setVariable ["ObjectID","1",true];
		_veh setVariable ["MalSar",1,true];
		diag_log format["Spawned bike for player at %1", getPos _veh];

		if (((getPlayerUID player) in _allowedUIDs)) then {

			// BEGIN Spawn a temporary box with stuff
			local _boxPos = ([_grid,0,25,10,0,1,0] call BIS_fnc_findSafePos);
			_thebox = createVehicle ["USOrdnanceBox", _boxPos, [], 0, "CAN_COLLIDE"];
			clearWeaponCargoGlobal _thebox;
			clearMagazineCargoGlobal _thebox;
			_thebox setVariable ["ObjectID","1",true];
			_thebox setVariable ["permaLoot",true];
			_thebox allowDamage true;

			local _box_items = [
				"ItemCrowbar",
				"ItemToolbox",
				"ItemEtool",
				"ItemMap",
				"Binocular_Vector",
				"NVGoggles",
				"ItemHatchet",
				"ItemMatchbox",
				"ItemSledge",
				"ItemSolder_DZE",
				"Mk48_DZ",
				"M110_NVG_EP1"
			];
			local _box_mags = [
				"100Rnd_762x51_M240",
				"100Rnd_762x51_M240",
				"100Rnd_762x51_M240",
				"100Rnd_762x51_M240",
				"100Rnd_762x51_M240",
				"100Rnd_762x51_M240",
				"20Rnd_762x51_B_SCAR",
				"20Rnd_762x51_B_SCAR",
				"20Rnd_762x51_B_SCAR",
				"20Rnd_762x51_B_SCAR"
			];

			{
				_thebox addWeaponCargoGlobal [_x,1];
			} forEach _box_items;
			{
				_thebox addMagazineCargoGlobal [_x,1];
			} forEach _box_mags;
		};
	};

	// Ground spawn
	player setPosATL _grid;
	if (surfaceIsWater respawn_west_original) then {player call fn_exitSwim;};
	
	// Show infoText if not in HALO spawn
	_nearestCity = nearestLocations [_grid, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];
	Dayz_logonTown = "Wilderness";
	if (count _nearestCity > 0) then {Dayz_logonTown = text (_nearestCity select 0)};
	[toUpper worldName,Dayz_logonTown,format[localize "str_player_06",Dayz_logonDate]] spawn {
		uiSleep 5;
		BIS_fnc_infoText = compile preprocessFileLineNumbers "ca\modules_e\functions\GUI\fn_infoText.sqf";
		_this spawn BIS_fnc_infoText;
	};
};

spawn_camera cameraEffect ["terminate","back"];
camDestroy spawn_camera;

dayz_enableRules = dayz_enableRulesOriginal;
dayz_maxGlobalAnimals = dayz_maxGlobalAnimalsOriginal;
fnc_usec_damageHandler = fnc_usec_damageHandlerOriginal;
player_spawn_2 = player_spawn_2_original;

dayz_slowCheck = [] spawn player_spawn_2;
if (dayz_enableRules && (profileNamespace getVariable ["streamerMode",0] == 0)) then { dayz_rulesHandle = execVM "rules.sqf"; };
