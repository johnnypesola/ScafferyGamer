/*
	Based on DZMSAIKilled.sqf by Vampire
	This function is called when an AI Unit is killed.
	It handles the humanity allocation and body cleanup.
*/

private ["_unit","_player","_humanity","_banditkills","_rnd"];
_unit = _this select 0;
_player = _this select 1;

//If the killer is a player, lets handle the humanity

if (isPlayer _player) then {
	private ["_banditkills","_humanity"];
	
	diag_log format ["[OK]: Debug: Unit killed by %1 at %2", _player, mapGridPosition _unit];
    
    //removing MAAWS
    _unit removeWeapon "MAAWS";
    _unit removeWeapon "Stinger";
    _unit removeMagazines "MAAWS_HEAT";
    
    diag_log format ["[OK]: Debug: Launchers removed from posession"];
	
	//Lets grab some info
	_humanity = _player getVariable ["humanity",0];
	_banditkills = _player getVariable ["banditKills",0];
	
	//If the player gets humanity per config, lets give it
	if (OKMissHumanity) then {
		if (_humanity >= 0) then {
			_player setVariable ["humanity",(_humanity - OKCntHumanity),true];
		} else {
			_player setVariable ["humanity",(_humanity + OKCntHumanity),true];
		};
	};
	
	//If this counts as a bandit kill, lets give it
	if (OKCntBanditKls) then {
		_player setVariable ["banditKills",(_banditkills + 1),true];
	};
	
	//Lets inform the nearby AI of roughly the players position
	//This makes the AI turn and react instead of laying around
    //50% chance to left unspotted
	{
        _rnd = random 1;
        if (_rnd > 0.5) then {        
		if (((position _x) distance (position _unit)) <= 1200) then {
            _rnd = floor random 4;
			_x reveal [_player, _rnd];
		}}
	} forEach allUnits;
	
} else {

	diag_log format ["[OK]: Debug: Unit killed by %1 at %2", _player, mapGridPosition _unit];

	if (OKRunGear) then {
		//Since a player ran them over, or they died from unknown causes
		//Lets strip their gear
		removeBackpack _unit;
		removeAllWeapons _unit;
		{
			_unit removeMagazine _x
		} forEach magazines _unit;
	};
	
};

//Dead body timer and cleanup
sleep OKBodyTime;
deletevehicle _unit;
