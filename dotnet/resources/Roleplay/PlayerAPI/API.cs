using GTANetworkAPI;
using MySql.Data.MySqlClient;

namespace Roleplay.PlayerAPI
{
    class API : Script
    {
        public static void SavePlayer(Player c)
        {
            if (c.HasData("character_id"))
            {
                int cId = c.GetData<int>("character_id");
                if (cId != -1)
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE characters SET last_pos_x = @p_x, last_pos_y = @p_y, last_pos_z = @p_z, dim = @dim WHERE id = @id");
                    cmd.Parameters.AddWithValue("@id", cId);
                    cmd.Parameters.AddWithValue("@p_x", c.Position.X);
                    cmd.Parameters.AddWithValue("@p_y", c.Position.Y);
                    cmd.Parameters.AddWithValue("@p_z", c.Position.Z);
                    cmd.Parameters.AddWithValue("@dim", c.Dimension);

                    DatabaseAPI.API.executeNonQuery(cmd);
                    Log.WriteM("Spieler " + c.Name + " gespeichert.");
                }
            }
        }

        public static void Login(MySqlConnection conn, Player c, int id)
        {
            MySqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT * FROM characters WHERE account_id = @a_id";
            cmd.Parameters.AddWithValue("@a_id", id);
            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                c.SetData("character_id", reader.GetInt32("id"));
                c.SetData("dim", reader.GetUInt32("dim"));
                c.Name = reader.GetString("first_name") + reader.GetString("last_name");
                c.Position = new Vector3(reader.GetFloat("last_pos_x"), reader.GetFloat("last_pos_y"), reader.GetFloat("last_pos_z"));
                c.Dimension = reader.GetUInt32("dim");
            }
            reader.Close();

            c.SetData("account_id", id);

            c.TriggerEvent("ShowHUD", c);
            c.TriggerEvent("LoginSuccess");

            MoneyAPI.API.SyncCash(c);

            c.SendNotification("~g~Erfolgreich eingeloggt!");
        }
    }
}
