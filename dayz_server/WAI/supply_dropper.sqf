Private ["_drop_duration","_cleanup_at"];

if (!isServer) exitWith{};

diag_log "SUPPLY DROP: Waiting 30 seconds before releasing first supply drop...";

sleep 30;

show_marker = {
	Private ["_marker","_dot", "_id", "_marker_pos", "_name"];

	_name = _this select 0;
	_marker_pos = _this select 1;
	_id = _this select 2;

	while {(SUPPLY_DROP_spawned_list select _id)} do {
		_marker = createMarker [format["SupplyDrop_%1", _id], _marker_pos];
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "Grid";
		_marker setMarkerSize [200,200];
		_marker setMarkerText _name;
		_dot = createMarker [format["SupplyDrop_%1_dot", _id], _marker_pos];
		_dot setMarkerColor "ColorBlack";
		_dot setMarkerType "mil_dot";
		_dot setMarkerText _name;
		sleep 30;
		deleteMarker _marker;
		deleteMarker _dot;
		//diag_log format ["Marker for %1 is %2, %3.", _name, _marker, _dot];
	};
};

fill_box_weapons = {
	private["_box","_loot","_weapons","_weapon","_mags","_num_weap"];
	_box = _this select 0;
	_loot = _this select 1;
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_weapons = _loot select 0;
	_num_weap = _loot select 1;
	for "_i" from 1 to _num_weap do {
		_weapon = _weapons call BIS_fnc_selectRandom;
		_mags = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");
		_box addWeaponCargoGlobal [_weapon, 1];
		_box addMagazineCargoGlobal [(_mags select 0), floor(random 3) + 1];
	};
	_box
};

fill_box_items = {
	private["_box","_loot","_items","_item","_num_items"];
	_box = _this select 0;
	_loot = _this select 1;
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_items = _loot select 0;
	_num_items = _loot select 1;
	for "_i" from 1 to _num_items do {
		_item = _items call BIS_fnc_selectRandom;
		_box addMagazineCargoGlobal [_item, 1];
	};
	_box
};

fill_box_tools = {
	private["_box","_loot","_tools","_tool","_mags","_num_tools"];
	_box = _this select 0;
	_loot = _this select 1;
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_tools = _loot select 0;
	_num_tools = _loot select 1;
	for "_i" from 1 to _num_tools do {
		_tool = _tools call BIS_fnc_selectRandom;
		_box addWeaponCargoGlobal [_tool, 1];
	};
	_box
};


