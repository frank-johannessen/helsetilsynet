using System;
using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class CalendarUpdate : UpdateContent
    {
        // ReSharper disable MemberCanBePrivate.Global
        
        public string Title { get; private set; }
        public string StartTime { get; private set; }
        public string Icon { get; private set; }
        public string Link { get; private set; }
        
        // ReSharper restore MemberCanBePrivate.Global

        public CalendarUpdate(string title, string startTime, string icon, string link)
        {
            Title = title;
            StartTime = startTime;
            Icon = icon;
            Link = link;
        }
    }
}