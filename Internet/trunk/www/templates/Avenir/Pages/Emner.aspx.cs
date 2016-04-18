using System;
using System.Linq;
using EPiServer;
using System.Collections.Generic;
using Helsetilsynet.CustomProperties.htilDictionaryProperty;
using System.Collections;

namespace Avenir.Templates.Pages
{
	/// <summary>
	/// The search page presents the search result from both the quick search user control
	/// and the search function on this page. The search can be restricted to a page branch by 
	/// setting the "SearchRoot" property.
	/// </summary>
    public partial class Emner : TemplatePage
    {
        private const int _previewTextLength = 150;
        private string _emne = string.Empty;
        private string _eg = string.Empty;
        private string _emneGruppe = string.Empty;
        private string _scroll = "0"; //indeks i resultatsettet. Listen i skjermbildet vises fra index = scroll
        private static int MAX_FASETT_COUNT = 100;
        private string _branch;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Response.CacheControl = "no-cache";
            Response.AddHeader("Pragma","no-cache");
            Response.Expires = -1;
            Pager.PagerEvent += Navigasjon;
            Lib.CurrentPage = CurrentPage;
            //Form.DefaultButton = SearchButton.UniqueID;

            _branch = Request.QueryString["Branch"];
            if (String.IsNullOrEmpty(_branch)) 
                Master.NoMenu();
            else                
                _branch = Request.QueryString["Branch"];

            _scroll = Request.QueryString["scroll"];
            if (String.IsNullOrEmpty(_scroll)) _scroll = "0";

            _emne = Request.QueryString["emne"];
            _eg = Request.QueryString["eg"];

            if (!String.IsNullOrEmpty(_eg))
                _emneGruppe = Lib.KeyGroup(_eg);
            string query = Request.QueryString["quicksearchquery"];
            if (!String.IsNullOrEmpty(query))
                Sok.Text = query;

            if (!IsPostBack)
            {
                Sortby.Items.Add(CurrentPage.Property["SortRelevanceTxt"].ToString());
                Sortby.Items.Add(CurrentPage.Property["SortDateTxt"].ToString());
                Sortby.Items[0].Selected = true;
                //Avenir.Lib.createCheckboxList(Doctype, Avenir.Lib.docTypeList());
                Doctype.Groups = Lib.MakeCheckboxList(Doctype, Lib.DocTypeList());
                Lib.CreateCheckboxList(Year, Lib.YearList());
                Button1_Click(null, null);
            }
        }


            //return TextIndexer.StripHtml(previewText, _previewTextLength);

        protected void Navigasjon(string scr)
        {
            _scroll = scr;
            Button1_Click("useCache", null);
        }

