//Kitbashed from Epoch Change Script by Rosska85 because he got sick of spending half an hour sorting stacks of gold

private ["_part","_worth","_totalCurrency","_ruby","_emerald","_emerald_a","_emerald_b","_sapphire","_sapphire_a","_sapphire_b","_topaz","_topaz_a","_topaz_b","_briefcase_100oz","_briefcase_100oz_a","_briefcase_100oz_b","_gold_10oz_a","_gold_10oz_b","_gold_10oz","_gold_1oz_a","_gold_1oz_b","_gold_1oz","_silver_10oz_a","_silver_10oz_b","_silver_10oz","_silver_1oz_a","_silver_1oz_b","_silver_1oz","_successful","_buyOrSell","_total_items"];

//Get total currency
_totalCurrency = 0;
{
	_part =  (configFile >> "CfgMagazines" >> _x);
	_worth =  (_part >> "worth");
	if isNumber (_worth) then {
		if (([player,_part,1] call BIS_fnc_invRemove) == 1) then {
			_totalCurrency = _totalCurrency + getNumber(_worth);
		};
	} else {
		// ADDED for High End Currency
		switch (_x) do
		{
			case "ItemRuby":
			{
				_worth = 100000000;
				if (([player,_part,1] call BIS_fnc_invRemove) == 1) then {
					_totalCurrency = _totalCurrency + _worth;
				};
			};
			case "ItemEmerald":
			{
				_worth = 10000000;
				if (([player,_part,1] call BIS_fnc_invRemove) == 1) then {
					_totalCurrency = _totalCurrency + _worth;
				};
			};
			case "ItemSapphire":
			{
				_worth = 1000000;
				if (([player,_part,1] call BIS_fnc_invRemove) == 1) then {
					_totalCurrency = _totalCurrency + _worth;
				};
			};
			case "ItemTopaz":
			{
				_worth = 100000;
				if (([player,_part,1] call BIS_fnc_invRemove) == 1) then {
					_totalCurrency = _totalCurrency + _worth;
				};
			};
		};
	};

} count (magazines player);

_ruby = floor(_totalCurrency / 100000000);

_emerald_a = floor(_totalCurrency / 10000000);
_emerald_b = _ruby * 10;
_emerald = (_emerald_a - _emerald_b);

_sapphire_a = floor(_totalCurrency / 1000000);
_sapphire_b = _emerald_a * 10;
_sapphire = (_sapphire_a - _sapphire_b);

_topaz_a = floor(_totalCurrency / 100000);
_topaz_b = _sapphire_a * 10;
_topaz = (_topaz_a - _topaz_b);

_briefcase_100oz_a = floor(_totalCurrency / 10000);
_briefcase_100oz_b = _topaz_a * 10;
_briefcase_100oz = (_briefcase_100oz_a - _briefcase_100oz_b);

_gold_10oz_a = floor(_totalCurrency / 1000);
_gold_10oz_b = _briefcase_100oz_a * 10;
_gold_10oz = (_gold_10oz_a - _gold_10oz_b);

_gold_1oz_a = floor(_totalCurrency / 100);
_gold_1oz_b = _gold_10oz_a * 10;
_gold_1oz = (_gold_1oz_a - _gold_1oz_b);

_silver_10oz_a = floor(_totalCurrency / 10);
_silver_10oz_b = _gold_1oz_a * 10;
_silver_10oz = (_silver_10oz_a - _silver_10oz_b);

_silver_1oz_a = floor(_totalCurrency);
_silver_1oz_b = _silver_10oz_a * 10;
_silver_1oz = (_silver_1oz_a - _silver_1oz_b);


if (_ruby > 0) then {
	for "_x" from 1 to _ruby do {
		player addMagazine "ItemRuby";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _ruby, "ItemRuby"];
	};
};
if (_emerald > 0) then {
	for "_x" from 1 to _emerald do {
		player addMagazine "ItemEmerald";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _emerald, "ItemEmerald"];
	};
};
if (_sapphire > 0) then {
	for "_x" from 1 to _sapphire do {
		player addMagazine "ItemSapphire";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _sapphire, "ItemSapphire"];
	};
};
if (_topaz > 0) then {
	for "_x" from 1 to _topaz do {
		player addMagazine "ItemTopaz";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _topaz, "ItemTopaz"];
	};
};
if (_briefcase_100oz > 0) then {
	for "_x" from 1 to _briefcase_100oz do {
		player addMagazine "ItemBriefcase100oz";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _briefcase_100oz, "ItemBriefcase100oz"];
	};
};
if (_gold_10oz > 0) then {
	if (_gold_10oz == 1) then {
		player addMagazine "ItemGoldBar10oz";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _gold_10oz, "ItemGoldBar10z"];
	} else {
		player addMagazine format["ItemBriefcase%1oz",floor(_gold_10oz*10)];
		//diag_log format["DEBUG TRADER CHANG MADE: ItemBriefcase%1oz", floor(_gold_10oz*10)];
	};
};
if (_gold_1oz > 0) then {
	if (_gold_1oz == 1) then {
		player addMagazine "ItemGoldBar";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _gold_1oz, "ItemGoldBar"];
	} else {
		player addMagazine format["ItemGoldBar%1oz",_gold_1oz];
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _gold_1oz, "ItemGoldBar"];
	};
};
if (_silver_10oz > 0) then {
	if (_silver_10oz == 1) then {
		player addMagazine "ItemSilverBar10oz";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _silver_10oz, "ItemSilverBar10oz"];
	} else {
		player addMagazine format["ItemBriefcaseS%1oz",floor(_silver_10oz*10)];
		//diag_log format["DEBUG TRADER CHANG MADE: ItemBriefcaseS%1oz", floor(_silver_10oz*10)];
	};
};
if (_silver_1oz > 0) then {
	if (_silver_1oz == 1) then {
		player addMagazine "ItemSilverBar";
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _silver_1oz, "ItemSilverBar"];
	} else {
		player addMagazine format["ItemSilverBar%1oz",_silver_1oz];
		//diag_log format["DEBUG TRADER CHANG MADE: %1 x %2", _silver_1oz, "ItemSilverBar"];
	};
};

//Let the player know it happened
cutText [format["Combined all bars in your inventory to the highest denomination."], "PLAIN DOWN"];
