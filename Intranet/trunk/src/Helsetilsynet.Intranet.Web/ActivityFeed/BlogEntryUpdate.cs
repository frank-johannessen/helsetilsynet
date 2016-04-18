using OpenWaves.ActivityFeed;
using System.Text;
using System.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class BlogEntryUpdate : UpdateContent
    {
        public string Title { get; private set; }
        public string Author { get; private set; }
        public string Icon { get; private set; }
        public string Url { get; private set; }
        public string Summary { get; private set; }

        public BlogEntryUpdate(string title, string author, string icon, string url, string summary)
        {
            Title = title;
            Author = HttpUtility.HtmlDecode(author);//issue-79: dirty fix, but neccessary to fix existing errors on blogentries live
            Icon = icon;
            Url = url;
            Summary = summary;
        }
    }
}