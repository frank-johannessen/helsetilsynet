using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using System.Web.UI;
using EPiServer;
using EPiServer.DynamicContent;
using EPiServer.Core.Html;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using System.Data;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;


namespace Avenir
{
    static public partial class Lib
    {
        static public PageData CurrentPage { get; set; }

        static public string Nyno(string query)
        {
            String resultData = query;
            string link = "http://hts-nyno01.osl.basefarm.net:8090/ts/svc/rewrite";

            ASCIIEncoding encoding = new ASCIIEncoding();
            string postData = @"pq=query&pcharset=UTF-8&pqsntx=standard&ppwd=local&puser=local&prealm=local&pu=http://www.helsetilsynet.no.epi5-hotel.osl.basefarm.net/templates/avenir/pages&px=px+pq+pcharset+pqsntx+ppwd+puser+prealm+pu&query=" + query;
            byte[] data = encoding.GetBytes(postData);

            // Prepare web request...
            HttpWebRequest myRequest =
               (HttpWebRequest)WebRequest.Create(link);
            myRequest.Method = "POST";
            myRequest.ContentType = "application/x-www-form-urlencoded";
            myRequest.ContentLength = data.Length;
            try
            {
                Stream newStream = myRequest.GetRequestStream();
                // Send the data.
                newStream.Write(data, 0, data.Length);
                newStream.Close();
                // Assign the response object of 'HttpWebRequest' to a 'HttpWebResponse' variable.
                HttpWebResponse myHttpWebResponse = (HttpWebResponse)myRequest.GetResponse();
                // Display the contents of the page to the console.
                Stream streamResponse = myHttpWebResponse.GetResponseStream();
                // Get stream object
                StreamReader streamRead = new StreamReader(streamResponse);
                Char[] readBuffer = new Char[256];
                // Read from buffer
                int count = streamRead.Read(readBuffer, 0, 256);
                resultData = string.Empty;
                while (count > 0)
                {
                    resultData += new String(readBuffer, 0, count);
                    // Write the data 
                    //Console.WriteLine(resultData);
                    // Read from buffer
                    count = streamRead.Read(readBuffer, 0, 256);
                }
                if (resultData.Length > 8)
                    resultData = resultData.Substring(7);
                // Release the response object resources.
                streamRead.Close();
                streamResponse.Close();
                // Close response
                myHttpWebResponse.Close();
            }
            catch (Exception)
            {
            }
            if (resultData.Contains('?'))
                resultData = string.Empty;
            return resultData;
        }



        static public string TestNyno(bool avenir)
        {
            string strId = "test1";
            string strName = "test2";
            string link;
            if (avenir)
                link = "http://avenir.no/";
            else
                link = "http://hts-nyno01.osl.basefarm.net:8090/ts/demo/index.html";

            ASCIIEncoding encoding = new ASCIIEncoding();
            string postData = "userid=" + strId;
            postData += ("&username=" + strName);
            byte[] data = encoding.GetBytes(postData);

	        // Prepare web request...
	        HttpWebRequest myRequest =
               (HttpWebRequest)WebRequest.Create(link);
            myRequest.Method = "POST";
            myRequest.ContentType = "application/x-www-form-urlencoded";
            myRequest.ContentLength = data.Length;
	        Stream newStream=myRequest.GetRequestStream();
	        // Send the data.
	        newStream.Write(data,0,data.Length);
	        newStream.Close();

           // Assign the response object of 'HttpWebRequest' to a 'HttpWebResponse' variable.
          HttpWebResponse myHttpWebResponse= (HttpWebResponse)myRequest.GetResponse();

            // Display the contents of the page to the console.
          Stream streamResponse=myHttpWebResponse.GetResponseStream();

          // Get stream object
          StreamReader streamRead = new StreamReader( streamResponse );

          Char[] readBuffer = new Char[256];
          // Read from buffer
          int count = streamRead.Read( readBuffer, 0, 256 );
          String resultData = string.Empty;
          while (count > 0) 
          {
                resultData  += new String( readBuffer, 0, count);
                // Write the data 
                Console.WriteLine( resultData );
                // Read from buffer
                count = streamRead.Read( readBuffer, 0, 256);
          }

          // Release the response object resources.
          streamRead.Close();
          streamResponse.Close();

          // Close response
          myHttpWebResponse.Close();
          return resultData;
       }


