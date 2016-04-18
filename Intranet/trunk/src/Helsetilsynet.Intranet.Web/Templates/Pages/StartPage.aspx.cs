using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using EPiServer;
using EPiServer.Core;
using EPiUtilities.Extensions;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class StartPage : RelateTemplatePage<Model.StartPage>
    {
        private bool IsGoogleMiniIP
        {
            get { return Request.UserHostAddress == ConfigurationManager.AppSettings[GlobalName.GoogleMini.HostAddress]; }
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "frontpage";

            featured.Articles = GetFeaturedArticles();
            featured.DataBind();

            activityFeed.Visible = !IsGoogleMiniIP;
            activityFeed.DataBind();

            rssFrontPage.Visible = !IsGoogleMiniIP;
            rssFrontPage.DataBind();
        }

        private IEnumerable<Model.Article> GetFeaturedArticles()
        {
            var archiveLink = CurrentPage.GlobalSettings.ArticleArchive;
            if (archiveLink == null)
                return new List<Model.Article>();

            var c1FrontPage = CurrentUser.IsC1FrontPage();
            var cacheKey = c1FrontPage
                               ? GlobalName.CacheKey.FrontPageFeaturedArticlesAll
                               : GlobalName.CacheKey.FrontPageFeaturedArticlesNotC1;

            List<Model.Article> featuredArticles;
            var cached = Cache[cacheKey];
            if (cached == null)
            {
                var pages = (from pageRef in DataFactory.Instance.GetDescendents(archiveLink)
                             let page = DataFactory.Instance.GetPage(pageRef) as Model.Article
                             where page != null && (c1FrontPage || !page.IsC1Only)
                             orderby page.StartPublish descending
                             select page).ToPageDataCollection().FilterForVisitor().Take(16);

                featuredArticles = pages.Select(page => page as Model.Article).ToList();

                int cacheDuration;
                var appSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.FrontPageFeaturedCacheDuration];
                int.TryParse(appSetting, out cacheDuration);

                string cacheContent = string.Join(",", from page in featuredArticles select page.PageLink.ID);
                Cache.Insert(cacheKey, cacheContent, null, DateTime.Now.AddSeconds(cacheDuration), TimeSpan.Zero);
            }
            else
            {
                var pageReferences = new List<PageReference>();
                foreach (var p in cached.ToString().Split(','))
                {
                    PageReference pageReference;
                    if (PageReference.TryParse(p, out pageReference))
                        pageReferences.Add(pageReference);
                }

                featuredArticles = (from pageRef in pageReferences
                                   let page = DataFactory.Instance.GetPage(pageRef) as Model.Article
                                   where page != null
                                   orderby page.StartPublish descending
                                   select page).ToList();
            }

            return featuredArticles.FilterForVisitor().OfType<Model.Article>();
        }
    }
}