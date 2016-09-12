private ["_veh","_location","_isOk","_part_out","_part_in","_qty_out","_qty_in","_qty","_buy_o_sell","_obj","_objectID","_objectUID","_bos","_started","_finished","_animState","_isMedic","_dir","_helipad","_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_damage","_tireDmg","_tires","_okToSell","_temp_keys","_hitpoints","_needed","_activatingPlayer","_textPartIn","_textPartOut","_traderID","_canAfford","_trade_total","_total_currency","_return_change","_done","_abort","_removed","_weapons","_ammunition"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_103") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

// Test cannot lock while another player is nearby
//_playerNear = {isPlayer _x} count (player nearEntities ["CAManBase", 12]) > 1;
//if(_playerNear) exitWith { DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_104") , "PLAIN DOWN"];  };

// [part_out,part_in, qty_out, qty_in, loc];

_activatingPlayer = player;

_part_out = (_this select 3) select 0;
_part_in = (_this select 3) select 1;
_qty_out = (_this select 3) select 2;
_qty_in = (_this select 3) select 3;
//_buy_o_sell = (_this select 3) select 4;
_textPartIn = (_this select 3) select 5;
_textPartOut = (_this select 3) select 6;
_weapons = (_this select 3) select 7;
_ammunition = (_this select 3) select 8;

_abort = false;
cutText [(localize "str_epoch_player_105"), "PLAIN DOWN"];

[1,1] call dayz_HungerThirst;
// force animation
player playActionNow "Medic";

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
	if (_started and !_isMedic) then {
		r_doLoop = false;
		_finished = true;
	};
	if (r_interrupt) then {
		r_doLoop = false;
	};
	sleep 0.1;
};
r_doLoop = false;

if (!_finished) exitWith {
	r_interrupt = false;
	if (vehicle player == player) then {
		[objNull, player, rSwitchMove,""] call RE;
		player playActionNow "stop";
	};
	cutText [(localize "str_epoch_player_106") , "PLAIN DOWN"];
	DZE_ActionInProgress = false;
};

if (_finished) then {

	//buy
	_qty = {_x == _part_in} count magazines player;
	if (_qty >= _qty_in) then {
	
		_removed = _removed + ([player,_part_in,_qty_in] call BIS_fnc_invRemove);
		if (_removed == _qty_in) then {
			
			// Buying

			// First select key color
			_keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;

			// then select number from 1 - 2500
			_keyNumber = (floor(random 2500)) + 1;

			// Combine to key (eg.ItemKeyYellow2494) classname
			_keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber];

			_isKeyOK = 	isClass(configFile >> "CfgWeapons" >> _keySelected);

			_config = _keySelected;
			_isOk = [player,_config] call BIS_fnc_invAdd;

			waitUntil {!isNil "_isOk"};

			if (_isOk and _isKeyOK) then {

				// spawn vehicle
				_dir = round(random 360);

				_helipad = nearestObjects [player, ["HeliHCivil","HeliHempty"], 100];
				if(count _helipad > 0) then {
					_location = (getPosATL (_helipad select 0));
				} else {
					_location = [(position player),0,20,1,0,2000,0] call BIS_fnc_findSafePos;
				};

				//place vehicle spawn marker (local)
				_veh = createVehicle ["Sign_arrow_down_large_EP1", _location, [], 0, "CAN_COLLIDE"];

				_location = (getPosATL _veh);

				//["PVDZE_veh_Publish",[_veh,[_dir,_location],_part_out,false,_keySelected]] call callRpcProcedure;
				PVDZE_veh_Publish2 = [_veh,[_dir,_location],_part_out,false,_keySelected,_activatingPlayer];
				publicVariableServer  "PVDZE_veh_Publish2";

				cutText [format[(localize "STR_EPOCH_ACTIONS_11"),_qty_in,_textPartIn,_textPartOut], "PLAIN DOWN"];
			} else {
				cutText [(localize "str_epoch_player_107"), "PLAIN DOWN"];
			};

			cutText [format[(localize "str_epoch_player_186"),_qty_in,_textPartIn,_qty_out,_textPartOut], "PLAIN DOWN"];
			
		} else {
			
			// Return items from botched trade. 		 
			for "_x" from 1 to _removed do {
				player addMagazine _part_in;
			};
			_abort = true;
		};	

	} else {
		_needed =  _qty_in - _qty;
		cutText [format[(localize "str_epoch_player_184"),_needed,_textPartIn] , "PLAIN DOWN"];
	};

	sleep 1;

	if(_abort) exitWith {};
};
	

DZE_ActionInProgress = false;

