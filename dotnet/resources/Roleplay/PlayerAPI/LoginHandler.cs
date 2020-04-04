using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;

namespace Roleplay.PlayerAPI
{
    class LoginHandler : Script
    {
        [RemoteEvent("LoginAccount")]
        public static void LoginPlayer(Player c, string username, string password)
        {
            if (c.HasData("login_time") && (((long)(DateTime.Now - c.GetData<DateTime>("login_time")).TotalMilliseconds) < 1000))
            {
                c.SendNotification("Nicht so schnell!");
                return;
            }

            if (c.HasData("account_id"))
            {
                c.SendNotification("Du bist bereits eingeloggt!");
                return;
            }

            c.SetData("login_time", DateTime.Now);

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "SELECT socialclub FROM bans_socialclub WHERE socialclub = @sc";
            cmd.Parameters.AddWithValue("@sc", c.SocialClubName);
            MySqlDataReader read = cmd.ExecuteReader();
            bool scCheck = read.Read();
            read.Close();
            if (scCheck)
            {
                c.SendNotification("~r~Dein SocialClub wurde von unserem Server gebannt!");
                c.Kick();
                DatabaseAPI.API.GetInstance().FreeConnection(conn);
                return;
            }
            read.Close();

            cmd.CommandText = "SELECT * FROM accounts WHERE username = @user";
            cmd.Parameters.AddWithValue("@user", username);
            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                if (password == reader.GetString("password"))
                {
                    int id = reader.GetInt32("id");
                    reader.Close();
                    PlayerAPI.API.Login(conn, c, id);
                }
                else
                {
                    reader.Close();
                    c.SendNotification("~r~Passwort falsch");
                }
            }
            else
            {
                reader.Close();
                c.SendNotification("~r~Benutzername nicht gefunden");
            }

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }
    }
}
