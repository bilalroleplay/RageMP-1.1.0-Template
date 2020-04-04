let housemenu = null;

mp.events.add('StartHouseMenu', (playerimhaus, lockedhouse, c) => {
    mp.gui.chat.show(false);

    let NativeUI = require("nativeui");
    housemenu = new NativeUI.Menu("Haus", "Haussystem", new NativeUI.Point(50, 50));
    
    if (playerimhaus != 0) {
        housemenu.AddItem(new NativeUI.UIMenuItem("~r~Menü schließen", "Menü schließen"));
        if (lockedhouse == 0) {       
            housemenu.AddItem(new NativeUI.UIMenuItem("~r~Haus abschließen", "Schlüssel wird benötigt!"));
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus verlassen"));
        } else {
            housemenu.AddItem(new NativeUI.UIMenuItem("~g~Haus öffnen", "~r~Schlüssel wird benötigt!"));
        }
    
        housemenu.forceOpen = true;

        housemenu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            mp.gui.chat.show(true);
            housemenu.forceOpen = false;
            housemenu.Close();
            housemenu = null;
        });
    } else {
        housemenu.AddItem(new NativeUI.UIMenuItem("~r~Menü schließen", "Menü schließen"));
        if (lockedhouse == 0) {       
            housemenu.AddItem(new NativeUI.UIMenuItem("~r~Haus abschließen", "Schlüssel wird benötigt!"));
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus betreten"));
        } else {
            housemenu.AddItem(new NativeUI.UIMenuItem("~g~Haus öffnen", "Schlüssel wird benötigt!"));
        }
    
        housemenu.forceOpen = true;

        housemenu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            mp.gui.chat.show(true);
            housemenu.forceOpen = false;
            housemenu.Close();
            housemenu = null;
        });
    }

    housemenu.MenuClose.on(()  => {
        if (housemenu.forceOpen) {
            housemenu.Open();
        }    
    });
});

mp.keys.bind(0x45, true, function() {
    if (housemenu == null && !mp.gui.cursor.visible) {
        mp.events.callRemote("KeyE");
    }
});