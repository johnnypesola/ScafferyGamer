/* ----------------------------------------------------------------------------
   Upgrade vehicle weapon (using addWeapon and addMagazine)
   
   	[_veh, _gunType, _requestedUpgradeType] call server_upgradeVehWeapons;
   where _gunType is:
   	0 - machinegun
   	1 - AT
   	2 - AA
   	3 - armor

   each number is [gun,AT,AA,armor] where 5 first bits for each number is
   the upgrade level, 3 last bits is the upgrade type.

   Alternatively:
   	[_veh, _upgradeLvl] call server_upgradeVehWeapons;

   where _upgradeLvl is the existing upgradeLvl on the vehicle.

   By Pastorn
   ---------------------------------------------------------------------------- */

private ["_veh","_gunType","_upgradeLvl","_gun","_at","_aa","_level","_currentUpgradeType","_found","_shift_right","_requestedUpgradeType"];


_shift_right = {
	private ["_op","_sh","_powTab"];
	_powTab = [1,2,4,8,16,32,64,128,256];
	_op = _this select 0;
	_sh = _this select 1;
	if (_sh > 7) then {
		_op = 0;
	} else {
		if (_sh > 0) then {
			if (_op < 0) then {
				_op = _op - 256;
				_op = _op / (_powTab select _sh);
				_op = _op + (_powTab select (7 - _sh));
			} else {
				_op = _op / (_powTab select (_sh));
			};
		};
	};
	_op
};


_veh = _this select 0;
_upgradeLvl = _veh getVariable ["upgradeLvl", []];
if (4 > count _upgradeLvl) then {
	_upgradeLvl = [0, 0, 0, 0];
};

if (1 < count _this) then {
	_gunType = _this select 1;
	_requestedUpgradeType = _this select 2;
	diag_log format["Upgrading vehicle with gun type %1 and upgrade type %2...", _gunType, _requestedUpgradeType];
} else {
	_gunType = 0;
	if (0 < _upgradeLvl select 1) then {
		_gunType = 1;
	};
	if (0 < _upgradeLvl select 2) then {
		_gunType = 2;
	};
	if (0 < _upgradeLvl select 3) then {
		_gunType = 3;
	};
	_requestedUpgradeType = [(_upgradeLvl select (_gunType)), 5] call _shift_right;
	diag_log format["Setting vehicle upgrade with gun type %1 and upgrade type %2...", _gunType, _requestedUpgradeType];
};

if (!((typeOf _veh) in ["AN2_DZ"])) exitWith {
	diag_log format ["Vehicle Weapon Upgrade: Vehicle type %1 not in upgradable vehicles list!", _veh];
};


if (_gunType == 0) then {

	// Process gun
	_gun = _upgradeLvl select 0;
	_level = _gun mod 31;	// _gun bitwise and 0x11111
	_currentUpgradeType = [_gun, 5] call _shift_right;

	diag_log format["Current vehicle gun upgrade type and upgrade level is %1, %2...", _currentUpgradeType, _level];
	if (_requestedUpgradeType == 1) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M240_veh";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M240_veh";
			_veh addWeapon "M240_veh_2";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
			_veh addMagazine "100Rnd_762x51_M240";
		};
		if (_level == 5) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
		};
		if (_level == 11) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "TwinM134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
			_veh addMagazine "4000Rnd_762x51_M134";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
	if (_requestedUpgradeType == 2) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M2";
			_veh addWeapon "M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
	if (_requestedUpgradeType == 4) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "DSHKM";
			_veh addWeapon "DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
	if (_requestedUpgradeType == 7) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "MK19";
			_veh addWeapon "MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
};
if (_gunType == 1) then {

	// Process AT
	_at = _upgradeLvl select 1;
	_level = _at mod 31;	// _gun bitwise and 31
	_currentUpgradeType = [_at, 5] call _shift_right;

	diag_log format["Current vehicle gun upgrade type and upgrade level is %1, %2...", _currentUpgradeType, _level];
	if (_requestedUpgradeType == 1) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "TOWLauncherSingle";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "TOWLauncher";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
	if (_requestedUpgradeType == 2) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "AT13LauncherSingle";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "AT5Launcher";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
};

if (_gunType == 2) then {

	// Process AA
	_aa = _upgradeLvl select 1;
	_level = _aa mod 31;	// _gun bitwise and 31
	_currentUpgradeType = [_aa, 5] call _shift_right;

	diag_log format["Current vehicle gun upgrade type and upgrade level is %1, %2...", _currentUpgradeType, _level];
	if (_requestedUpgradeType == 1) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "StingerLaucher";
			_veh addMagazine "8Rnd_Stinger";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "StingerLauncher_twice";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
	if (_requestedUpgradeType == 2) then {
		if (_currentUpgradeType != _requestedUpgradeType) then {
			_level = 0;
		};
		if (_level == 0) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "R73Launcher";
			_veh addMagazine "4Rnd_R73";
			_veh addMagazine "4Rnd_R73";
		};
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "R73Launcher_2";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
		};
		_level = _level + 1;
		_veh setVariable ["upgradeLvl", (_level + _requestedUpgradeType)];
	};
};
