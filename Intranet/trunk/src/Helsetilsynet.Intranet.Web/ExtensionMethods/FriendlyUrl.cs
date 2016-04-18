using EPiServer;
using EPiServer.Core;
using EPiServer.SpecializedProperties;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class FriendlyURL
    {
        //GetFriendlyURL
        public static string GetFriendlyURL(PageData page, bool includeDomainName)
        {
            if (page != null)
            {
                var url = new UrlBuilder(page.LinkURL);

                PropertyLinkType linkType = (PropertyLinkType)page.Property["PageShortcutType"];
                if (LinkType.External.Equals(linkType.Link))
                    return (url.ToString());

                EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.Encoding.UTF8);
                string urlString = url.ToString();

                if (includeDomainName)
                {
                    if (urlString.StartsWith("/"))
                        urlString = urlString.Substring(1);

                    return EPiServer.Configuration.Settings.Instance.SiteUrl + urlString;
                }

                return urlString;
            }
            return "";
        }

        public static string GetFriendlyURL(string internalURL)
        {
            return GetFriendlyURL(internalURL, false);
        }

        public static string GetFriendlyURL(string internalUrl, bool includeDomainName)
        {
            if (!string.IsNullOrEmpty(internalUrl))
            {
                var url = new UrlBuilder(internalUrl);
                EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, internalUrl, System.Text.Encoding.UTF8);
                string urlString = url.ToString();

                if (includeDomainName)
                {
                    if (urlString.StartsWith("/"))
                        urlString = urlString.Substring(1);

                    return EPiServer.Configuration.Settings.Instance.SiteUrl + urlString;
                }

                return urlString;
            }
            return "";
        }
    }
}