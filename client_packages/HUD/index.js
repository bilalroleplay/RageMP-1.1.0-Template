let hud = null;

mp.events.add('ShowHUD', (c) => {
	hud = mp.browsers.new('package://HUD/index.html');
	hud.execute(`document.getElementById('namelabel').innerHTML="` + c.name + `";`);
});
mp.events.add("moneyhud", (money) => {
	hud.execute(`document.getElementById('moneylabel').innerHTML=` + money + `;`);
});

const Use3d = true;
const UseAutoVolume = false;

const MaxRange = 15.0;

mp.keys.bind(0x73, true, function(player) {
	if(mp.gui.cursor.visible)
		return;
	mp.events.callRemote("IfPlayerLoggedIn", player);
});

mp.events.add("VoiceMute", (loggedIn) => {
	if (loggedIn) {
		mp.voiceChat.muted = !mp.voiceChat.muted;
		mp.game.graphics.notify("Voice Chat: " + ((!mp.voiceChat.muted) ? "~g~enabled" : "~r~disabled"));
		if (!mp.voiceChat.muted) {
			hud.execute(`document.getElementById('voice').classList.remove("vOff");`);
			hud.execute(`document.getElementById('voice').classList.add("vOn");`);
		} else {
			hud.execute(`document.getElementById('voice').classList.remove("vOn");`);
			hud.execute(`document.getElementById('voice').classList.add("vOff");`);
		}
	}
});

let g_voiceMgr =
{
	listeners: [],
	
	add: function(player)
	{
		this.listeners.push(player);
		
		player.isListening = true;		
		mp.events.callRemote("add_voice_listener", player);
		
		if(UseAutoVolume)
		{
			player.voiceAutoVolume = true;
		}
		else
		{
			player.voiceVolume = 1.0;
		}
		
		if(Use3d)
		{
			player.voice3d = true;
		}
	},
	
	remove: function(player, notify)
	{
		let idx = this.listeners.indexOf(player);
			
		if(idx !== -1)
			this.listeners.splice(idx, 1);
			
		player.isListening = false;		
		
		if(notify)
		{
			mp.events.callRemote("remove_voice_listener", player);
		}
	}
};

mp.events.add("playerQuit", (player) =>
{
	if(player.isListening)
	{
		g_voiceMgr.remove(player, false);
	}
});

setInterval(() =>
{
	let localPlayer = mp.players.local;
	let localPos = localPlayer.position;
	
	mp.players.forEachInStreamRange(player =>
	{
		if(player != localPlayer)
		{
			if(!player.isListening)
			{
				const playerPos = player.position;		
				let dist = mp.game.system.vdist(playerPos.x, playerPos.y, playerPos.z, localPos.x, localPos.y, localPos.z);
				
				if(dist <= MaxRange)
				{
					g_voiceMgr.add(player);
				}
			}
		}
	});
	g_voiceMgr.listeners.forEach((player) =>
	{
		if(player.handle !== 0)
		{
			const playerPos = player.position;		
			let dist = mp.game.system.vdist(playerPos.x, playerPos.y, playerPos.z, localPos.x, localPos.y, localPos.z);
			
			if(dist > MaxRange)
			{
				g_voiceMgr.remove(player, true);
			}
			else if(!UseAutoVolume)
			{
				player.voiceVolume = 1 - (dist / MaxRange);
			}
		}
		else
		{
			g_voiceMgr.remove(player, true);
		}
    });
    //mp.gui.chat.push("Voice: " + JSON.stringify(g_voiceMgr.listeners));
}, 500);