using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;

namespace Roleplay.VehiclesAPI
{
    class Vehicles : Script
    {
        public static bool Create(Player c, string vehName)
        {
            int cId = c.GetData<int>("character_id");

            uint hash = NAPI.Util.GetHashKey(vehName);

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("INSERT INTO vehicles(cfg_vehicle_id, fuel, character_id, p_x, p_y, p_z, r) (SELECT id, fuel_tank / 2, @c_id, @p_x, @p_y, @p_z, @r FROM cfg_vehicles WHERE hash = @hash)", conn);
            cmd.Parameters.AddWithValue("@hash", hash);
            cmd.Parameters.AddWithValue("@p_x", c.Position.X);
            cmd.Parameters.AddWithValue("@p_y", c.Position.Y);
            cmd.Parameters.AddWithValue("@p_z", c.Position.Z);
            cmd.Parameters.AddWithValue("@r", c.Rotation.Z);
            cmd.Parameters.AddWithValue("@c_id", cId);

            int rows = 0;
            try
            {
                rows = cmd.ExecuteNonQuery();
            }
            catch (MySqlException ex)
            {
                Log.WriteDError("Hash von Fahrzeug konnte nicht gefunden werden: " + ex.Message);
                DatabaseAPI.API.GetInstance().FreeConnection(conn);
            }

            if (rows != 0)
            {
                cmd = new MySqlCommand("SELECT v.*, c.hash, c.multi, fuel_tank, fuel_consumption FROM vehicles v JOIN cfg_vehicles c ON v.cfg_vehicle_id = c.id WHERE v.id = LAST_INSERT_ID()", conn);
                MySqlDataReader r = cmd.ExecuteReader();
                if (r.Read())
                {
                    Vehicle veh = Spawn(r);
                    c.SetIntoVehicle(veh, -1);
                }
                r.Close();
            }
            else
            {
                Log.WriteDError("Fahrzeug wurde nicht gefunden: " + vehName);
            }


            DatabaseAPI.API.GetInstance().FreeConnection(conn);
            return true;
        }


        public static Vehicle Spawn(MySqlDataReader r)
        {
            string numberPlate = "TEST";
            byte alpha = 255;
            bool engine = r.GetBoolean("engine");
            int c = r.GetInt32("c");
            int s = r.GetInt32("s");

            Vehicle veh = NAPI.Vehicle.CreateVehicle(
                r.GetUInt32("hash"),
                new Vector3(r.GetFloat("p_x"), r.GetFloat("p_y"), r.GetFloat("p_z")),
                r.GetFloat("r"),
                c,
                s,
                numberPlate,
                alpha,
                r.GetBoolean("locked"),
                engine,
                r.GetUInt32("dim")
            );

            if (c == 0 && s == 0)
            {
                veh.CustomPrimaryColor = new Color(r.GetByte("c_r"), r.GetByte("c_g"), r.GetByte("c_b"));
                veh.CustomSecondaryColor = new Color(r.GetByte("s_r"), r.GetByte("s_g"), r.GetByte("s_b"));
            }

            veh.SetData("id", r.GetInt32("id"));
            veh.SetData("hp", r.GetFloat("hp"));

            veh.SetData("owner", r.GetInt32("character_id"));

            veh.SetData("multi", r.GetInt32("multi"));

            veh.SetData("km", r.GetFloat("km"));
            veh.SetData("fuel", r.GetFloat("fuel"));
            veh.SetData("fuelTank", r.GetFloat("fuel_tank"));
            veh.SetData("fuelConsumption", r.GetFloat("fuel_consumption"));

            veh.SetData("engine", engine);

            veh.SetData("lastUsed", r.GetDateTime("last_used"));
            veh.SetData("lastDriver", -1);

            return veh;
        }

        public static void syncVehicle(Player c, Vehicle veh)
        {
            float fuel = veh.GetData<float>("fuel");

            c.TriggerEvent("vehicleEnter",
                veh.GetData<int>("id"),
                veh.GetData<float>("hp"),
                veh.GetData<float>("km"),
                veh.GetData<int>("multi"),
                fuel,
                veh.GetData<float>("fuelTank"),
                veh.GetData<float>("fuelConsumption"),
                veh.GetData<bool>("engine")
            );
            veh.SetData("lastUsed", DateTime.Now);
            veh.SetData("lastDriver", c.GetData<int>("character_id"));
            c.SetData("lastVehicle", veh);
        }
    }
}
