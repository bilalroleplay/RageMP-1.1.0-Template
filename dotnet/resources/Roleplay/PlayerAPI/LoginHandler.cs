using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

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
                    Login(conn, c, id);
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

        public struct CharacterObj
        {
            public int id;
            public string firstName;
            public string lastName;
        }

        public static void Login(MySqlConnection conn, Player c, int id)
        {
            c.SetData("account_id", id);

            MySqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT id, first_name, last_name FROM characters WHERE account_id = @a_id";
            cmd.Parameters.AddWithValue("@a_id", id);
            MySqlDataReader reader = cmd.ExecuteReader();

            List<CharacterObj> chars = new List<CharacterObj> { };
            while (reader.Read())
            {
                CharacterObj characterObj = new CharacterObj
                {
                    id = reader.GetInt32("id"),
                    firstName = reader.GetString("first_name"),
                    lastName = reader.GetString("last_name")
                };
                chars.Add(characterObj);
            }

            reader.Close();

            c.TriggerEvent("LoginSuccess", chars);
        }
    }
}
