using System;
using System.Web.Script.Services;
using System.Web.Services;
using MakingWaves.Common.Caching;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Util;
using MakingWaves.Helsetilsynet.Util.GoogleMini;
using log4net;

namespace MakingWaves.Helsetilsynet.Intranet.Web.WebServices
{

    /// <summary>
    /// Summary description for SearchService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class SearchService : WebService
    {
        private static SimpleCache<int> _simpleCache;

        static SearchService()
        {
            InitializeCache();
        }

        private static void InitializeCache()
        {
            _simpleCache = new SimpleCache<int>(new AspCacheImplementation(), "SEARCHSERVICE", TimeSpan.FromMinutes(5));
        }

        /// <summary>
        /// Returns search hit count. Caches result in 5 minutes
        /// </summary>
        /// <param name="docQueryStr"></param>
        /// <returns>Count</returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public int SearchCount(string docQueryStr)
        {
            try
            {
                var searchCount = _simpleCache.Get(docQueryStr, Fetcher);
                return searchCount;
            }
            catch(Exception ex)
            {
                LogManager.GetLogger(GetType()).Error(ex);
                throw;
            }
        }

        private static int Fetcher(string docQueryStr)
        {
            var docQuery = DocQuery.CreateDocQuery(docQueryStr);
            docQuery.MaxReturn = 0;
            docQuery.Collection = SearchCollections.CombinedCollection;
            docQuery.ExecuteQuery();
            return (int)docQuery.Count;
        }
    }
}


