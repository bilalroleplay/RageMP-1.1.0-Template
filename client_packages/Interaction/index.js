let menu = null;

mp.events.add('StartHouseMenu', (playerimhaus, lockedhouse, c) => {
    mp.gui.chat.show(false);

    let NativeUI = require("nativeui");
    menu = new NativeUI.Menu("Haus", "Haussystem", new NativeUI.Point(50, 50));
    
    if (playerimhaus != 0) {
        menu.AddItem(new NativeUI.UIMenuItem("~r~Menü schließen", "Menü schließen"));
        if (lockedhouse == 0) {       
            menu.AddItem(new NativeUI.UIMenuItem("Haus abschließen", "Schlüssel wird benötigt!"));
            menu.AddItem(new NativeUI.UIMenuItem("Haus verlassen"));
        } else {
            menu.AddItem(new NativeUI.UIMenuItem("Haus öffnen", "~r~Schlüssel wird benötigt!"));
        }
    
        menu.forceOpen = true;

        menu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            mp.gui.chat.show(true);
            menu.forceOpen = false;
            menu.Close();
            menu = null;
        });
    } else {
        menu.AddItem(new NativeUI.UIMenuItem("~r~Menü schließen", "Menü schließen"));
        if (lockedhouse == 0) {       
            menu.AddItem(new NativeUI.UIMenuItem("Haus abschließen", "Schlüssel wird benötigt!"));
            menu.AddItem(new NativeUI.UIMenuItem("Haus betreten"));
        } else {
            menu.AddItem(new NativeUI.UIMenuItem("Haus öffnen", "Schlüssel wird benötigt!"));
        }
    
        menu.forceOpen = true;

        menu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            mp.gui.chat.show(true);
            menu.forceOpen = false;
            menu.Close();
            menu = null;
        });
    }

    menu.MenuClose.on(()  => {
        if (menu.forceOpen) {
            menu.Open();
        }    
    });
});

mp.events.add('StartVehicleMenu', (engine, c) => {
    mp.gui.chat.show(false);

    let NativeUI = require("nativeui");
    menu = new NativeUI.Menu("Fahrzeug", "Fahrzeugsystem", new NativeUI.Point(50, 50));
    
    menu.AddItem(new NativeUI.UIMenuItem("~r~Menü schließen", "Menü schließen"));
    if (engine == true) {       
        menu.AddItem(new NativeUI.UIMenuItem("Motor starten", "Schlüssel wird benötigt!"));
    } else {
        menu.AddItem(new NativeUI.UIMenuItem("Motor abschalten", "~r~Schlüssel wird benötigt!"));
    }

    menu.forceOpen = true;

    menu.ItemSelect.on((item, index)  => {
        switch(index) {
            case 1:
                    mp.events.callRemote("toggleEngine", c);
                break;
        };
        mp.gui.chat.show(true);
        menu.forceOpen = false;
        menu.Close();
        menu = null;
    });

    menu.MenuClose.on(()  => {
        if (menu.forceOpen) {
            menu.Open();
        }    
    });
});

mp.keys.bind(0x58, true, function() { //X
    if (player.vehicle && menu == null && !mp.gui.cursor.visible) {
		mp.events.callRemote("KeyX");
	}
});

mp.keys.bind(0x45, true, function() { //E
    if (!player.vehicle && menu == null && !mp.gui.cursor.visible) {
        mp.events.callRemote("KeyE");
    }
});