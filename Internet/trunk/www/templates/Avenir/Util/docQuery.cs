using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using EPiServer;
using EPiServer.DynamicContent;
using EPiServer.Core;
using EPiServer.Filters;


namespace Avenir
{
    static public partial class Lib
    {
        
        internal static string Decode(string s)
        {
            return  HttpUtility.HtmlDecode(s);
        }


        public static string GoogleSearch(string search)
        {
            return searchG(search).Result;
        }

        private static List<ResultElement> GetChildren(PageReference pageLink, int previewLenght)
        {
            PageDataCollection pdc = DataFactory.Instance.GetChildren(pageLink);
            List<ResultElement> list = new List<ResultElement>();
            //for (int pageIndex = pdc.Count - 1; pageIndex >= 0; pageIndex--)
            for (int pageIndex = 0; pageIndex < pdc.Count; pageIndex++)
                {
                PageData pd = pdc[pageIndex];

                if (pd.Property["DummyPage"] != null &&
                    pd.Property["DummyPage"].ToString() == "True")
                {
                    //pdc.RemoveAt(pageIndex);
                }
                else
                {
                    string title = pd.PageName;
                    if (pd.Property["Title"] != null && pd.Property["Title"].ToString() != string.Empty)
                        title = pd.Property["Title"].ToString();
                    string dato = pd.Created.ToShortDateString();
                    string meta = string.Empty;
                    if (pd.Property["metaDescription"] != null && pd.Property["metaDescription"].ToString() != string.Empty)
                        meta = pd.Property["metaDescription"].ToString();
                    list.Add(new ResultElement(title,
                                                    GetPreview(pd, previewLenght),
                                                    dato,
                                                    pd.LinkURL,
                                                    meta,
                                                    pd.PageLink.ToString()
                                                    ));
                }
            }
            return list;
        }

        public static string PageListSearch(string search, bool showDate, bool showMetaDescp, bool showIntro, bool extLinkList, int previewLength)
        {
            List<ResultElement> resultat = SearchGoogle(search);
            return PageListSearch(resultat, showDate, showMetaDescp, showIntro, extLinkList, previewLength);
        }

        //epiListe
        public static string PageListSearch(PageReference search, bool showDate, bool showMetaDescp, bool showIntro, bool extLinkList, int previewLength)
        {
            List<ResultElement> resultat = GetChildren(search,previewLength);
            return PageListSearch(resultat, showDate, showMetaDescp, showIntro, extLinkList, previewLength);
        }


        public static string PageListSearch(List<ResultElement> resultat, bool showDate, bool showMetaDescp, bool showIntro, bool extLinkList, int previewLength)
        {
            if (extLinkList)
            {
                return PageListSearchLinks(resultat, showDate, showMetaDescp, showIntro, previewLength);
            }
            //List<ResultElement> resultat = searchGoogle(search);
            string s = string.Empty;
            foreach (ResultElement r in resultat)
            {
                s += "<p><h3><a href=\"" + r.Url + "\">";
                s += r.Title + "</a></h3>";
                if (showMetaDescp)
                    s += r.MetaDescp;
                else
                {
                    if (showIntro)
                        s += r.Description;
                }
                if (showDate)
                    s += "<span class=\"date\">" + Decode(r.Date) + "</span></p>";
            }
            return s;
        }

        private static string PageListSearchLinks(List<ResultElement> resultat, bool showDate, bool showMetaDescp, bool showIntro, int previewLength)
        {
            //List<ResultElement> resultat = searchGoogle(search);
            string s = string.Empty;
            foreach (ResultElement r in resultat)
            {
                string link;
                string rest;
                PageData pd = GetPageInfo(r.Pageid, out link, out rest);
                if (pd == null)
                    continue;
                s += "<h3>" + link + "</h3><p>";
                
                if (showMetaDescp)
                    s += r.MetaDescp;
                else
                {
                    if (showIntro)
                        //s += GetPreview(pd, previewLength);
                        s += rest;
                }
                if (showDate)
                    s += "<span class=\"date\">" + Decode(r.Date) + "</span>";
            }
            return s + "</p>";
        }


        static private PageData GetPageInfo (string id, out string link, out string resttext)
        {
            link = "";
            resttext = string.Empty;
            try
            {
                PageReference pr = PageReference.Parse(id);
                PageData pd = DataFactory.Instance.GetPage(pr);
                //link = Avenir.Lib.GetTitleLink(pd);
                Avenir.Lib.SplitLinkFromBody(pd, out link, out resttext);
                return pd;
            }
            catch { };
            return null;
        }

