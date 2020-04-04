using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System.Collections.Generic;

namespace Roleplay.Housesystem
{
    class API : Script
    {
        public static Blip CreateMarker(uint sprite, Vector3 position, float scale, byte color, string name = "", byte alpha = 255, float drawDistance = 0, bool shortRange = true, short rotation = 0, uint dimension = uint.MaxValue)
        {
            Blip blip = NAPI.Blip.CreateBlip(sprite, position, scale, color, name, alpha, drawDistance, shortRange, rotation, dimension);
            return blip;
        }

        public static List<House> houseList;

        public static Vector3[] InteriorList = new Vector3[]
        {
            new Vector3(-614.86, 40.6783, 97.60007), //Hochhaus Gehoben - 0
            new Vector3(152.2605, -1004.471, -98.99999), //Low Low End Apartment - 1
            new Vector3(261.4586, -998.8196, -99.00863), //Low End Apartment - 2
            new Vector3(347.2686, -999.2955, -99.19622), //Medium End Apartment - 3
            new Vector3(-1477.14, -538.7499, 55.5264), //Hochhaus Sehr Gehoben - 4
            new Vector3(-169.286, 486.4938, 137.4436), // Sehr Gehoben Hills 1 - 5
            new Vector3(340.9412, 437.1798, 149.3925), // Sehr Gehoben Hills 2 - 6
            new Vector3(373.023, 416.105, 145.7006), // Sehr Gehoben Hills 3 - 7
            new Vector3(-676.127, 588.612, 145.1698), // Sehr Gehoben Hills 4 - 8
            new Vector3(-763.107, 615.906, 144.1401), // Sehr Gehoben Hills 5 - 9
            new Vector3(-857.798, 682.563, 152.6529), // Sehr Gehoben Hills 6 - 10
            new Vector3(-1288, 440.748, 97.69459), // Sehr Gehoben Hills 7 - 11
            new Vector3(1397.072, 1142.011, 114.3335) // Farm Ultra Luxus - 12
        };

        #region BuyHouse/SellHouse
        public static void SellHouse(Player c)
        {
            foreach (House houseModel in houseList)
            {
                while (c.Position.DistanceTo2D(houseModel.position) < 5 || c.Dimension == houseModel.id)
                {
                    if (houseModel.owner == c.Name)
                    {
                        FinishSellHouse(c, houseModel.id);

                        houseModel.owner = "STAAT";
                        houseModel.status = 1;
                        houseModel.locked = 0;
                        houseModel.houseLabel.Text = GetHouseLabelText(houseModel);

                        c.SendChatMessage("Haus verkauft!");
                        Log.WriteS($"Spieler {c.Name} hat sein Haus mit folgender ID verkauft: {houseModel.id}");
                    }
                    else
                    {
                        c.SendChatMessage("~r~Das Haus gehört nicht dir!");
                    }
                    break;
                }
            }
        }

        public static void BuyHouse(Player c)
        {
            foreach (House houseModel in houseList)
            {
                while (c.Position.DistanceTo2D(houseModel.position) < 5 || c.Dimension == houseModel.id)
                {
                    if (houseModel.status == 1)
                    {

                        if (c.GetData<int>("money_cash") <= houseModel.price)
                        {
                            c.SendNotification("Dein Geld reicht dafür nicht aus!");
                            return;
                        }

                        FinishBuyHouse(c, houseModel.id);

                        houseModel.owner = c.Name;
                        houseModel.status = 0;
                        houseModel.houseLabel.Text = GetHouseLabelText(houseModel);

                        PlayerAPI.MoneyAPI.API.SubCash(c, houseModel.price);
                        c.SendChatMessage("Haus gekauft!");
                        Log.WriteS($"Spieler {c.Name} hat das Haus mit folgender ID gekauft: {houseModel.id}");
                    }
                    else
                    {
                        c.SendChatMessage("~r~Das Haus steht nicht zum vekauf!");
                    }
                    break;
                }
            }
        }

        public static void FinishSellHouse(Player c, uint houseid)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "UPDATE house SET owner=@owner, status=@status, locked=@locked WHERE id=@houseid";
            cmd.Parameters.AddWithValue("@houseid", houseid);
            cmd.Parameters.AddWithValue("@owner", "STAAT");
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@locked", 0);
            cmd.ExecuteNonQuery();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }

