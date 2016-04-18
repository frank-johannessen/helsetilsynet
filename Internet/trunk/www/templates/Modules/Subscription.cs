using System;
using System.Web;
using System.Text;
using EPiServer.Core;
using EPiServer.Configuration;
using EPiServer;
using System.Text.RegularExpressions;

namespace Avenir
{
    public class SubscriptionMail: EPiServer.Personalization.SubscriptionMail
    {
        private readonly string _subscriptionMailDatePropertyName;

        public SubscriptionMail()
        {
           _subscriptionMailDatePropertyName = "__SubscriptionMailDate";
        }

        public override string FormatPageForBody(PageData subscriptionPage, PageData page)
        {
           StringBuilder builder = new StringBuilder();
           builder.Append("<br><span class=MailDate>");
           builder.Append("[");
           builder.Append(((DateTime)page[_subscriptionMailDatePropertyName]).ToShortDateString());
           builder.Append("]</span>");
           builder.Append("<br><span class=MailPageName>");
           builder.Append(page.Property["PageName"].ToWebString());
           builder.Append("</span><br><span class=MailPagePreview>");
            //if (page["NewsPageText"] != null && page["NewsPageText"].ToString() != string.Empty)
           if (page["NewsPageText"] != null)
           {
               if (page.Property["NewsPageText"].Type == PropertyDataType.LongString)
                   builder.Append(StripHtml(page["PageName"] as string,
                         page["NewsPageText"] as string, 0xff));
               else
                   builder.Append(page.Property["NewsPageText"].ToWebString());
               builder.Append("<br>");
           }
           else
           {
               string str = StripHtml(page["PageName"] as string,
                                           page["MetaDescription"] as string, 0xff);
               if (str != null)
               {
                   builder.Append(str);
                   builder.Append("<br>");
               }
           }

            builder.Append("</span><a class=MailReadMore href=\"");
            if (((page.LinkURL != null) && page.LinkURL.StartsWith("/")) 
                        && !page.LinkURL.StartsWith("//"))
            {
              PageReference startPage = PageReference.StartPage;
              Uri siteUrl = Settings.Instance.SiteUrl;
              Settings settingsFromPage = DataFactory.Instance.GetSettingsFromPage(page.PageLink);
              if (settingsFromPage.PageStartId != startPage.ID)
              {
                siteUrl = settingsFromPage.SiteUrl;
               }
               builder.Append(siteUrl.GetLeftPart(UriPartial.Authority));
             }
                         UrlBuilder url = new UrlBuilder(
                    UriSupport.AddLanguageSelection(page.LinkURL, page.LanguageBranch));
             Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, Encoding.UTF8);
             builder.Append(url.ToString());
             builder.Append("\">");
             if (subscriptionPage["SubscriptionMailReadMore"] != null)
             {
                builder.Append(subscriptionPage["SubscriptionMailReadMore"].ToString());
             }
             else
             {
               builder.Append(LanguageManager.Instance.
                    TranslateFallback("/subscription/pagelinktext", 
                    "Read more", subscriptionPage.LanguageBranch));
             }
             builder.Append("</a>");
             builder.Append("<br>");
             return builder.ToString();

            }

        private string StripHtml(string title, string html, int len)
        {
          if ((title != null) && (html != null))
          {
             if (html.Length > (len * 10))
             {
                 html = html.Substring(0, len * 10);
             }
             html = html.Replace("<br>", " ");
             html = html.Replace("<BR>", " ");
             html = html.Replace("</p>", " ");
             html = html.Replace("</P>", " ");
             var regex = new Regex("<[^>]*>", RegexOptions.IgnorePatternWhitespace);
              string str = HttpUtility.HtmlDecode(regex.Replace(html, "")).TrimStart(new char[] { ' ' });
              if (str.ToLower().StartsWith(title.ToLower()))
             {
                str = str.Remove(0, title.Length).TrimStart(new[] { ' ' });
             }
             if (str.Length > len)
             {
                str = str.Substring(0, len);
             }
             int num = str.LastIndexOfAny(new[] { ' ', '.' });
             if (num > (str.Length / 2))
             {
                str = str.Substring(0, num + 1);
             }
             if (str.Length > 0)
             {
                return (str + "..");
             }
          }
         return null;
        }

     }

}
