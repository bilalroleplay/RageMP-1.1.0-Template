using GTANetworkAPI;

namespace Roleplay.PlayerAPI.Commands
{
    class Commands : Script
    {
        [Command("veh", GreedyArg = true)]
        public void HandleVeh(Player c, string vehName)
        {
            if (PlayerAPI.API.GetAdmin(c) > 1) //Nur Admin's und höher
                VehiclesAPI.Vehicles.Create(c, vehName);
            else if (PlayerAPI.API.GetAdmin(c) == 1) //Wenn Spieler ein Supporter ist
                c.SendNotification("Du kannst diesen Befehl nicht ausführen!");
        }

        [Command("fuel")]
        public void HandleRefuel(Player c, int value)
        {
            Vehicle v = c.Vehicle;

            if (value < 1)
            {
                c.SendNotification("Du musst mindestens einen Wert von 1 oder mehr angeben.");
                return;
            }

            if (v.GetData<float>("fuel") + (v.GetData<float>("fuelTank") * value / 100) > (v.GetData<float>("fuelTank") * 100 / 100))
            {
                c.SendNotification("~r~So viel passt nicht mehr in das Fahrzeug!");
                return;
            }

            v.SetData("fuel", v.GetData<float>("fuel") + (v.GetData<float>("fuelTank") * value / 100));
            VehiclesAPI.Vehicles.syncVehicle(c, v);
        }

        [Command("dc")]
        public void dc(Player c)
        {
            c.Kick();
        }

        [Command("sellhouse")]
        public void SellHouse(Player c)
        {
            Housesystem.API.SellHouse(c);
        }

        [Command("buyhouse")]
        public void BuyHouse(Player c)
        {
            Housesystem.API.BuyHouse(c);
        }

        [Command("createhouse")]
        public void CreateHouse(Player c, int interior, int cost)
        {
            Housesystem.API.CreateHouse(c, interior, cost);
        }

        #region Admin
        [Command("setadmin")]
        public void SetAdmin(Player c, Player t, int lvl)
        {
            if (PlayerAPI.API.IsAdmin(c) && t.HasData("adminlvl"))
                PlayerAPI.API.SetAdmin(c, t, lvl);
        }

        [Command("oc")]
        public void OC(Player c, string[] args)
        {
            if (PlayerAPI.API.IsAdmin(c))
                NAPI.Chat.SendChatMessageToAll("[~r~OC~w~]: " + args);
        }
        #endregion
    }
}
