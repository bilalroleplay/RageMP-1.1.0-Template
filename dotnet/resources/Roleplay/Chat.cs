using System;
using System.Collections.Generic;
using System.Text;
using GTANetworkAPI;

namespace Roleplay
{
    class Chat : Script
    {
        [ServerEvent(Event.ChatMessage)]
        public void EventChatMessage(Player c, string message)
        {
            Player[] p = NAPI.Pools.GetAllPlayers().FindAll(x => x.Position.DistanceTo2D(c.Position) <= 15).ToArray();

            for (int i = 0; i < p.Length; i++)
            {
                if (!p[i].Exists)
                    continue;

                p[i].SendChatMessage($"{c.Name} sagt: {message}");
            }
        }
    }
}