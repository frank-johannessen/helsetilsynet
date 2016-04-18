using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using log4net;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    
    /// <summary>
    /// Used to parse and create QueryString used by the UserSearch page
    /// </summary>
    internal class UserSearchQueryStringReader
    {

        private const char IdSeparator = '_';

        private const string QueryStringParamName_Category = "cat";
        private const string QueryStringParamName_Department = "dep";
        
        public IEnumerable<int> CategoryIds { get; private set; }
        public IEnumerable<int> DepartmentIds { get; private set; }
        
        private UserSearchQueryStringReader(NameValueCollection queryString)
        {
            CategoryIds = ParseIntListFromQueryString(queryString[QueryStringParamName_Category]);
            DepartmentIds = ParseIntListFromQueryString(queryString[QueryStringParamName_Department]);
        }
        
        public static UserSearchQueryStringReader CreateFromQueryString(NameValueCollection queryString)
        {
            return new UserSearchQueryStringReader(queryString);
        }

        private IEnumerable<int> ParseIntListFromQueryString(string str)
        {
            if (string.IsNullOrEmpty(str))
                return new List<int>();

            var list = str.Split(new[] {IdSeparator});

            if (list.Any(IsNotNumeric))
                return new List<int>();

            return list.Select(int.Parse);
        }

        private static bool IsNotNumeric(string l)
        {
            int result;
            return !Int32.TryParse(l, out result);
        }
    }
}