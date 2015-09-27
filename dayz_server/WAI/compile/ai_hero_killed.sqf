private["_unit","_player","_humanity","_humankills","_type"];
_unit = _this select 0;
_player = _this select 1;
_type = _this select 2;

switch (_type) do {
	case "ground" : {ai_ground_units = (ai_ground_units -1);};
	case "air" : {ai_air_units = (ai_air_units -1);};
	case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
	case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
};

_unit setVariable ["killedat", time];
if (isPlayer _player) then {
	private ["_humankills","_humanity"];
	_humanity = _player getVariable["humanity",0];
	_humankills = _player getVariable["humanKills",0];
	if (ai_humanity_gain) then {
		_player setVariable ["humanity",(_humanity - ai_remove_hero_humanity),true];
	};
	if (ai_herokills_gain) then {
		_player setVariable ["humanKills",(_humankills + 1),true];
	};
	if (ai_clear_body) then {
		{_unit removeMagazine _x;} forEach (magazines _unit);
		{_unit removeWeapon _x;} forEach (weapons _unit);
	};
	if (ai_ahare_info) then {
		{if (((position _x) distance (position _unit)) <= ai_share_distance) then {_x reveal [_player, 4.0];}} forEach allUnits;
	};

	// Make soldiers shoot back
	//if (((rating _player) > -10000) && (!isServer)) then {
	//	_player addRating -10000;
	//	{
	//		_x doTarget _player;
	//		_x doFire _player;
	//	} forEach units group _unit;	
//
//		if (side _player == sideEnemy) then {
//			diag_log format ["DEBUG: Player has become renegade! %1 rating!", rating _player];
//		};
//
//	};
	// Check every 60 seconds after if all units are dead, and then reset hostile status of the player.
	//[_player,_tagVariable] spawn {
	//	Private ["_player","_tagVariable","_unitAttacker","_group","_dummyLeader","_class"];
	//	_player = _this select 0;
	//	_tagVariable = _this select 1;
	//	while {true} do {
	//		{
	//			_unitAttacker = _x getVariable [_tagVariable, "notdefined"];
	//			if (_unitAttacker != "notdefined" and !(alive _x)) then {
	//				// Reset rating
	//				_player addRating abs(rating _player);
	//				//_group createGroup west;
	//				//_class = getText (configFile >> "CfgSurvival" >> "Skins" >> ((DZE_defaultSkin select 0) select _rand) >> "playerModel");
	//				//_dummyLeader = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
	//				// _player joinSilent _group;
	//				// deleteVehicle _dummyLeader;
	//				if (side _player != sideEnemy) then {
	//					diag_log format ["Player is no longer renegade. %1 rating.", rating _player];
	//				};
	//				if (true) exitWith { };
	//			};
	//		}forEach allUnits;
	//		sleep 60;
	//	};
	//};
};
