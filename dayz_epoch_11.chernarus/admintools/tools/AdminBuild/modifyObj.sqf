if (dayz_actionInProgress) exitWith {localize "str_epoch_player_40" call dayz_rollingMessages;};
dayz_actionInProgress = true;

private ["_cursorTarget","_reason","_lockable","_isAllowedUnderGround","_offset","_classname","_zheightdirection","_zheightchanged","_rotate","_objectHelperPos","_objHDiff","_position","_isOk","_dir","_vector","_cancel","_location2","_location","_finished","_proceed","_counter","_combination_1_Display","_combination_1","_combination_2","_combination_3","_combination","_combinationDisplay","_combination_4","_num_removed","_tmpbuilt","_vUp","_classnametmp","_text","_ghost","_objectHelper","_location1","_object","_helperColor","_canDo","_pos","_playerPos","_onLadder","_vehicle","_inVehicle","_canBuild","_friendsArr"];

_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);

clientside_KK_fnc_floatToString = {
    private "_arr";
    if (abs (_this - _this % 1) == 0) exitWith { str _this };
    _arr = toArray str abs (_this % 1);
    _arr set [0, 32];
    toString (toArray str (
        abs (_this - _this % 1) * _this / abs _this
    ) + _arr - [32])
};

clientside_KK_fnc_positionToString = {
    format [
        "[%1,%2,%3]",
        _this select 0 call clientside_KK_fnc_floatToString,
        _this select 1 call clientside_KK_fnc_floatToString,
        _this select 2 call clientside_KK_fnc_floatToString
    ]
};


DZE_Q = false;
DZE_Z = false;

DZE_Q_alt = false;
DZE_Z_alt = false;

DZE_Q_ctrl = false;
DZE_Z_ctrl = false;

DZE_5 = false;
DZE_4 = false;
DZE_6 = false;

DZE_F = false;

DZE_cancelBuilding = false;

DZE_updateVec = false;
DZE_memDir = 0;
DZE_memForBack = 0;
DZE_memLeftRight = 0;

call gear_ui_init;
closeDialog 1;

if (dayz_isSwimming) exitWith {dayz_actionInProgress = false; localize "str_player_26" call dayz_rollingMessages;};
if (_inVehicle) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_42" call dayz_rollingMessages;};
if (_onLadder) exitWith {dayz_actionInProgress = false; localize "str_player_21" call dayz_rollingMessages;};

_cursorTarget = cursorTarget;
if (isNil "_cursorTarget" || {isNull _cursorTarget}) exitWith {
	dayz_actionInProgress = false;
	"No object below cursor!" call dayz_rollingMessages;
};

_pos = [_cursorTarget] call FNC_GetPos;
_playerPos = [player] call FNC_GetPos;
_classname = typeOf _cursorTarget;
_classnametmp = _classname;
_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
_ghost = getText (configFile >> "CfgVehicles" >> _classname >> "ghostpreview");

