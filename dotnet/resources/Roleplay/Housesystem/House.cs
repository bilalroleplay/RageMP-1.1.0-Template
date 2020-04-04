using GTANetworkAPI;

namespace Roleplay.Housesystem
{
    class House
    {
        public uint id { get; set; }
        public int status { get; set; }
        public string owner { get; set; }
        public int price { get; set; }
        public int interior { get; set; }
        public int locked { get; set; }
        public Vector3 position { get; set; }
        public TextLabel houseLabel { get; set; }
    }
}
