using GTANetworkAPI;

namespace Roleplay.PlayerAPI.Commands
{
    class Commands : Script
    {
        [Command("eng")]
        public void ShowEngineStatus(Player c)
        {
            c.SendNotification("Status: " + c.Vehicle.GetData<bool>("engine"));
        }

        [Command("veh", GreedyArg = true)]
        public void HandleVeh(Player c, string vehName)
        {
            VehiclesAPI.Vehicles.Create(c, vehName);
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
    }
}
