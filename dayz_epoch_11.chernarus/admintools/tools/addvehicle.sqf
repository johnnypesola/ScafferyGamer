private ["_veh","_location","_isOk","_vehtospawn","_dir","_pos","_helipad","_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_player","_sign","_result"];
_vehtospawn = _this select 0;
_player = player;
_dir = getdir vehicle _player;
_pos = getPos vehicle _player;
_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
 
cutText ["Starting Spawn...", "PLAIN DOWN"];
 
_result = call epoch_generateKey;
 
_isKeyOK =  _result select 0;

waitUntil {!isNil "_isKeyOK"};

if (_isKeyOK) then {
 
	_dir = round(random 360); 
	_helipad = nearestObjects [_player, ["HeliHCivil","HeliHempty"], 100];

	if(count _helipad > 0) then {
		_location = (getPosATL (_helipad select 0));
	} else {
		_location = _pos;
	};
	
	if(count _location != 0) then {
		//place vehicle spawn marker (local)
		_sign = "Sign_arrow_down_large_EP1" createVehicleLocal [0,0,0];
		_sign setPos _location;
		_location = [_sign] call FNC_GetPos;
		[_vehtospawn,_sign] call fn_waitForObject;

		PVDZE_veh_Publish2 = [[_dir,_location],_vehtospawn,false,_result select 1,_player];
		publicVariableServer  "PVDZE_veh_Publish2";

		cutText ["Vehicle spawned, key added to toolbelt.", "PLAIN DOWN"];

		// Tool use logger
		if(logMajorTool) then {
			usageLogger = format["%1 %2 -- has spawned a permanent vehicle: %3",name _player,getPlayerUID _player,_vehtospawn];
			[] spawn {publicVariable "usageLogger";};
		};
	} else {
		_removeitem = [_player, _result select 1] call BIS_fnc_invRemove;
		cutText ["Could not find an area to spawn vehicle.", "PLAIN DOWN"];
	};
} else {
	cutText ["Your toolbelt is full.", "PLAIN DOWN"];
};
