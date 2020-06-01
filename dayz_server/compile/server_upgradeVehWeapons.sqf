/* ----------------------------------------------------------------------------
 * Upgrade vehicle weapon (using addWeapon and addMagazine)
 *
 * [_veh, _owner, _upgradeArray, _gunType, _requestedCal] call server_upgradeVehWeapons;
 *   where _gunType is:
 *     0 - machinegun
 *     1 - AT
 *     2 - AA
 *     3 - armor
 *
 * or just set upgrade level:
 * [_veh, _owner, _upgradeArray] call server_upgradeVehWeapons;
 * 
 * Each gun type is [gun,AT,AA,armor] where each element is a sub array: [level,caliber].
 * "level" is the upgrade level, "caliber" is the upgrade type/caliber.
 * Having value 0 on "caliber" does not add any upgrade to the vehicle.
 *
 * Alternatively:
 * [_veh] call server_upgradeVehWeapons;
 *
 * where the _veh vehicle must have "upgradeArray" variable set with the existing upgradeArray on the vehicle.
 *
 * By Pastorn
 * ----------------------------------------------------------------------------
 */

private ["_veh","_gunType","_upgradeArray","_gun","_at","_aa","_level","_currentCal","_doUpgrade","_requestedCal","_upgradeData","_vehicleTypes","_vehicleTypeLevelMultiplier","_multiplier","_mulIdx","_gunTypeName","_owner","_needMoreLevel","_msg"];

_vehicleTypes 			= ["GNT_C185U_DZ", "GNT_C185_DZ", "GNT_C185R_DZ", "GNT_C185C_DZ", "AN2_DZ", "AN2_2_DZ", "AN2_2_TK_CIV_EP1_DZ", "C130J_US_EP1_DZ", "MV22_DZ"];
_vehicleTypeLevelMultiplier 	= [2, 2, 2, 2, 2, 2, 2, 1, 4];
_gunTypeName = ["Machine Gun", "Anti Tank", "Anti Air", "Bomb"];


_str = "";
_needMoreLevel = true;
_veh = _this select 0;
_owner = _this select 1;
_upgradeArray = _this select 2;
diag_log format["Current vehicle %1 upgrade level is %2", typeOf _veh, _upgradeArray];
if (4 > count _upgradeArray) then {
	_upgradeArray = [[0,0],[0,0],[0,0],[0,0]];
	diag_log "Resetting upgradeArray, it is empty.";
};

if (5 == count _this) then {
	_gunType = _this select 3;
	_requestedCal = _this select 4;

	_doUpgrade = true;
	diag_log format["Upgrading vehicle with gun type %1 and upgrade type/caliber %2...", _gunType, _requestedCal];
} else {
	diag_log "Vehicle was loaded with upgrades.";
	_doUpgrade = false;

	_gunType = 0;
	_gun = _upgradeArray select 0;
	if (0 < _gun select 1) then {	// Checks upgrade type for each gun type (here: 0:7.62mm, 1:0.5cal, 2:12.7x99mm, 3:40mm GMG)
		_gunType = 0;
	};
	_gun = _upgradeArray select 1;
	if (0 < _gun select 1) then {	// Checks upgrade type for each AT type (here: 0:NATO, 1:Russian)
		_gunType = 1;
	};
	_gun = _upgradeArray select 2;
	if (0 < _gun select 1) then {	// Checks upgrade type for each AA type (here: 0:NATO, 1:Russian)
		_gunType = 2;
	};
	_gun = _upgradeArray select 3;
	if (0 < _gun select 1) then {	// Checks upgrade type for each ARMOR type (here: 0:NATO, 1:Russian)
		_gunType = 3;
	};
	// Get type / caliber for missiles/guns
	_requestedCal = (_upgradeArray select _gunType) select 1;
	diag_log format["Setting vehicle upgrade with gun type %1 and upgrade type/caliber %2...", _gunTypeName select _gunType, _requestedCal];
};

if (!((typeOf _veh) in _vehicleTypes)) exitWith {
	diag_log format ["Vehicle Weapon Upgrade: Vehicle type %1 not in upgradable vehicles list!", _veh];
};

// Applicable multiplier
_mulIdx = _vehicleTypes find (toUpper(typeOf _veh));
if (_mulIdx == -1) then {
	diag_log "Whoops, didn't find multiplier index... using 0";
	_mulIdx = 0
};
_multiplier = _vehicleTypeLevelMultiplier select _mulIdx;

