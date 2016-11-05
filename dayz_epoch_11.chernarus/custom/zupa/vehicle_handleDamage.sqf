private["_selection","_state","_strH","_total","_unit"];


//***Zupa Config ****//


_godmodeVechilesEverywhere = false; // Godmode on all locked vehicles
_onlyLockedVehicles = true; //Plotarea: Godmode for Only locked vehicles (true) or locked and unlocked(false)
_onlyVehicleWithoutGear = true; // Only godmode on vehicles that hold no gear.
_safeZoneGodVehicle = true; // Godmode vehicles in safezones. (or specific zone's)


// donator plotpole only works with PLOT FOR LIFE, set FALSE if you dont have it.
_donatorsPlots = false; // True = only godmode vehicles for donaters in the list, False = godmode for every guy.
_plotDonators = ["76561198101253426","505"]; // PUID's of poeple who donated for plotpole


// Chernarus safezone area's - change these to other coordinates for other maps. ( You can also add specific locations on the map.
_safezones = [ 
	//[[5070.75,9729.54],100,"Air"],
	//[[1606.6443,7803.5156],100,"Bandit"],
	//[[4063.4226,11664.19],100,"Bash"],
	//[[12944.227,12766.889],100,"Hero"],
	//[[11447.472,11364.504],100,"Klen"],
	//[[6315.88,7791.3],100,"Stary"] // [[x,y],distance,"just name"]
	[[8246.3184,15485.867], 50,"Lenzburg"],
	[[15506.952,13229.368], 100,"Emmen"],
	[[12399.751,5074.5273], 75,"Schratten"],
	[[10398.626,8279.4619], 50,"Bandit Camp"],
	[[5149.9814,4864.1191], 50,"Hero Vendor"],
	[[2122.7954,7807.9878], 50,"West Wholesale1"],
	[[5379.0342,16103.187], 50,"Wholesaler"],
	[[6772.8877,16983.27], 50,"Boat Vendor"],
	[[16839.973,5264.0566], 50,"Boat Vendor2"],
	[[15128.379,16421.879], 75,"Aircraft Vendor"]
	];


	//***END Config ****//


	_unit = _this select 0;
	_selection = _this select 1;
	_total = _this select 2;
	_state = true;


	_HPBefore = -1;


	if (_selection != "") then {
		_strH = "hit_" + _selection;
		_HPBefore = [_unit,_strH] call object_getHit; 


	} else {
		_strH = "totalDmg";
		_HPBefore = getDammage _unit;




	};


if(_total > _HPBefore)then{


	if((locked _unit && _godmodeVechilesEverywhere  && (count (crew _unit)) < 1))then{_state = false;
	};


	if(_state)then{
		if(_safeZoneGodVehicle )then{
			{if ((_unit distance (_x select 0)) < (_x select 1)) then {_state = false;
										  };} forEach _safezones;
		};
	};




	if(_state)then{
		_gearCount = 0;
		if(_onlyVehicleWithoutGear)then{
			//_weaps = count(getWeaponCargo _unit);
			//_mags = count(getMagazineCargo _unit);
			//_backs = count(getBackpackCargo _unit);
			//_gearCount = _gearCount + _weaps + _mags + _backs;
		};
		_plots = nearestObjects [_unit, ["Plastic_Pole_EP1_DZ"], DZE_PlotPole select 0];	
		if((count(_plots) > 0))then{		
			_thePlot = _plots select 0;
			_plotOwner = _thePlot getVariable ["ownerPUID",0];
			if ( (_gearCount == 0) &&(locked _unit || !(_onlyLockedVehicles) ) && (count (crew _unit)) < 1 && (  !(_donatorsPlots) || (_plotOwner in _plotDonators))) then {_state = false;

			};
		};
	};

}; //fix
if(_state)then{


	if (_total >= 0.98) then {
		_total = 1.0;
	};


	if (local _unit) then {
		if (_total > 0) then {


			_unit setVariable [_strH, _total, true];
			_unit setHit [_selection, _total];


			if (isServer) then {
				[_unit, "damage"] call server_updateObject;
			} else {
				PVDZE_veh_Update = [_unit,"damage"];
				publicVariableServer "PVDZE_veh_Update";
			};
		};
	} else {
		// vehicle is not local to this client, ask the client which vehicle is local to set damage
		/* PVS/PVC - Skaronator */
		PVDZE_send = [_unit,"VehHandleDam",_this];
		publicVariableServer "PVDZE_send";
	};


}else{
	_total = _HPBefore;
};
// all "HandleDamage event" functions should return the effective damage that the engine will record for that part


_total

