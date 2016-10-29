/*
	Usage: [_crate,"type"] execVM "dir\OKBox.sqf";
		_crate is the crate to fill
		"type" is the type of crate
		"type" can be weapons, secret, cloth, supply or medical
*/
_crate = _this select 0;
_type = _this select 1;

// Clear the current cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

// Define lists. Some lists are defined in OKWeaponCrateList.sqf in the ExtConfig.
_bpackList = ["DZ_Assault_Pack_EP1","DZ_Czech_Vest_Puch","DZ_British_ACU","DZ_CivilBackpack_EP1","DZ_Backpack_EP1"];
_gshellList = ["HandGrenade_west","1Rnd_HE_M203","6Rnd_HE_M203"];
_medical = ["ItemBandage","ItemMorphine","ItemEpinephrine","ItemPainkiller","ItemWaterbottle","FoodMRE","ItemAntibiotic","ItemBloodbag"];

//////////////////////////////////////////////////////////////////
// Medical Crates
if (_type == "medical") then {
	// load medical
	_scount = count _medical;
	for "_x" from 0 to 16 do {
		_sSelect = floor(random _sCount);
		_item = _medical select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
};

///////////////////////////////////////////////////////////////////
// Weapon Crates
if (_type == "weapons") then {
	// load grenades
	_scount = count _gshellList;
	for "_x" from 0 to 16 do {
		_sSelect = floor(random _sCount);
		_item = _gshellList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
   
	// load packs
	_scount = count _bpackList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	 
	// load pistols
	_scount = count OKpistolList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = OKpistolList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load sniper
	_scount = count OKsniperList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = OKsniperList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load mg
	_scount = count OKmgList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = OKmgList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load primary
	_scount = count OKprimaryList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = OKprimaryList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};
};

///////////////////////////////////////////////////////////////////
// Epoch Supply Crates
if (_type == "supply") then {
	// load tools
	_scount = count OKConTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = OKConTools select _sSelect;
		_crate addWeaponCargoGlobal [_item, 1];
	};
	
	// load construction
	_scount = count OKConSupply;
	for "_x" from 0 to 24 do {
		_sSelect = floor(random _sCount);
		_item = OKConSupply select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
};

///////////////////////////////////////////////////////////////////
// Some secret stuff
if (_type == "secret") then {
    
    _crate addWeaponCargoGlobal ["AKS_GOLD",(round(random 1))];
	_crate addWeaponCargoGlobal ["revolver_gold_EP1",(round(random 1))];
    _crate addMagazineCargoGlobal ["6Rnd_45ACP",(round(random 4))];
    _crate addMagazineCargoGlobal ["30Rnd_762x39_AK47",(round(random 3))];
    _crate addMagazineCargoGlobal ["Skin_Functionary1_EP1_DZ",(round(random 1))];
	// load valuables
	_scount = count OKSecret;
	for "_x" from 0 to (floor(random 12)+12) do {
		_sSelect = floor(random _sCount);
		_item = OKSecret select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
    
    // Add 1 item from the rare secret loot item list
    _sSelect = [];
    {
        _item = _x select 0;
        _sCount = _x select 1;
        for "_i" from  1 to _sCount do {
            _sSelect set [count _sSelect, _item];
        }; 
    } forEach OKSecretRare;
    _crate addMagazineCargoGlobal [(_sSelect call BIS_fnc_selectRandom),1];
};

///////////////////////////////////////////////////////////////////
// Some wearable stuff
if (_type == "cloth") then {
		
	// load clothing
	_scount = count OKCloth;
	for "_x" from 0 to 6 do {
		_sSelect = floor(random _sCount);
		_item = OKCloth select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 3))];
	};
};
