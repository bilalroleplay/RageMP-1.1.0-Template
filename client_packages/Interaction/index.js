MenuOpen = false;

mp.events.add("StartHouseMenu", (playerimhaus, lockedhouse, c) => {

    let NativeUI = require("nativeui");
    housemenu = new NativeUI.Menu("Haus", "Haussystem", new NativeUI.Point(50, 50));

    mp.gui.chat.show(false);
    MenuOpen = true;

    if (playerimhaus != 0) {
        housemenu.AddItem(new NativeUI.UIMenuItem("Menü schließen"));
        if (lockedhouse == 0) {       
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus abschließen", "~r~Schlüssel wird benötigt!"));
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus verlassen"));
        } else {
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus öffnen", "~r~Schlüssel wird benötigt!"));
        }
    
        housemenu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            housemenu.Close();
            MenuOpen = false;
            mp.gui.chat.show(true);
        });
    } else {
        housemenu.AddItem(new NativeUI.UIMenuItem("Menü schließen"));
        if (lockedhouse == 0) {       
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus abschließen", "~r~Schlüssel wird benötigt!"));
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus betreten"));
        } else {
            housemenu.AddItem(new NativeUI.UIMenuItem("Haus öffnen", "~r~Schlüssel wird benötigt!"));
        }
    
        housemenu.ItemSelect.on((item, index)  => {
            switch(index) {
                case 1:
                        mp.events.callRemote("LockThatHouse", c);
                    break;
                case 2:
                        mp.events.callRemote("EnterExitThatHouse", c);
                    break;
            };
            housemenu.Close();
            MenuOpen = false;
            mp.gui.chat.show(true);
        });
    }

});


mp.keys.bind(0x45, true, function() {
    if (!MenuOpen && !mp.gui.cursor.visible) {
        mp.events.callRemote("KeyE");
    }
});