using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class StringExtensionMethods_
    {
        public static string UrlEncode(this string str)
        {
            return HttpUtility.UrlEncode(str);
        }

        public static string UrlDecode(this string str)
        {
            return HttpUtility.UrlDecode(str);
        }

        public static string HtmlEncode(this string str)
        {
            return HttpUtility.HtmlEncode(str);
        }

        public static string HtmlDecode(this string str)
        {
            return HttpUtility.HtmlDecode(str);
        }

        public static void CreateAuthenticatedUserCookie(this string userName, bool persist)
        {
            if (!String.IsNullOrEmpty(userName))
            {
                FormsAuthentication.SetAuthCookie(userName, persist);
            }
        }
    }
}