rare_food_crate = {
	private ["_pos","_box","_drinks","_food","_drink","_can"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Food supply crate was found at %1", _pos];
	[nil,nil,rTitleText,"A box of rare food has been spotted! Check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["BAF_IEDBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_food = [
		"FoodCanGriff",
		"FoodCanBadguy",
		"FoodCanBoneboy",
		"FoodCanCorn",
		"FoodCanCurgon",
		"FoodCanDemon",
		"FoodCanFraggleos",
		"FoodCanHerpy",
		"FoodCanOrlok",
		"FoodCanPowell",
		"FoodCanTylers",
		"FoodPumpkin"
	];
	_drinks = [
		"ItemSodaMtngreen",
		"ItemSodaR4z0r",
		"ItemSodaClays",
		"ItemSodaSmasht",
		"ItemSodaDrwaste",
		"ItemSodaLemonade",
		"ItemSodaLvg",
		"ItemSodaMzly",
		"ItemSodaRabbit"
	];

	for "_i" from 1 to 10 do {
		_drink = _drinks call BIS_fnc_selectRandom;
		_can = _food call BIS_fnc_selectRandom;
		_box addMagazineCargoGlobal [_drink, 1];
		_box addMagazineCargoGlobal [_can, 1];
	};
	_box
};


red_bull_crate = {
	private ["_pos","_box"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Red bull supply crate was dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of Red Bull was dropped from an air plane, check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_box addMagazineCargoGlobal ["ItemSodaRbull", 10];
	_box
};


mountain_dew_crate = {
	private ["_pos","_box"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Mountain dew supply crate was dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of Mountain Dew was dropped from a bandit escape truck! Check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_box addMagazineCargoGlobal ["ItemSodaMdew", 10];
	_box
};


bandit_skin_crate = {
	private ["_pos","_box","_skins"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Bandit skins were dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of bandit clothing has been spotted. Check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_skins = [
		"Skin_Bandit1_DZ",
		"Skin_Bandit2_DZ",
		"Skin_GUE_Soldier_MG_DZ",
		"Skin_GUE_Soldier_Sniper_DZ",
		"Skin_GUE_Soldier_Crew_DZ",
		"Skin_GUE_Soldier_CO_DZ",
		"Skin_GUE_Soldier_2_DZ",
		"Skin_GUE_Commander_DZ",
		"Skin_Ins_Soldier_GL_DZ",
		"Skin_TK_INS_Soldier_EP1_DZ",
		"Skin_TK_INS_Soldier_EP1_DZ",
		"Skin_TK_INS_Warlord_EP1_DZ",
		"Skin_TK_INS_Warlord_EP1_DZ"
	];

	for "_i" from 1 to 20 do {
		_box addMagazineCargoGlobal [(_skins call BIS_fnc_selectRandom), 1];
	};
	_box
};


civilian_skin_crate = {
	private ["_pos","_box","_skins"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Civilian skins were dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of civilian clothing has been spotted. Check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_skins = [
		"Skin_RU_Policeman_DZ",
		"Skin_Priest_DZ",
		"Skin_Haris_Press_EP1_DZ",
		"Skin_Pilot_EP1_DZ",
		"Skin_Functionary1_EP1_DZ",
		"Skin_Rocker3_DZ",
		"Skin_Rocker1_DZ",
		"Skin_Rocker2_DZ",
		"Skin_Rocker4_DZ"
	];

	for "_i" from 1 to 20 do {
		_box addMagazineCargoGlobal [(_skins call BIS_fnc_selectRandom), 1];
	};
	_box
};


military_skin_crate = {
	private ["_pos","_box","_skins"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Military skins were dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of military clothing has been spotted. Check the marked location!", "PLAIN",10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_skins = [
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Rocket_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Soldier1_DZ",
		"Skin_Sniper1_DZ",	// Rare skins
		"Skin_CZ_Soldier_Sniper_EP1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_Camo1_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_OHara_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_FR_Rodriguez_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_Graves_Light_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_CZ_Special_Forces_GL_DES_EP1_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Bodyguard_AA12_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ",
		"Skin_Soldier_Sniper_PMC_DZ"
	];

	for "_i" from 1 to 20 do {
		_box addMagazineCargoGlobal [(_skins call BIS_fnc_selectRandom), 1];
	};
	_box
};


female_skin_crate = {
	private ["_pos","_box","_skins"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: Female skins were dropped at %1", _pos];
	[nil,nil,rTitleText,"A box of woman's clothing has been spotted. Check the marked location!", "PLAIN", 10] call RE;

	_box = createVehicle ["USOrdnanceBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_skins = [
		"Skin_BanditW1_DZ",
		"Skin_BanditW2_DZ",
		"Skin_SurvivorW2_DZ",
		"Skin_SurvivorW3_DZ",
		"Skin_SurvivorWcombat_DZ",
		"Skin_SurvivorWdesert_DZ",
		"Skin_SurvivorWurban_DZ",
		"Skin_SurvivorWpink_DZ"
	];

	for "_i" from 1 to 20 do {
		_box addMagazineCargoGlobal [(_skins call BIS_fnc_selectRandom), 1];
	};
	_box
};


beerbacon_crate = {
	private ["_pos","_box","_loc"];

	_pos = [getMarkerPos "center",0,10000,10,0,1,0] call BIS_fnc_findSafePos;

	diag_log format["WAI: A Bacon n' Beer crate was dropped at %1", _pos];
	[nil,nil,rTitleText, "A Bacon n' Beer box was dropped off! These are truly great news!", "PLAIN",10] call RE;

	_box = createVehicle ["BAF_IEDBox",[(_pos select 0),(_pos select 1), 0.0], [], 0, "CAN_COLLIDE"];
	_box setVariable ["ObjectID","1",true];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;

	_box addMagazineCargoGlobal ["ItemSodaRabbit", 10];
	_box addMagazineCargoGlobal ["FoodbaconCooked", 10];
	_box
};



diag_log "SUPPLY DROP: Starting supply drops!";

SUPPLY_DROP_drop_duration = 2700;
SUPPLY_DROP_cleanup_at = 300;
SUPPLY_DROP_spawned_list = [false, false, false, false, false];

for "_supplyNum" from 0 to 4 do {

	[_supplyNum] spawn {
		Private ["_max_drops","_prev_max_drops","_droptype","_box","_added","_marker_pos","_weaps","_mags","_box_time_left","_playersNear","_men","_supplyNum","_timedOut"];

		_supplyNum = _this select 0;
		_prev_max_drops = 0;
		_box = objNull;
		_name = "";

		while {true} do {

			_max_drops = floor (({isPlayer _x}count allUnits) / 5);

			if (_max_drops > 5) then {
				_max_drops = 5;
			};

			if (_prev_max_drops != _max_drops) then 
			{
				diag_log format ["SUPPLY DROP #%1: Supply drops count is %2.", _supplyNum, _max_drops];
			};
			_prev_max_drops = _max_drops;

			waitUntil {(_supplyNum) <= _max_drops && !(SUPPLY_DROP_spawned_list select _supplyNum)};

			_droptype = floor(random 8);
			switch (_droptype) do {
				case 0: {
					_box = [] call rare_food_crate;
					_name = "Rare food supplies";
				};
				case 1: {
					_box = [] call red_bull_crate;
					_name = "Red Bull crate";
				};
				case 2: {
					_box = [] call mountain_dew_crate;
					_name = "Mountain Dew crate";
				};
				case 3: {
					_box = [] call bandit_skin_crate;
					_name = "Bandit clothing";
				};
				case 4: {
					_box = [] call civilian_skin_crate;
					_name = "Civilian clothing";
				};
				case 5: {
					_box = [] call military_skin_crate;
					_name = "Military clothing";
				};
				case 6: {
					_box = [] call female_skin_crate;
					_name = "Female clothing";
				};
				case 7: {
					_box = [] call beerbacon_crate;
					_name = "Beer n' Bacon box";
				};
				default {
					_box = [] call rare_food_crate;
					_name = "Rare food supplies";
				};
			};

			SUPPLY_DROP_spawned_list set [_supplyNum, true];
			_marker_pos = getPos _box;
			_marker_pos = [
				(_marker_pos select 0) + (random 200) - 100, 
				(_marker_pos select 1) + (random 200) - 100
			];

			[_name, _marker_pos, _supplyNum] spawn show_marker;

			_box_time_left = SUPPLY_DROP_drop_duration;

			diag_log format ["SUPPLY DROP #%1: Drop [%2] added at %3.", _supplyNum, _name, _marker_pos];

			_playersNear = 0;
			_timedOut = false;

			// Check timeout or if players come near
			while {_playersNear == 0 && !_timedOut} do {

				_men = (getPos _box) nearEntities ["Man", 10];
				_playersNear = { isPlayer _x} count _men;

				_box_time_left = _box_time_left - 10;
				if (_box_time_left <= SUPPLY_DROP_cleanup_at) then { _timedOut = true; };
				//diag_log format ["SUPPLY_DROP #%1: Drop [%2] time left: %3 seconds.", _supplyNum, _name, _box_time_left];
				
				sleep 10;
			};


			sleep 60.0;
			_weaps = count ((getWeaponCargo _box) select 0);
			_mags = count ((getMagazineCargo _box) select 0);

			// Wait while players are near
			while {_playersNear > 0 || (_weaps + _mags) > 0} do {

				_weaps = count ((getWeaponCargo _box) select 0);
				_mags = count ((getMagazineCargo _box) select 0);
				_men = (getPos _box) nearEntities ["Man", 200];
				_playersNear = { isPlayer _x} count _men;
				sleep 10;
			};

			// Clear box
			deleteVehicle _box;
			diag_log format ["SUPPLY DROP #%1: Cleared out supply drop %2, waiting %3 seconds...", _supplyNum, _name, SUPPLY_DROP_cleanup_at];

			SUPPLY_DROP_spawned_list set [_supplyNum, false];

			// Wait before spawning it again.
			sleep SUPPLY_DROP_cleanup_at;

		}; // End while
	}; // End spawn
}; // End while

