/*
[_objectID,_objectUID,_activatingPlayer] call server_deleteObj;
*/
private["_id","_uid","_key","_activatingPlayer","_query"];
_id 	= _this select 0;
_uid 	= _this select 1;
_activatingPlayer 	= _this select 2;

if (isServer) then {
	//remove from database
	if (parseNumber _id > 0) then {
		//Send request
		_key = [_id];
		_query = ["objectDeleteByID",_key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE: %1 Deleted by ID: %2",_activatingPlayer,_id];
	} else  {
		//Send request
		_key = [_uid];
		_query = ["objectDeleteByUID",_key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE: %1 Deleted by UID: %2",_activatingPlayer,_uid];
	};
};
