using GTANetworkAPI;

namespace Roleplay.PlayerAPI.Hotkeys
{
    class HotkeyX : Script
    {
        [RemoteEvent("KeyX")]
        public void TestOpenVehicleMenu(Player c)
        {
            c.TriggerEvent("StartVehicleMenu", c.Vehicle.GetData<bool>("engine"), c);
        }
    }
}