_lockable = 0;
if (isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then {
	_lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable");
};

_isAllowedUnderGround = 1;
if (isNumber (configFile >> "CfgVehicles" >> _classname >> "nounderground")) then {
	_isAllowedUnderGround = getNumber(configFile >> "CfgVehicles" >> _classname >> "nounderground");
};

_offset = [(_pos select 0) - (_playerPos select 0), (_pos select 1) - (_playerPos select 1), (_pos select 2) - (_playerPos select 2)];
_objectHelper = objNull;
_isOk = true;
_location1 = [_cursorTarget] call FNC_GetPos;
_dir = getDir _cursorTarget;
_vector = [(vectorDir _cursorTarget),(vectorUp _cursorTarget)];
diag_log format [
	"Old %1: ws_x=%2, ws_y=%3, ws_z=%4, ws_dir=%5, ws_vect=[%6,%7]",
	_classname, 
	_pos select 0 call clientside_KK_fnc_floatToString, 
	_pos select 1 call clientside_KK_fnc_floatToString, 
	_pos select 2 call clientside_KK_fnc_floatToString, 
	_dir call clientside_KK_fnc_floatToString, 
	(_vector select 0) call clientside_KK_fnc_positionToString,
	(_vector select 1) call clientside_KK_fnc_positionToString
];

if (_ghost != "") then {
	_classname = _ghost;
};

_object = _cursorTarget;

if ((count _offset) <= 0) then {
	_offset = [0,(abs(((boundingBox _object)select 0) select 1)),0];
};

_objectHelper = "Sign_sphere10cm_EP1" createVehicle [0,0,0];
_helperColor = "#(argb,8,8,3)color(0,0,0,0,ca)";
_objectHelper setobjecttexture [0,_helperColor];
_objectHelper setPosATL (getPosATL _cursorTarget);
_cursorTarget attachTo [_objectHelper,[0,0,0]];
helperDetach = true;

if (isClass (configFile >> "SnapBuilding" >> _classname)) then {
	["","","",["Init",_object,_classname,_objectHelper]] spawn snap_build;
};

//if !(DZE_buildItem in DZE_noRotate) then{	// No easy way to know!
["","","",["Init","Init",0]] spawn build_vectors;
//};

_objHDiff = 0;
_cancel = false;
_reason = "";

_canDo = (!r_drag_sqf && !r_player_unconscious);
_position = [_objectHelper] call FNC_GetPos;

while {_isOk} do {

	_zheightchanged = false;
	_zheightdirection = "";
	_rotate = false;

	if (DZE_Q) then {
		DZE_Q = false;
		_zheightdirection = "up";
		_zheightchanged = true;
	};
	if (DZE_Z) then {
		DZE_Z = false;
		_zheightdirection = "down";
		_zheightchanged = true;
	};
	if (DZE_Q_alt) then {
		DZE_Q_alt = false;
		_zheightdirection = "up_alt";
		_zheightchanged = true;
	};
	if (DZE_Z_alt) then {
		DZE_Z_alt = false;
		_zheightdirection = "down_alt";
		_zheightchanged = true;
	};
	if (DZE_Q_ctrl) then {
		DZE_Q_ctrl = false;
		_zheightdirection = "up_ctrl";
		_zheightchanged = true;
	};
	if (DZE_Z_ctrl) then {
		DZE_Z_ctrl = false;
		_zheightdirection = "down_ctrl";
		_zheightchanged = true;
	};
	if (DZE_4) then {
		_rotate = true;
		DZE_4 = false;
		if (DZE_dirWithDegrees) then{
			DZE_memDir = DZE_memDir - DZE_curDegree;
		}else{
			DZE_memDir = DZE_memDir - 45;
		};
	};
	if (DZE_6) then {
		_rotate = true;
		DZE_6 = false;
		if (DZE_dirWithDegrees) then{
			DZE_memDir = DZE_memDir + DZE_curDegree;
		}else{
			DZE_memDir = DZE_memDir + 45;
		};
	};

	if (DZE_updateVec) then{
		[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
		DZE_updateVec = false;
	};

	if (DZE_F and _canDo) then {
		if (helperDetach) then {
			_objectHelper attachTo [player];
			DZE_memDir = DZE_memDir-(getDir player);
			helperDetach = false;
			[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
		} else {
			_objectHelperPos = getPosATL _objectHelper;
			detach _objectHelper;
			DZE_memDir = getDir _objectHelper;
			[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
			_objectHelper setPosATL _objectHelperPos;
			_objectHelper setVelocity [0,0,0];
			helperDetach = true;
		};
		DZE_F = false;
	};

	if (_rotate) then {
		[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
	};

	if (_zheightchanged) then {
		if (!helperDetach) then {
			detach _objectHelper;
		};

		_position = [_objectHelper] call FNC_GetPos;

		if (_zheightdirection == "up") then {
			_position set [2,((_position select 2)+0.1)];
			_objHDiff = _objHDiff + 0.1;
		};
		if (_zheightdirection == "down") then {
			_position set [2,((_position select 2)-0.1)];
			_objHDiff = _objHDiff - 0.1;
		};

		if (_zheightdirection == "up_alt") then {
			_position set [2,((_position select 2)+1)];
			_objHDiff = _objHDiff + 1;
		};
		if (_zheightdirection == "down_alt") then {
			_position set [2,((_position select 2)-1)];
			_objHDiff = _objHDiff - 1;
		};

		if (_zheightdirection == "up_ctrl") then {
			_position set [2,((_position select 2)+0.01)];
			_objHDiff = _objHDiff + 0.01;
		};
		if (_zheightdirection == "down_ctrl") then {
			_position set [2,((_position select 2)-0.01)];
			_objHDiff = _objHDiff - 0.01;
		};

		if ((_isAllowedUnderGround == 0) && {(_position select 2) < 0}) then {
			_position set [2,0];
		};

		if (surfaceIsWater _position) then {
			_objectHelper setPosASL _position;
		} else {
			_objectHelper setPosATL _position;
		};

		if (!helperDetach) then {
			_objectHelper attachTo [player];
		};
		[_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
	};

	uiSleep 0.5;

	_location2 = [player] call FNC_GetPos;
	_objectHelperPos = [_objectHelper] call FNC_GetPos;

	if (DZE_5) exitWith {
		_isOk = false;
		_position = [_object] call FNC_GetPos;
		detach _object;
		_dir = getDir _object;
		_vector = [(vectorDir _object),(vectorUp _object)];
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};

	if (_location1 distance _location2 > DZE_buildMaxMoveDistance) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = format[localize "STR_EPOCH_BUILD_FAIL_MOVED",DZE_buildMaxMoveDistance];
		detach _object;
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};

	if (_location1 distance _objectHelperPos > DZE_buildMaxMoveDistance) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = format[localize "STR_EPOCH_BUILD_FAIL_TOO_FAR",DZE_buildMaxMoveDistance];
		detach _object;
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};

	if (abs(_objHDiff) > DZE_buildMaxHeightDistance) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = format[localize "STR_EPOCH_BUILD_FAIL_HEIGHT",DZE_buildMaxHeightDistance];
		detach _object;
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};

	if (DZE_BuildHeightLimit > 0 && {_position select 2 > DZE_BuildHeightLimit}) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = format[localize "STR_EPOCH_PLAYER_168",DZE_BuildHeightLimit];
		detach _object;
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};

	if (DZE_cancelBuilding) exitWith {
		_isOk = false;
		_cancel = true;
		_reason = localize "STR_EPOCH_PLAYER_46";
		detach _object;
		detach _objectHelper;
		deleteVehicle _objectHelper;
	};
};

_isOk = true;
_proceed = false;
_counter = 0;
_location = [0,0,0];

if (!_cancel) then {
	_classname = _classnametmp;
	_location = _position;

	format[localize "str_epoch_player_138",_text] call dayz_rollingMessages;

	_proceed = true;
	if (_proceed) then {

		[format[localize "str_build_01",_text],1] call dayz_rollingMessages;

		_object setVariable ["OEMPos",_location,true]; //store original location as a variable

		if (_lockable > 1) then { //if item has code lock on it

			_combinationDisplay = ""; //define new display

			call { //generate random combinations depending on item type

				if (_lockable == 2) exitwith { // 2 lockbox
					dayz_combination = "";
					dayz_selectedVault = objNull;

					createDialog "KeyPadUI";
					waitUntil {!dialog};

					_combinationDisplay = dayz_combination call fnc_lockCode;
					if (keypadCancel || {typeName _combinationDisplay == "SCALAR"}) then {
						_combination_1 = (floor(random 3)) + 100; // 100=red,101=green,102=blue
						_combination_2 = floor(random 10);
						_combination_3 = floor(random 10);
						_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];
						dayz_combination = _combination;
						if (_combination_1 == 100) then {
							_combination_1_Display = localize "STR_TEAM_RED";
						};
						if (_combination_1 == 101) then {
							_combination_1_Display = localize "STR_TEAM_GREEN";
						};
						if (_combination_1 == 102) then {
							_combination_1_Display = localize "STR_TEAM_BLUE";
						};
						_combinationDisplay = format["%1%2%3",_combination_1_Display,_combination_2,_combination_3];
					} else {
						_combination = dayz_combination;
					};
				};

				if (_lockable == 3) exitwith { // 3 combolock
					DZE_topCombo = 0;
					DZE_midCombo = 0;
					DZE_botCombo = 0;
					DZE_Lock_Door = "";
					dayz_selectedDoor = objNull;

					dayz_actionInProgress = false;
					createDialog "ComboLockUI";
					waitUntil {!dialog};
					dayz_actionInProgress = true;

					if (keypadCancel || {parseNumber DZE_Lock_Door == 0}) then {
						_combination_1 = floor(random 10);
						_combination_2 = floor(random 10);
						_combination_3 = floor(random 10);
						_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];
						DZE_Lock_Door = _combination;
					} else {
						_combination = DZE_Lock_Door;
					};
					if (_classname in ["WoodenGate_1_DZ","WoodenGate_2_DZ","WoodenGate_3_DZ","WoodenGate_4_DZ"]) then {
						GateMethod = DZE_Lock_Door;
					};

					_combinationDisplay = _combination;
				};

				if (_lockable == 4) exitwith { // 4 safe
					dayz_combination = "";
					dayz_selectedVault = objNull;

					createDialog "SafeKeyPad";
					waitUntil {!dialog};

					if (keypadCancel || {(parseNumber dayz_combination) > 9999} || {count (toArray (dayz_combination)) < 4}) then {
						_combination_1 = floor(random 10);
						_combination_2 = floor(random 10);
						_combination_3 = floor(random 10);
						_combination_4 = floor(random 10);
						_combination = format["%1%2%3%4",_combination_1,_combination_2,_combination_3,_combination_4];
						dayz_combination = _combination;
					} else {
						_combination = dayz_combination;
					};
					_combinationDisplay = _combination;
				};
			};

			_object setVariable ["CharacterID",_combination,true]; //set combination as a character ID

			//call publish precompiled function with given args and send public variable to server to save item to database
			if (DZE_permanentPlot) then {
				_object setVariable ["ownerPUID",dayz_playerUID,true];
				if (_lockable == 3) then {
					_friendsArr = [[dayz_playerUID,toArray (name player)]];
					_object setVariable ["doorfriends", _friendsArr, true];
				};
			};

			[format[localize "str_epoch_player_140",_combinationDisplay,_text],1] call dayz_rollingMessages; //display new combination
			systemChat format[localize "str_epoch_player_140",_combinationDisplay,_text];

		} else { //if not lockable item
			_object setVariable ["CharacterID",dayz_characterID,true];
			// fire?
			if (_object isKindOf "Land_Fire_DZ") then { //if campfire, then spawn, but do not publish to database
				[_object,true] call dayz_inflame;
				_object spawn player_fireMonitor;
			} else {
				if (DZE_permanentPlot) then {
					_object setVariable ["ownerPUID",dayz_playerUID,true];
					_friendsArr = [[dayz_playerUID,toArray (name player)]];
					_object setVariable ["plotfriends", _friendsArr, true];
				};
			};
		};
		if (DZE_GodModeBase && {!(_classname in DZE_GodModeBaseExclude)}) then {
			_object addEventHandler ["HandleDamage",{false}];
		};
		localize "str_epoch_player_46" call dayz_rollingMessages;
		diag_log format ["New %1: ws_x=%2, ws_y=%3, ws_z=%4, ws_dir=%5, ws_vect='[%6,%7]'",
			_classname, 
			_location select 0 call clientside_KK_fnc_floatToString, 
			_location select 1 call clientside_KK_fnc_floatToString, 
			_location select 2 call clientside_KK_fnc_floatToString, 
			_dir call clientside_KK_fnc_floatToString, 
			(_vector select 0) call clientside_KK_fnc_positionToString,
			(_vector select 1) call clientside_KK_fnc_positionToString
		];
		diag_log format ["%1 friends: door=%2, plot=%3", _classname, _object getVariable ["doorfriends", "[]"], _object getVariable ["plotfriends", "[]"]];
	};

} else { //cancel build if passed _cancel arg was true or building on roads/trader city
	format[localize "str_epoch_player_47",_text,_reason] call dayz_rollingMessages;
};

dayz_actionInProgress = false;