        static public void GetCodeList(string property, ref System.Web.UI.WebControls.ListBox input)
        {
            //ListItemCollection input = new ListItemCollection();
            DataFactory factory = DataFactory.Instance; // Global.EPDataFactory;
            PageReference pr = PageReference.StartPage; // new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnStartPage"]);
            PageData pd = factory.GetPage(pr);

            if (pd.Property[property] == null)
                return;
            string PersonellList = factory.GetPage(pr).Property[property].ToString();
            PersonellList = StripPtag(PersonellList);
            


            string[] ArrayList = PersonellList.Split(',');
            input.Items.Add(new ListItem("(None)", ""));
            foreach (string item in ArrayList)
            {
                string K = item;
                if (K.Substring(0, 1) == "@") // stikktittel
                {
                    K = K.Substring(1);
                    int p1 = K.IndexOf('@');
                    K = K.Substring(p1 + 1);
                }
                string code = K;
                string value = K;
                int p = K.IndexOf(':');
                if (p > 0)
                {
                    value = K.Substring(0, p);
                    code = K.Substring(p + 1);
                }
                input.Items.Add(new ListItem(code, value));
            }
        }
        
        static public bool ArchiveYear(string year)
        {
            if (year.Length == 4)
            {
                int meta;
                if (int.TryParse(year, out meta))
                {
                    int y = DateTime.Now.Year - 5;
                    if (meta < y)
                        return true;
                }
            }
            return false;
        }

        //Trekke ut link i toppen av MainBody
        static public string GetTitleLink(PageData p)
        {
            string s = "-----------Link ikke funnet";
            string property = "Link";
            if (p.Property["Link"] == null)
                property = "MainBody";
            if (p.Property[property] != null && p.Property[property].ToString() != string.Empty)
            {
                string l = p.Property[property].ToString();
                string lUpper = l.ToUpper();
                int pos = lUpper.IndexOf("<A");
                if (pos > -1)
                {
                    int pos2 = lUpper.IndexOf("</A>", pos);
                    if (pos2 > pos)
                    {
                        pos2 += 4;
                        s = l.Substring(pos, pos2 - pos);
                    }
                }
            }
            return s;
        }


        //Variant av funksjonen ovenfor - her skal også ha med teksten i MainBody
        static public void SplitLinkFromBody(PageData p, out string link, out string rest)
        {
            string s = "-----------Link ikke funnet";
            string restText = string.Empty;
            string property = "Link";
            if (p.Property["Link"] == null)
                property = "MainBody";
            if (p.Property[property] != null && p.Property[property].ToString() != string.Empty)
            {
                string l = p.Property[property].ToString();
                string lUpper = l.ToUpper();
                
                //Fjern evt. <div>
                if (lUpper.StartsWith("<DIV>") && lUpper.Length > 10)
                {
                    l = l.Substring(5, l.Length - 11);
                    lUpper = lUpper.Substring(5, lUpper.Length - 11);
                }
                // finn link
                int pos = lUpper.IndexOf("<A");
                if (pos > -1)
                {
                    int pos2 = lUpper.IndexOf("</A>", pos);
                    if (pos2 > pos)
                    {
                        pos2 += 4;
                        s = l.Substring(pos, pos2 - pos);
                        //Fjern evt. <BR>
                        if (lUpper.Substring(pos2).StartsWith("<BR />"))
                            pos2 += 6;
                       restText = l.Substring(pos2);
                    }
                }
            }
            rest = restText;
            link = s;
        }





