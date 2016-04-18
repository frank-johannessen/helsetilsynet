using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class ClubUpdate : UpdateContent
    {
        public string Title { get; private set; }
        public string Description { get; private set; }
        public string Icon { get; private set; }
        public string Url { get; private set; }

        public ClubUpdate(string title, string description, string icon, string url)
        {
            Title = title;
            Description = description;
            Icon = icon;
            Url = url;
        }
    }
}