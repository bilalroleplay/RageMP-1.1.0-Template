using System;
using System.Threading.Tasks;
using GTANetworkAPI;

namespace Roleplay.Init
{
    public class Init : Script
    {
        private static readonly Random rnd = new Random();

        [ServerEvent(Event.ResourceStart)]
        public void ResourceStart()
        {
            Console.WriteLine("=============================");
            Console.WriteLine("====== Roleplay Script ======");
            Console.WriteLine("=============================");

            NAPI.Server.SetAutoSpawnOnConnect(false);
            NAPI.Server.SetAutoRespawnAfterDeath(false);
            NAPI.Server.SetGlobalServerChat(false);
            NAPI.Server.SetLogRemoteEventParamParserExceptions(false);
            NAPI.Server.SetLogCommandParamParserExceptions(false);

            NAPI.Server.SetCommandErrorMessage("[~r~SERVER~w~] Dieser Befehl existiert nicht!");

            DatabaseAPI.API.GetInstance();

            Log.WriteM("Haussystem wird geladen...");
            Housesystem.API.LoadDatabaseHouses();

            Log.WriteM("Fahrzeuge werden geladen...");
            VehiclesAPI.API.lastSave = DateTime.Now;
            VehiclesAPI.API.SpawnAll();

            Log.WriteS("Zeit wird angepasst...");
            NAPI.World.SetTime(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);

            Task.Run(() =>
            {
                while (true)
                {
                    //TODO: Zeit anpassen. Ist nur zum testen
                    Task.Delay(500).Wait();
                    foreach (Vehicle v in NAPI.Pools.GetAllVehicles())
                    {
                        if (v.GetData<float>("fuel") == 0)
                            v.EngineStatus = false;
                        else
                            v.EngineStatus = v.GetData<bool>("engine");
                    }
                }
            });

            Task.Run(() =>
            {
                while (true)
                {
                    Task.Delay(1000 * 60 * 1).Wait();
                    Task first_while = Task.Run(() =>
                    {
                        NAPI.World.SetTime(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                        Log.WriteS("Zeit wurde aktualisiert!");

                        foreach (Player c in NAPI.Pools.GetAllPlayers())
                        {
                            PlayerAPI.API.SavePlayer(c);
                        }

                        VehiclesAPI.API.SaveAll();
                    });

                    first_while.Wait();
                }
            });

            Console.WriteLine("=============================");
            Console.WriteLine("====== Roleplay Script ======");
            Console.WriteLine("=============================");
        }

        [ServerEvent(Event.PlayerConnected)]
        public void PlayerConnected(Player c)
        {
            c.Dimension = uint.MaxValue - (uint)rnd.Next(999999);
            c.Position = new Vector3(344.3341, -998.8612, -99.19622);
            c.TriggerEvent("ShowLogin");
        }

        [ServerEvent(Event.PlayerDisconnected)]
        public void PlayerDisconnected(Player c, DisconnectionType type, string reason)
        {
            PlayerAPI.API.SavePlayer(c);

            switch (type)
            {
                case DisconnectionType.Left:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen.");
                    }
                    break;
                case DisconnectionType.Timeout:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen. [Timeout]");
                    }
                    break;
                case DisconnectionType.Kicked:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen. [Kick]");
                    }
                    break;
            }
        }

        [RemoteEvent("IfPlayerLoggedIn")]
        public void IfPlayerLoggedIn(Player c, string data)
        {
            bool loggedin = false;

            if (c.HasData("character_id"))
                loggedin = true;

            switch(data)
            {
                case "voice":
                    c.TriggerEvent("VoiceMute", loggedin);
                    break;
            }
        }

        [RemoteEvent("add_voice_listener")]
        public void add_voice_listener(Player c, Player t)
        {
            NAPI.Player.EnablePlayerVoiceTo(c, t);
        }

        [RemoteEvent("remove_voice_listener")]
        public void remove_voice_listener(Player c, Player t)
        {
            NAPI.Player.DisablePlayerVoiceTo(c, t);
        }
    }
}
