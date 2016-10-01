private ["_fromMagClass", "_toMagClass", "_fromMagSize", "_toMagSize", "_dialog", "_control", "_ammoQty", "_targetQty", "_val", "_item", "_magazineArray", "_sourceMagArray", "_currQty","_destMagArray", "_found", "_abort"];

// Parameters:
// _fromMagClass
// _toMagClass
// _fromMagClass_count
_fromMagClass = (_this select 0) select 0;
_toMagClass = (_this select 1) select 0;

_abort = false;

// Get player's current inventory

disableSerialization;

_magazineArray = [];
_sourceMagArray = [];
_destMagArray = [];

_dialog = ["0"] call gearDialog_create;
if ((isNull _dialog) || (isNil "_dialog")) exitWith {disableUserInput false; (findDisplay 106) closeDisplay 0; closeDialog 0; _magazineArray};

//Main inventory
for "_i" from 109 to 120 do {
	_control = _dialog displayCtrl _i;
	_item = gearSlotData _control;
	_val = gearSlotAmmoCount _control;
	if (typeName (_item) == "STRING") then {
		if (_item == _fromMagClass) then {
			_magazineArray set [count _magazineArray, [_item,_val]];
		};
	} else {
		if ((_item select 0) == _fromMagClass) then {
			_magazineArray set [count _magazineArray, _item];
		};
	};
};
//diag_log format ["Inventory: %1", _magazineArray];

// How much space in destination magazine
_toMagSize = getNumber(configFile >> "cfgMagazines" >> _toMagClass >> "count");
if (_toMagSize == 0) then {

	//diag_log "No record in cfg! Need to do it manually...";
	switch (_toMagClass) do {
		case "200Rnd_556x45_M249": {
			_toMagSize = 200;
		};
		case "100Rnd_556x45_M249": {
			_toMagSize = 100;
		};
		case "100Rnd_556x45_BetaCMag": {
			_toMagSize = 100;
		};
		case "20Rnd_762x51_DMR": {
			_toMagSize = 20;
		};
		case "100Rnd_762x51_M240": {
			_toMagSize = 100;
		};
		case "30Rnd_9x19_UZI": {
			_toMagSize = 30;
		};
		case "30Rnd_9x19_MP5": {
			_toMagSize = 30;
		};
		case "1Rnd_HE_M203": {
			_toMagSize = 1;
		};
		case "6Rnd_HE_M203": {
			_toMagSize = 6;
		};
		case "20Rnd_762x51_FNFAL": {
			_toMagSize = 20;
		};
		case "10Rnd_127x99_M107": {
			_toMagSize = 10;
		};
		case "100Rnd_127x99_M2": {
			_toMagSize = 100;
		};
		default { _toMagSize = 0; };
	};
};

// Format of the source magazine
_fromMagSize = getNumber(configFile >> "cfgMagazines" >> _fromMagClass >> "count");
if (_fromMagSize == 0) then {

	//diag_log "No record in cfg! Need to do it manually...";
	switch (_fromMagClass) do {
		case "200Rnd_556x45_M249": {
			_fromMagSize = 200;
		};
		case "100Rnd_556x45_M249": {
			_fromMagSize = 100;
		};
		case "100Rnd_556x45_BetaCMag": {
			_fromMagSize = 100;
		};
		case "20Rnd_762x51_DMR": {
			_fromMagSize = 20;
		};
		case "100Rnd_762x51_M240": {
			_fromMagSize = 100;
		};
		case "30Rnd_9x19_UZI": {
			_fromMagSize = 30;
		};
		case "30Rnd_9x19_MP5": {
			_fromMagSize = 30;
		};
		case "1Rnd_HE_M203": {
			_fromMagSize = 1;
		};
		case "6Rnd_HE_M203": {
			_fromMagSize = 6;
		};
		case "20Rnd_762x51_FNFAL": {
			_fromMagSize = 20;
		};
		case "10Rnd_127x99_M107": {
			_fromMagSize = 10;
		};
		case "100Rnd_127x99_M2": {
			_fromMagSize = 100;
		};
		default { _fromMagSize = 0; };
	};
};


// We got all mags, now collect and see what we can do
if ((count _this) == 3) then {

	
	_newMagArray = [];
	// How many in current magazine
	_ammoQty = _this select 2;
	//diag_log format ["Got input ammo qty: %1, of type %2", _ammoQty, _fromMagClass];

	if (isNil ("DZE_AcknowledgeConvert")) then {
		DZE_AcknowledgeConvert = true; 
		if (_ammoQty % _toMagSize != 0) exitWith { (findDisplay 106) closeDisplay 0; cuttext ["Cannot convert ammo where conversion does not result in full magazines, you will lose ammo! Attempt again to ignore this msg.", "PLAIN DOWN"]; _abort = true;};
	};

	if (!_abort) then {
		// Remove the mag physically
		player removeMagazines _fromMagClass;

		// Logically do the same
		_found = false;
		{
			if ((_x select 1) != _ammoQty || !_found) then {
				_found = true;
			} else {
				_sourceMagArray set [count _sourceMagArray, _x];
			};
		} forEach _magazineArray;

		// Calculate the amount of dest mags
		while {_ammoQty > 0} do {

			if ((_ammoQty - _toMagSize) < 0) exitWith {
				_ammoQty = 0;
				//diag_log format ["Adding partial %1 mag with %2 rounds.", _toMagClass, (_toMagSize - _ammoQty)];
				//_destMagArray set [count _destMagArray, [_toMagClass, (_toMagSize - _ammoQty)]];
			};
			//diag_log format ["Adding %1 mag with %2 rounds.", _toMagClass, (_toMagSize)];
			_ammoQty = _ammoQty - _toMagSize;
			_destMagArray set [count _destMagArray, [_toMagClass, _toMagSize]];
		};

		{ player addMagazine _x } forEach _sourceMagArray; 
		{ player addMagazine _x } forEach _destMagArray; 
	};

} else {

	_currQty = 0;
	{ 
		_currQty = _currQty + (_x select 1);
	} forEach _magazineArray;

	if (_currQty < _toMagSize) exitWith {
		(findDisplay 106) closeDisplay 0; 
		cuttext ["Cannot convert this ammo where conversion does not result in at least one full magazine!", "PLAIN DOWN"];
	};

	if (isNil ("DZE_AcknowledgeConvert")) then {
		DZE_AcknowledgeConvert = true; 
		if (_currQty % _toMagSize != 0 && _currQty < _toMagSize) exitWith { (findDisplay 106) closeDisplay 0; cuttext ["Cannot convert ammo where conversion does not result in full magazines, you will lose ammo! Attempt again to ignore this msg.", "PLAIN DOWN"]; _abort = true;};
	};

	if (!_abort) then {

		_currQty = 0;		// Start filling the mag from zero

		// Remove the mags
		player removeMagazines _fromMagClass;

		// There will be leftover ammo, fill all mags until _currQty is 0
		if (_fromMagSize <= _toMagSize) then { 

			// Transfer the ammo
			{
				if (_currQty < _toMagSize) then {
					_currQty = _currQty + (_x select 1);	// Remove mag of source type
				} else {
					// When required ammo is transferred just readd the rest of the mags
					_sourceMagArray set [count _sourceMagArray, _x];
				};

			} forEach _magazineArray;


			//diag_log format ["Adding the following existing mags: %1", _sourceMagArray];

			{ player addMagazine _x } forEach _sourceMagArray; 
			player addMagazine [_toMagClass, _currQty];	// Add the mag of the dest type

		};
	};
};

// Close inventory screen, it gets bugged and duping is possible
(findDisplay 106) closeDisplay 0;
