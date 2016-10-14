private["_worth","_string","_ruby","_emerald_a","_emerald_b","_emerald","_sapphire_a","_sapphire_b","_sapphire","_topaz_a","_topaz_b","_topaz","_briefcase_100oz_a","_briefcase_100oz_b","_briefcase_100oz","_gold_10oz_a","_gold_10oz_b","_gold_10oz","_gold_1oz","_gold_1oz_b","_gold_1oz_a","_silver_10oz","_silver_10oz_a","_silver_10oz_b"
,"_silver_1oz","_silver_1oz_a","_silver_10oz_b","_pic","_string"
];
_total = _this;
_string = "";

// Adding gems as currency // Pastorn

_ruby = floor(_total / 100000000);

_emerald_a = floor(_total / 10000000);
_emerald_b = _ruby * 10;
_emerald = (_emerald_a - _emerald_b);

_sapphire_a = floor(_total / 1000000);
_sapphire_b = _emerald_a * 10;
_sapphire = (_sapphire_a - _sapphire_b);

_topaz_a = floor(_total / 100000);
_topaz_b = _sapphire_a * 10;
_topaz = (_topaz_a - _topaz_b);

_briefcase_100oz_a = floor(_total / 10000);
_briefcase_100oz_b = _topaz_a * 10;
_briefcase_100oz = (_briefcase_100oz_a - _briefcase_100oz_b);

_gold_10oz_a = floor(_total / 1000);
_gold_10oz_b = _briefcase_100oz_a * 10;
_gold_10oz = (_gold_10oz_a - _gold_10oz_b);

_gold_1oz_a = floor(_total / 100);
_gold_1oz_b = _gold_10oz_a * 10;
_gold_1oz = (_gold_1oz_a - _gold_1oz_b);

_silver_10oz_a = floor(_total / 10);
_silver_10oz_b = _gold_1oz_a * 10;
_silver_10oz = (_silver_10oz_a - _silver_10oz_b);

_silver_1oz_a = floor(_total);
_silver_1oz_b = _silver_10oz_a * 10;
_silver_1oz = (_silver_1oz_a - _silver_1oz_b);


if (_ruby > 0) then {
  _pic = getText (configFile >> 'CfgMagazines' >> 'ItemRuby' >> 'picture');
  _string = format["<t size='1'>%1x</t><img image='%2'/>",_ruby,_pic];
};
if (_emerald > 0) then {
  _pic = getText (configFile >> 'CfgMagazines' >> 'ItemEmerald' >> 'picture');
  _string = format["<t size='1'>%1x</t><img image='%2'/>",_emerald,_pic];
};
if (_sapphire > 0) then {
  _pic = getText (configFile >> 'CfgMagazines' >> 'ItemSapphire' >> 'picture');
  _string = format["<t size='1'>%1x</t><img image='%2'/>",_sapphire,_pic];
};
if (_topaz > 0) then {
  _pic = getText (configFile >> 'CfgMagazines' >> 'ItemTopaz' >> 'picture');
  _string = format["<t size='1'>%1x</t><img image='%2'/>",_topaz,_pic];
};
if (_briefcase_100oz > 0) then {
  _pic = getText (configFile >> 'CfgMagazines' >> 'ItemBriefcase100oz' >> 'picture');
  _string = format["<t size='1'>%1x</t><img image='%2'/>",_briefcase_100oz,_pic];
};
if (_gold_10oz > 0) then {
    _pic = getText (configFile >> 'CfgMagazines' >> 'ItemGoldBar10oz' >> 'picture');
    _string = format["%3<t size='1'>%1x</t><img image='%2'/>",_gold_10oz,_pic, _string];
};
if (_gold_1oz > 0) then {
    _pic = getText (configFile >> 'CfgMagazines' >> 'ItemGoldBar' >> 'picture');
    _string = format["%3<t size='1'>%1x</t><img image='%2'/>",_gold_1oz,_pic, _string];
};
if (_silver_10oz > 0) then {
    _pic = getText (configFile >> 'CfgMagazines' >> 'ItemSilverBar10oz' >> 'picture');
    _string = format["%3<t size='1'>%1x</t><img image='%2'/>",_silver_10oz,_pic, _string];
};
if (_silver_1oz > 0) then {
    _pic = getText (configFile >> 'CfgMagazines' >> 'ItemSilverBar' >> 'picture');
    _string = format["%3<t size='1'>%1x</t><img image='%2'/>",_silver_1oz,_pic, _string];
};

_string
