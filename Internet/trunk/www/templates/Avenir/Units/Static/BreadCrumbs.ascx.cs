using System;
using System.Text;
using EPiServer;
using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Units.Static
{
    /// <summary>
    /// Provide links back to each previous page that the user navigated through in order 
    /// to get to the current page. In the case of the trail being too long, only the start page
    /// parent pages below the <see cref="BreadcrumbsMaxLength"/> threshold are shown.
    /// </summary>
    public partial class BreadCrumbs : UserControlBase
    {
        private const string Link = "<span{3}><a href=\"{0}\" title=\"{1}\">{2}</a></span>";
        private const string Link0 = "<span{1}>{0}</span>";
        private const string LastClass = " class=\"lastItem\"";
        //A string used to separate the page links (default = " / ")
        private const string Separator = @"<span> &gt; </span>";
        private const int BreadcrumbsMaxLength = 180;

        /// <summary>
        /// In case the breadcrumb string is longer then the specified BreadcrumbsMaxLength, 
        /// a shorter alternative is used where only the start page, parent page
        /// and the current page are shown.
        /// </summary>
        protected override void OnLoad(EventArgs e)
        {
            Breadcrumbs.Text = GenerateBreabCrumbs(CurrentPage);
        }

        /// <summary>
        /// Creates the bread crumb link string from the start page of the site to the supplied page
        /// </summary>
        /// <param name="page">The last page in the bread crumb string.</param>
        /// <returns>A bread crumb string with anchors to parent pages.</returns>
        private string GenerateBreabCrumbs(PageData page)
        {
            // Initiate a string builder based on max length. The generated html is considerably longer than the visible text.
            var breadCrumbsText = new StringBuilder(8 * BreadcrumbsMaxLength);

            // Initiate a counter holding the visible length of the bread crumbs with the length of the start page link text.
            int breadCrumbsLength = Translate("/navigation/startpage").Length;
            string cssClass = LastClass;

            while (page != null && page.PageLink != PageReference.StartPage)
            {
                if (!(page.Property["DummyPage"] != null && page.Property["DummyPage"].ToString() == "True"))
                {
                    breadCrumbsLength += page.PageName.Length + Separator.Length;
                    if (breadCrumbsLength > BreadcrumbsMaxLength)
                    {
                        breadCrumbsText.Insert(0, Separator + "<span>...</span>");
                        break;
                    }

                    // Insert the link at beginning of the bread crumbs string 
                    breadCrumbsText.Insert(0, Separator + GetLink(page, cssClass));
                    cssClass = "";
                }
                // Get next visible parent
                page = GetParentPageData(page);
           }

            // Generate the start page link 
            string startPageLinkUrl = Server.UrlPathEncode(GetPage(PageReference.StartPage).LinkURL);
            string startPageLink = String.Format(Link, startPageLinkUrl, Translate("/navigation/startpagelinktitle"), Translate("/navigation/startpage"), cssClass);

            // Insert the startpage link and return
            return breadCrumbsText.Insert(0, startPageLink).ToString();
        }

        /// <summary>
        /// Get the next visible parent page of the supplied
        /// </summary>
        private PageData GetParentPageData(PageData pageData) 
        {
            // Don't return a PageData object for start page or root page.
            if (pageData == null || pageData.ParentLink == PageReference.StartPage || pageData.ParentLink == PageReference.RootPage)
            {
                return null;
            }

            // Get Page data for parent page
            pageData = GetPage(pageData.ParentLink);
            if (pageData != null && pageData.VisibleInMenu)
            {
                return pageData;
            }
            // Step up to next parent
            return GetParentPageData(pageData);
        }


        /// <summary>
        /// Returns a anchor based on a <see cref="PageData"/> object.
        /// </summary>
        private string GetLink(PageData page, string cssClass)
        {
            string pageName = page.Property["PageName"].ToWebString();
            if (cssClass == "")
                return string.Format(Link, Server.UrlPathEncode(page.LinkURL), pageName, pageName, cssClass);

            return string.Format(Link0, pageName, cssClass);
        }
    }
}