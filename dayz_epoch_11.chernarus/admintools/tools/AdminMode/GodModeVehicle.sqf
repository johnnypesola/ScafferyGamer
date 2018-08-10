/*
	Air vehicles will explode if hit with a rocket or when crashing.
*/
private["_playerVehicle"];

if(isNil "vehicleGod2") then {vehicleGod2 = true;} else {vehicleGod2 = !vehicleGod2};

if(vehicleGod2) then {
	// Tool use logger
	if(logMajorTool) then {
		usageLogger = format["%1 %2 -- has ENABLED vehicle god mode",name player,getPlayerUID player];
		[] spawn {publicVariable "usageLogger";};
	};
};

previousVehicle = objNull;

while{alive (vehicle player) && vehicleGod2} do
{
	// Wait until player gets in a vehicle or god mode is turned off
	waitUntil{Sleep 1; ((player != (vehicle player)) || !vehicleGod2)};

	// Enable god mode only if it hasn't been turned off
	if(vehicleGod2) then {
		_playerVehicle = vehicle player;
		previousVehicle = _playerVehicle;
		
		_playerVehicle setfuel 1;
		_playerVehicle setdammage 0;
		
		_playerVehicle removeAllEventHandlers "handleDamage";
		_playerVehicle addEventHandler ["handleDamage", {false}];
		_playerVehicle allowDamage false;
	 
		fnc_veh_handleDam = {};
		fnc_veh_handleKilled = {};
	};

	// Wait until player leaves vehicle or god mode is turned off
	waitUntil{Sleep 1; ((player == (vehicle player)) || !vehicleGod2)};

	// Disable god mode for a vehicle only if it was on
	if((!isNil "previousVehicle") && (typeName previousVehicle == "OBJECT") && (!isNull previousVehicle)) then {
		previousVehicle removeAllEventHandlers "handleDamage";
		previousVehicle addEventHandler ["handleDamage", {_this select 2}];
		previousVehicle allowDamage true;

		fnc_veh_handleDam = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\veh_handleDam.sqf";
		fnc_veh_handleKilled = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\veh_handleKilled.sqf";
		previousVehicle = objNull;
	};
};

// Disable god mode for a vehicle only if it was on
if((!isNil "previousVehicle") && (typeName previousVehicle == "OBJECT") && (!isNull previousVehicle)) then {
    previousVehicle removeAllEventHandlers "handleDamage";
    previousVehicle addEventHandler ["handleDamage", {_this select 2}];
    previousVehicle allowDamage true;

    fnc_veh_handleDam = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\veh_handleDam.sqf";
    fnc_veh_handleKilled = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\veh_handleKilled.sqf";
};
	// Tool use logger
	if(logMajorTool) then {
		usageLogger = format["%1 %2 -- has DISABLED vehicle god mode",name player,getPlayerUID player];
		[] spawn {publicVariable "usageLogger";};
	};
