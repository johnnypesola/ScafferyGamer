/*
[_objectID,_objectUID,_activatingPlayer,_objPos,dayz_authKey] call server_deleteObj;
*/
private["_id","_uid","_key","_activatingPlayer","_query","_objPos","_clientKey","_exitReason","_playerUID","_processDelete"];

if (count _this < 5) exitWith {
	diag_log format["Server_DeleteObj error: Improper parameter format, expected 5 or 6 args, got %2", (count _this)];
	diag_log "Parameters received: ";
	{ diag_log format["%1", _x];} forEach _this;
};
_id 	= _this select 0;
_uid 	= _this select 1;
_activatingPlayer 	= _this select 2;
_objPos = _this select 3; //Can be object or position if _processDelete is false
_clientKey = _this select 4;
_processDelete = if (count _this > 5) then {_this select 5} else {true};
_PlayerUID = getPlayerUID _activatingPlayer;

_exitReason = [_this,"DeleteObj",_objPos,_clientKey,_PlayerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

if (isServer) then {
	if (_processDelete) then {deleteVehicle _objPos};
	//remove from database
	if (parseNumber _id > 0) then {
		//Send request
		_key = [_id];
		_query = ["objectDeleteByID",_key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE: Player %1(%2) deleted object with ID: %3",(_activatingPlayer call fa_plr2str), _PlayerUID, _id];
	} else  {
		//Send request
		_key = [_uid];
		_query = ["objectDeleteByUID",_key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE: Player %1(%2) deleted object with UID: %3",(_activatingPlayer call fa_plr2str), _PlayerUID, _uid];
	};
};
