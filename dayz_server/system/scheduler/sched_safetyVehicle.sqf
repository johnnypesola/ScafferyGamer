
sched_safetyVehicle = {
	{
		if (!isNil "_x") then {
			if (!isNull _x) then {
				if (vehicle _x != _x && !(vehicle _x in dayz_serverObjectMonitor) && !((typeOf vehicle _x) in DZE_safeVehicle) && ((vehicle _x) getVariable ["MalSar",0] !=1)) then {
					diag_log [ __FILE__, "KILLING A HACKER", name _x, " IN ", typeOf vehicle _x ];
					(vehicle _x) setDamage 1;
					_x setDamage 1;
				};
			};
		};
	} forEach allUnits;

	objNull
};
