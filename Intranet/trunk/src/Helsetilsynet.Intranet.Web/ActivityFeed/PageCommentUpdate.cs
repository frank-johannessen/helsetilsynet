using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class PageCommentUpdate : UpdateContent
    {
        public string Title { get; private set; }
        public string CommentSummary { get; private set; }
        public string Icon { get; private set; }
        public string Url { get; private set; }
        public string Author { get; private set; }

        public PageCommentUpdate(string title, string commentSummary, string author, string icon, string url)
        {
            Title = title;
            CommentSummary = commentSummary;
            Author = author;
            Icon = icon;
            Url = url;
        }
    }
}