private ["_key","_query","_classname","_charID","_ws","_inv","_coins","_item","_itemList","_uniqId","_dataStatus","_accessResult","_numFields","_numRows","_columnNames"];

// Get Character ID derived from vehicle key
_charID = _this select 0;

// Enable access to insured vehicles from scrap_yard table in DB
_key = format["CHILD:500:%1:[""Object.object_data_scrap_yard"",""Object.object_data_scrap_yard""]::",(profileNamespace getVariable "SUPERKEY")];
_accessResult = _key call server_hiveReadWrite;
diag_log format ["changeTableAccess result: %1", _accessResult];

diag_log format ["Fetching vehicle by insurance... using code %1", _charID];

// Get an abandoned base from DB
_key = "CHILD:501:Object.object_data_scrap_yard:[""Classname"",""CharacterID"",""Worldspace"",""Inventory"",""StorageCoins""]:";
_key = _key + format["[[""CharacterID"",""="",""%1""],""AND"",[""Instance"",""="",""%2""],""AND"",[""Damage"",""="",""1.0""]]:[0,1]:", _charID, dayZ_instance];
_uniqId = _key call server_hiveReadWrite;
if ((_uniqId select 0) == "PASS") then {
	_uniqId = _uniqId select 1;
	diag_log format ["Got Unique ID: %1", _uniqId];
} else {
	diag_log format ["Failed to get Unique ID", _uniqId];
	if (true) exitWith {[]};
};

_item = ["NA"];
_itemList = [];
_dataStatus = [];
_numRows = 0;
_numFields = 0;
_columnNames = [];

_key = format["CHILD:503:%1:", _uniqId];
_dataStatus = _key call server_hiveReadWrite;
if ((_dataStatus select 0) == "PASS") then {
	diag_log format ["Data status for ID %1 is : %2", _uniqId, _dataStatus];
	_numRows = _dataStatus select 1;
	_numFields = _dataStatus select 2;
	_columnNames = _dataStatus select 3;
} else {
	diag_log format ["Failed to get data status for ID %1 : %2", _uniqId, _dataStatus];
	if (true) exitWith {[]};
};

while {((_item select 0) != "NOMORE") && {_numRows > 0}} do {
	_key = format["CHILD:504:%1:", _uniqId];
	_item = _key call server_hiveReadWrite;
	if ((_item select 0) == "UNKID") exitWith {[]};
	if ((_item select 0) != "PASS") exitWith {
		diag_log format ["Could not get data row for ID %1 : %2", _uniqId, _item];
		[]
	};
	_item = _item select 1;
	_itemList = _itemList + [_item];
	_numRows = _numRows - 1;
};
diag_log format ["Get a vehicle item from this list: %1", _itemList];

if ((count _itemList) == 0) exitWith {
	diag_log "ERROR: No insured vehicles available!";
	_itemList = [];
	_itemList
};

if (count _itemList > 1) exitWith {
	diag_log ": Somehow got more than 1 insured vehicle! This is a bug and should not happen!";
	[]
};

// Get the mandatory data for the recovered vehicle only: 

_item = _itemList select 0;
_classname = _item select 0;
_charID = _item select 1;
_ws = call compile (_item select 2);
_inv = call compile (_item select 3);
_coins = parseNumber (_item select 4);

diag_log format["INFO: Loaded %1 via insurance with ID %2! Inv: %3", _classname, _charID, _inv];

// Return abandoned base ID, location and plot poles from DB
[_classname, _charID, _ws, _inv, _coins]
