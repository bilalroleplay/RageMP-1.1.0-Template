using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;

namespace Roleplay.PlayerAPI
{
    class API : Script
    {
        public static readonly string[] AdminLvlNames = new string[] {
            "Bürger",
            "Supporter",
            "Admin",
            "Head Admin",
            "Projektleiter",
        };

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

        #region Admin
        public static bool IsAdmin(Player c)
        {
            if (c.HasData("adminlvl"))
                if (c.GetData<int>("adminlvl") > 0)
                    return true;

            return false;
        }

        public static int GetAdmin(Player c)
        {
            if (c.HasData("adminlvl"))
                return c.GetData<int>("adminlvl");

            return 0;
        }

        public static void SetAdmin(Player c, Player t, int admin)
        {
            if (GetAdmin(c) >= 4) //0 = Bürger, 1 = Supporter, 2 = Admin, 3 = Head Admin, 4 = Projektleiter
            {
                MySqlCommand cmd = new MySqlCommand("UPDATE characters SET admin = @admin WHERE id = @id");

                cmd.Parameters.AddWithValue("@id", t.GetData<int>("character_id"));
                cmd.Parameters.AddWithValue("@admin", admin);

                DatabaseAPI.API.executeNonQuery(cmd);

                if (admin > t.GetData<int>("adminlvl"))
                    NAPI.Chat.SendChatMessageToAll("[~r~SERVER~w~]: Spieler " + t.Name + " wurde zum ~g~" + AdminLvlNames[(admin > AdminLvlNames.Length) ? 0 : admin] + "~w~ befördert.");
                else if (admin < t.GetData<int>("adminlvl"))
                    NAPI.Chat.SendChatMessageToAll("[~r~SERVER~w~]: Spieler " + t.Name + " wurde zum ~g~" + AdminLvlNames[(admin > AdminLvlNames.Length) ? 0 : admin] + "~w~ degradiert.");

                t.SetData("adminlvl", admin);
            }
        }
        #endregion
    }
}
