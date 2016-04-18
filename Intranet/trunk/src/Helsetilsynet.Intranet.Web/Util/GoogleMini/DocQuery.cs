using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using EPiServer;
using GSALib.Constants;
using GSALib.GSA;
using MakingWaves.Helsetilsynet.Intranet.Web;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini;
using log4net;
using Configuration = MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini.Configuration;

namespace MakingWaves.Helsetilsynet.Util.GoogleMini
{
    /// <summary>
    /// Execute a search using specified search engine.
    /// </summary>
    public class DocQuery 
    {
        private List<ResultElement> _results = new List<ResultElement>();

        public List<ResultElement> Results 
        {
            get { return _results; }
            private set { _results = value; }
        }

        private readonly List<SearchItem> _searchItems = new List<SearchItem>();
        
        public DocQuery()
        {
            SortbyDate = false;
        }

        private int _maxReturn = 10;
        public int MaxReturn
        {
            private get { return _maxReturn; }
            set { _maxReturn = value; }
        }

        public bool SortbyDate { get; set; }

        private string Synonym { get; set; }
        
        public string[] Population  { get; set; }

        public string Query { private get; set; }

        public long Count { get; private set; }

        public int Scroll { private get; set; }

        public string Collection { private get; set; }

        private static readonly Dictionary<string, string> SiteSourceBaseUrls = new Dictionary<string, string>
                                                                           {
                                                                               {ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.Losen], GlobalName.SiteSourceName.Losen},
                                                                               {ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.Helsetilsynet], GlobalName.SiteSourceName.Helsetilsynet},
                                                                               {ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.CompendiaRewriteUrl], GlobalName.SiteSourceName.Compendia}
                                                                           };
        public void AddSearchItem(SearchItem f)
        {
            _searchItems.Add(f);
        }
        
        public static DocQuery CreateDocQuery(string docQueryString)
        {
            return DocQueryBuilder.Build(docQueryString);
        }

        public void ExecuteQuery()
        {
            var query = BuildGsaQuery();

            string dcQuery = Query;
            var term = new QueryTerm(dcQuery);
            query.setQueryTerm(term);
            
            var gsaResponse = Configuration.ClientAccess.getGSAResponse(query, null);

            var syn = gsaResponse.getSynonymsWithMarkup();
            if (syn != null && syn.Count > 0)
            {
                var synonym = syn[0].ToString();
                Synonym = synonym;
            }

            Results = ConvertResult(gsaResponse);

            Count = (int) gsaResponse.getNumResults();

        }

        private Query BuildGsaQuery()
        {

            if (Population == null)
                Population = new[] { Collection }; // new string[0];

            // Doc: http://gsa-japi.sourceforge.net/apidocs/net/sf/gsaapi/GSAQuery.html 

            var gsaQuery = new Query();

            AddSettings(gsaQuery);
            AddSearchCriterias(gsaQuery);

            return gsaQuery;
        }

        private void AddSearchCriterias(Query gsaQuery)
        {
            var htMetaTags = new Hashtable();
            //htMetaTags.Clear();
            var addkeys = String.Empty;
            var startValue = String.Empty;
            if (_searchItems != null)
                foreach (SearchItem searchItem in _searchItems)
                {
                    string valueString = String.Empty;
                    bool start = true;
                    foreach (string searchItemValue in searchItem.Value)
                    {
                        if (start)
                            valueString = searchItem.Key + ":" + searchItemValue;
                        else
                            valueString += "|" + searchItem.Key + ":" + searchItemValue;
                        start = false;
                    }
                    addkeys += startValue + "(" + valueString + ")";
                    startValue = "."; // value '.' = logical operator 'and'
                }

            if (String.IsNullOrEmpty(Query))
            {
                if (addkeys != String.Empty) //OBS DETTE MÅ ENDRES
                {
                    //addkeys = "keywords:Tilsyn";
                    htMetaTags.Add("-keywords", "x9y9z.(" + addkeys + ")"); //må ha et negativt + positivt begrep hvis q=""
                    gsaQuery.setPartialMetaFields(htMetaTags, false);
                }
            }
            else if (addkeys != String.Empty)
            {
                htMetaTags.Add("-keywords", "x9y9z." + addkeys);
                gsaQuery.setPartialMetaFields(htMetaTags, false);
            }
        }

        private void AddSettings(Query gsaQuery)
        {
            gsaQuery.setFrontend("default_frontend");

            gsaQuery.setSiteCollections(Population);
            gsaQuery.setOutputFormat(Output.XML_NO_DTD);
            gsaQuery.setOutputEncoding(Encoding.UTF8);
            gsaQuery.setAccess(Access.PUBLIC);
            gsaQuery.setMaxResults(MaxReturn); // Restrict search results to these many at most.
            gsaQuery.setScrollAhead(Scroll); // Scroll ahead to display (n+1)th result as the first result. 

            gsaQuery.setFilter(Filtering.NO_FILTER);
            string[] o = { "keywords", "creation_date", "pageid", "imageurl", "kategori-id" };
            gsaQuery.setFetchMetaFields(o);
            if (SortbyDate)
                gsaQuery.setSortByDate(false, 'R'); // S = sorter 1000 mest relevante (alt. R = alle)
        }

        private List<ResultElement> ConvertResult(Response gsaResponse)
        {
            var retval = new List<ResultElement>();
            foreach (Result result in gsaResponse.getResults())
            {
                var date = ConvertDate(result.getMeta("creation_date").HtmlDecode());
                var title = ReplaceBtag(result.getTitle().HtmlDecode());
                var summary = ReplaceBtag(result.getSummary().HtmlDecode());
                var url = RewriteUrlFromIpToSiteName(TransformUrl(result.getUrl().HtmlDecode()));
                var description = result.getMeta("description").HtmlDecode();
                var epiPageId = result.getMeta("pageid").HtmlDecode();
                var source = GetSource(url);
                var fileExtension = GetFileExstension(url);
                var imageUrl = result.getMeta("imageurl");
                var catIds = result.getMeta("kategori-id");

                retval.Add(new ResultElement(title, summary, date, url, description, epiPageId, source, fileExtension, imageUrl, catIds));
            }

            return retval;
        }

        private string RewriteUrlFromIpToSiteName(string url)
        {
            if (string.IsNullOrEmpty(url))
                return string.Empty;
            if (url.StartsWith(ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.Compendia]))
                return RewriteUrlForCompendia(url);

            var ipAddress = ConfigurationManager.AppSettings[GlobalName.AppSettings.HostIPAdress];
            var losenUrl = ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.Losen];
            if (string.IsNullOrEmpty(ipAddress) || !url.Contains(ipAddress) || string.IsNullOrEmpty(losenUrl))
                return url;

            return url.Replace(ipAddress, losenUrl);
        }

        private string RewriteUrlForCompendia(string url)
        {
            if (string.IsNullOrWhiteSpace(url))
                return string.Empty;
            return url.Replace(ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.Compendia],
                               ConfigurationManager.AppSettings[GlobalName.SiteSourceBaseUrl.CompendiaRewriteUrl]);
        }

        private string GetFileExstension(string url)
        {
            if (string.IsNullOrWhiteSpace(url))
                return string.Empty;

            var extension = VirtualPathUtility.GetExtension(url);
            if(string.IsNullOrWhiteSpace(extension))
                return string.Empty;

            return extension.Substring(1);
        }
        
        private string GetSource(string url)
        {
            foreach (var siteSourceBaseUrl in SiteSourceBaseUrls)
            {
                if (url.StartsWith(siteSourceBaseUrl.Key))
                    return siteSourceBaseUrl.Value;
            }
            return GlobalName.SiteSourceName.External;
        }

        private string TransformUrl(string url)
        {
            if (url.Contains(".epi5-hotel.osl.basefarm.net"))
                return url.Replace(".epi5-hotel.osl.basefarm.net","");
            return url;
        }

        private static string ReplaceBtag(string s)
        {
            if (string.IsNullOrWhiteSpace(s))
                return string.Empty;
            return s
                .Replace("<b>", "<strong>")
                .Replace("</b>", "</strong>");
        }

        private DateTime? ConvertDate(string dateString)
        {
            if (dateString == null)
                return null;

            try
            {
                return DateTime.Parse(dateString);
            }
            catch (Exception ex)
            {
                LogManager.GetLogger(this.GetType()).Error("Unable to parse date format from GoogleMini: '" + dateString + "'. Returning null.", ex);
                return null;
            }
        }

        public static IEnumerable<ResultElement> Search(DocQuery docQuery)
        {
            docQuery.ExecuteQuery();
            return docQuery.Results;
        }

        public static IEnumerable<ResultElement> Search(string docQueryString)
        {
            var docQuery = DocQueryBuilder.Build(docQueryString);
            return Search(docQuery);
        }
    }




}
