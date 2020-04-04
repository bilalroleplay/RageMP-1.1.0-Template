using GTANetworkAPI;

namespace Roleplay.PlayerAPI.Commands
{
    class Commands : Script
    {
        [Command("dc")]
        public void dc(Player c)
        {
            c.Kick();
        }

        [Command("sellhouse")]
        public void SellHouse(Player c)
        {
            Housesystem.API.SellHouse(c);
        }

        [Command("buyhouse")]
        public void BuyHouse(Player c)
        {
            Housesystem.API.BuyHouse(c);
        }

        [Command("createhouse")]
        public void CreateHouse(Player c, int interior, int cost)
        {
            Housesystem.API.CreateHouse(c, interior, cost);
        }
    }
}
