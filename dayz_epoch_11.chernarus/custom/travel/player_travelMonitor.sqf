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

	if (isNil "player_inTravelZone") then {
		player_inTravelZone = false;
	};

	if (!travelMonitorRunning) then {
		[] spawn {
			private ["_menu","_veh","_rcvdVeh"];
			_menu = -1;
			_veh = objNull;
			_rcvdVeh = objNull;

			while {alive player} do {

				if (!isNil "dayz_clientPreload" && {dayz_clientPreload} && {!isNull player}) then {

					// If this player transported something to this server - will be executed once.
					if (!checked_receiveVehicle) then {
						// Check if after login to a server there are pending transports to be received
						PV_travel_receiveVeh = [player];
						publicVariableServer "PV_travel_receiveVeh";

						// This will call a series of events which will spawn in a transported vehicle
						// and put the player inside, but only if there was a vehicle in transit to this server.
						checked_receiveVehicle = true;
					};
				};

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
