using System;
using EPiServer;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class QueryString
    {
        //AddQueryStrings
        public static string AddQueryStrings(string url, string queryStrings)
        {
            try
            {
                string newURL = url;
                char[] dividerAmp = { '&' };
                char[] dividerEq = { '=' };

                if (!String.IsNullOrEmpty(url) && !String.IsNullOrEmpty(queryStrings))
                {
                    var qs = queryStrings.Split(dividerAmp);
                    for (int i = 0; i < qs.Length; i++)
                    {
                        if (String.IsNullOrEmpty(qs[i]))
                            continue;

                        var oneQs = qs[i].Split(dividerEq);
                        newURL = UriSupport.AddQueryString(newURL, oneQs[0], oneQs[1]);
                    }
                }

                return newURL;
            }
            catch
            {
                return url;
            }
        }
    }
}