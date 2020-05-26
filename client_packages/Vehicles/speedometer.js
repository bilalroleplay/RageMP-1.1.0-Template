function sleep(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}

const updateInterval = 60;

let speedo = mp.browsers.new("package://Vehicles/speedometer.html");
let showed = false;
var player = mp.players.local;

var timeNow = Date.now();

var veh = null;
var eng = false;

var vId = -1;
var vHp = 0;
var vKm = 0;
var vMulti = 0;
var vFuel = 0;
var vFuelTank = 0;
var vFuelConsumption = 0;
var updateI = 0;



mp.events.add('render', () => {
	if(showed) {
		if (player.vehicle) {
			let vel = player.vehicle.getSpeed() * 3.6 ; 
			speedo.execute('update(' + vel.toFixed(0) + ');');
		} else {
            speedo.execute("hide();");
            showed = false;
        }
	}
});

mp.events.add('epm', (vMulti) => {
	mp.players.local.vehicle.setEnginePowerMultiplier(vMulti);
});

mp.events.add('vehicleEnter', (id, hp, km, multi, fuel, fuelTank, fuelConsumption) => {
	vId = id;
	vHp = hp;
	vKm = km;
	vMulti = multi;
	vFuel = fuel;
	vFuelTank = fuelTank;
	vFuelConsumption = fuelConsumption;
    veh = player.vehicle;

	if(!showed) {
		showed = true;
		speedo.execute("show();");
	}

	if (vFuel == 0) {
		mp.game.graphics.notify("~r~ Achtung Tank ist leer!");
	} 

	speedo.execute('updateG(' + (vFuel / vFuelTank * 100 ) + ',' + vKm.toFixed(2) + ');');

	mp.players.local.vehicle.setEnginePowerMultiplier(vMulti);

});


mp.events.add("playerEnterVehicle", (vehicle, seat) => {
	if (seat == -1) {
		if (!vehicle.getIsEngineRunning()) {
            vehicle.setEngineOn(false, true, true);
		}
	}
	veh = vehicle;
});


mp.events.add("playerLeaveVehicle", () => {
	speedo.execute("hide();");
	showed = false;

	updateVeh();

	vId = -1;
	vHp = 0;
	vKm = 0;
	vMulti = 0;
	vFuel = 0;
	vFuelTank = 0;
	vFuelConsumption = 0;
	updateI = 0;
	eng = false;
});

function updateVeh() {
	if (vId != -1) {
		mp.events.callRemote("updateVehicle", vId, vKm, vFuel);
	}
}

function setEng(v, s) {
	if (v.getIsEngineRunning() != s) {
		v.setEngineOn(s, true, true);
	}	
}

setInterval(function(){_intervalFunction();},1000);

function _intervalFunction() {
	let vehicle = player.vehicle;
	if (vehicle) {
		let speed =  vehicle.getSpeed(); 
		let trip = speed / 1000;
		if (vFuel > 0) {
			vFuel = vFuel - (vFuelConsumption * trip);
			if (vFuel < 0) {
				vFuel = 0;
			}
			if (vFuel == 0) {
				updateVeh();
			} 
		}

		vKm = vKm + trip;
		speedo.execute('updateG(' + (vFuel / vFuelTank * 100 ) + ',' + vKm.toFixed(2) + ');');
		updateI++;
		if (updateI == updateInterval) {
			updateI = 0;
			updateVeh();
		}
        eng = vehicle.getIsEngineRunning();
	}

};