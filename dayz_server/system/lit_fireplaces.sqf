// (c) facoptere@gmail.com, licensed to DayZMod for the community
private ["_blocked","_flame","_position"];
{
	_blocked = false;
	_position = _x;
	{if (_position distance _x < 150) exitWith {_blocked = true;};} forEach dayz_townGeneratorBlackList;
	if (!_blocked && (random 1 < 0.33)) then {
		_flame = "flamable_DZ" createVehicle [0,0,0]; //200x faster https://community.bistudio.com/wiki/Code_Optimisation#createVehicle.28Local.29
		_flame setPosATL _x;
		_flame inflame true;  
		_flame setVariable ["permaLoot",true]; // = won't be removed by the cleaner, cf. sched_lootpiles.sqf
	};
	uiSleep 0.001;
} count [ 
	[11580.2,3391.72,-1.20629], [11604.4,3389.41,0.0161071], [11664.6,3415.82,-0.524297], [11678.4,3421.32,-0.526046], [11681.4,3409.25,0.028707], 
	[11700.9,3416.6,-0.433657], [11707.7,3431.61,0.597957], [11817.8,12693.7,-0.131821], [11844.7,12749.8,-0.109467], [11845.2,12747.7,-0.119843], 
	[11846.3,12751.1,-0.234741], [11862.3,12748.1,-0.31282], [11863,12748.5,-0.302368], [11863.9,12749.1,-0.279175], [11911.8,9101.2,0.597935], 
	[11983,9162.89,0.597931], [12013.1,9159.38,0.597931], [12197.2,9499.66,0.603302], [12210.8,9728.83,0.597929], [12218.7,9752.14,0.597929], 
	[12247,9746.97,0.597929], [12271.7,9719.5,0.597929], [12407.3,9549.83,0.599188], [12698.9,9523.05,0.039454], [12700.7,9515.4,7.22985], 
	[12701.1,9516.98,7.29042], [12704,9511.34,0.0394101], [12706.2,9510.56,0.0394883], [12706,9513.22,0.0393739], [12707.3,9520.42,0.03929], 
	[12707.4,9537.02,0.0394235], [12710.4,9548.67,9.79484], [12712.2,9544.37,9.98028], [12714.3,9535.06,-0.634063], [12715.2,9539.4,0.039432], 
	[12715.5,9536.36,0.0393863], [12718.4,9550.81,-0.633002], [12718.6,9550.53,0.0454731], [12721.6,9502.26,0.0394025], [1689.3,11754.5,-0.640869], 
	[1693.15,11750.4,0.0564575], [1698.03,11751.3,0.0558929], [1700.78,11733,0.0564728], [1704.94,11761.2,0.0585327], [1705.92,11728.9,0.0565643], 
	[1709.39,11727.4,0.0566864], [1713.98,11724.6,0.0566711], [1724.37,11729.1,0.054306], [1725.6,11729.7,0.0551147], [1727.1,11727.7,0.0535278], 
	[1727.33,11724.1,-0.64357], [1728.14,11729.9,-0.644043], [1729.12,11729.2,0.0558777], [1730.91,11729.7,-0.644058], [1731.99,11728.5,0.0557709], 
	[1746.26,11721.7,0.0542297], [1782.34,11754.6,0.598038], [4889.27,2234.81,0.272388], [4892.66,2235.29,0.272345], [6043.67,7781.65,0.597931], 
	[6177.52,2125.36,0.598278], [6291.18,7808.69,0.597961], [6317.3,7835.18,0.597961], [6428.26,2244.95,0.59796], [6513.29,2298.32,0.597929], 
	[6536.12,2639.35,0.597929], [6545.71,2630.16,0.597929], [6663.22,2286.33,0.597929], [6706.46,3012.04,0.59866], [6725.35,2576.59,0.597929], 
	[6754.5,2780.37,0.597929], [6760.03,2727.7,0.597929], [6789.35,2692.69,0.597929], [6796.09,2726.09,0.597929], [6810.51,2499.86,0.597929], 
	[6822.79,2482.01,0.597929], [6832.25,2500.24,0.597929], [6833.6,3176.97,0.59797], [6835.19,2694.23,0.597929],
	[6856.71,2522.75,0.597929], [6864.41,2464.66,0.597929], [7065.12,2622.94,0.597929], [7095.99,2740.68,0.597929] 
];
//[6847.45,2360.25,0.597929] removed for now, see https://github.com/DayZMod/DayZ/issues/869
