private ["_world","_seat","_seatType"];

call compile preprocessFileLineNumbers "custom\travel\travel_config.sqf";

// Initialize variables with data from config
_world = toLower format ["%1", worldName];
call compile format ["server_ferryTerminalPos = server_ferryTerminalPos_%1;", _world];
call compile format ["server_ferryTerminalRadius = server_ferryTerminalRadius_%1;", _world];

if (isServer) then {

	// *** Server event handlers ***

	// Set up server side PV handlers for travelling
	"PV_travel_transportVeh"		addPublicVariableEventHandler {(_this select 1) call server_ferry_transportVehicle};
	"PV_travel_receiveVeh"			addPublicVariableEventHandler {(_this select 1) call server_ferry_receiveVehicle};

} else {

	player_sendAwayCrew = compile preprocessFileLineNumbers "custom\travel\player_sendAwayCrew.sqf";
	player_boardCrew = compile preprocessFileLineNumbers "custom\travel\player_boardCrew.sqf";

	"PV_travel_boardFerry"			addPublicVariableEventHandler {(_this select 1) call player_sendAwayCrew};
	"PV_travel_boardRcvdVeh"		addPublicVariableEventHandler {(_this select 1) call player_boardCrew};

	if (isNil "checked_receiveVehicle") then { checked_receiveVehicle = false; };
	if (isNil "travelMonitorRunning") then { travelMonitorRunning = false; };
	if (isNil "player_inTravelZone") then {	player_inTravelZone = false; };

	if (!travelMonitorRunning) then {
		[] spawn {
			private ["_menu","_veh","_rcvdVeh","_debug","_platform","_isPZombie","_holder"];
			_menu = -1;
			_veh = objNull;
			_rcvdVeh = objNull;

			_debug = getMarkerPos "respawn_west";
			if (getText(configFile >> "CfgMods" >> "DayZ" >> "dir") == "@DayZ_Epoch") then {
				if (surfaceIsWater _debug) then {
					_debug set [2,2];
					_platform = "MetalFloor_DZ" createVehicleLocal _debug;
					_platform setPosASL _debug;
					_platform allowDamage false;
					_platform hideObject true;
					_platform enableSimulation false;
				};
				diag_log "Travel: Waiting for login...";
				waitUntil {!isNil "PVDZE_plr_LoginRecord"};
				_isPZombie = player isKindOf "PZombie_VB";
			} else {
				waitUntil {!isNil "PVDZ_plr_LoginRecord"};
				_isPZombie = false;
			};
			diag_log "Travel: Login complete!";

			// If this player transported something to this server - will be executed once.
			// Check if after login to a server there are pending transports to be received

			diag_log "Travel: Waiting for player to enter game...";
			waitUntil {!isNil "dayzPlayerLogin2"};
			if (3 < count dayzPlayerLogin2) then {
				if (dayzPlayerLogin2 select 3) then {
					PV_travel_receiveVeh = [player];
					publicVariableServer "PV_travel_receiveVeh";
				};
			};
			diag_log "Travel: Done!";

			if (100 > (player distance [0,0,0])) then {
				cutText["","BLACK OUT",1];
			};

			while {alive player} do {

				if (_menu == -1) then {
					if (player_inTravelZone && player != vehicle player) then {
						if (player == driver vehicle player) then {
							_veh = vehicle player;
							_menu = _veh addaction [("<t color=""#cccc00"">" + ("Travel to...") +"</t>"),"custom\travel\player_showTravelMenu.sqf","true",0,false,true,"",""];
						};
					};
				};
				if (_veh != vehicle player || player == vehicle player || !player_inTravelZone || player != driver _veh) then {
					_veh removeAction _menu;
					_menu = -1;
				};

				sleep 2;
			};
		};
		travelMonitorRunning = true;
	};
	waitUntil { sleep 2; !alive player; };
	travelMonitorRunning = false;
};