        private string StripCounting(string s)
        {
            int p = s.IndexOf(" [");
            if (p > -1)
                return s.Substring(0, p);
            return s;
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            docQuery dq = docQuery.GetDocQuery();
            if (sender == "useCache" && dq is dqGoogle && Session["emne_SearchResult"] != null)//issue-57
            {
                (dq as dqGoogle).cachedResults = (ArrayList)Session["emne_SearchResult"];
                dq.Count = (dq as dqGoogle).cachedResults.Count;
                dq.Scroll = int.Parse(_scroll);
                if (dq is dqGoogle)
                    (dq as dqGoogle).renderResult = true;
                dq.Execute();
            }
            else
            {
                string qry = Sok.Text;
                if (!string.IsNullOrEmpty(qry))
                {
                    qry = new Nyno(qry).Query;
                }
                dq.Query = qry;
                dq.AddFasett(new Fasett("emne", Lib.CreateList(_emne)));
                dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                dq.Execute();

                int maxFasettCount;
                if (dq.Count < MAX_FASETT_COUNT * 2)
                    maxFasettCount = (int)dq.Count / 2;
                else if (dq.Count > MAX_FASETT_COUNT * 10)
                    maxFasettCount = MAX_FASETT_COUNT / 10;
                else
                    maxFasettCount = MAX_FASETT_COUNT;

                // sjekk for synonym
                string synonym = dq.Synonym;
                if (synonym != null && synonym != string.Empty)
                {
                    qry += " OR " + synonym;
                    dq = docQuery.GetDocQuery();
                    dq.Query = qry;
                    dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                    dq.Execute();
                }
                if (dq.Count > 0)
                {
                    //----OPPTELLING FASETTER PÅ DOKUMENTTYPE
                    if (dq is dqGoogle)
                    {
                        (dq as dqGoogle).fasettCountMode = true;
                        (dq as dqGoogle).maxFasettCount = maxFasettCount;
                    }
                    foreach (System.Web.UI.WebControls.ListItem item in Doctype.Items)
                    {
                        dq.RemoveFasetter();
                        dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                        dq.AddFasett(new Fasett("emne", Lib.CreateList(_emne)));
                        dq.AddFasett(new Fasett("dokumenttype", StripCounting(item.Text)));
                        if (_branch != string.Empty)
                            dq.AddFasett(new Fasett("menugroup", _branch));
                        dq.Execute();
                        item.Text = StripCounting(item.Text);
                        if (dq.Count > 0)
                            item.Text = item.Text + " [" + dq.Count + "]";
                        else
                            item.Enabled = false;
                    }
                    foreach (System.Web.UI.WebControls.ListItem item in Year.Items)
                    {
                        dq.RemoveFasetter();
                        dq.AddFasett(new Fasett("emne", Lib.CreateList(_emne)));
                        //Removing the check to remove this fasett for every search
                        //if (RemoveReports.Checked) 
                        dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                        dq.AddFasett(new Fasett("year", StripCounting(item.Text)));
                        if (_branch != string.Empty)
                            dq.AddFasett(new Fasett("menugroup", _branch));
                        dq.Execute();
                        item.Text = StripCounting(item.Text);
                        if (dq.Count > 0)
                            item.Text = item.Text + " [" + dq.Count + "]";
                        else
                            item.Enabled = false;
                    }
                }
                else
                {
                    foreach (System.Web.UI.WebControls.ListItem item in Doctype.Items)
                    {
                        item.Text = StripCounting(item.Text);
                        if (Sok.Text != string.Empty)
                            item.Enabled = false;
                    }
                    foreach (System.Web.UI.WebControls.ListItem item in Year.Items)
                    {
                        item.Text = StripCounting(item.Text);
                        if (Sok.Text != string.Empty)
                            item.Enabled = false;
                    }

                }
                dq.RemoveFasetter();
                if (dq is dqGoogle)
                    (dq as dqGoogle).fasettCountMode = false;

                //issue-57: detect count
                List<string> li = Lib.TestCheckList(Doctype);
                if (li != null && li.Count != 0)
                    dq.AddFasett(new Fasett("dokumenttype", li));
                dq.AddFasett(new Fasett("emne", Lib.CreateList(_emne)));
                dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                List<string> liYear = Lib.TestCheckList(Year);
                if (liYear != null && liYear.Count != 0)
                    dq.AddFasett(new Fasett("year", liYear));
                if (_branch != string.Empty)
                    dq.AddFasett(new Fasett("menugroup", _branch));
                dq.Execute();
                if (dq is dqGoogle)
                {
                    (dq as dqGoogle).numResults = dq.Count;
                    (dq as dqGoogle).renderResult = true;
                }

                //...and finally perform the real search
                dq.Scroll = int.Parse(_scroll);
                if (Sortby.Items[1].Selected)
                    dq.SortbyDate = true;
                dq.Execute();
                AntallTreff.Text = dq.Count.ToString();
                if (dq.Count > 10 && dq is dqGoogle)
                    Session["search_SearchResult"] = (dq as dqGoogle).cachedResults;
            }
            
            dq.Result = dq.Result.Replace("<br>", "");
            Resultatet.Text = dq.Result;
            string keyName = string.Empty;
            if (!string.IsNullOrEmpty(_emne))
            {
                keyName = _emne;// vi må fjerne evt. angivelse av gruppenr
                int pp = keyName.IndexOf('0');
                if (pp > 0)
                    keyName = keyName.Substring(0, pp);
            }
            string menugroup = string.Empty;
            if (!string.IsNullOrEmpty(_branch))
                menugroup = _branch + " - ";

            //Getting the list property from startpage and getting the new heading, if no match found use the old one
            ResultHead.Text = GetCustomTopicHeading(keyName, menugroup);
            litIngress.Text = GetCustomIngress(keyName);


            //create pager control
            int intScroll = int.Parse(_scroll);
            if (dq.Count > 10)
            {
                Pager.InitNav(intScroll, (int)dq.Count);
                Pager.Visible = true;
            }
            else
                Pager.Visible = false;
        }

        private string GetCustomTopicHeading(string key, string menugroup)
        {
            var losenIndex = AlphabethicalUtils.GlobalKeywordList().ToList();
            string keyWithEG = key + "&eg=" + _eg;

            foreach (var alphabethicalItem in losenIndex)
                if (alphabethicalItem.Title == keyWithEG)
                    return alphabethicalItem.Url;

            foreach (var alphabethicalItem in losenIndex)
                if (alphabethicalItem.Title == key)
                    return alphabethicalItem.Url;

            return menugroup + "Emne " + key + " relatert til " + _emneGruppe;
        }

        private string GetCustomIngress(string key)
        {
            var losenIndex = AlphabethicalUtils.GlobalKeywordList().ToList();

            foreach (var alphabethicalItem in losenIndex)
            {
                if (alphabethicalItem.Title == key)
                    return alphabethicalItem.Ingress;
            }
            return string.Empty;
        }
    }
}
