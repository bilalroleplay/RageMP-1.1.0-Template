using System;
using GTANetworkAPI;
using MySql.Data.MySqlClient;


namespace Roleplay.VehiclesAPI
{
    class API
    {
        public static DateTime lastSave;
        public static void SpawnAll()
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("SELECT v.*, c.hash, c.multi, fuel_tank, fuel_consumption FROM vehicles v JOIN cfg_vehicles c ON v.cfg_vehicle_id = c.id", conn);
            MySqlDataReader r = cmd.ExecuteReader();
            while (r.Read())
            {
                Vehicles.Spawn(r);
            }
            r.Close();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }

        public static void SaveAll()
        {
            foreach (Vehicle v in NAPI.Pools.GetAllVehicles())
            {
                SavePos(v);
            }
            lastSave = DateTime.Now;
        }

        public static void SavePos(Vehicle v)
        {
            if (v.HasData("id"))
            {
                int vId = v.GetData<int>("id");
                if (vId != -1)
                {
                    if (v.GetData<DateTime>("lastUsed") > lastSave)
                    {
                        MySqlCommand cmd = new MySqlCommand("UPDATE vehicles SET " +
                            "p_x = @p_x, p_y = @p_y, p_z = @p_z, r = @r, " +
                            "engine = @engine, locked = @locked, hp = @hp, km=@km, fuel=@fuel, last_used = @last_used " +
                            "WHERE id = @id");
                        cmd.Parameters.AddWithValue("@p_x", v.Position.X);
                        cmd.Parameters.AddWithValue("@p_y", v.Position.Y);
                        cmd.Parameters.AddWithValue("@p_z", v.Position.Z);
                        cmd.Parameters.AddWithValue("@r", v.Rotation.Z);

                        cmd.Parameters.AddWithValue("@engine", v.GetData<bool>("engine"));
                        cmd.Parameters.AddWithValue("@locked", v.Locked);
                        cmd.Parameters.AddWithValue("@hp", v.GetData<float>("hp"));
                        cmd.Parameters.AddWithValue("@km", v.GetData<float>("km"));
                        cmd.Parameters.AddWithValue("@fuel", v.GetData<float>("fuel"));
                        cmd.Parameters.AddWithValue("@last_used", v.GetData<DateTime>("lastUsed"));

                        cmd.Parameters.AddWithValue("@id", vId);

                        DatabaseAPI.API.executeNonQuery(cmd);
                        Log.WriteM("Fahrzeug[" + vId + "] gespeichert.");
                    }
                }
            }
        }

        public static void Delete(int vId)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("DELETE FROM vehicles WHERE id = @id", conn);

            cmd.Parameters.AddWithValue("@id", vId);

            DatabaseAPI.API.executeNonQuery(cmd);

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }

        public static bool HasVehicleKey(Vehicle v, Player c)
        {
            if (v.GetData<int>("owner") == c.GetData<int>("character_id"))
                return true;

            return false;
        }
    }
}
