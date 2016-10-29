/*
	Based on DZMSAIKilled.sqf by Vampire
	This function is called when an AI Helo is downed.
	It handles the loot spawn.
*/

private ["_unit","_crate1","_crate2","_crate3","_crate4","_coords","_rnd"];

diag_log format ["[OK]: Pinata hit."];

_unit = _this select 0;
_coords = getpos _unit;

OKLoot = ["weapons","medical","supply","secret","cloth"];

//Create boxes. OKBoxFill fills the box, OKProtectObj prevents it from disappearing

_rnd = (random 15)+1;
diag_log format ["[OK]: Debug: _rnd = %1",_rnd];
if (_rnd > 8) then 
    {
        _rnd = _rnd - 8;
        _crate4 = createVehicle ["USLaunchersBox",[(_coords select 0) - 15, (_coords select 1) - 15,0],[], 0, "CAN_COLLIDE"]; 
        _loot = OKLoot select floor random count OKLoot; 
        [_crate4,_loot] ExecVM OKBoxSetup; 
        [_crate4] call OKProtectObj; 
        diag_log format ["[OK]: Debug: box 1 spawned at %1",_coords];
    };
if (_rnd > 4) then 
    {
        _rnd = _rnd - 4;    
        _crate3 = createVehicle ["SpecialWeaponsBox",[(_coords select 0) + 15, (_coords select 1) + 15,0],[], 0, "CAN_COLLIDE"];
        _loot = OKLoot select floor random count OKLoot;
        [_crate3,_loot] ExecVM OKBoxSetup;
        [_crate3] call OKProtectObj;
        diag_log format ["[OK]: Debug: box 2 spawned at %1",_coords];
    };
if (_rnd > 2) then 
    {
        _rnd = _rnd - 2;
        _crate2 = createVehicle ["RUBasicAmmunitionBox",[(_coords select 0) - 15, (_coords select 1) + 15,0],[], 0, "CAN_COLLIDE"];
        _loot = OKLoot select floor random count OKLoot;
        [_crate2,_loot] ExecVM OKBoxSetup;
        [_crate2] call OKProtectObj;
        diag_log format ["[OK]: Debug: box 3 spawned at %1",_coords];
    };
if (_rnd > 1) then 
    {
        _rnd = _rnd - 1;
        _crate1 = createVehicle ["GuerillaCacheBox",[(_coords select 0) + 15, (_coords select 1) - 15,0],[], 0, "CAN_COLLIDE"];
        _loot = OKLoot select floor random count OKLoot;
        [_crate1,_loot] ExecVM OKBoxSetup;
        [_crate1] call OKProtectObj;
        diag_log format ["[OK]: Debug: box 4 spawned at %1",_coords];
    };
diag_log format ["[OK]: Debug: _rnd after spawn = %1",_rnd];

