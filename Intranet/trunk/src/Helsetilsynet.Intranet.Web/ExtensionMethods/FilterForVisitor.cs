using System.Collections.Generic;
using System.Linq;
using EPiServer;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using EPiServer.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class FilterForVisitorExtensions
    {
        public static IEnumerable<PageData> FilterForVisitor(this IEnumerable<PageData> pageDataCollection)
        {
            var retval = new List<PageData>();
            foreach (var pages in pageDataCollection.Select(pageData => new PageDataCollection { pageData }))
            {
                retval.AddRange(pages.FilterForVisitor());
            }

            return retval;
        }

        public static IEnumerable<PageData> FilterForVisitor(this IEnumerable<PageReference> pageReferanceCollection)
        {
            var pages = pageReferanceCollection
                .Select(pageReference => DataFactory.Instance.GetPage(pageReference))
                .Where(pageData => pageData != null).ToList();
            
            return pages.FilterForVisitor();
        }

        public static IEnumerable<PageData> FilterForVisitor(this PageDataCollection pageDataCollection)
        {
            EPiServer.Filters.FilterForVisitor.Filter(pageDataCollection);
            return pageDataCollection;
        }

        public static LinkItemCollection FilterForVisitor(this IEnumerable<LinkItem> linkItemCollection)
        {
            var retval = new LinkItemCollection();
            if (linkItemCollection == null)
                return retval;

            foreach (var item in linkItemCollection)
            {
                var url = new UrlBuilder(item.Href);

                bool isEPiServerPage = PermanentLinkMapStore.ToMapped(url);
                if (!isEPiServerPage)
                {
                    // external page...
                    item.Target = "_blank";
                    retval.Add(item);
                    continue;
                }

                var pageReference = PermanentLinkUtility.GetPageReference(url);
                if (pageReference == null || pageReference == PageReference.EmptyReference)
                {
                    // not external page, but no pageReference available; perhaps direct link to file?
                    retval.Add(item);
                    continue;
                }

                var page = DataFactory.Instance.GetPage(pageReference);
                if (page == null)
                {
                    // shouldn't really happen, we have a valid PageReference...
                    retval.Add(item);
                    continue;
                }

                var pages = new PageDataCollection { page };
                foreach (var p in pages.FilterForVisitor())
                {
                    // should add the page 0 or 1 times...

                    if (false) // page is File)
                    {
                        //var linkItem = new LinkItem { Href = ((File)page).Document, Text = item.Text, Target = "_blank" };
                        //retval.Add(linkItem);
                    }
                    else
                    {
                        retval.Add(item);
                    }
                }
            }

            return retval;
        }
    }
}