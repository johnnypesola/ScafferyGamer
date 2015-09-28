private["_num", "_randomizedLoot", "_guaranteedLoot", "_lootTable", "_itemTypes", "_CBLBase", "_weights", "_cntWeights", "_index1", "_index2", "_itemType", "_centralPos", "_position", "_nearby", "_angle"];

_centralPos = _this select 0;
_randomizedLoot = 8;
_guaranteedLoot = 6;

if (count _this == 2) then {
	_weights = _this select 1;	// Two-dimensional array of: [["item-type", (Number {0-99} (chance))], ...] 
} else {
	_num = round(random _randomizedLoot) + _guaranteedLoot;
	_lootTable = "HeliCrash";

	if (DZE_MissionLootTable) then {
		_itemTypes = [] + getArray (missionConfigFile >> "CfgBuildingLoot" >> _lootTable >> "lootType");
	} else {
		_itemTypes = [] + getArray (configFile >> "CfgBuildingLoot" >> _lootTable >> "lootType");
	};
	_CBLBase = dayz_CBLBase find (toLower(_lootTable));
	_weights = dayz_CBLChances select _CBLBase;
};

_cntWeights = count _weights;

for "_x" from 1 to _num do {

	_angle = random 360;		

	// get a random position for loot
	_position = [ 
		(_centralPos select 0) + (10 + random 10) * cos _angle, 
		(_centralPos select 1) + (10 + random 10) * sin _angle, 
		0.0
	];

	//create loot
	_index1 = floor(random _cntWeights);
	_index2 = _weights select _index1;
	_itemType = _itemTypes select _index2;
	[_itemType select 0, _itemType select 1, _position, 5] call spawn_loot;
};
// ReammoBox is preferred parent class here, as WeaponHolder wouldn't match MedBox0 && other such items.
_nearby = _position nearObjects ["ReammoBox", sizeOf(_crashModel)];
{
	_x setVariable ["permaLoot",true];
} count _nearBy;
