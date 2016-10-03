/*
	DayZ Base Building
	Made for DayZ Epoch please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
*/
/*
Build Snapping - Extended v1.6.5

Idea and first code:
Maca

Reworked by: OtterNas3
01/11/2014
Last update 02/20/2014

Last Updated by
GeekGarage - 03/31/2014
*/
private ["_location","_dir","_classname","_item","_hasRequiredTools","_missingT","_missingB","_hastoolweapon","_cancel","_reason","_started","_finished","_animState","_isMedic","_dis","_sfx","_hasbuilditem","_tmpbuilt","_onLadder","_isWater","_require","_text","_offset","_IsNearPlot","_isOk","_location1","_location2","_counter","_limit","_proceed","_num_removed","_position","_object","_canBuildOnPlot","_friendlies","_nearestPole","_ownerID","_findNearestPoles","_findNearestPole","_distance","_classnametmp","_ghost","_isPole","_needText","_lockable","_zheightchanged","_rotate","_combination_1","_combination_2","_combination_3","_combination_4","_combination","_combination_1_Display","_combinationDisplay","_zheightdirection","_abort","_isNear","_need","_objHupDiff","_needNear","_vehicle","_inVehicle","_previewCounter","_requireplot","_objHDiff","_isLandFireDZ","_isTankTrap","_isNear2","_typeIsString","_isBuildAdmin","_needBuildItem","_hasbuilditems","_itemIn","_countIn","_qty","_missingQty","_textMissing","_removed","_tobe_removed_total","_removed_total","_playerName"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_40") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

// disallow building if too many objects are found within 30m
if((count ((getPosATL player) nearObjects ["All",30])) >= DZE_BuildingLimit) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_41"), "PLAIN DOWN"];};

_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater = 		dayz_isSwimming;
_cancel = false;
_reason = "";
_canBuildOnPlot = false;

if(isNil "adminBuild") then {
	adminBuild = false;
};

_isBuildAdmin = adminBuild; // (getPlayerUID player) in AdminList;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_playerName = name player;
_playerUID = getPlayerUID player;

DZE_Q = false;
DZE_Z = false;

DZE_Q_alt = false;
DZE_Z_alt = false;

DZE_Q_ctrl = false;
DZE_Z_ctrl = false;

DZE_5 = false;
DZE_4 = false;
DZE_6 = false;

DZE_cancelBuilding = false;

call gear_ui_init;
closeDialog 1;

if (_isWater) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_26", "PLAIN DOWN"];};
if (_inVehicle) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_42"), "PLAIN DOWN"];};
if (_onLadder) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_21", "PLAIN DOWN"];};
if (player getVariable["combattimeout", 0] >= time) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_43"), "PLAIN DOWN"];};

_typeIsString = ((typeName _this) == "STRING");
//diag_log format["Type is STRING: %1",_typeIsString];
if (_typeIsString) then {
	_item =	_this;
};
if (!_typeIsString) then {
	_item =	_this select 0;
};

// Need Near Requirements
_abort = false;
_distance = 10;
_reason = "";

if (_typeIsString) then {
	_needNear = 	getArray (configFile >> "CfgMagazines" >> _item >> "ItemActions" >> "Build" >> "neednearby");

	{
		switch(_x) do{
			case "fire":
			{
				_isNear = {inflamed _x} count (getPosATL player nearObjects _distance);
				if(_isNear == 0) then {
					_abort = true;
					_reason = "fire";
				};
			};
			case "workshop":
			{
				_isNear = count (nearestObjects [player, ["Wooden_shed_DZ","WoodShack_DZ","WorkBench_DZ"], _distance]);
				if(_isNear == 0) then {
					_abort = true;
					_reason = "workshop";
				};
			};
			case "fueltank":
			{
				_isNear = count (nearestObjects [player, dayz_fuelsources, _distance]);
				_isNear2 = nearestObjects [player, dayz_fuelsources, _distance];
				if(_isNear == 0) then {
					_abort = true;
					_reason = "fuel tank";
					_distance = 30;
				};
			};
		};
	} forEach _needNear;


	if(_abort) exitWith {
		cutText [format[(localize "str_epoch_player_135"),_reason,_distance], "PLAIN DOWN"];
		DZE_ActionInProgress = false;
	};
};

if (_typeIsString) then {
	_classname = 	getText (configFile >> "CfgMagazines" >> _item >> "ItemActions" >> "Build" >> "create");
	_classnametmp = _classname;
	_require =  getArray (configFile >> "cfgMagazines" >> _this >> "ItemActions" >> "Build" >> "require");
};
if (!_typeIsString) then {
	_classname = _this select 0;
	_classnametmp = _classname;
	_require = _this select 1;
};
_text = 		getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
_ghost = getText (configFile >> "CfgVehicles" >> _classname >> "ghostpreview");

_lockable = 0;
if(isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then {
	_lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable");
};

_requireplot = DZE_requireplot;
if(isNumber (configFile >> "CfgVehicles" >> _classname >> "requireplot")) then {
	_requireplot = getNumber(configFile >> "CfgVehicles" >> _classname >> "requireplot");
};

_isAllowedUnderGround = 1;
if(isNumber (configFile >> "CfgVehicles" >> _classname >> "nounderground")) then {
	_isAllowedUnderGround = getNumber(configFile >> "CfgVehicles" >> _classname >> "nounderground");
};


if (!_typeIsString) then {
	_offset = _this select 3;
};
if (_typeIsString) then {
	_offset = 	getArray (configFile >> "CfgVehicles" >> _classname >> "offset");
	if((count _offset) <= 0) then {
		_offset = [0,1.5,0];
	};
};

_isPole = (_classname == "Plastic_Pole_EP1_DZ");
_isLandFireDZ = (_classname == "Land_Fire_DZ");

_distance = DZE_PlotPole select 0;
_needText = localize "str_epoch_player_246";

if(_isPole) then {
	_distance = DZE_PlotPole select 1;
};

// check for near plot
_findNearestPoles = nearestObjects [(vehicle player), ["Plastic_Pole_EP1_DZ"], _distance];
_findNearestPole = [];

{
	if (alive _x) then {
		_findNearestPole set [(count _findNearestPole),_x];
	};
} foreach _findNearestPoles;

_IsNearPlot = count (_findNearestPole);

// If item is plot pole && another one exists within 45m
if(_isPole && _IsNearPlot > 0) exitWith {  DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_44") , "PLAIN DOWN"]; };

if(_IsNearPlot == 0) then {

	// Allow building of plot
	if(_requireplot == 0 || _isLandFireDZ) then {
		_canBuildOnPlot = true;
	};

} else {
	// Since there are plots nearby we check for ownership && then for friend status

	// check nearby plots ownership && then for friend status
	_nearestPole = _findNearestPole select 0;

	// Find owner
	_ownerID = _nearestPole getVariable ["CharacterID","0"];

	// diag_log format["DEBUG BUILDING: %1 = %2", dayz_characterID, _ownerID];

	// check if friendly to owner
	if(dayz_characterID == _ownerID) then {  //Keep ownership
		// owner can build anything within his plot except other plots
		if(!_isPole) then {
			_canBuildOnPlot = true;
		};

	} else {
		// disallow building plot
		if(!_isPole) then {
			_friendlies		= player getVariable ["friendlyTo",[]];
			// check if friendly to owner
			if(_ownerID in _friendlies) then {
				_canBuildOnPlot = true;
			};
		};
	};
};

//Item Check
if(!_canBuildOnPlot) exitWith {  DZE_ActionInProgress = false; cutText [format[(localize "STR_EPOCH_PLAYER_135"),_needText,_distance] , "PLAIN DOWN"]; };

_missingT = "";
_missingB = "";
_hasRequiredTools = true;
_hasbuilditem = true;
if (!_isBuildAdmin) then {
	{
		//diag_log format["Testing for tool: %1",_x];
		_hastoolweapon = _x in weapons player;
		if(!_hastoolweapon) exitWith {_hasRequiredTools = false; _missingT = getText (configFile >> "cfgWeapons" >> _x >> "displayName");};
	} forEach _require;

	if (!_typeIsString && _hasRequiredTools) then {
		_needBuildItem = _this select 2;
		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			_qty = { (_x == _itemIn) || (configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn) } count magazines player;
			if(_qty < _countIn) exitWith { _missingB = getText(configFile >> "CfgMagazines" >> _itemIn >> "displayName"); _missingQty = (_countIn - _qty); _hasbuilditem = false;};
		} forEach _needBuildItem;
	};
	
	if (_typeIsString && _hasRequiredTools) then {
		_hasbuilditem = _this in magazines player;
	};
};
// Message If missing
if (!_hasRequiredTools) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_137"),_missingT] , "PLAIN DOWN"];};

if (!_typeIsString && !_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_146"),_missingQty, _missingB], "PLAIN DOWN"];};

if (_typeIsString && !_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_player_31"),_text,"build"] , "PLAIN DOWN"]; };


//Proceed after item check
if (_hasRequiredTools && _hasbuilditem) then {

	_location = [0,0,0];
	_isOk = true;

	// get inital players position
	_location1 = getPosATL player;
	_dir = getDir player;


	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
	_object setDir _dir;
	_object attachTo [player,_offset];
	
	_position = getPosATL _object;

	cutText [(localize "str_epoch_player_45"), "PLAIN DOWN"];

	player allowDamage false;
	SnappingOffset = _offset;
	SnappingDir = 0;
	SnappingSpotMarkers = [];
	SnappingEnabled = false;
	SnappedOffsetZ = 0;
	SnappingResetPos = false;

	if (isClass (missionConfigFile >> "SnapPoints" >> _classname)) then {
		s_building_snapping = player addAction ["<t color=""#0000ff"">Toggle Snapping</t>", "custom\snap_build\player_toggleSnapping.sqf",_classname, 3, true, false, "",""];
	};
	
	_snapper = [_object, _classname] spawn snap_object;
	_key_monitor = [] spawn player_buildControls ;

	while {_isOk} do {
		sleep 1;
		_location2 = getPosATL player;

		if(DZE_5) exitWith {
			_isOk = false;
			detach _object;
			_dir = getDir _object;
			_position = getPosATL _object;
		};

		if(_location1 distance _location2 > 10) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "You've moved to far away from where you started building (within 10 meters)"; 
			detach _object;
		};
		
		if(((SnappingOffset select 2) > 20) or ((SnappingOffset select 2) < -20)) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "Cannot move up or down more than 20 meters"; 
			detach _object;
		};

		if (player getVariable["combattimeout", 0] >= time) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = (localize "str_epoch_player_43");
			detach _object;
		};

		if (DZE_cancelBuilding) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "Cancelled building.";
			detach _object;
		};
	};

	terminate _snapper;
	terminate _key_monitor;
	if (isClass (missionConfigFile >> "SnapPoints" >> _classname)) then {
		player removeAction s_building_snapping;
	};
	player allowDamage true;
	
	//No building on roads unless toggled
	if (!DZE_BuildOnRoads) then {
		if (isOnRoad _position) then { _cancel = true; _reason = "Cannot build on a road."; };
	};
	// No building in trader zones
	if(!canbuild) then { _cancel = true; _reason = "Cannot build in a city."; };

	if(!_cancel) then {
		//diag_log "Cancel is FALSE";

		_classname = _classnametmp;

		_location = _position;

		if((_isAllowedUnderGround == 0) and ((_location select 2) < 0)) then {
			_location set [2,0];
		};
	
		_object setPosATL _location;
		cutText [format[(localize "str_epoch_player_138"),_text], "PLAIN DOWN"];
		
		_limit = 3;

		if (DZE_StaticConstructionCount > 0) then {
			_limit = DZE_StaticConstructionCount;
		} else {
			if (isNumber (configFile >> "CfgVehicles" >> _classname >> "constructioncount")) then {
				_limit = getNumber(configFile >> "CfgVehicles" >> _classname >> "constructioncount");
			};
		};

		_isOk = true;
		_proceed = false;
		_counter = 0;

		while {_isOk && !_isBuildAdmin} do {

			[10,10] call dayz_HungerThirst;
			player playActionNow "Medic";

			_dis=20;
			_sfx = "repair";
			[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
			[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

			r_interrupt = false;
			_animState = animationState player;
			r_doLoop = true;
			_started = false;
			_finished = false;

			while {r_doLoop} do {
				_animState = animationState player;
				_isMedic = ["medic",_animState] call fnc_inString;
				if (_isMedic) then {
					_started = true;
				};
				if (_started && !_isMedic) then {
					r_doLoop = false;
					_finished = true;
				};
				if (r_interrupt || (player getVariable["combattimeout", 0] >= time)) then {
					r_doLoop = false;
				};
				if (DZE_cancelBuilding) exitWith {
					r_doLoop = false;
				};
				sleep 0.1;
			};
			r_doLoop = false;


			if(!_finished) exitWith {
				_isOk = false;
				_proceed = false;
			};

			if(_finished) then {
				_counter = _counter + 1;
			};

			cutText [format[(localize "str_epoch_player_139"),_text, _counter,_limit], "PLAIN DOWN"];

			if(_counter == _limit) exitWith {
				_isOk = false;
				_proceed = true;
			};

		};

		if (_isBuildAdmin) then {
			_isOk = false;
			_proceed = true;
		};
		
		if (_proceed) then {
		//diag_log "Proceed OK";
			_tobe_removed_total = 0;
			_removed_total = 0;
			_temp_removed_array = [];
			if (!_isBuildAdmin) then {
				//diag_log "Is Admin REMOVE NOT OK";
				if (_typeIsString) then {
					_tobe_removed_total = ([player,_item] call BIS_fnc_invRemove);
					_removed_total = _tobe_removed_total;
				};
				if (!_typeIsString) then {
					{
						_removed = 0;
						_itemIn = _x select 0;
						_countIn = _x select 1;
						// //diag_log format["Recipe Finish: %1 %2", _itemIn,_countIn];
						_tobe_removed_total = _tobe_removed_total + _countIn;
			
						{					
							if( (_removed < _countIn) && ((_x == _itemIn) || configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn)) then {
								_num_removed = ([player,_x] call BIS_fnc_invRemove);
								_removed = _removed + _num_removed;
								_removed_total = _removed_total + _num_removed;
								if(_num_removed >= 1) then {
									_temp_removed_array set [count _temp_removed_array,_x];
								};
							};
						} forEach magazines player;
					} forEach _needBuildItem;
				};
			} else {
				//diag_log "Is Admin REMOVE OK";
				_tobe_removed_total = 1;
				_removed_total = 1;
			};
			if((_tobe_removed_total == _removed_total) && (_removed_total >= 1)) then {
				//diag_log "Removed Item OK";
				cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];

				// This is just annoying; removed :P
				//if (_isPole) then {
				//	[] spawn player_plotPreview;
				//};

				_object setVariable ["OEMPos",_location,true];

				if(_lockable > 1) then {
					//diag_log "Is Lockable OK";
					_combinationDisplay = "";

					switch (_lockable) do {

						case 2: { // 2 lockbox
							_combination_1 = (floor(random 3)) + 100; // 100=red,101=green,102=blue
							_combination_2 = floor(random 10);
							_combination_3 = floor(random 10);
							_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];
							
							dayz_combination = _combination;
							if (_combination_1 == 100) then {
								_combination_1_Display = "Red";
							};
							if (_combination_1 == 101) then {
								_combination_1_Display = "Green";
							};
							if (_combination_1 == 102) then {
								_combination_1_Display = "Blue";
							};
							_combinationDisplay = format["%1%2%3",_combination_1_Display,_combination_2,_combination_3];
						};

						case 3: { // 3 combolock
							_combination_1 = floor(random 10);
							_combination_2 = floor(random 10);
							_combination_3 = floor(random 10);
							_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];
							dayz_combination = _combination;
							_combinationDisplay = _combination;
						};

						case 4: { // 4 safe
							_combination_1 = floor(random 10);
							_combination_2 = floor(random 10);
							_combination_3 = floor(random 10);
							_combination_4 = floor(random 10);
							_combination = format["%1%2%3%4",_combination_1,_combination_2,_combination_3,_combination_4];
							dayz_combination = _combination;
							_combinationDisplay = _combination;
						};
					};

					_object setVariable ["CharacterID",_combination,true];


					PVDZE_obj_Publish = [_combination,_object,[_dir,_location],_classname,_playerName];
					//diag_log "Publish Lockable";
					publicVariableServer "PVDZE_obj_Publish";

					cutText [format[(localize "str_epoch_player_140"),_combinationDisplay,_text], "PLAIN DOWN", 5];


				} else {

					_object setVariable ["CharacterID",dayz_characterID,true];

					// fire?
					if(_object isKindOf "Land_Fire_DZ") then {
						_object spawn player_fireMonitor;
					} else {

						if ("Explosive" == typeOf _object) then {
							[] spawn {
								Private ["_count"];
								_count = 10;
								while { _count > 0 } do {
									hint format ["%1 seconds until Explosive Tripwire is armed...", _count];
									sleep 1;
									_count = _count - 1;
								};	
								hint "Tripwire is now armed!";
							};
						};

						//diag_log "Publish Other";
						PVDZE_obj_Publish = [dayz_characterID,_object,[_dir,_location],_classname,_playerName];
						publicVariableServer "PVDZE_obj_Publish";
					};
				};
			} else {
				//diag_log "Remove Item NOT OK";
				deleteVehicle _object;
				cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
				{
					[player,_x] call BIS_fnc_invAdd;
				} forEach _temp_removed_array;				
			};

		} else {
			//diag_log "Proceed NOT OK";
			r_interrupt = false;
			if (vehicle player == player) then {
				[objNull, player, rSwitchMove,""] call RE;
				player playActionNow "stop";
			};

			deleteVehicle _object;
			cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
		};

	} else {
		//diag_log "Cancel is TRUE";
		deleteVehicle _object;
		cutText [format[(localize "str_epoch_player_47"),_text,_reason], "PLAIN DOWN"];
	};
};

DZE_ActionInProgress = false;
