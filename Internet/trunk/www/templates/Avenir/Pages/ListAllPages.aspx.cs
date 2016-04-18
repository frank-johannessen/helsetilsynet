/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using EPiServer.Core;
using EPiServer;
using EPiServer.Filters;
using System;
using System.Text;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class ListAllPages : TemplatePage
    {

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Find();
        }

        //protected void Write_Click(object sender, EventArgs e)
        //{
        //    Makefile();
        //    Msg.Text = "File written";
        //}

        //protected void Read_Click(object sender, EventArgs e)
        //{
        //    Readfile();
        //    Msg.Text = "File read ok";
        //}

        protected void Find()
        {
            //Makefile();
            //Readfile();
            //return;

            int searchPageTypeID = 399;

            PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
            PropertyCriteria criteria = new PropertyCriteria();

            criteria.Name = "PageTypeID";
            criteria.Type = PropertyDataType.PageType;
            criteria.Condition = CompareCondition.NotEqual;
            criteria.Value = searchPageTypeID.ToString();

            //criteria.Condition = CompareCondition.NotEqual;
            //criteria.Value = "News";
            //criteria.Type = PropertyDataType.Category;
            //criteria.Required = true;
            //criteria.Name = "PageCategory";
            //PropertyCriteria criteria = new PropertyCriteria(); 
            //criteria.IsNull = true; criteria.Name = "WriterName"; 

            //PageReference fromPage = (PageReference)CurrentPage["ListingContainer"];
            PageReference fromPage = PageReference.StartPage;
            criterias.Add(criteria);
            PageDataCollection pages = DataFactory.Instance.FindAllPagesWithCriteria(fromPage, criterias, "no", new LanguageSelector("no"));
            //PageDataCollection pages = EPiServer.DataFactory.Instance.FindPagesWithCriteria(PageReference.StartPage, criterias);

            StringBuilder liste = new StringBuilder();
            int i = 0;
            //Response.Write("ID;NAME;TITLE;WEBNAME;SIMPLENAME;URL\r\n");
            foreach (PageData page in pages)
            {
                //Response.Write(page.PageLink.ID.ToString() + "\t");
                //Response.Write(page.PageName + "\t");
                //if (page.Property["Heading"] != null)
                //    Response.Write(page.Property["Heading"].ToString() + "\t");
                //else if (page.Property["PageHeader"] != null)
                //{
                //    Response.Write(page.Property["PageHeader"].ToString() + "\t");
                //}
                //else
                //    Response.Write("\t");
                //Response.Write(page.URLSegment + "\t");
                //Response.Write(page.Property["PageExternalURL"].ToString() + "\t");
                //UrlBuilder url = new UrlBuilder(page.LinkURL); EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.UTF8Encoding.UTF8);
                //Response.Write(url);
                //Response.Write("\r\n");
                i++;
                var ub = new UrlBuilder(page.LinkURL);
                Global.UrlRewriteProvider.ConvertToExternal(
                   ub,
                   page.PageLink,
                   Encoding.UTF8);
                string url = ub.Uri.ToString();
                liste.Append("<a href='" + ResolveUrl("~" + url) + "'>" + url + "</a><br />");

                Response.Write("<a href='" + url + "'>" + url + "</a><br />");

                //Response.Write(ResolveUrl(page.LinkURL.ToString() + "<br />"));
                //Response.Write(string.Format("{0} # {1}# {2}<br />",
                //    page.PageTypeID,
                //    page.PageLink.ID,
                //    page.PageName
                //    //page.Property["MetaKeywords"]
                //    ));
            }
            //page.PageName,  page.PageLink.ID,
            Msg.Text = "Antall sider: " + i + "<br />" + liste;
        }


        //private void Makefile()
        //{
        //    TextWriter tw = new StreamWriter(@"c:\prosjekter\pagelist.txt");

        //    int searchPageTypeID = 399;

        //    PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
        //    PropertyCriteria criteria = new PropertyCriteria();

        //    criteria.Name = "PageTypeID";
        //    criteria.Type = PropertyDataType.PageType;
        //    criteria.Condition = CompareCondition.NotEqual;
        //    criteria.Value = searchPageTypeID.ToString();
        //    PageReference fromPage = PageReference.StartPage;
        //    criterias.Add(criteria);
        //    PageDataCollection pages = EPiServer.DataFactory.Instance.FindAllPagesWithCriteria(fromPage, criterias, "no", new LanguageSelector("no"));
        //    //PageDataCollection pages = EPiServer.DataFactory.Instance.FindPagesWithCriteria(PageReference.StartPage, criterias);

        //    StringBuilder liste = new StringBuilder();
        //    //int i = 0;
        //    tw.WriteLine("ID\tNAME\tTITLE\tWEBNAME\tSIMPLENAME\tURL");
        //    foreach (PageData page in pages)
        //    {
        //        tw.Write(page.PageLink.ID.ToString() + "\t");
        //        tw.Write(page.PageName + "\t");
        //        if (page.Property["Heading"] != null)
        //            tw.Write(page.Property["Heading"].ToString() + "\t");
        //        else if (page.Property["PageHeader"] != null)
        //        {
        //            tw.Write(page.Property["PageHeader"].ToString() + "\t");
        //        }
        //        else
        //            tw.Write("\t");
        //        tw.Write(page.URLSegment + "\t");
        //        tw.Write(page.Property["PageExternalURL"].ToString() + "\t");
        //        UrlBuilder url = new UrlBuilder(page.LinkURL); EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.UTF8Encoding.UTF8);
        //        tw.Write(url);
        //        tw.WriteLine();
        //    }
        //    tw.Close();
        //}

        //private void Readfile()
        //{
        //    StreamReader sr = new StreamReader(@"c:\prosjekter\pagelist.txt");
        //    while (!sr.EndOfStream)
        //    {
        //        string s = sr.ReadLine();
        //        string[] a = s.Split('\t');
        //        if (a.Length != 6)
        //        {
        //            Response.Write(a[0]);
        //            Response.Write("Error");
        //        }
        //    }
        //    sr.Close();

        //}

    }
}