private["_killedat","_dyn_id","_player","_ai","_alive","_aiData", "_aiEntry", "_isClose","_grp","_ai_members","_alive_ai"];
if (!isServer) exitWith {};

diag_log "WAI: AI Monitor Started";
sleep 120;
while {true} do {
	if (ai_clean_dead) then {
		{
			_killedat = _x getVariable "killedat";
			if (!isNil "_killedat") then {

				if ((time - _killedat) >= cleanup_time) then {

					_ai = _x;
					_dyn_id = _ai getVariable "dynamic_id";
					if (!isNil "_dyn_id") then {
						{
							_aiEntry = _x;
							_aiData = _aiEntry select 1;
							if ((_aiData select 9) == _dyn_id) then {

								_alive_ai = false;

								// ...but we need to check if whole group is gone.
								_grp = group _ai;

								_ai_members = units _grp;
								{
									// Still any AI alive in group?
									if (alive _x) exitWith {
										_alive_ai = true;
									};

									// Measure respawn time from last killed member in AI group.
									_killedat = _x getVariable "killedat";

									if (!isNil "_killedat") then {

										if ((time - _killedat) < cleanup_time) exitWith {

											_alive_ai = true;
										};
									};
									
								} forEach _ai_members;
								_aiEntry set [0, _alive_ai];	// Indicate whether AI is dead or alive, if whole group is dead then respawn now.
							};
						} forEach dyn_ai_list;
					};
					deleteVehicle _ai;


				};
			};
		} forEach allDead;

		{
			_dyn_id = _x getVariable "dynamic_id";
			if (!isNil "_dyn_id") then {

				_ai = _x;
				_isClose = false;

				{
					_player = _x;
					if (alive _player && _player distance _ai < 1300) exitWith {
						_isClose = true;
					};
				} forEach playableUnits;

				if (!_isClose) then {
					{
						_aiData = _x select 1;
						if ((_aiData select 9) == _dyn_id) exitWith {
							_x set [0, false];		// Mark this AI to be respawned
							_grp = group _ai;		// Get the group this AI is in.
							_ai_members = units _grp;	// Get unit members of this group.
							{
								deletevehicle _x;	// Remove whole group.
								ai_ground_units = (ai_ground_units - 1);
							} forEach _ai_members;
							deleteGroup _grp;
						};
					} forEach dyn_ai_list;
				};
			};
		} forEach allUnits;
	};
	diag_log format ["%1 Active ground units", ai_ground_units];
	diag_log format ["%1 Active emplacement units", ai_emplacement_units];
	diag_log format ["%1 Active chopper patrol units (Crew)", ai_air_units];
	diag_log format ["%1 Active vehicle patrol units (Crew)", ai_vehicle_units];
	diag_log format ["%1 Active Survivor Camps", ai_active_survivorcamps];

	sleep 600;
};