        static private string GetPreview(PageData page, int previewTextLength)
        {

            if (previewTextLength <= 0)
            {
                return string.Empty;
            }

            string s;
            string previewText = String.Empty;

            if (page.Property["MainIntro"] != null && page.Property["MainIntro"].ToString().Length > 0)
            {
                previewText = page.Property["MainIntro"].ToWebString(); 
                //return TextIndexer.StripHtml(previewText, PreviewTextLength);
                s = previewText;
                if (s.Length > previewTextLength)
                    s = s.Substring(0, previewTextLength);
                return s;
            }


            if (page.Property["MainBody"] != null)
            {
                previewText = page.Property["MainBody"].ToWebString(); 
            }

            if (String.IsNullOrEmpty(previewText))
            {
                return string.Empty;
            }

            //If the MainBody contains DynamicContents, replace those with an empty string
            StringBuilder regexPattern = new StringBuilder(@"<span[\s\W\w]*?classid=""");
            regexPattern.Append(DynamicContentFactory.Instance.DynamicContentId.ToString());
            regexPattern.Append(@"""[\s\W\w]*?</span>");
            previewText = Regex.Replace(previewText, regexPattern.ToString(), string.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline);
            //return TextIndexer.StripHtml(previewText, PreviewTextLength);
            s = previewText;
            if (s.Length > previewTextLength)
                s = s.Substring(0, previewTextLength);
            return s;
        }

        public static string GoogleFrontpage(string search)
        {
            List<ResultElement> resultat = SearchGoogle(search);
            string s = string.Empty;
            foreach (ResultElement r in resultat)
            {
                s += "<h2><a href=\"" + r.Url + "\">";
                s += r.Title + "</a></h2>";
                s += "<p>" + r.Description;
                s += "<span class=\"date\">" + Decode(r.Date) + "</span></p>";
            }
            return s;
        }


        public static string GoogleShortSearch(string search)
        {
            List<ResultElement> resultat = SearchGoogle(search);
            string s = string.Empty;
            foreach (ResultElement r in resultat)
            {
                s += "<p><a href=\"" + r.Url + "\">";
                s += r.Title + "</a>";
                s += "<span class=\"date\">" + Decode(r.Date) + "</span></p>";
            }
            return s;
        }

        public static List<ResultElement> SearchGoogle(string search)
        {
            docQuery dq = searchG(search);
            return dq.Results;
        }

        private static docQuery searchG(string search)
        {
            if (string.IsNullOrEmpty(search))
                return null;
            string[] criteria = search.Split(';');
            //string r = string.Empty;
            //løp igjennom første gang for å sjekke om vi har angivelse av engine
            string engine = string.Empty;
            foreach (string s in criteria)
            {
                try
                {
                    string[] group = s.Split(':');
                    if (group[0] == "e")
                        engine = group[1];
                }
                catch { }
            }
            docQuery g;
            g = engine == string.Empty ? docQuery.GetDocQuery() : docQuery.GetDocQuery(engine);
            if (g is dqGoogle)
            {
                (g as dqGoogle).listMode = true;
                (g as dqGoogle).renderResult = true;
            }
            foreach (string s in criteria)
            {
                try
                {
                    string[] group = s.Split(':');
                    if (group[0] == "q")
                        g.Query = group[1];
                    else if (group[0] == "m")
                        g.MaxReturn = int.Parse(group[1]);
                    //else if (group[0] == "m")
                    //    g.MaxReturn = int.Parse(group[1]);
                    else if (group[0] == "p")
                    {
                        g.Population = new string[0];
                        g.Population[0] = group[1];
                    }
                    else if (group[0] != "e")
                    //g.AddFasett(new Fasett(group[0], new List<string> { group[1] }));
                    {
                        string verdi = group[1];
                        List<string> liste = new List<string>();
                        if (verdi.Contains('#'))
                        {
                            string[] aListe = verdi.Split('#');
                            foreach (string item in aListe)
                            {
                                liste.Add(item);
                            }
                        }
                        else
                            liste.Add(verdi);
                        g.AddFasett(new Fasett(group[0], liste));
                    }
                }
                catch 
                {
                    return g;
                }
            }
            g.SortbyDate = true;
            g.Execute();
            return g;
        }
    }


    public struct Fasett
    {
        string _key;

        public string Key
        {
            get { return _key; }
            set { _key = value; }
        }

        List<string> _value;

        public List<string> Value
        {
            get { return _value; }
            set { _value = value; }
        }

        public Fasett(string key, List<string> value)
        { _key = key; _value = value; }

        public Fasett(string key, string value)
        {   _key = key; 
            _value = new List<string>();
            _value.Add(value);
        }
    }

    public struct ResultElement
    {
        string _title;

        public string Title 
        {
            get { return _title; }
            set { _title = value; }
        }

        string _description;

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }
        string _date;

        public string Date
        {
            get { return _date; }
            set { _date = value; }
        }

        string _url;

        public string Url
        {
            get { return _url; }
            set { _url = value; }
        }

        string _metaDescp;

        public string MetaDescp
        {
            get { return _metaDescp; }
            set { _metaDescp = value; }
        }

        string _pageid;

        public string Pageid
        {
            get { return _pageid; }
            set { _pageid = value; }
        }

        public ResultElement(string title, string description, string date, string url, string metaDescp, string pageid)
        {
            _title = title; 
            _description = description; 
            _date = date; 
            _url = url;
            _metaDescp = metaDescp;
            _pageid = pageid;
        }
    }



    /// <summary>
    /// Execute a search using specified search engine.
    /// </summary>
    public abstract class docQuery 
    {
        private string synonym;

        public string Synonym
        {
            get { return synonym; }
            set { synonym = value; }
        }

        public static docQuery GetDocQuery()
        {
            //return GetEngineInstance(ConfigurationManager.AppSettings["defaultSearchEngine"]);
            //return GetEngineInstance(GetConfig(Config.defaultSearchEngine));
            return GetEngineInstance(Config.DefaultSearchEngine.GetConfigValue());
        }

        public static docQuery GetDocQuery(string engine)
        {
            return GetEngineInstance(engine);
        }

        private static docQuery GetEngineInstance(string engine)
        {
            switch (engine)
            {
                case "mini": return new dqGoogleMini();
                case "cs": return new dqGoogleCS();
                case "epi": return new dqEpi();
            }
            return null;
        }

        private List<ResultElement> _results = new List<ResultElement>();

        public List<ResultElement> Results //{ get; set; }
        {
            get { return _results; }
            set { _results = value; }
        }


        public List<Fasett> Fasetter = new List<Fasett>();

        public void AddFasett(Fasett f)
        {
            Fasetter.Add(f);
        }


        public void RemoveFasetter()
        {
            Fasetter = new List<Fasett>();
        }


        private bool _removeReports = false;
        public bool RemoveReports
        {
            get { return _removeReports; }
            set { _removeReports = value; }
        }

        private bool _sortbyDate = false;
        public bool SortbyDate
        {
            get { return _sortbyDate; }
            set { _sortbyDate = value; }
        }

        private int _maxReturn = 10;
        public int MaxReturn
        {
            get { return _maxReturn; }
            set { _maxReturn = value; }
        }

        public string[] Population  { get; set; }
        public string   Query       { get; set; }
        public string   Result      { get; set; }
        public long     Count       { get; set; }
        public int      Scroll      { get; set; }

        public abstract void Execute();
    }


    class dqGoogleMini : dqGoogle
    { 
        internal override void Config(GSALib.GSA.Query q, out GSALib.GSA.ClientAccess ca)
        {
            //ca = new GSALib.GSA.ClientAccess(ConfigurationManager.AppSettings["miniHostAddress"]);
            ca = new GSALib.GSA.ClientAccess(Avenir.Config.MiniHostAddress.GetConfigValue());
            q.setFrontend("default_frontend"); 
        }
    }

    class dqGoogleCS : dqGoogle
    {
        internal override void Config(GSALib.GSA.Query q, out GSALib.GSA.ClientAccess ca)
        {
            //ca = new GSALib.GSA.ClientAccess(ConfigurationManager.AppSettings["csHostAddress"]);
            ca = new GSALib.GSA.ClientAccess(Avenir.Config.CsHostAddress.GetConfigValue());
            q.setFrontend("google-csbe"); 
        }
    }

    //Her blir jobben utført
    internal abstract class dqGoogle : docQuery
    {
        public bool renderResult = false;
        public long numResults = -1;
        public bool fasettCountMode = false;
        public bool listMode = false;
        public ArrayList cachedResults;
        public int maxFasettCount = 100;

        internal abstract void Config(GSALib.GSA.Query q, out GSALib.GSA.ClientAccess ca);

        public override void Execute()
        {
            GSALib.GSA.Query q = null;
            GSALib.GSA.ClientAccess ca = null;
            
            if (cachedResults == null)
            {
                q = new GSALib.GSA.Query();
                Config(q, out ca);
                if (Population == null)
                    Population = new[] { "default_collection" }; // new string[0];
                q.setSiteCollections(Population);
                q.setOutputFormat(GSALib.Constants.Output.XML_NO_DTD);
                q.setOutputEncoding(GSALib.Constants.Encoding.UTF8);
                q.setAccess(GSALib.Constants.Access.PUBLIC);
                if (listMode)
                    q.setMaxResults(MaxReturn);
                else if (fasettCountMode)
                    q.setMaxResults(maxFasettCount);
                else if (numResults == -1)
                    q.setMaxResults(2);
                else if (numResults > MaxReturn && numResults <= MaxReturn * 10)//testing issue 57
                    q.setMaxResults(MaxReturn * 10);
                else
                {
                    q.setMaxResults(MaxReturn);
                    q.setScrollAhead(Scroll);
                    Scroll = 0;
                }

                

                q.setFilter(GSALib.Constants.Filtering.NO_FILTER);
                if (!fasettCountMode)
                {
                    string[] o = { "keywords", "creation_date", "description", "pageid" };
                    q.setFetchMetaFields(o);
                    if (SortbyDate)
                        q.setSortByDate(false, 'R'); // S = sorter 1000 mest relevante (alt. R = alle)
                }
                else
                    q.unsetSortByDate();

                var htMetaTags = new Hashtable();
                htMetaTags.Clear();
                string addkeys = string.Empty;
                string startverdi = string.Empty;
                if (Fasetter != null)
                    foreach (Fasett f in Fasetter)
                    {
                        string value = string.Empty;
                        bool start = true;
                        foreach (string v in f.Value)
                        {
                            if (start)
                                value = f.Key + ":" + v;
                            else
                                value += "|" + f.Key + ":" + v;
                            start = false;
                        }
                        addkeys += startverdi + "(" + value + ")";
                        startverdi = "."; // value '.' = logical operator 'and'
                    }

                if (string.IsNullOrEmpty(Query))
                {
                    if (addkeys != string.Empty)        //OBS DETTE MÅ ENDRES
                    {
                        //addkeys = "keywords:Tilsyn";
                        htMetaTags.Add("-keywords", "x9y9z.(" + addkeys + ")"); //må ha et negativt + positivt begrep hvis q=""
                        q.setPartialMetaFields(htMetaTags, false);
                    }
                }
                else
                    if (addkeys != string.Empty)
                    {
                        htMetaTags.Add("-keywords", "x9y9z." + addkeys);
                        q.setPartialMetaFields(htMetaTags, false);
                    }

                //Logg søkeaktivitet
                //Avvis 75.125.20.178    ThePlanet.com  og 180.76.5.xxx      Beijing Baidu 
                if (renderResult)
                {
                    string ipAdress = HttpContext.Current.Request.UserHostAddress;
                    if (ipAdress != null && ipAdress.Length > 9)
                    {
                        if (ipAdress == "75.125.20.178")
                            return;
                        if (ipAdress.Substring(0, 9) == "180.76.5.")
                            return;
                    }
                    string tid = DateTime.UtcNow.ToLongTimeString();
                    string fasttListe = string.Empty;
                    IDictionaryEnumerator iHash = htMetaTags.GetEnumerator();
                    while (iHash.MoveNext())
                    {
                        fasttListe += "//" + iHash.Value;
                    }
                    WriteLog(ipAdress + "  -  " + tid + "  -  " + Query + "  -  " + fasttListe);
                }

                string sok = Query;
                var term = new GSALib.GSA.QueryTerm(sok);
                q.setQueryTerm(term);
            }
            GSALib.GSA.Response res = null;
            string s = "";
            string url;
            Results = new List<ResultElement>();
            ArrayList ar = new ArrayList();
            try
            {
                s = "<br />";
                if (cachedResults == null)
                {
                    res = ca.getGSAResponse(q, null);
                    // synonyms
                    ArrayList syn = res.getSynonymsWithMarkup();
                    if (syn != null && syn.Count > 0)
                        Synonym = syn[0].ToString();
                    // end synonyms
                    ar = res.getResults();
                }
                else
                    ar = cachedResults;

                if (renderResult && !fasettCountMode)
                {
                    for (int i = Scroll; i < (Scroll + MaxReturn) && i < ar.Count; i++)
                    {
                        var searchResult = (GSALib.GSA.Result)ar[i];
                        // håndtere tittellinjen med url target=_blank
                        url = Lib.Decode(searchResult.getUrl());
                        url = TransformUrl(url); //korriger site-navn
                        if (url.ToUpper().Contains(".PDF"))
                            s += "<h3>[PDF] <a href=\"" + url + "\" target=_blank>";
                        else
                            s += "<h3><a href=\"" + url + "\">";
                        s += !string.IsNullOrEmpty(searchResult.getTitle()) ? ReplaceBtag(Lib.Decode(searchResult.getTitle())) + "</a></h3><p>" : "</a></h3><p>";
                        s += !string.IsNullOrEmpty(searchResult.getSummary()) ? ReplaceBtag(Lib.Decode(searchResult.getSummary())) : string.Empty;
                        string dato = convertDate(Lib.Decode(searchResult.getMeta("creation_date")));
                        s += "<span class=\"date\">" + dato + "</span></p>";
                        Results.Add(new ResultElement(!string.IsNullOrEmpty(searchResult.getTitle()) ? ReplaceBtag(Lib.Decode(searchResult.getTitle())) : string.Empty,
                                                        !string.IsNullOrEmpty(searchResult.getSummary()) ? ReplaceBtag(Lib.Decode(searchResult.getSummary())) : string.Empty,
                                                        dato,
                                                        url,
                                                        Lib.Decode(searchResult.getMeta("description")),
                                                        Lib.Decode(searchResult.getMeta("pageid"))
                                                        ));
                    }
                }
                if (cachedResults == null && res != null)
                {
                    if (fasettCountMode)
                    {
                        Count = (ar.Count == maxFasettCount) ? (res.getNumResults() / 2) : ar.Count;
                    }
                    else if (numResults == -1)
                        Count = (long)res.getNumResults();
                    else if (numResults <= MaxReturn * 10)
                        Count = ar.Count;
                    else
                        Count = (long)(res.getNumResults() / 2); //issue-57
                }
            }
            //catch (GSALib.Exceptions.GSANeedNetworkCredentailsException ex)
            catch(Exception e) 
            {

            }

            Result = s;
            if (cachedResults == null && ar.Count > MaxReturn && !fasettCountMode)
                cachedResults = ar;
        }


        private string TransformUrl(string url)
        {
            if (url.Contains(".epi5-hotel.osl.basefarm.net"))
                return url.Replace(".epi5-hotel.osl.basefarm.net","");
            return url;
        }

        private static string ReplaceBtag(string s)
        {
            s = s.Replace("<b>", "<strong>");
            s = s.Replace("</b>", "</strong>");
            return s;
        }

        private string convertDate(string dato)
        {
            if (dato != "")
            {
                try
                {
                    DateTime d = DateTime.Parse(dato);
                    return d.ToShortDateString();
                }
                catch (Exception)
                {
                }
            }
            return "";
        }


        private static void WriteLog (string logThis)
        {
            try
            {
                string path = HttpContext.Current.Server.MapPath(@"~/") + "GoogleLog.txt";
                if (File.Exists(path))
                {
                //    // Create a file to write to.
                //    using (StreamWriter sw = File.CreateText(path))
                //    {
                //        sw.WriteLine(logThis);
                //    }
                //}
                //else
                //{
                    using (StreamWriter sw = File.AppendText(path))
                    {
                        sw.WriteLine(logThis);
                    }
                }
            }
            catch
            {
            }

        }
    }

    class dqEpi: docQuery
    {
        public override void Execute()
        {
            PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
            PropertyCriteria pc = new PropertyCriteria();
            pc.Condition = CompareCondition.Contained;
            string verdi = string.Empty;
            string nokkel=string.Empty;
            SjekkFasetter(ref nokkel,ref verdi);
            pc.Name = nokkel;
            pc.Type = PropertyDataType.String;
            pc.Value = verdi;
            criterias.Add(pc);
            PageReference start = PageReference.StartPage;
            PageDataCollection pdc = DataFactory.Instance.FindPagesWithCriteria
                (start,criterias,"no");
            foreach (PageData pd in pdc)
                try
                {
                    Results.Add(new ResultElement(Lib.Decode(pd.PageName),
                                Lib.Decode(pd.Property["MainIntro"].ToString()),
                                pd.Created.ToShortDateString(),
                                Lib.Decode(pd.LinkURL),
                                Lib.Decode(pd.Property["MetaDescription"].ToString()),
                                Lib.Decode(pd.Property["pageid"].ToString())
                                ));
                }
                catch { }
        }


        private void SjekkFasetter(ref string nokkel, ref string verdi)
        {
            //string addkeys = string.Empty;
            //string startverdi = string.Empty;

            if (Fasetter != null)
                foreach (Fasett f in Fasetter)
                {
                    nokkel = f.Key;
                    verdi = f.Value[0];
                    return;
                }
            return;
        }
    }

}
