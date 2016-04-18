using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Xml.Linq;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class RSS : RelateUserControlBase<Model.BasePage>
    {
        public string CssClass { get; set; }

        private static int MaxCount
        {
            get
            {
                var appSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.Rss.MaxCount];
                int max;
                int.TryParse(appSetting, out max);
                return max;
            }
        }

        private static int CacheDuration
        {
            get
            {
                var appSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.Rss.CacheDuration];
                int value;
                int.TryParse(appSetting, out value);
                return value;
            }
        }

        private static bool Debug
        {
            get
            {
                var appSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.Rss.Debug];
                bool value;
                bool.TryParse(appSetting, out value);
                return value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblDebugError.Visible = false;
            lblError.Visible = false;

            var feed = CurrentUser.GetHelsetilsynetRssFeed();
            if (string.IsNullOrEmpty(feed))
                feed = RelateTemplatePage<RelateGlobalSettings>.HelsetilsynetStandardRssFeed;

            rptRss.DataSource = GetRssFeed(feed);
            rptRss.DataBind();
        }

        private IEnumerable<RssItem> GetRssFeed(string feed)
        {
            try
            {
                string cacheKey = string.Format(GlobalName.CacheKey.RssFeed + feed);

                XDocument rssDocument;
                if (Cache[cacheKey] == null)
                {
                    rssDocument = LoadFeedFromUrl(feed);
                    Cache.Insert(cacheKey, rssDocument, null, DateTime.Now.AddSeconds(CacheDuration), TimeSpan.Zero);
                }
                else
                {
                    rssDocument = (XDocument)Cache[cacheKey];
                }

                return rssDocument
                    .Descendants("item")
                    .Take(MaxCount)
                    .Select(item => new RssItem(item));
            }
            catch (Exception exception)
            {
                lblError.Visible = true;

                if (Debug)
                {
                    lblDebugError.Visible = true;
                    lblDebugError.Text = exception.Message;
                }

                return new List<RssItem>();
            }
        }

        private XDocument LoadFeedFromUrl(string feed)
        {
            var wr = (HttpWebRequest)WebRequest.Create(feed);
            wr.Method = "GET";
            wr.UserAgent = "Fiddler";
            wr.Timeout = 10000; // 10 seconds

            var resp = wr.GetResponse();
            var stream = resp.GetResponseStream();

            return XDocument.Load(stream);
        }
    }

    public class RssItem
    {
        public string Link { get; private set; }
        public string Title { get; private set; }
        public string Description { get; private set; }
        public string PubDate { get; private set; }

        public RssItem(XElement item)
        {
            var link = item.Element("link");
            var title = item.Element("title");
            var description = item.Element("description");
            var pubDate = item.Element("pubDate");

            Link = link != null ? link.Value : string.Empty;
            Title = title != null ? title.Value : string.Empty;
            Description = description != null ? description.Value : string.Empty;
            PubDate = pubDate != null ? pubDate.Value : string.Empty;
        }
    }
}