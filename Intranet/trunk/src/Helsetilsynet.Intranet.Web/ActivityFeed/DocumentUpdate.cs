using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class DocumentUpdate : UpdateContent
    {
        // ReSharper disable MemberCanBePrivate.Global

        public string Title { get; private set; }
        public string Url { get; private set; }
        public string UpdateType { get; set; }

        // ReSharper restore MemberCanBePrivate.Global
        public DocumentUpdate(string title, string url, string updateType)
        {
            Title = title;
            Url = url;
            UpdateType = updateType;
        }
    }
}