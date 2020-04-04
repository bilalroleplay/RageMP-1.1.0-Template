using GTANetworkAPI;
using MySql.Data.MySqlClient;

namespace Roleplay.PlayerAPI
{
    class Character : Script
    {
        [RemoteEvent("login.character.select")]
        public static void SelectCharacter(Player c, int id)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM characters WHERE id = @id AND account_id = @a_id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@a_id", c.GetData<int>("account_id"));
            MySqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                c.SetData("character_id", r.GetInt32("id"));
                c.SetData("dim", r.GetUInt32("dim"));
                c.Name = r.GetString("first_name") + r.GetString("last_name");
                c.Position = new Vector3(r.GetFloat("last_pos_x"), r.GetFloat("last_pos_y"), r.GetFloat("last_pos_z"));
                c.Dimension = r.GetUInt32("dim");
            }

            r.Close();
            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            c.TriggerEvent("ShowHUD", c);
            c.TriggerEvent("LoginSuccess");

            MoneyAPI.API.SyncCash(c);

            c.SendNotification("~g~Erfolgreich eingeloggt!");
        }
    }
}