        public static void FinishBuyHouse(Player c, uint houseid)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "UPDATE house SET status=@status, owner=@owner WHERE id=@houseid";
            cmd.Parameters.AddWithValue("@houseid", houseid);
            cmd.Parameters.AddWithValue("@status", 0);
            cmd.Parameters.AddWithValue("@owner", c.Name);
            cmd.ExecuteNonQuery();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }
        #endregion

        #region LockHouse
        [RemoteEvent("LockThatHouse")]
        public static void LockHouse(Player c)
        {
            if (c.IsInVehicle)
            {
                c.SendNotification("~r~Du musst dafür aussteigen!");
                return;
            }

            foreach (House houseModel in houseList)
            {
                if (c.Position.DistanceTo(houseModel.position) < 5 || c.Dimension == houseModel.id)
                {
                    if (c.Name == houseModel.owner)
                    {
                        if (houseModel.locked == 0)
                        {
                            LockedHouse(0, houseModel.id);
                            c.SendChatMessage("~r~Haus abgeschlossen!");
                        }
                        else
                        {
                            LockedHouse(1, houseModel.id);
                            c.SendChatMessage("~g~Haus aufgeschlossen!");
                        }
                    }
                    else
                    {
                        c.SendChatMessage($"Du besitzt keinen Schlüssel für dieses Haus!");
                    }
                    break;
                }
            }
        }

        public static void LockedHouse(int locked, uint houseid)
        {
            House house = GetHouseById(houseid);

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("UPDATE house SET locked=@locked WHERE id=@houseid", conn);
            cmd.Parameters.AddWithValue("@houseid", houseid);

            if (locked == 0)
            {
                cmd.Parameters.AddWithValue("@locked", 1);
                cmd.ExecuteNonQuery();

                house.locked = 1;
            }
            else if (locked == 1)
            {
                cmd.Parameters.AddWithValue("@locked", 0);
                cmd.ExecuteNonQuery();

                house.locked = 0;
            }

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }
        #endregion

        #region EnterHouse/ExitHouse
        [RemoteEvent("EnterExitThatHouse")]
        public static void HouseEnterExit(Player c)
        {
            foreach (House houseModel in houseList)
            {
                while (c.Position.DistanceTo(houseModel.position) < 2 || c.Dimension == houseModel.id)
                {
                    if (c.GetData<uint>("dim") != 0)
                    {
                        c.Dimension = 0;
                        c.Position = houseModel.position;
                        c.SetData("dim", c.Dimension);
                        PlayerAPI.API.SavePlayer(c);
                    }
                    else
                    {
                        c.Dimension = houseModel.id;
                        c.Position = InteriorList[(houseModel.interior > InteriorList.Length) ? 0 : houseModel.interior];
                        c.SetData("dim", houseModel.id);
                        c.SendNotification("Dimension:" + c.Dimension);
                        PlayerAPI.API.SavePlayer(c);
                    }
                    break;
                }
            }
        }
        #endregion

        #region CreateHouse
        public static void CreateHouse(Player c, int interior, int cost)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("INSERT INTO house (status, owner, interior, x, y, z, locked, cost) VALUES (@status, @account, @interior, @x, @y, @z, @locked, @cost)", conn);
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@account", "STAAT");
            cmd.Parameters.AddWithValue("@interior", interior);
            cmd.Parameters.AddWithValue("@x", c.Position.X);
            cmd.Parameters.AddWithValue("@y", c.Position.Y);
            cmd.Parameters.AddWithValue("@z", c.Position.Z);
            cmd.Parameters.AddWithValue("@locked", 0);
            cmd.Parameters.AddWithValue("@cost", cost);
            cmd.ExecuteNonQuery();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            MySqlCommand cmd2 = new MySqlCommand("SELECT * FROM house WHERE id = LAST_INSERT_ID();", conn);
            MySqlDataReader reader = cmd2.ExecuteReader();

            if (reader.Read())
            {
                House house = new House();
                float posX = reader.GetFloat("x");
                float posY = reader.GetFloat("y");
                float posZ = reader.GetFloat("z");

                house.id = reader.GetUInt32("id");
                house.status = reader.GetInt32("status");
                house.position = new Vector3(posX, posY, posZ);
                house.price = reader.GetInt32("cost");
                house.owner = reader.GetString("owner");
                house.locked = reader.GetInt32("locked");
                house.interior = reader.GetInt32("interior");

                houseList.Add(house);

                string houseLabelText = GetHouseLabelText(house);
                house.houseLabel = NAPI.TextLabel.CreateTextLabel(houseLabelText, house.position, 20.0f, 0.75f, 4, new Color(255, 255, 255), false, 0);
                CreateMarker(40, house.position, 0.8f, 2, "Haus");
            }
            reader.Close();
        }
        #endregion

        #region LoadHouse
        public static List<House> LoadAllHouses()
        {
            List<House> houseList = new List<House>();

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "SELECT * FROM house";

            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    House house = new House();
                    float posX = reader.GetFloat("x");
                    float posY = reader.GetFloat("y");
                    float posZ = reader.GetFloat("z");

                    house.id = reader.GetUInt32("id");
                    house.status = reader.GetInt32("status");
                    house.position = new Vector3(posX, posY, posZ);
                    house.price = reader.GetInt32("cost");
                    house.owner = reader.GetString("owner");
                    house.locked = reader.GetInt32("locked");
                    house.interior = reader.GetInt32("interior");

                    houseList.Add(house);
                }
            }

            return houseList;
        }

        public static void LoadDatabaseHouses()
        {
            houseList = LoadAllHouses();
            foreach (House houseModel in houseList)
            {
                string houseLabelText = GetHouseLabelText(houseModel);
                houseModel.houseLabel = NAPI.TextLabel.CreateTextLabel(houseLabelText, houseModel.position, 20.0f, 0.75f, 4, new Color(255, 255, 255), false, 0);
                CreateMarker(40, houseModel.position, 0.8f, 2, "Haus");
            }
        }

        public static string GetHouseLabelText(House house)
        {
            string label = string.Empty;

            switch (house.status)
            {
                case 0:
                    label = $"[~g~Haus von~w~]:" + house.owner;
                    break;
                case 1:
                    label = "[~y~Haus wird verkauft!~w~]\n[~g~Kosten~w~]: " + house.price;
                    break;
            }
            return label;
        }

        public static House GetHouseById(uint id)
        {
            House house = null;
            foreach (House houseModel in houseList)
            {
                if (houseModel.id == id)
                {
                    house = houseModel;
                    break;
                }
            }
            return house;
        }
        #endregion
    }
}
