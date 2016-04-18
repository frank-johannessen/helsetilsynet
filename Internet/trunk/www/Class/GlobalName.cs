using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Helsetilsynet.Class
{
    public class GlobalName
    {
        public struct QueryStringName
        {
            public const string Q = "q";
            public const string CatList = "catLists"; // webservice ArticleArchiveSearchService ajax usage
            public const string Page = "page"; // paging in search result
            public const string ID = "id"; //pageid
            public const string Details = "d"; // Detail level for table of contents (LargeDocuments)
            public const string PdfView = "pdf";
            public const string Section = "section";

            public struct SectionValue
            {
                public const string Header = "header";
                public const string Footer = "footer";
                public const string Main = "main";
            }
        }

    }
}