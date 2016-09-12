/*
	Place Machinegun script
*/
/*

Idea and first code:
Maca

Reworked by: Pastorn
09/18/2014
Last update 09/18/2014

*/
private ["_location","_dir","_classname","_item","_hasRequiredTools","_missingT","_missingB","_hastoolweapon","_cancel","_reason","_started","_finished","_animState","_isMedic","_dis","_sfx","_hasbuilditem","_onLadder","_isWater","_require","_text","_offset","_isOk","_location1","_location2","_counter","_limit","_proceed","_position","_object","_classnametmp","_vehicle","_inVehicle","_isBuildAdmin","_needBuildItem","_hasbuilditems","_itemIn","_countIn","_qty","_missingQty","_zheightchanged","_zheightdirection","_rotate","_objHDiff","_canBuildOnPlot","_findNearestPoles","_findNearestPole","_distance","_IsNearPlot","_nearestPole","_ownerID","_isPole","_friendlies","_playerName"];

// Machine gun type
_item = _this select 0;

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_40") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

// disallow building if too many objects are found within 30m
if((count ((getPosATL player) nearObjects ["All",30])) >= DZE_BuildingLimit) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_41"), "PLAIN DOWN"];};

_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater = 		dayz_isSwimming;
_cancel = false;
_reason = "";

if(isNil "adminBuild") then {
	adminBuild = false;
};

_isBuildAdmin = adminBuild; // (getPlayerUID player) in AdminList;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_playerName = name player;

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

_isAllowedUnderGround = 0;

_offset = [0, 1.5, 1];

// Need Near Requirements
_reason = "";
_canBuildOnPlot = false;

//_item =	"M2StaticMG";
_classname = _item; 
_classnametmp = _classname;
_require =  ["ItemToolbox"];
if (_item == "M2StaticMG") then {
	_needBuildItem = ["100Rnd_127x99_M2", "100Rnd_127x99_M2", "100Rnd_127x99_M2", "100Rnd_127x99_M2", "ItemPole", "ItemPole", "ItemPole", "PartGeneric"];
} else {
	_needBuildItem = ["50Rnd_127x107_DSHKM", "50Rnd_127x107_DSHKM", "50Rnd_127x107_DSHKM", "50Rnd_127x107_DSHKM", "ItemPole", "ItemPole", "ItemPole", "PartGeneric"];
};
_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");

_distance = DZE_PlotPole select 0;
_needText = localize "str_epoch_player_246";

// check for near plot
_findNearestPoles = nearestObjects [(vehicle player), ["Plastic_Pole_EP1_DZ"], _distance];
_findNearestPole = [];

{
	if (alive _x) then {
		_findNearestPole set [(count _findNearestPole),_x];
	};
} foreach _findNearestPoles;

_IsNearPlot = count (_findNearestPole);

