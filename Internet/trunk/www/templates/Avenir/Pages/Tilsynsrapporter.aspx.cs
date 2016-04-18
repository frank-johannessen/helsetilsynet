using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Core;
using System.Collections;

namespace Avenir.Templates.Pages
{
    public partial class Tilsynsrapporter : TemplatePage
    {

        protected System.Web.UI.WebControls.Label Label1;
        protected EPiServer.Web.WebControls.PageList EpiPageList;
        private readonly string _addHeading = string.Empty;
        private string _scroll = "0"; //indeks i resultatsettet. Listen i skjermbildet vises fra index = scroll
        private string _qYear = string.Empty;

        /// <summary>
        /// Returns the property Heading if set; otherwise the PageName is returned.
        /// </summary>
        protected string Heading
        {
            get
            {
                if (CurrentPage["Heading"] != null)
                {
                    return CurrentPage.Property["Heading"].ToWebString() + _addHeading;
                }
                return CurrentPage.Property["PageName"].ToWebString() + _addHeading;
            }
        }


        private void Page_Load(object sender, EventArgs e)
        {
            Pager.PagerEvent += Navigasjon;
            Lib.CurrentPage = CurrentPage;
            _scroll = Request.QueryString["scroll"];
            if (String.IsNullOrEmpty(_scroll))
            {
                _scroll = "0";
            }

            if (IsPostBack)
            {
                NoShow();
            }
            else
            {
                Sortby.Items.Add(CurrentPage.Property["SortRelevanceTxt"].ToString());
                Sortby.Items.Add(CurrentPage.Property["SortDateTxt"].ToString());
                Sortby.Items[1].Selected = true;
                Lib.CreateCheckboxList(Fylke, Lib.CountyList());
                Lib.CreateCheckboxList(Year, Lib.YearList());
                Lib.CreateCheckboxList(Region, Lib.RegionList());
                Lib.CreateCheckboxList(Institution, Lib.InstitutionList());
                Lib.CreateCheckboxList(CountryWide, Lib.CountrywideList());
                Lib.CreateCheckboxList(Categories, Lib.CategoryList());

                string qFylke = Request.QueryString["fylke"];
                string qLandsomfattende = Request.QueryString["landsomfattende"];
                string qRegion = Request.QueryString["region"];
                string qInstitution = Request.QueryString["helseforetak"];
                string qCountryWide = Request.QueryString["landsomfattende"];
                string qCategories = Request.QueryString["tilsynstemaer"];


                _qYear = Request.QueryString["year"];

                bool queryElement = false;
                if (!String.IsNullOrEmpty(qCategories))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Categories, qCategories);
                }
                if (!String.IsNullOrEmpty(qCountryWide))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(CountryWide, qCountryWide);
                }
                if (!String.IsNullOrEmpty(qInstitution))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Institution, qInstitution);
                }
                if (!String.IsNullOrEmpty(qRegion))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Region, qRegion);
                }
                if (!String.IsNullOrEmpty(_qYear))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Year, _qYear);
                }
                if (!String.IsNullOrEmpty(qLandsomfattende))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(CountryWide, qLandsomfattende);
                }
                if (!String.IsNullOrEmpty(qFylke))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Fylke, qFylke);
                }
                if (queryElement)
                {
                    NoShow();
                    Button1_Click(null, null);
                }

            }
        }

        private void NoShow()
        {
            MainIntro.Visible = false;
            PageBody.Visible = false;
        }

        protected string GetPreviewText(PageData page)
        {
            if (page.Property["MainIntro"] != null && page.Property["MainIntro"].ToString().Length > 0)
                return Lib.StripHtml(page.Property["MainIntro"].ToWebString());
            return "";

        }

        protected void Navigasjon(string scr)
        {
            _scroll = scr;
            Button1_Click("useCache", null);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            docQuery g = docQuery.GetDocQuery();
            if (sender == "useCache" && g is dqGoogle && Session["TilsynsRapport_SearchResult"] != null)//issue-57
            {
                (g as dqGoogle).cachedResults = (ArrayList)Session["TilsynsRapport_SearchResult"];
                g.Count = (g as dqGoogle).cachedResults.Count;
                g.Scroll = int.Parse(_scroll);
                if (g is dqGoogle)
                    (g as dqGoogle).renderResult = true;
                g.Execute();
            }
            else
            {
                string qry = Sok.Text;
                if (!string.IsNullOrEmpty(qry))
                {
                    qry = new Nyno(qry).Query;
                }

                resultHead.Visible = true;
                g.Query = qry;

                /* issue-57 start */
                g.AddFasett(new Fasett("dokumenttype", Lib.CreateList("Tilsynsrapport")));

                List<string> liFylke = Lib.TestCheckList(Fylke);
                if (liFylke != null && liFylke.Count != 0)
                    g.AddFasett(new Fasett("fylke", liFylke));
                List<string> liYear = Lib.TestCheckList(Year);
                if (liYear != null && liYear.Count != 0)
                    g.AddFasett(new Fasett("year", liYear));
                if (_qYear != string.Empty)
                {
                    var y = new List<string> { _qYear };
                    g.AddFasett(new Fasett("year", y));
                }
                List<string> liRegion = Lib.TestCheckList(Region);
                if (liRegion != null && liRegion.Count != 0)
                    g.AddFasett(new Fasett("region", liRegion));
                List<string> liInstitution = Lib.TestCheckList(Institution);
                if (liInstitution != null && liInstitution.Count != 0)
                    g.AddFasett(new Fasett("institusjon", liInstitution));
                List<string> liCountryWide = Lib.TestCheckList(CountryWide);
                if (liCountryWide != null && liCountryWide.Count != 0)
                    g.AddFasett(new Fasett("landsomfattende", liCountryWide));
                List<string> liCategories = Lib.TestCheckList(Categories);
                if (liCategories != null && liCategories.Count != 0)
                    g.AddFasett(new Fasett("kategori", liCategories));
                /* issue-57 end */

                // sjekk for synonym
                if (g is dqGoogle)
                    (g as dqGoogle).renderResult = false;
                g.Execute();
                string synonym = g.Synonym;
                long numresults = g.Count;
                if (!string.IsNullOrEmpty(synonym))
                {
                    qry += " OR " + synonym;
                    g = docQuery.GetDocQuery();
                    g.Query = qry;

                    g.AddFasett(new Fasett("dokumenttype", Lib.CreateList("Tilsynsrapport")));

                    if (liFylke != null && liFylke.Count != 0)
                        g.AddFasett(new Fasett("fylke", liFylke));
                    if (liYear != null && liYear.Count != 0)
                        g.AddFasett(new Fasett("year", liYear));
                    if (_qYear != string.Empty)
                    {
                        var y = new List<string> { _qYear };
                        g.AddFasett(new Fasett("year", y));
                    }
                    if (liRegion != null && liRegion.Count != 0)
                        g.AddFasett(new Fasett("region", liRegion));
                    if (liInstitution != null && liInstitution.Count != 0)
                        g.AddFasett(new Fasett("institusjon", liInstitution));
                    if (liCountryWide != null && liCountryWide.Count != 0)
                        g.AddFasett(new Fasett("landsomfattende", liCountryWide));
                    if (liCategories != null && liCategories.Count != 0)
                        g.AddFasett(new Fasett("kategori", liCategories));
                }

                if (g is dqGoogle) //issue-57
                    (g as dqGoogle).numResults = numresults;
                g.Scroll = int.Parse(_scroll);
                if (Sortby.Items[1].Selected)
                    g.SortbyDate = true;
                if (g is dqGoogle)
                    (g as dqGoogle).renderResult = true;
                g.Execute();

                if (g.Count > 10 && g is dqGoogle)
                    Session["TilsynsRapport_SearchResult"] = (g as dqGoogle).cachedResults;
            }

            searchSummary.Query = Sok.Text;

            var filtersList = new List<string>();
            var checkBoxesLists = new List<CheckBoxList>
                {
                    Fylke, Year, Region, Institution, CountryWide, Categories
                };

            foreach (var checkBoxesList in checkBoxesLists)
            {
                var selectedItems = checkBoxesList.Items.Cast<ListItem>().Where(x => x.Selected);
                filtersList.AddRange(selectedItems.Select(selectedItem => selectedItem.Text));
            }

            searchSummary.Filters = filtersList;
            searchSummary.HitsCount = g.Count.ToString();
            searchSummary.DataBind();

            g.Result = g.Result.Replace("<br>", "");
            Resultatet.Text = g.Result;

            //more results
            int intScroll = int.Parse(_scroll);
            if (g.Count > 10)
            {
                Pager.InitNav(intScroll, (int)g.Count);
                Pager.Visible = true;
            }
            else
                Pager.Visible = false;
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
        }
        #endregion
    }
}