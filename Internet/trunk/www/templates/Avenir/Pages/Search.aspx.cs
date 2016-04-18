/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using System.Text;
using EPiServer;
using System.Collections.Generic;
using EPiServer.Core;
using System.Collections;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The search page presents the search result from both the quick search user control
    /// and the search function on this page. The search can be restricted to a page branch by 
    /// setting the "SearchRoot" property.
    /// </summary>
    public partial class SearchPage : TemplatePage
    {
        private string _scroll = "0"; //indeks i resultatsettet. Listen i skjermbildet vises fra index = scroll
        private static int MAX_FASETT_COUNT = 100;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Pager.PagerEvent += Navigasjon;
            Lib.CurrentPage = CurrentPage;
            Master.NoMenu(); //make menu invisible
            _scroll = Request.QueryString["scroll"];
            if (String.IsNullOrEmpty(_scroll)) _scroll = "0";

            if (!IsPostBack)
            {
                Sortby.Items.Add(CurrentPage.Property["SortRelevanceTxt"].ToString());
                Sortby.Items.Add(CurrentPage.Property["SortDateTxt"].ToString());
                Sortby.Items[0].Selected = true;
                Doctype.Groups = Lib.MakeCheckboxList(Doctype, Avenir.Lib.DocTypeList());
                Lib.CreateCheckboxList(Year, Avenir.Lib.YearList());
                string query = Request.QueryString["quicksearchquery"];
                Sok.Text = query;
                Button1_Click(null, null);
            }
        }



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
            if (sender == "useCache" && dq is dqGoogle && Session["search_SearchResult"] != null)//issue-57
            {
                (dq as dqGoogle).cachedResults = (ArrayList)Session["search_SearchResult"];
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
                    qry = new Nyno(qry).Query;
                dq.Query = qry;
                if (RemoveReports.Checked)
                    dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                dq.Execute();
                // sjekk for synonym
                int maxFasettCount;
                if (dq.Count < MAX_FASETT_COUNT*2)
                    maxFasettCount = (int)dq.Count / 2;
                else if (dq.Count > MAX_FASETT_COUNT*10)
                    maxFasettCount = MAX_FASETT_COUNT/10;
                else
                    maxFasettCount = MAX_FASETT_COUNT;

                string synonym = dq.Synonym;
                if (synonym != null && synonym != string.Empty)
                {
                    qry += " OR " + synonym;
                    dq = docQuery.GetDocQuery();
                    dq.Query = qry;
                    if (RemoveReports.Checked)
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
                        if (RemoveReports.Checked)
                            dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                        dq.AddFasett(new Fasett("dokumenttype", StripCounting(item.Text)));
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
                        if (RemoveReports.Checked)
                            dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                        dq.AddFasett(new Fasett("year", StripCounting(item.Text)));
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
                if (RemoveReports.Checked)
                    dq.AddFasett(new Fasett("-dokumenttype", "Tilsynsrapport"));
                List<string> liYear = Lib.TestCheckList(Year);
                if (liYear != null && liYear.Count != 0)
                    dq.AddFasett(new Fasett("year", liYear));
                dq.Execute();
                if (dq is dqGoogle)
                {
                    (dq as dqGoogle).numResults = dq.Count;
                    (dq as dqGoogle).renderResult = true;
                }

                //and finally perform the actual search
                dq.Scroll = int.Parse(_scroll);
                if (Sortby.Items[1].Selected)
                    dq.SortbyDate = true;
                dq.Execute();
                searchSummary.Query = Sok.Text;
                searchSummary.Filters = li;
                searchSummary.HitsCount = dq.Count.ToString();
                searchSummary.DataBind();
                if (dq.Count > 10 && dq is dqGoogle)
                    Session["search_SearchResult"] = (dq as dqGoogle).cachedResults;
            }
            
            dq.Result = dq.Result.Replace("<br>", "");
            Resultatet.Text = dq.Result;

            //more results
            int intScroll = int.Parse(_scroll);
            if (dq.Count > 10)
            {
                Pager.InitNav(intScroll, (int)dq.Count);
                Pager.Visible = true;
            }
            else
                Pager.Visible = false;

        }

        string GetResult(System.Collections.ArrayList ar)
        {
            string s = "<br />";
            foreach (GSALib.GSA.Result searchResult in ar)
            {
                s += Server.HtmlDecode(searchResult.getTitle());
                s += "<br />";
                s += Server.HtmlDecode(searchResult.getUrl());
                s += "<br />";
                s += Server.HtmlDecode(searchResult.getSummary());
                s += "<br />Meta - keywords: " + Server.HtmlDecode(searchResult.getMeta("keywords"));
                s += "<br /><br />";
            }
            return s;
        }
    }
}
