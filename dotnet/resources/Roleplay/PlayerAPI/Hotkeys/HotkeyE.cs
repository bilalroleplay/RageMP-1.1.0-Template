using GTANetworkAPI;

namespace Roleplay.PlayerAPI.Hotkeys
{
    class HotkeyE : Script
    {
        [RemoteEvent("KeyE")]
        public void TestOpenHouseMenu(Player c)
        {
            foreach (Housesystem.House houseModel in Housesystem.API.houseList)
            {
                while (c.Position.DistanceTo(houseModel.position) < 2 || c.Dimension == houseModel.id)
                {
                    c.TriggerEvent("StartHouseMenu", c.GetData<uint>("dim"), houseModel.locked, c);
                    c.SendNotification("Funktioniert!");
                    break;
                }
            }
        }
    }
}
