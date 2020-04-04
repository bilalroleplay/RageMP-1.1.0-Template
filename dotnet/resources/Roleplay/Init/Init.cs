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

            Log.WriteS("Zeit wird angepasst...");
            NAPI.World.SetTime(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);

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
                    });

                    first_while.Wait();
                }
            });

            Console.WriteLine("=============================");
            Console.WriteLine("====== Roleplay Script ======");
            Console.WriteLine("=============================");
        }

        [ServerEvent(Event.IncomingConnection)]
        public void OnIncomingConnection(string ip, string serial, string rgscName, ulong rgscId, CancelEventArgs cancel)
        {
            Log.WriteS("Eingehende Verbindung: [IP: " + ip + " | RgScName: " + rgscName + "]");
        }

        [ServerEvent(Event.PlayerConnected)]
        public void PlayerConnected(Player c)
        {
            c.Dimension = uint.MaxValue - (uint)rnd.Next(999999);
            c.Position = new Vector3(344.3341, -998.8612, -99.19622);
        }

        [ServerEvent(Event.PlayerDisconnected)]
        public void PlayerDisconnected(Player c, DisconnectionType type, string reason)
        {
            switch (type)
            {
                case DisconnectionType.Left:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen.");
                        PlayerAPI.API.SavePlayer(c);
                    } else if (c.HasData("account_id"))
                    {
                        Log.WriteS("Account ID: " + c.GetData<int>("account_id") + ", hat den Server verlassen.");
                    }
                    break;
                case DisconnectionType.Timeout:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen. [Timeout]");
                        PlayerAPI.API.SavePlayer(c);
                    }
                    else if (c.HasData("account_id"))
                    {
                        Log.WriteS("Account ID: " + c.GetData<int>("account_id") + ", hat den Server verlassen. [Timeout]");
                    }
                    break;
                case DisconnectionType.Kicked:
                    if (c.HasData("character_id"))
                    {
                        Log.WriteS(c.Name + ", hat den Server verlassen. [Kick]");
                        PlayerAPI.API.SavePlayer(c);
                    }
                    else if (c.HasData("account_id"))
                    {
                        Log.WriteS("Account ID: " + c.GetData<int>("account_id") + ", hat den Server verlassen. [Kick]");
                    }
                    break;
            }
        }

        [RemoteEvent("IfPlayerLoggedIn")]
        public void IfPlayerLoggedIn(Player c)
        {
            if (c.HasData("character_id"))
            {
                c.TriggerEvent("VoiceMute", true);
            } else
            {
                c.TriggerEvent("VoiceMute", false);
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
