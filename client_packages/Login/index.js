let loginBrowser = null;
let camera = undefined;

mp.events.add('ShowLogin', (c) => {
    loginBrowser = mp.browsers.new('package://Login/Login.html');
    
    mp.players.local.freezePosition(true);

    mp.game.ui.displayRadar(true);
    mp.game.ui.displayHud(true);

    mp.gui.chat.activate(false);
    mp.gui.chat.show(false);

    mp.gui.cursor.show(true, true); 

    camera = mp.cameras.new('default', new mp.Vector3(344.3341, -998.8612, -98.19622), new mp.Vector3(0, 0, 0), 40);

    camera.pointAtCoord(-986.61447, 0, -186.61447); //-99.19622 Changes the rotation of the camera to point towards a location
    camera.setActive(true);
    mp.game.cam.renderScriptCams(true, false, 0, true, false);
});

mp.events.add('render', () =>
{
	if(mp.players.local.isSprinting())
	{
		mp.game.player.restoreStamina(100);
    }
});

mp.events.add('uiLogin_LoginButton', (username, password) => {
    mp.events.callRemote('LoginAccount', username, password);
});

mp.events.add('Notify', (msg) => {
    mp.game.graphics.notify(msg);
});

let destroyCam = function(){
    mp.players.local.freezePosition(false);

    mp.gui.chat.activate(true);
    mp.gui.chat.show(true);

    mp.game.cam.renderScriptCams(false, false, 0, true, false);

    camera.setActive(false);
    camera.destroy();
    camera = undefined;  
}

let selectChar = function(cId){
    destroyCam();
    mp.events.callRemote('login.character.select', cId);
}

mp.events.add('LoginSuccess', (chars) => {
    mp.events.remove(["LoginSuccess", "uiLogin_LoginButton"]);
    loginBrowser.destroy();
    mp.gui.cursor.show(false, false);

    let NativeUI = require("nativeui");
    charSelect = new NativeUI.Menu("Charakterauswahl", "Charakter Auswahl", new NativeUI.Point(50, 50));
    
    chars.forEach(function(c) {
        charSelect.AddItem(new NativeUI.UIMenuItem(c.firstName + " " + c.lastName, "Charakter auswählen"));
    });  
    
    charSelect.forceOpen = true;

    charSelect.ItemSelect.on((item, index)  => {
        cId = chars[index].id;
        selectChar(cId);
        charSelect.forceOpen = false;
        charSelect.Close();
        delete charSelect;
    });

    charSelect.MenuClose.on(()  => {
        if (charSelect.forceOpen) {
            charSelect.Open();
        }    
    });
});