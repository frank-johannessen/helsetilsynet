using EPiServer;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using EPiServer.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class LinkItems
    {
        public static string GetItemTarget(this LinkItem linkItem)
        {
            var pageData = linkItem.AsPageData();
            if (pageData == null)
                return "_blank";

            // return pageData is File ? "_blank" : "_self";
            return "_self";
        }

        // http://joelabrahamsson.com/entry/convert-a-linkitemcollection-to-a-list-of-pagedata
        // https://github.com/JohannesOstensjo/EPiUtilities/blob/master/EPiUtilities/Extensions/LinkItemCollectionExtensions.cs
        public static PageData AsPageData(this LinkItem linkItem)
        {
            string linkUrl;
            if (!PermanentLinkMapStore.TryToMapped(linkItem.Href, out linkUrl))
                return null;

            if (string.IsNullOrEmpty(linkUrl))
                return null;

            var pageReference = PageReference.ParseUrl(linkUrl);
            if (PageReference.IsNullOrEmpty(pageReference))
                return null;

            return DataFactory.Instance.GetPage((pageReference));
        }
    }
}