// This will always require a friendly or owned plot pole
if(_IsNearPlot != 0) then {
	// Since there are plots nearby we check for ownership && then for friend status

	// check nearby plots ownership && then for friend status
	_nearestPole = _findNearestPole select 0;

	// Find owner
	_ownerID = _nearestPole getVariable ["CharacterID","0"];

	// diag_log format["DEBUG BUILDING: %1 = %2", dayz_characterID, _ownerID];

	// check if friendly to owner
	if(dayz_characterID == _ownerID) then {  //Keep ownership
		// owner can build anything within his plot except other plots
		_canBuildOnPlot = true;
	} else {
		_friendlies = player getVariable ["friendlyTo",[]];
		// check if friendly to owner
		if(_ownerID in _friendlies) then {
			_canBuildOnPlot = true;
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
};

// Message If missing
if (!_hasRequiredTools) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_137"),_missingT] , "PLAIN DOWN"];};

{
	_itemIn = _x;
	_countIn = { _x == _itemIn } count _needBuildItem;
	_qty = { _x == _itemIn } count magazines player;
	if (_countIn > _qty) exitWith { _missingB = getText(configFile >> "CfgMagazines" >> _x >> "displayName"); _missingQty = (_countIn - _qty); _hasbuilditem = false;};
} forEach _needBuildItem;

if (!_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_146"),_missingQty, _missingB], "PLAIN DOWN"];};

//Proceed after item check
if (_hasRequiredTools && _hasbuilditem) then {

	_location = [0,0,0];
	_isOk = true;

	// get inital players position
	_location1 = getPosATL player;
	_dir = getDir player;
	player allowDamage false;

	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
	
	_object attachTo [player,_offset];
	
	_position = getPosATL _object;

	cutText [(localize "str_epoch_player_45"), "PLAIN DOWN"];

	_objHDiff = 0;

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
			_dir = (_dir + 90) mod 360;
		};
		if (DZE_6) then {
			_rotate = true;
			DZE_6 = false;
			_dir = (_dir - 90) mod 360;
		};

		if(_rotate) then {
			_object setDir _dir;
			_object setPosATL _position;
			//diag_log format["DEBUG Rotate BUILDING POS: %1", _position];
		};

		if(_zheightchanged) then {
			detach _object;

			_position = getPosATL _object;

			if(_zheightdirection == "up") then {
				_position set [2,((_position select 2)+0.1)];
				_objHDiff = _objHDiff + 0.1;
			};
			if(_zheightdirection == "down") then {
				_position set [2,((_position select 2)-0.1)];
				_objHDiff = _objHDiff - 0.1;
			};

			if(_zheightdirection == "up_alt") then {
				_position set [2,((_position select 2)+1)];
				_objHDiff = _objHDiff + 1;
			};
			if(_zheightdirection == "down_alt") then {
				_position set [2,((_position select 2)-1)];
				_objHDiff = _objHDiff - 1;
			};

			if(_zheightdirection == "up_ctrl") then {
				_position set [2,((_position select 2)+0.01)];
				_objHDiff = _objHDiff + 0.01;
			};
			if(_zheightdirection == "down_ctrl") then {
				_position set [2,((_position select 2)-0.01)];
				_objHDiff = _objHDiff - 0.01;
			};

			_object setDir (getDir _object);

			if((_isAllowedUnderGround == 0) && ((_position select 2) < 0)) then {
				_position set [2,0];
			};

			_object setPosATL _position;

			//diag_log format["DEBUG Change BUILDING POS: %1", _position];

			_object attachTo [player];

		};

		sleep 0.5;


		sleep 1;
		_location2 = getPosATL player;

		if(DZE_5) exitWith {
			_isOk = false;
			detach _object;
			_dir = getDir _object;
			_position = getPosATL _object;
		};

		if(_location1 distance _location2 > 20) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "You've moved to far away from where you started building (within 20 meters)"; 
			detach _object;
		};
		
		if(abs(_objHDiff) > 5) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "Cannot move up or down more than 5 meters"; 
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

	player allowDamage true;

	// No building in trader zones
	if(!canbuild) then { _cancel = true; _reason = "Cannot build in a city."; };

	if(!_cancel) then {
		diag_log "Cancel is FALSE";

		_classname = _classnametmp;

		_location = _position;

		if((_isAllowedUnderGround == 0) and ((_location select 2) < 0)) then {
			_location set [2,0];
		};
	
		_object setPosATL _location;
		cutText [format[(localize "str_epoch_player_138"),_text], "PLAIN DOWN"];
		
		_limit = 3;

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
			diag_log "Proceed OK";
			_temp_removed_array = [];
			_hasbuilditem = true;
			if (!_isBuildAdmin) then {
				diag_log "Is Admin REMOVE NOT OK";
				{
					// //diag_log format["Recipe Finish: %1 %2", _itemIn,_countIn];
					_hasbuilditem = _x in magazines player;
					_itemIn = _x;
					_countIn = { _x == _itemIn } count _needBuildItem;
					_qty = { _x == _itemIn } count magazines player;

					if (!_hasbuilditem) exitWith { _missingB = getText(configFile >> "CfgMagazines" >> _x >> "displayName"); _missingQty = (_countIn - _qty); _hasbuilditem = false;};
					_temp_removed_array set [count _temp_removed_array,_itemIn];

					player removeMagazine _x;
				} forEach _needBuildItem;
			};
			if(_hasbuilditem) then {
				diag_log "Removed Item OK";
				cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];

				switch (_item) do {
					case "DSHKM_CDF": {
						_object removeMagazinesTurret ["50Rnd_127x107_DSHKM", [0]];
					};
					case "M2StaticMG": {
						_object removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
					};
				};

				_object setVariable ["OEMPos",_location,true];
				_object setVariable ["CharacterID",dayz_characterID,true];

				PVDZE_obj_Publish = [dayz_characterID,_object,[_dir,_location],_classname,_playerName];
				publicVariableServer "PVDZE_obj_Publish";
			} else {
				diag_log "Remove Item NOT OK";
				deleteVehicle _object;
				cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
				{
					[player,_x] call BIS_fnc_invAdd;
				} forEach _temp_removed_array;				
			};

		} else {
			diag_log "Proceed NOT OK";
			r_interrupt = false;
			if (vehicle player == player) then {
				[objNull, player, rSwitchMove,""] call RE;
				player playActionNow "stop";
			};

			deleteVehicle _object;
			cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
		};

	} else {
		diag_log "Cancel is TRUE";
		deleteVehicle _object;
		cutText [format[(localize "str_epoch_player_47"),_text,_reason], "PLAIN DOWN"];
	};
};

DZE_ActionInProgress = false;
