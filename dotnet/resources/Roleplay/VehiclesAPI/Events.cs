using System;
using GTANetworkAPI;

namespace Roleplay.VehiclesAPI
{
    class Events : Script
    {
        [RemoteEvent("clog")]
        public static void OnCLog(Player c, string s)
        {
            Console.WriteLine(s);
        }

        [RemoteEvent("updateVehicle")]
        public static void UpdateVehicle(Player c, int vId, float km, float fuel)
        {
            Vehicle veh = c.GetData<Vehicle>("lastVehicle");
            if (veh.GetData<int>("id") == vId)
            {
                veh.SetData("km", km);
                veh.SetData("fuel", fuel);
                if (fuel == 0)
                {
                    if (veh.GetData<bool>("engine"))
                    {
                        veh.SetData("engine", false);
                        veh.EngineStatus = false;
                        Vehicles.syncVehicle(c, veh);
                    }
                }
            }
            else
            {
                Log.WriteSError("Veh update error: " + vId);
            }

            veh.SetData("lastUsed", DateTime.Now);
        }


        [RemoteEvent("toggleEngine")]
        public static void ToggleEngine(Player c)
        {
            Vehicle v = c.Vehicle;
            bool engine = v.GetData<bool>("engine");
            if (VehiclesAPI.API.HasVehicleKey(v, c))
            {
                if (engine)
                {
                    v.SetData("engine", false);
                    v.EngineStatus = false;
                }
                else
                {
                    if (v.GetData<float>("fuel") == 0)
                    {
                        c.SendNotification("Der Tank ist leer");
                    }
                    else
                    {
                        v.SetData("engine", true);
                        v.EngineStatus = true;
                    }
                }
            } else
            {
                c.SendNotification("Du besitzt keinen Schlüssel!");
            }
        }


        [ServerEvent(Event.PlayerEnterVehicle)]
        public void OnPlayerEnterVehicle(Player c, Vehicle veh, sbyte seatID)
        {
            if (seatID == 0)
            {
                Vehicles.syncVehicle(c, veh);
                c.SendNotification("Schalte den Motor mit '~g~X~w~' an oder aus");
            }
        }

        [ServerEvent(Event.VehicleDeath)]
        public void VehicleDeath(Vehicle veh)
        {
            int vId = veh.GetData<int>("id");
            VehiclesAPI.API.Delete(vId);
            Log.WriteS("Fahrzeug[" + vId + "] wurde zerstört.");
        }
    }
}
