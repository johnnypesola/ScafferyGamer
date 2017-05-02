private ["_clientID","_character","_traderid","_retrader","_data","_result","_status","_val","_key","_query"];
//[dayz_characterID,_tent,[_dir,_location],"TentStorage"]
_character = _this select 0;
_traderid = _this select 1;

_clientID = owner _character;
//diag_log ("HIVE: Menu Request by ClientID: "+ str(_clientID));

// add cacheing
_retrader = call compile format["ServerTcache_%1;",_traderid];

if(isNil "_retrader") then {
	
	_retrader = [];

	// extDB2
	//_key = format["CHILD:399:%1:",_traderid];
	//_data = "HiveEXT" callExtension _key;
	_key = [_traderid];
	_query = ["getTraderItemsCount",_key] call dayz_prepareDataForDB;
	_data = _query call server_hiveReadWrite;

	//diag_log "HIVE: Request sent";
		
	//Process result
	_result = call compile format ["%1",_data];
	_status = _result select 0;
		
	// extDB2
	//if (_status == "ObjectStreamStart") then {
	//	_val = _result select 1;
	if (0 < count _status) then {
		_val = (_result select 0) select 0;
		//Stream Objects
		//diag_log ("HIVE: Commence Menu Streaming...");
		call compile format["ServerTcache_%1 = [];",_traderid];

		// extDB2
		_key = [_traderid];
		_query = ["loadTraderItems",_key] call dayz_prepareDataForDB;
		_data = _query call server_hiveReadWrite;

		for "_i" from 1 to _val do {
			// extDB2
			//_data = "HiveEXT" callExtension _key;
			//_result = call compile format ["%1",_data];
			_result = call compile format ["%1",(_data select _i)];
			call compile format["ServerTcache_%1 set [count ServerTcache_%1,%2]",_traderid,_result];
			_retrader set [count _retrader,_result];
		};
		//diag_log ("HIVE: Streamed " + str(_val) + " objects");
		
	};
};

// diag_log(_retrader);
PVDZE_plr_TradeMenuResult = _retrader;
if(!isNull _character) then {
	_clientID publicVariableClient "PVDZE_plr_TradeMenuResult";
};
