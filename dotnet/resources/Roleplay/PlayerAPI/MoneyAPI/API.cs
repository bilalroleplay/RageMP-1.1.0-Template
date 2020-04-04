using GTANetworkAPI;
using MySql.Data.MySqlClient;

namespace Roleplay.PlayerAPI.MoneyAPI
{
    class API : Script
    {

        [Command("subcash")]
        public void SubCashNow(Player c, int value)
        {
            SubCash(c, value);
        }

        [Command("addcash")]
        public void AddCashNow(Player c, int value)
        {
            AddCash(c, value);
        }

        #region SyncCash
        public static void SyncCash(Player c)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("SELECT cash FROM characters WHERE account_id = @id", conn);
            cmd.Parameters.AddWithValue("@id", c.GetData<int>("account_id"));
            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                c.SetData("money_cash", reader.GetInt32("cash"));
            }
            reader.Close();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            c.TriggerEvent("moneyhud", c.GetData<int>("money_cash"));
        }
        #endregion

        #region SetCash
        public static void SetCash(Player c, int value)
        {
            c.SetData("money_cash", value);

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand cmd = new MySqlCommand("UPDATE characters SET cash = @cash WHERE account_id = @id", conn);
            cmd.Parameters.AddWithValue("@cash", value);
            cmd.Parameters.AddWithValue("@id", c.GetData<int>("account_id"));
            cmd.ExecuteNonQuery();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);
        }
        #endregion

        #region AddCash
        public static void AddCash(Player c, int value)
        {
            SetCash(c, c.GetData<int>("money_cash") + value);
            c.TriggerEvent("moneyhud", c.GetData<int>("money_cash"));
            c.SendNotification("~g~+~w~" + value + "~g~$");
        }
        #endregion

        #region SubCash
        public static void SubCash(Player c, int value)
        {
            SetCash(c, c.GetData<int>("money_cash") - value);
            c.TriggerEvent("moneyhud", c.GetData<int>("money_cash"));
            c.SendNotification("~r~-~w~" + value + "~g~$");
        }
        #endregion
    }
}
