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
using System.IO;

namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class WashingUrl : TemplatePage
    {
        string _message = "ok";

        protected void Write_Click(object sender, EventArgs e)
        {
            Makefile();
            Msg.Text = "File written";
        }

        protected void Read_Click(object sender, EventArgs e)
        {
            Readfile();
            Msg.Text = _message;
        }



        private void Makefile()
        {
            //TextWriter tw = new StreamWriter(@"c:\prosjekter\pagelist.txt");
            String filname = Server.MapPath("~") + "WashingList.txt";
            TextWriter tw = new StreamWriter(filname);

            int searchPageTypeID = 399;

            PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
            PropertyCriteria criteria = new PropertyCriteria();

            criteria.Name = "PageTypeID";
            criteria.Type = PropertyDataType.PageType;
            criteria.Condition = CompareCondition.NotEqual;
            criteria.Value = searchPageTypeID.ToString();
            PageReference fromPage = PageReference.StartPage;
            criterias.Add(criteria);
            PageDataCollection pages = DataFactory.Instance.FindAllPagesWithCriteria(fromPage, criterias, "no", new LanguageSelector("no"));
            //PageDataCollection pages = EPiServer.DataFactory.Instance.FindPagesWithCriteria(PageReference.StartPage, criterias);

            StringBuilder liste = new StringBuilder();
            //int i = 0;
            tw.WriteLine("ID\tCHANGE\tNAME\tTITLE\tWEBNAME\tSIMPLENAME\tURL");
            foreach (PageData page in pages)
            {
                tw.Write(page.PageLink.ID + "\t\t");
                tw.Write(page.PageName + "\t");
                if (page.Property["Heading"] != null)
                    tw.Write(page.Property["Heading"] + "\t");
                else if (page.Property["PageHeader"] != null)
                {
                    tw.Write(page.Property["PageHeader"] + "\t");
                }
                else
                    tw.Write("\t");
                tw.Write(page.URLSegment + "\t");
                tw.Write(page.Property["PageExternalURL"].ToString() + "\t");
                UrlBuilder url = new UrlBuilder(page.LinkURL); EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.UTF8Encoding.UTF8);
                tw.Write(url);
                tw.WriteLine();
            }
            tw.Close();
        }

        private void TestFile()
        {
            String filname = Server.MapPath("~") + "WashingList.txt";
            StreamReader sr = new StreamReader(filname);
            while (!sr.EndOfStream)
            {
                string s = sr.ReadLine();
                if (s != null)
                {
                    string[] a = s.Split('\t');
                    if (a.Length != 7)
                    {
                        Response.Write(a[0]);
                        Response.Write(" - Error<br />");
                    }
                }
            }
            sr.Close();
        }


        private void Readfile()
        {
            String filname = Server.MapPath("~") + "WashingList.txt";
            StreamReader sr = new StreamReader(filname);
            sr.ReadLine();
            while (!sr.EndOfStream)
            {
                string s = sr.ReadLine();
                if (s != null)
                {
                    string[] a = s.Split('\t');
                    if (a.Length == 7)
                    {
                        //if (a[1] == "x")
                        UpdatePage(a);
                    }
                }
            }
            sr.Close();
        }

        private void UpdatePage(string[] a)
        { 
            PageReference pr = new PageReference(int.Parse(a[0]));
            try
            {
                PageData pd = GetPage(pr);
                PageData wpd = pd.CreateWritableClone();
                wpd.PageName = a[2];
                if (wpd.Property["Heading"] != null)
                    wpd.Property["Heading"].Value = a[3];
                else if (wpd.Property["PageHeader"] != null)
                {
                    wpd.Property["PageHeader"].Value = a[3];
                }
                wpd.URLSegment = a[4];
                wpd.Property["PageExternalURL"].Value = a[5];
                DataFactory.Instance.Save(wpd, EPiServer.DataAccess.SaveAction.Publish);
            }
            catch (Exception e)
            {
                _message += "<br />" + a[0] + " - " + e.Message;

            }
        }

    }
}