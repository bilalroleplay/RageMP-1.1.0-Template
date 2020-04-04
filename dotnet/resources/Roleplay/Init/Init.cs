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

        [ServerEvent(Event.PlayerConnected)]
        public void PlayerConnected(Player c)
        {
            c.Dimension = uint.MaxValue - (uint)rnd.Next(999999);
            c.Position = new Vector3(344.3341, -998.8612, -99.19622);
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
