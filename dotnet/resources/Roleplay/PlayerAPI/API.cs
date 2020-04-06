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
    }
}
