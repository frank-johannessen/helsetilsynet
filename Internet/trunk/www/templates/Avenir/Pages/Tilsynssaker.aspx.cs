using System.Linq;
using System.Web.UI.WebControls;
using EPiServer;
using System;
using EPiServer.Core;
using System.Collections.Generic;
using System.Collections;

namespace Avenir.Templates.Pages
{
    public partial class Tilsynssaker : TemplatePage
    {

        protected System.Web.UI.WebControls.Label Label1;
        private string addHeading = string.Empty;
        private string scroll = "0"; //indeks i resultatsettet. Listen i skjermbildet vises fra index = scroll
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
                    return CurrentPage.Property["Heading"].ToWebString() + addHeading;
                }
                return CurrentPage.Property["PageName"].ToWebString() + addHeading;
            }
        }

        private void Page_Load(object sender, System.EventArgs e)
        {
            Pager.PagerEvent += Navigasjon;
            Lib.CurrentPage = CurrentPage;
            scroll = Request.QueryString["scroll"];
            if (String.IsNullOrEmpty(scroll))
            {
                scroll = "0";
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
                Lib.CreateCheckboxList(hpKategori, Lib.hpKategoriList());
                Lib.CreateCheckboxList(virksomheter, Lib.virksomheterList());
                Lib.CreateCheckboxList(tYear, Lib.YearList());
                Lib.CreateCheckboxList(reaksjon, Lib.reaksjonList());
                Lib.CreateCheckboxList(tjeneste, Lib.tjenesteList());
                Lib.CreateCheckboxList(vurdering, Lib.vurderingList());
                Lib.CreateCheckboxList(VirksomhetIndividSaker, Lib.VirksomhetIndividSaker());
                Lib.CreateCheckboxList(Undersokelsessaker, Lib.Undersokelsessaker());

                string qhpKategori = Request.QueryString["helsepersonell"];
                string qvirksomheter = Request.QueryString["virksomheter"];
                string qtYear = Request.QueryString["year"];
                string qreaksjon = Request.QueryString["reaksjonstype"];
                string qtjeneste = Request.QueryString["tjeneste"];
                string qvurdering = Request.QueryString["vurdering"];
                string qUndersokelser = Request.QueryString["Undersokelser"];
                string qVirksomhetIndividSaker = Request.QueryString["VirksomhetIndividSaker"];

                _qYear = Request.QueryString["year"];

                bool queryElement = false;

                if (!String.IsNullOrEmpty(qhpKategori))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(hpKategori, qhpKategori);
                }
                if (!String.IsNullOrEmpty(qvirksomheter))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(virksomheter, qvirksomheter);
                }
                if (!String.IsNullOrEmpty(qtYear))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(tYear, qtYear);
                }
                if (!String.IsNullOrEmpty(qreaksjon))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(reaksjon, qreaksjon);
                }
                if (!String.IsNullOrEmpty(qtjeneste))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(tjeneste, qtjeneste);
                }
                if (!String.IsNullOrEmpty(qvurdering))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(vurdering, qvurdering);
                }
                if (!String.IsNullOrEmpty(qUndersokelser))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(Undersokelsessaker, qUndersokelser);
                }
                if (!String.IsNullOrEmpty(qVirksomhetIndividSaker))
                {
                    queryElement = true;
                    Lib.checkCheckboxList(VirksomhetIndividSaker, qVirksomhetIndividSaker);
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
            scroll = scr;
            Button1_Click("useCache", null);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            docQuery g = docQuery.GetDocQuery();
            if (sender == "useCache" && g is dqGoogle && Session["Tilsynsak_SearchResult"] != null)//issue-57
            {
                (g as dqGoogle).cachedResults = (ArrayList)Session["Tilsynsak_SearchResult"];
                g.Count = (g as dqGoogle).cachedResults.Count;
                g.Scroll = int.Parse(scroll);
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
                g.AddFasett(new Fasett("dokumenttype", Lib.CreateList("Vedtak tilsynssak")));

                List<string> li = Lib.TestCheckList(hpKategori);
                if (li != null && li.Count != 0)
                    g.AddFasett(new Fasett("hpkategori", li));
                List<string> liVirksomheter = Lib.TestCheckList(virksomheter);
                if (liVirksomheter != null && liVirksomheter.Count != 0)
                    g.AddFasett(new Fasett("virksomheter", liVirksomheter));
                List<string> liYear = Lib.TestCheckList(tYear);
                if (liYear != null && liYear.Count != 0)
                    g.AddFasett(new Fasett("year", liYear));
                List<string> liIndividSaker = Lib.TestCheckList(VirksomhetIndividSaker);
                if (liIndividSaker != null && liIndividSaker.Count != 0)
                    g.AddFasett(new Fasett("VirksomhetIndividSaker", liIndividSaker));
                List<string> liUndersokelsessaker = Lib.TestCheckList(Undersokelsessaker);
                if (liUndersokelsessaker != null && liUndersokelsessaker.Count != 0)
                    g.AddFasett(new Fasett("Undersokelsessaker", liUndersokelsessaker));

                List<string> liRegion = Lib.TestCheckList(reaksjon);
                if (liRegion != null && liRegion.Count != 0)
                    g.AddFasett(new Fasett("reaksjon", liRegion));
                List<string> liInstitution = Lib.TestCheckList(tjeneste);
                if (liInstitution != null && liInstitution.Count != 0)
                    g.AddFasett(new Fasett("tjeneste", liInstitution));
                List<string> liCountryWide = Lib.TestCheckList(vurdering);
                if (liCountryWide != null && liCountryWide.Count != 0)
                    g.AddFasett(new Fasett("vurdering", liCountryWide));
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
                    g.AddFasett(new Fasett("dokumenttype", Lib.CreateList("Vedtak tilsynssak")));

                    if (li != null && li.Count != 0)
                        g.AddFasett(new Fasett("hpkategori", li));
                    if (liVirksomheter != null && liVirksomheter.Count != 0)
                        g.AddFasett(new Fasett("virksomheter", liVirksomheter));
                    if (liYear != null && liYear.Count != 0)
                        g.AddFasett(new Fasett("year", liYear));
                    if (liIndividSaker != null && liIndividSaker.Count != 0)
                        g.AddFasett(new Fasett("VirksomhetIndividSaker", liIndividSaker));
                    if (liUndersokelsessaker != null && liUndersokelsessaker.Count != 0)
                        g.AddFasett(new Fasett("Undersokelsessaker", liUndersokelsessaker));

                    if (liRegion != null && liRegion.Count != 0)
                        g.AddFasett(new Fasett("reaksjon", liRegion));
                    if (liInstitution != null && liInstitution.Count != 0)
                        g.AddFasett(new Fasett("tjeneste", liInstitution));
                    if (liCountryWide != null && liCountryWide.Count != 0)
                        g.AddFasett(new Fasett("vurdering", liCountryWide));
                }

                if (g is dqGoogle) //issue-57
                    (g as dqGoogle).numResults = numresults;
                g.Scroll = int.Parse(scroll);
                if (Sortby.Items[1].Selected)
                    g.SortbyDate = true;
                if (g is dqGoogle)
                    (g as dqGoogle).renderResult = true;
                g.Execute();

                if (g.Count > 10 && g is dqGoogle)
                    Session["Tilsynsak_SearchResult"] = (g as dqGoogle).cachedResults;
            }
            searchSummary.Query = Sok.Text;

            var filtersList = new List<string>();
            var checkBoxesLists = new List<CheckBoxList>
                {
                    hpKategori,
                    tYear,
                    virksomheter,
                    vurdering,
                    reaksjon,
                    tjeneste
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
            int intScroll = int.Parse(scroll);
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
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            //this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion
    }
}
