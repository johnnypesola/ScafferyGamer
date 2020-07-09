private ["_key","_query","_baseId"];

_baseId = _this select 0;

// Delete an abandoned base from DB
diag_log format["INFO: Deleting abandoned base with ID #%1.", _baseId];
_key = [_baseId];
_query = ["deleteAbandonedBase", _key] call dayz_prepareDataForDB;
_query call server_hiveWrite;
