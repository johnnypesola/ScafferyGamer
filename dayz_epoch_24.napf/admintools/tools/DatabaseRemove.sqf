private ["_obj","_objectID","_objectUID","_cnt","_locationPlayer","_player","_text"];

_obj = cursorTarget;
_player = player;
_locationPlayer = _player modeltoworld [0,0,0];
_cnt = 0;
_text = "";

if(isNull _obj) exitWith{cutText ["No object selected","PLAIN UP"];};

_objectID = _obj getVariable["ObjectID","0"];
_objectUID = _obj getVariable["ObjectUID","0"];

	_fnc_databaseremtimer = {
		_cnt = 5;
		for "_i" from 1 to 5 do
		{
			_text = getText (configFile >> "CfgVehicles" >> typeOf _obj >> "displayName");
			cutText [format["!!!Deleting %1 from database in %2 seconds!!!\nMove from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal cancelled for %1, position of player moved",_text], "PLAIN DOWN",1]; breakOut "exit";};
			sleep 1;
			_cnt = _cnt - 1;
		};
		call _func_databaseremove;
	};

	_func_databaseremove = {
		// Tool use logger
		if(logMinorTool && !isNull _obj) then {
			usageLogger = format["%1 %2 -- has deleted object: %3 ID:%4 UID:%5 from database",name _player,getPlayerUID _player,_text,_objectID,_objectUID];
			[] spawn {publicVariable "usageLogger";};
		};

		cutText ["Object deleted from database", "PLAIN DOWN",1];
		PVDZ_obj_Destroy = [_objectID,_objectUID,(name player)];
		publicVariableServer "PVDZ_obj_Destroy";
		if (isServer) then {
			PVDZ_obj_Destroy call server_deleteObj;
		};
		deletevehicle _obj; 
		breakout "exit";
	};

	call _fnc_databaseremtimer;
