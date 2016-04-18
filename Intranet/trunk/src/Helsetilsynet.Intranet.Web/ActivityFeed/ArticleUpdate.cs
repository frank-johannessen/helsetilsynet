using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class ArticleUpdate : UpdateContent
    {
        public string Description { get; set; }
        public string Url { get; set; }
        public string UpdateType { get; set; }
        public string ShortIntro { get; set; }
        public string Title { get; set; }
        public string ThumbnailUrl { get; set; }
    }
}