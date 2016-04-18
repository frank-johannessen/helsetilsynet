using EPiServer.Web;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web
{
    public struct GlobalName
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

        public struct CacheKey
        {
            public const string RssFeed = "RssFeed:";
            public const string FrontPageFeaturedArticlesAll = "FrontPageFeaturedArticlesAll";
            public const string FrontPageFeaturedArticlesNotC1 = "FrontPageFeaturedArticlesNotC1";
        }

        public struct AppSettings
        {
            public const string CategoryClassNames = "CategoryClassNames";
            public const string HiddenCategories = "HiddenCategories";
            public const string DisplayLosenAlphabethicalIndexDeleteAllButton = "DisplayLosenAlphabethicalIndexDeleteAllButton";
            public const string CalmeyersCornerClubId = "CalmeyersCornerClubId";
            public const string FrontPageFeaturedCacheDuration = "FrontPageFeaturedCacheDuration";
            public const string PdfConverterLicenseKey = "PdfConverterLicenseKey";
            public const string PdfConverterTempfiles = "PdfConverterTempfiles";
            public const string MoveEvoInternalFromTo = "MoveEvoInternalFromTo";

            public struct Rss
            {
                public const string MaxCount = "Rss.MaxCount";
                public const string CacheDuration = "Rss.CacheDuration";
                public const string Debug = "Rss.Debug";
            }

            public const string FoldersInBreadCrumbs = "FoldersInBreadCrumbs";

            public const string HostIPAdress = "HostIPAdress";
        }

        public struct DynamicDataStore
        {
            public const string LosenAlphabethicalIndex = "LosenAlphabethicalIndex";
        }

        public struct GoogleMini
        {
            public const string UserAccountName = "GoogleMini.UserAccountName";
            public const string UserAccountPassword = "GoogleMini.UserAccountPassword";
            public const string HostAddress = "GoogleMini.HostAddress";

            public struct IndexName
            {
                public const string Losen = "GoogleMini.IndexName.Losen";
                public const string Compendia = "GoogleMini.IndexName.Compendia";
                public const string HelsetilsynetNO = "GoogleMini.IndexName.HelsetilsynetNO";
            }
        }

        public struct SiteSourceBaseUrl
        {
            public const string Losen = "LosenBaseUrl";
            public const string Helsetilsynet = "HelsetilsynetBaseUrl";
            public const string Compendia = "CompendiaBaseUrl";
            public const string CompendiaRewriteUrl = "CompendiaRewriteUrl";
        }

        public struct SiteSourceName
        {
            public const string Losen = "Losen";
            public const string Helsetilsynet = "HTIL";
            public const string Compendia = "HR-portal";
            public const string External = "External";
        }

        public struct PathToRelateImageFolder
        {
            public static readonly string PathToRelateImagesFolder = VirtualPathUtilityEx.ToAbsolute(RelateConstants.PathToRelateImagesFolder);     
        }
        
    }
}