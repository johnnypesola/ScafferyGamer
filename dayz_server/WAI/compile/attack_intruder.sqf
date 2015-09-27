Private ["_player","_tagVariable","_unitattacker"];

_player = _this select 0;
_tagVariable = _this select 1;

// Make player hostile
if (rating _player > -10000) then {
	_player addRating -10000;
	if (side _player == sideEnemy) then {
		diag_log format ["DEBUG: Player has become renegade! %1 rating!", rating _player];
	};
};

{
	_unitAttacker = _x getVariable [_tagVariable, "notdefined"];
	if (_unitAttacker != "notdefined" and _x distance _player <= 600) then {
		_x doTarget _player;
		_x doFire _player;
	};
} forEach allUnits;

// Check every 60 seconds after if all units are dead, and then reset hostile status of the player.
[_player,_tagVariable] spawn {
	Private ["_player","_tagVariable","_unitAttacker","_group","_dummyLeader","_class"];
	_player = _this select 0;
	_tagVariable = _this select 1;
	while {true} do {
		{
			_unitAttacker = _x getVariable [_tagVariable, "notdefined"];
			if (_unitAttacker != "notdefined" and !(alive _x)) then {
				// Reset rating
				_player addRating abs(rating _player);
				//_group createGroup west;
				//_class = getText (configFile >> "CfgSurvival" >> "Skins" >> ((DZE_defaultSkin select 0) select _rand) >> "playerModel");
				//_dummyLeader = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
				// _player joinSilent _group;
				// deleteVehicle _dummyLeader;
				if (side _player != sideEnemy) then {
					diag_log format ["Player is no longer renegade. %1 rating.", rating _player];
				};
				if (true) exitWith { };
			};
		}forEach allUnits;
		sleep 60;
	};
};
