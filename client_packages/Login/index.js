var loginBrowser = mp.browsers.new('package://Login/Login.html');

mp.gui.cursor.show(true, true);

mp.players.local.freezePosition(true);

mp.game.ui.displayRadar(true);
mp.game.ui.displayHud(true);

mp.gui.chat.activate(false);
mp.gui.chat.show(false);

let camera = undefined;
camera = mp.cameras.new('default', new mp.Vector3(344.3341, -998.8612, -98.19622), new mp.Vector3(0, 0, 0), 40);

camera.pointAtCoord(-986.61447, 0, -186.61447); //-99.19622 Changes the rotation of the camera to point towards a location
camera.setActive(true);
mp.game.cam.renderScriptCams(true, false, 0, true, false);

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

mp.events.add('LoginSuccess', () => {
    mp.events.remove(["LoginSuccess", "uiLogin_LoginButton"]);
    loginBrowser.destroy();
    mp.gui.cursor.show(false, false);

    destroyCam();
});