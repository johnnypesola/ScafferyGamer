/*
[_objectID,_objectUID] call server_deleteObjDirect;
*/
private["_id","_uid","_key","_query"];

_id    = _this select 0;
_uid   = _this select 1;

if (isServer) then {
	//remove from database
	if (parseNumber _id > 0) then {
		//Send request
		_key = [_id];
		_query = ["objectDeleteByID", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE DIRECT: SERVER deleted object with ID: %1", _id];
	} else  {
		//Send request
		_key = [_uid];
		_query = ["objectDeleteByUID", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		diag_log format["DELETE DIRECT: SERVER deleted object with UID: %1", _uid];
	};
};