if (_gunType == 0) then {

	// Process gun
	_gun = _upgradeArray select 0;
	_level = _gun select 0;
	_currentCal = _gun select 1;

	diag_log format["Current vehicle MG upgrade type and upgrade level is %1, %2...", _currentCal, _level];
	if (_requestedCal == 1) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level >= 12*_multiplier) then {
			if (_level == 12*_multiplier) then {
				
				{_veh removeWeapon _x} forEach weapons _veh;
				_veh addWeapon "TwinM134";
				_veh addMagazine "4000Rnd_762x51_M134";
				_veh addMagazine "4000Rnd_762x51_M134";
				[nil,_owner,rTitleText, format["Added twin miniguns to %1", typeOf _veh], "PLAIN",3] call RE;
				_needMoreLevel = false;
			} else {
				[nil,_owner,rTitleText, "Cannot upgrade any further!", "PLAIN",3] call RE;
			};
		} else {
			_str = _str + format["%1 steps to go for twin miniguns, ", 12*_multiplier-_level]; 
		};
		if (_level >= 6*_multiplier && _needMoreLevel) then {
			if (_level == 6*_multiplier) then {
				{_veh removeWeapon _x} forEach weapons _veh;
				_veh addWeapon "M134";
				_veh addMagazine "4000Rnd_762x51_M134";
				_veh addMagazine "4000Rnd_762x51_M134";
				[nil,_owner,rTitleText, format["Added minigun to %1", typeOf _veh], "PLAIN",3] call RE;
				_needMoreLevel = false;
			};
		} else {
			_str = _str + format["%1 steps to go for minigun, ", 6*_multiplier-_level]; 
		};
		if (_level >= 2*_multiplier && _needMoreLevel) then {
			if (_level == 2*_multiplier) then {
				{_veh removeWeapon _x} forEach weapons _veh;
				_veh addWeapon "M240_veh";
				_veh addWeapon "M240_veh_2";
				_veh addMagazine "100Rnd_762x51_M240";
				[nil,_owner,rTitleText, format["Added double M240 machine gun to %1", typeOf _veh], "PLAIN",3] call RE;
				_needMoreLevel = false;
			};
		} else {
			_str = _str + format["%1 steps to go for dual M240 machineguns, ", 2*_multiplier-_level]; 
		};
		if (_level >= _multiplier && _needMoreLevel) then {
			if (_level == _multiplier) then {
				{_veh removeWeapon _x} forEach weapons _veh;
				_veh addWeapon "M240_veh";
				_veh addMagazine "100Rnd_762x51_M240";
				[nil,_owner,rTitleText, format["Added M240 machine gun to %1", typeOf _veh], "PLAIN",3] call RE;
				_needMoreLevel = false;
			};
		} else {
			_str = _str + format["%1 steps to go for M240 machine gun, ", _multiplier-_level]; 
		};
		if (_needMoreLevel) then {
			[nil,_owner,rTitleText, format["Upgraded to level %1 - %2on 7.62mm caliber", _level, _str], "PLAIN",3] call RE;
		};
		diag_log format["New vehicle %1 upgrade level is %2, caliber is %3", typeOf _veh, _level, _requestedCal];
	};
	if (_requestedCal == 2) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1*_multiplier) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			diag_log format["Added single M2 machinegun to %1", typeOf _veh];
		};
		if (_level == 2*_multiplier) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "M2";
			_veh addWeapon "M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			_veh addMagazine "100Rnd_127x99_M2";
			diag_log format["Added dual M2 machineguns to %1", typeOf _veh];
		};
		diag_log format["New vehicle %1 upgrade level is %2, caliber is %3", typeOf _veh, _level, _requestedCal];
	};
	if (_requestedCal == 4) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "DSHKM";
			_veh addWeapon "DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
			_veh addMagazine "150Rnd_127x107_DSHKM";
		};
		diag_log format["New vehicle %1 upgrade level is %2, caliber is %3", typeOf _veh, _level, _requestedCal];
	};
	if (_requestedCal == 7) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "MK19";
			_veh addWeapon "MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
			_veh addMagazine "48Rnd_40mm_MK19";
		};
		diag_log format["New vehicle %1 upgrade level is %2, caliber is %3", typeOf _veh, _level, _requestedCal];
	};
};
if (_gunType == 1) then {

	// Process AT
	_gun = _upgradeArray select 1;
	_level = _gun select 0;
	_currentCal = _gun select 1;

	diag_log format["Current vehicle AT upgrade type and upgrade level is %1, %2...", _currentCal, _level];
	if (_requestedCal == 1) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "TOWLauncherSingle";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
			_veh addMagazine "6Rnd_TOW_HMMWV";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "TOWLauncher";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
			_veh addMagazine "2Rnd_TOW";
		};
		diag_log format["New vehicle %1 upgrade level is %2, type is %3", typeOf _veh, _level, _requestedCal];
	};
	if (_requestedCal == 2) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "AT13LauncherSingle";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
			_veh addMagazine "6Rnd_AT13";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "AT5Launcher";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
			_veh addMagazine "5Rnd_AT5_BRDM2";
		};
		diag_log format["New vehicle %1 upgrade level is %2, type is %3", typeOf _veh, _level, _requestedCal];
	};
};
if (_gunType == 2) then {

	// Process AA
	_gun = _upgradeArray select 2;
	_level = _gun select 0;
	_currentCal = _gun select 1;

	diag_log format["Current vehicle AA upgrade type and upgrade level is %1, %2...", _currentCal, _level];
	if (_requestedCal == 1) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "StingerLaucher";
			_veh addMagazine "8Rnd_Stinger";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "AALauncher_twice";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
			_veh addMagazine "2Rnd_Stinger";
		};
		diag_log format["New vehicle %1 upgrade level is %2, type is %3", typeOf _veh, _level, _requestedCal];
	};
	if (_requestedCal == 2) then {
		if (_currentCal != _requestedCal) then {
			_level = 0;
		};
		if (_doUpgrade) then { _level = _level + 1; };
		if (_level == 1) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "R73Launcher";
			_veh addMagazine "4Rnd_R73";
			_veh addMagazine "4Rnd_R73";
		};
		if (_level == 2) then {
			{_veh removeWeapon _x} forEach weapons _veh;
			_veh addWeapon "R73Launcher_2";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
			_veh addMagazine "2Rnd_R73";
		};
		diag_log format["New vehicle %1 upgrade level is %2, type is %3", typeOf _veh, _level, _requestedCal];
	};
};

_upgradeData = [[0,0],[0,0],[0,0],[0,0]];
_upgradeData set [_gunType, [_level, _requestedCal]];
_veh setVariable ["upgradeArray", _upgradeData];
diag_log format["Vehicle %1 upgrade array is now %2", typeOf _veh, _upgradeData];