        //static public void RemoveDummyPages(ref PageDataCollection pdc)
        //{
        //    foreach (PageData page in pdc)
        //        if (page.Property["DummyPage"] != null && page.Property["DummyPage"].ToString() == "True")
        //            pdc.Remove(page);
        //}

        static public bool DummyPage(PageData pd)
        {
            return (pd.Property["DummyPage"] != null && pd.Property["DummyPage"].ToString() == "True");
        }

        static public string GetLink(PageData pd)
        {
            return "<a href=" + pd.LinkURL + ">" + pd.PageName + "</a>";
        }

        static public string GetLink(PageData pd, string tip)
        {
            return "<a href=" + pd.LinkURL + " title=\"" + tip + "\">" + pd.PageName + "</a>";
        }

        /// <returns>Returns the preview text for the specified PageData</returns>
        /// <remarks>The preview text is primarily created from the MainIntro property if it exists, 
        /// otherwise parts of the MainBody property are being used. 
        /// If neither a MainIntro nor a MainBody property exists, the preview will not be shown. 
        /// The length of the preview text is defined in <code>PreviewTextLength</code></remarks>
        static public string StripHtml(string htmlString)
        {
            string previewText;
            //If the text contains DynamicContents, replace those with an empty string
            StringBuilder regexPattern = new StringBuilder(@"<span[\s\W\w]*?classid=""");
            regexPattern.Append(DynamicContentFactory.Instance.DynamicContentId.ToString());
            regexPattern.Append(@"""[\s\W\w]*?</span>");
            previewText = Regex.Replace(htmlString, regexPattern.ToString(), string.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline);

            return TextIndexer.StripHtml(previewText, 10000);
        }

        
        /// <summary>
        /// Strips a text to a given length without splitting the last word.
        /// </summary>
        /// <param name="previewText">The string to shorten</param>
        /// <returns>A shortened version of the given string</returns>
        private static string StripPreviewText(string previewText, int maxLength)
        {
            if (previewText.Length <= maxLength)
            {
                return previewText;
            }
            previewText = previewText.Substring(0, maxLength);
            // The maximum number of characters to cut from the end of the string.
            int maxCharCut = (previewText.Length > 15 ? 15 : previewText.Length - 1);
            int previousWord = previewText.LastIndexOfAny(new char[] { ' ', '.', ',', '!', '?' }, previewText.Length - 1, maxCharCut);
            if (previousWord >= 0)
            {
                previewText = previewText.Substring(0, previousWord);
            }
            return previewText + " ...";
        }


        /// <summary>
        /// Creates one element in the pager control.
        /// </summary>
        /// <param name="keyCode">Short code for keywords group</param>
        /// <returns>Name of the keywords group</returns>
        public static string KeyGroup(string keyCode)
        { 
            switch (keyCode)
            {
                case "ht": return CurrentPage.Property["HealthSvcTxt"].ToString(); //break;
                case "st": return CurrentPage.Property["SocialSvcTxt"].ToString(); //break;
                case "bt": return CurrentPage.Property["ChildSvcTxt"].ToString(); //break;
                case "ae": return CurrentPage.Property["OtherSvcTxt"].ToString(); 
            }
            return "Error in keyCode";
        }


        ///// <summary>
        ///// Creates one element in the pager control.
        ///// </summary>
        ///// <param name="no">index no in pager</param>
        ///// <returns>A string containing one element in the pager</returns>
        //private static string NextSearchNo(int no, string url, int scroll, int count)
        //{
        //    int start = (no * 10) - 10;
        //    //if (count < start + 10) return ""; 
        //    string strNo = no.ToString();
        //    string urlAnd = testUrl(url);
        //    //if (scroll == start) return strNo + "&nbsp;"; //skal egentlig være besøkt link
        //    if (scroll == start) return "," + strNo + ":" + start.ToString() + ":0";
        //    //string s = "<a href=\"" + urlAnd + "scroll=" + start.ToString() + "\">" + strNo + "&nbsp;</a>";
        //    string s = "," + strNo + ":" + start.ToString() + ":1";
        //    return s;
        //}

        ///// <summary>
        ///// Creates html for pager control used under search results.
        ///// </summary>
        ///// <param name="url">basepart for url used in each element</param>
        ///// <param name="scroll">indicates current position in the total result set</param>
        ///// <param name="count">total number of rows in result</param>
        ///// <returns>A string containing the html of the control</returns>
        ///// format: nr : scroll : enabled (1 = enabled, 0 =unabled)
        //public static string PagerControl(string url, int scroll, int count)
        //{
        //    int scrollInn = scroll;
        //    scroll = scroll / 80; scroll *= 80; // Scroll = 0, 80, 160, 240, 320... Vi er ikke interessert i mellomverdier
        //    int antElementer = 0;
        //    if (count > 10)
        //        antElementer = (count + 9) / 10;
        //    bool nextEl = false;
        //    if (count > scroll + 80) nextEl = true;
        //    string s = string.Empty;
        //    int scrollNext = 80; // scroll-verdi for >>>>
        //    int scrollPrev = 0;
        //    int start = scroll / 10 + 1;
        //    scrollNext = scroll + 80; // (scroll + 80) / 80; scrollNext *= 80;
        //    scrollPrev = scroll - 80; // scrollNext - 160;
        //    int maxCount = 8;
        //    string urlAnd = testUrl(url);
        //    if (scroll < 80)
        //    {
        //        s = "<<:0:0";
        //        if (antElementer > 7) antElementer = 8;
        //        for (int i = 1; i <= antElementer; i++)
        //            s += NextSearchNo(i, url, scrollInn, count);
        //    }
        //    else
        //    {
        //        maxCount = start + 8;
        //        int countToo = antElementer + 1;
        //        if (countToo > maxCount) countToo = maxCount;
        //        //s = "<a href=\"" + urlAnd + "scroll=" + scrollPrev.ToString() + "\">" + "<<&nbsp;</a>";
        //        s = "<<:" + scrollPrev.ToString() + ":1";
        //        for (int i = start; i < countToo; i++)
        //            s += NextSearchNo(i, url, scrollInn, count);

        //    }
        //    //if (antElementer >= maxCount -1) nextEl = true;
        //    //if (nextEl) s += "<a href=\"" + urlAnd + "scroll=" + scrollNext.ToString() + "\">" + "&nbsp;>></a>";
        //    if (nextEl) s += ",>>:" + scrollNext.ToString() + ":1";
        //    return s;
        //}


        //private static string testUrl(string url)
        //{
        //    if (url.Contains('?'))
        //        return url + "&";
        //    else
        //        return url + "?";
        //}


        public static string hpKategoriList()
        {
            return getList("Personell");
            //return "Fysioterapeut,Hjelpepleier,Lege,Psykolog,Sykepleier,Tannlege,Uten autorisasjon";
        }

        public static string virksomheterList()
        {
            return getList("Virksomhet");
            //return "Helseforetak,Kommuner,Andre virksomheter";
        }
        public static string VirksomhetIndividSaker()
        {
            return getList("VirksomhetIndividSaker");
            //return "Forsvarlig virksomhet – undersøkelse og diagnostikk og behandling,Informasjon,Medisinering,Oppførsel/atferd,Organisering av virksomhet,Pasientjournal,Rusmiddelmisbruk,Taushetsplikt,Øyeblikkelig hjelp,Andre vurderingsgrunnlag";
        }
        public static string Undersokelsessaker()
        {
            return getList("Undersokelsessaker");
            //return "Forsvarlig virksomhet – undersøkelse og diagnostikk og behandling,Informasjon,Medisinering,Oppførsel/atferd,Organisering av virksomhet,Pasientjournal,Rusmiddelmisbruk,Taushetsplikt,Øyeblikkelig hjelp,Andre vurderingsgrunnlag";
        }
        //public static string tyearList()
        //{
        //    //return getList("tYear");
        //    return "2010,2009,2008,Tidligere år";
        //}

        public static string reaksjonList()
        {
            return getList("Reaksjonstype");
            //return "Ingen reaksjon / veiledning,Advarsel,Suspensjon av autorisasjon/lisens,Tap av autorisasjon/lisens,Begrenset autorisasjon/lisens (hpl § 59),Begrenset autorisasjon/lisens (hpl § 59a),Suspensjon av rekvireringsrett,Tap av rekvireringsrett";
        }

        public static string tjenesteList()
        {
            return getList("Tjenesteomraade");
            //return "Spesialisthelsetjeneste (offentlig),Fastlege,Legevakt,Pleie- og omsorgstjeneste,Annen kommunehelsetjeneste,Private tjenester (uten avtale)";
        }

        public static string vurderingList()
        {
            return getList("Vurderingsgrunnlag");
            //return "Forsvarlig virksomhet – undersøkelse og diagnostikk og behandling,Informasjon,Medisinering,Oppførsel/atferd,Organisering av virksomhet,Pasientjournal,Rusmiddelmisbruk,Taushetsplikt,Øyeblikkelig hjelp,Andre vurderingsgrunnlag";
        }

        public static string DocTypeList()
        {
            return getList("Dokumenttype");
            //string s = "Bibliotek, Brev, Forskrifter, Høringsuttalelser, Lover, Nyheter, Publikasjoner, Tilsynsrapport, Rundskriv";
            //return s;
        }

        public static string docTypeList(int nr)
        {
            return getList("Dokumenttype", nr);
            //string s = "Bibliotek, Brev, Forskrifter, Høringsuttalelser, Lover, Nyheter, Publikasjoner, Tilsynsrapport, Rundskriv";
            //return s;
        }


        public static string YearList()
        {
            string s = getList("Year");
            string y = (DateTime.Now.Year - 6).ToString();
            int p = s.IndexOf(y);
            if (p > 0)
            {
                s = s.Substring(0, p) + "Eldre";
            }
            return s;
            //return "2009, 2008, 2007, 2006, 2005, Tidligere år";
        }

        public static string CountyList()
        {
            return getList("Fylke");
            //return "Østfold,Akershus,Oslo,Hedmark,Oppland,Buskerud,Vestfold,Telemark,Aust-Agder,Vest-Agder,Rogaland,Hordaland,Sogn og Fjordane,Møre og Romsdal,Sør-Trøndelag,Nord-Trøndelag,Nordland,Troms,Finnmark";
        }

        public static string RegionList()
        {
            return getList("Region");
            //return "Helse Midt-Norge RHF, Helse Nord RHF, Helse Sør-Øst RHF, Helse Vest RHF";
        }

        public static string CountrywideList()
        {
            return getList("Landsomfattende");
            //return "2009 Barnebolig, 2009 DPS, 2008 Barn, Eldre";
        }


        public static string InstitutionList()
        {
            return getList("Institusjon");
            //return "Akershus universitetssykehus HF, Oslo universitetssykehus HF, Psykiatrien i Vestfold HF";
        }


        private static string getList(string listNavn)
        {
            PageData pd = CurrentPage;
            if (pd[listNavn] == null || pd[listNavn].ToString() == "")
                return "";
            return StripPtag( pd[listNavn].ToString());
        }

        private static string getList(string listNavn, int nr)
        {
            PageData pd = CurrentPage;
            if (pd[listNavn] == null || pd[listNavn].ToString() == "")
                return "";
            string list = StripPtag( pd[listNavn].ToString());
            string[] s = list.Split(',');
            if (s.Length >= nr)
                return s[nr];
            return "";
        }

        private static string StripPtag(string inn)
        {
            string s = inn.Replace("<p>", "");
            return s.Replace("</p>", "");
        }

        public static string CategoryList()
        {
            string s = string.Empty;
            DataTable d = GetSortedCategories();
            string skille = string.Empty;
            for (int i = 0; i < d.Rows.Count; i++)
            {
                s += skille + d.Rows[i][0];
                skille = ",";
            }
            return s;
        }
        
        
        public static string createCheckList(string list)
        {
            string r = string.Empty;
            string[] s = list.Split(',');
            foreach (string item in s)
            {
                r += "<li><input runat=\"server\" enableviewstate=\"true\" id=\"" + item + "\" type=\"checkbox\" value=\"\" /> <a href=\"#\">" + item + "</a></li>";
            }
            return r;
        }


        /// <summary>
        /// Gets the categories names on a page
        /// </summary>
        /// <param name="pd">The source page with categories</param>
        /// <returns>A comma-sperated string the names of the categories</returns>
        /// par exemple: <%=Avenir.Lib.findCategories(CurrentPage) %>
        public static string findCategories(PageData pd)
        {
            CategoryList pl = pd.Category;
            string s = string.Empty;
            string skille = string.Empty;
            
            foreach (int item in pl)
            {
                s += skille + EPiServer.DataAbstraction.Category.Find(item).Name;
                skille = ", ";
            }
            return s;
        }

        /// <summary>
        /// Sorts all EPiServer categories.
        /// </summary>
        /// <param name="no">index no in pager</param>
        /// <returns>A datatable containing the sorted categories</returns>
        private static DataTable GetSortedCategories()
        {
            DataTable returnValue = new DataTable();
            returnValue.Columns.Add(new DataColumn("Name", "".GetType()));
            returnValue.Columns.Add(new DataColumn("Id", 0.GetType()));

            Category cat = Category.GetRoot();
            IList categories = cat.GetList();

            foreach (object obj in categories)
            {
                Category category = obj as Category;
                if (category != null)
                {
                    DataRow dataRow = returnValue.NewRow();
                    dataRow[0] = category.Name;
                    dataRow[1] = category.ID;
                    returnValue.Rows.Add(dataRow);
                }
            }

            returnValue.AcceptChanges();
            DataView dv = new DataView(returnValue);
            dv.Sort = "Name ASC";

            return dv.ToTable();
        }

        /// <summary>
        /// Tests a list of checkboxes if they are checked.
        /// </summary>
        /// <param name="cbl">List of checkboxes to test</param>
        /// <param name="list">The string of elements which is used to create the checkboxlist</param>
        /// <returns>A list of strings with the value of the checkboxes</returns>
        public static List<string> TestCheckList(CheckBoxList cbl)
        {
            List<string> li = new List<string>();
            //string r = string.Empty;
            //string[] s = list.Split(',');
            foreach (ListItem item in cbl.Items)
            {
                if (item.Selected)
                {
                    li.Add(StripCounting(item.Value));
                }
            }
            return li;
        }

        private static string StripCounting(string s)
        {
            int p = s.IndexOf(" [");
            if (p > -1)
                return s.Substring(0, p);
            return s;
        }



        /// <summary>
        /// Creates a list of strings with one element.
        /// </summary>
        public static List<string> CreateList(string s)
        {
            List<string> li = new List<string>();
            li.Add(s);
            return li;
        }


        /// <summary>
        /// Creates a list of checkboxes.
        /// </summary>
        /// <param name="p">List to fill with checkboxes</param>
        /// <param name="list">The string of elements with the name of each checkbox</param>
        public static void CreateCheckboxList(CheckBoxList p, string list)
        {
         
            if(string.IsNullOrEmpty(list))
                return;
            //CheckBox box;
            ListItem li;
            //string r = string.Empty;
            string[] s = list.Split(',');
            int i = 0;
            foreach (string item in s)
            {
                string code = item;
                string value = item;
                int pos = item.IndexOf(':');
                if (pos > 0)
                {
                    code = item.Substring(0, pos);
                    value = item.Substring(pos + 1);
                }
                if (item.Substring(0, 1) == "@") // hopp over stikktittel
                    continue;
                li = new ListItem(value,code);
                p.Items.Add(li);
                i++;
            }
            return;
        }

        public static string[] MakeCheckboxList(CheckBoxList c, string list)
        {
            //CheckBox box;
            ListItem li;
            //string r = string.Empty;
            string[] s = list.Split(',');
            int i = 0;
            bool headings = list.Contains('@');
            string[] head = new string[s.Length];
            foreach (string denne in s)
            {
                string item = denne;
                if (item.Substring(0, 1) == "@") // stikktittel
                {
                    item = item.Substring(1);
                    int p = item.IndexOf('@');
                    if (p>0)
                        head[i] = item.Substring(0, p);
                    else
                        head[i] = "";
                    item = item.Substring(p + 1);
                }
                string code = item;
                string value = item;
                int pos = item.IndexOf(':');
                if (pos > 0)
                {
                    code = item.Substring(0, pos);
                    value = item.Substring(pos + 1);
                }
                li = new ListItem(value, code);
                c.Items.Add(li);
                i++;
            }
            if (headings)
                return head;
            return null;
        }


        public static void checkCheckboxList(CheckBoxList p, string value)
        {
            foreach (ListItem item in p.Items)
            {
                if (item.Value == value)
                {
                    item.Selected = true;
                }
            }
        }
    }

    /// <summary>Configurasjonsvariable definert under appSettings i Web.Config</summary>
    public enum Config
    {
        MiniHostAddress,
        CsHostAddress,
        DefaultSearchEngine,
        PageTypeIdArtikkel,
        PageTypeIdTilsynsrapport,
        PageTypeIdLovside,
        PageTypeIdBoxListing
        //PageIDSitemap,
        //PageIDUtilMenu
    }

    //public enum LanguageConst
    //{ 
    //    MainMenuStartPageTitle1,
    //    MainMenuStartPageTitle2,
    //    Logotext,
    //    LanguageText, 
    //    Language,
    //    LanguageText2,
    //    Language2,
    //    SiteMapText, 
    //    DoNotShowAlfabethical,
    //    FaqText,
    //    ContactText,
    //    AdvancedSearch, 
    //    SearchType,
    //    SearchSort,
    //    Tilsynsrapport,
    //    SearchRules,
    //    SearchNews,
    //    SearchDisplayTitle,
    //    SearchSortOnHit,
    //    SearchHitResult,
    //    SearchHitCount1,
    //    SearchHitCount2,
    //    SearchHitCount3,
    //    SearchHitCount4,
    //    SearchHitCount5,
    //    TilsynsReportTitle,
    //    PrintText,
    //    FrontPageSubscribeText,
    //    FrontPageReadMore,
    //    SearchDropDownFormText,
    //    SearchButtonEnglish,
    //    LangLetterTitle,
    //    LangLetterFrom,
    //    LangLetterTo,
    //    LangLetterDate,
    //    LangLetterOure,
    //    LangLetterYours, 
    //    PrintPagePrintTxt,
    //    PrintPageCloseTxt,
    //    KeyWordList,
    //    KeywordLinkBack,
    //    SearchKeywordTitle
    //}


    static class AddEnum
    {
        /// <summary>Extention method to access appsettings in Web.Config from a enum variable</summary>
        public static string GetConfigValue(this System.Enum e)
        {
            return System.Configuration.ConfigurationManager.AppSettings[e.ToString()];
        }

        ///// <summary>Extention method to access appsettings in Web.Config from a enum variable</summary>
        //public static string GetLanguageValue(this System.Enum e, PageData CurrentPage)
        //{
        //    return CurrentPage.Property[e.ToString()].ToString();
        //}
    }
}
