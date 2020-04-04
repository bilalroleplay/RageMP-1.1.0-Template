using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System.Collections.Generic;

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
                CharacterObj characterObj = new CharacterObj();
                characterObj.id = reader.GetInt32("id");
                characterObj.firstName = reader.GetString("first_name");
                characterObj.lastName = reader.GetString("last_name");
                chars.Add(characterObj);
            }

            reader.Close();

            c.TriggerEvent("LoginSuccess", chars);
        }
    }
}
