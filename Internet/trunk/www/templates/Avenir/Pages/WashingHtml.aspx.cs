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
using EPiServer.DataAccess;
using System.Text.RegularExpressions;
using System.Diagnostics;


namespace Avenir.Templates.Pages
{
    /// <summary>
    /// The Site Map page displays the page structure beneath a specific page, the IndexRoot parameter. 
    /// If If no page has been set the start page of the site is used as root.
    /// </summary>
    public partial class WashingHtml : TemplatePage
    {
        private int _intPageId;
        private int _intPageTypeId;
        private bool _error;
        private int _teller = 0;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (IsPostBack)
            {
                Msg.Text = string.Empty;
                if (!string.IsNullOrEmpty(txtPageId.Text))
                    _intPageId = int.Parse(txtPageId.Text);
                else
                {
                    if (!string.IsNullOrEmpty(txtPageTypeId.Text))
                        _intPageTypeId = int.Parse(txtPageTypeId.Text);
                    else
                       _error = true;
                }
            }
            else
            {
                startpage.Text = "30";
                txtPageTypeId.Text = "83";
                txtField.Text = "MainBody";
            }

        }

        protected void Write_Click(object sender, EventArgs e)
        {
            Makefile();
            Msg.Text += "File written";
        }

        protected void Test_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(regex1.Text))
                _error = true;
            if (_error)
            {
                Msg.Text += "<br />Error";
                return;
            }
            //TestFile();
            ExecuteFile(true);
            Msg.Text += "<br />File test ferdig";
        }

        protected void Execute_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(regex1.Text))
                _error = true;
            if (_error)
            {
                Msg.Text = "Error";
                return;
            }
            ExecuteFile(false);
            Msg.Text += "File read ok";
        }

        protected void Backup_Click(object sender, EventArgs e)
        {
            if (_error)
            {
                Msg.Text = "Error";
                return;
            }
            ExecuteBackup();
            Msg.Text += "File read ok";
        }


        private void Makefile()
        {
            //TextWriter tw = new StreamWriter(@"c:\prosjekter\pagelist.txt");
            String filname = Server.MapPath("~") + "WashingList.txt";
            TextWriter tw = new StreamWriter(filname);

            int searchPageTypeID = 399; //ikke eksitsterende sidetype

            PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
            PropertyCriteria criteria = new PropertyCriteria();

            criteria.Name = "PageTypeID";
            criteria.Type = PropertyDataType.PageType;
            criteria.Condition = CompareCondition.NotEqual;
            criteria.Value = searchPageTypeID.ToString();
            //PageReference fromPage = PageReference.StartPage;
            PageReference fromPage = PageReference.Parse(startpage.Text);
            Msg.Text += "<br />Skal skrive fil " + filname;
            criterias.Add(criteria);
            //PageDataCollection pages = EPiServer.DataFactory.Instance.FindAllPagesWithCriteria(fromPage, criterias, "no", new LanguageSelector("no"));
            PageDataCollection pages = DataFactory.Instance.FindPagesWithCriteria(fromPage, criterias);

            StringBuilder liste = new StringBuilder();
            //int i = 0;
            tw.WriteLine("ID\tCHANGE\tNAME\tTITLE\tWEBNAME\tSIMPLENAME\tURL");
            int count = 0;
            foreach (PageData page in pages)
            {
                count++;
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
                tw.Write(page.Property["PageExternalURL"] + "\t");
                UrlBuilder url = new UrlBuilder(page.LinkURL); Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.UTF8Encoding.UTF8);
                tw.Write(url);
                tw.WriteLine();
            }
            Msg.Text += "<br />Har skrevet data om sider:  " + count;
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


        private void ExecuteFile(bool testing)
        {
            String filname = Server.MapPath("~") + "WashingList.txt";
            StreamReader sr = new StreamReader(filname);
            sr.ReadLine();
            while (!sr.EndOfStream)
            {
                string s = sr.ReadLine();
                string[] a = s.Split('\t');
                PageReference pr = new PageReference(int.Parse(a[0]));
                try
                {
                    PageData pd = GetPage(pr);
                    if (pd.LinkType == PageShortcutType.Normal) //sjekk at siden ikke er en shortcut
                    {
                        if (Treff(pd)) //treff på sidetype eller sideid
                        {
                            if (testing)
                            {
                                if (TestPage(a, pd))
                                {
                                }
                            }
                            else
                                UpdatePage(pd);
                        }
                    }
                }
                catch (Exception)
                {
                }
            }
            sr.Close();
        }

        private bool Treff(PageData pd)
        {
            if (_intPageId == pd.PageLink.ID)
            {
                return true;
            }
            //else if (intPageTypeId == pd.PageTypeID)
            else if (_intPageTypeId == 83 || _intPageTypeId == 124)
                return true;
            return false;
        }

        private bool TestPage(string[] a, PageData pd)
        {
            string regexExp = regex1.Text;
            Match matchResult = null;
            if (pd.Property["MainBody"] == null)
            {
                Msg.Text += "<br /> " + pd.PageLink.ID + "  " + " MainBody finnes ikke.";
                return false;
            }
            string doc = pd.Property["MainBody"].ToRawProperty().Value;
            _teller++;
                    Debug.Print(pd.PageLink.ID.ToString(), " ", _teller);
            try
            {
	            Regex regexObj = new Regex(regexExp);
                matchResult = regexObj.Match(doc);
                while (matchResult.Success)
                {
                    Msg.Text += "<br />" + pd.PageLink.ID + "  " + Server.HtmlEncode(matchResult.Value);
                    if (replace1.Text != string.Empty)
                    {
                        string replace = replace1.Text;
                        if (replace == "#") replace = string.Empty;
                        string result = Regex.Replace(matchResult.Value, regexExp, replace);
                        Msg.Text += "<br />#" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "  " + Server.HtmlEncode(result);
                    }
                    matchResult = matchResult.NextMatch();
                }
            }
            catch (ArgumentException ex)
            {
                Msg.Text += "<br />" + pd.PageLink.ID + "  " + "Syntax error in the regular expression";
                Msg.Text += "<br />" + ex.Message;
            }

            return false;
        }

        private void UpdatePage(PageData pd)
        {
            string regexExp = regex1.Text;
            string doc = pd.Property["MainBody"].ToRawProperty().Value;
            if (doc.Length > 0)
            {
                try
                {
                    string replace = replace1.Text;
                    if (replace == "#") replace = string.Empty;
                    bool foundMatch = Regex.IsMatch(doc, regexExp);
                    if (foundMatch)
                    {
                        string result = Regex.Replace(doc, regexExp, replace);
                        PageData wpd = pd.CreateWritableClone();
                        wpd.Property["MainBody"].Value = result;
                        //DataFactory.Instance.Save(wpd, SaveAction.Publish);

                        SaveAction saveAction = SaveAction.ForceCurrentVersion;
                        //SaveAction saveAction = SaveAction.CheckIn;
                        //if (wpd.Status != VersionStatus.Published)
                        //{
                        //    // Update existing version if it is not published
                        //    saveAction = saveAction | SaveAction.ForceCurrentVersion;
                        //}
                        DataFactory.Instance.Save(wpd, saveAction);
                        
                        
                        Msg.Text += "<br /># " + pd.PageLink.ID.ToString() + " - " + result.Length.ToString();
                    }
                }
                catch (ArgumentException ex)
                {
                    Msg.Text += "<br />" + pd.PageLink.ID + "  " + "Syntax error in the regular expression";
                    Msg.Text += "<br />" + ex.Message;
                }
            }
        }


        private void ExecuteBackup()
        {
            String filname = Server.MapPath("~") + "WashingList.txt";
            StreamReader sr = new StreamReader(filname);
            sr.ReadLine();
            while (!sr.EndOfStream)
            {
                string s = sr.ReadLine();
                string[] a = s.Split('\t');
                PageReference pr = new PageReference(int.Parse(a[0]));
                try
                {
                    PageData pd = GetPage(pr);
                    if (pd.LinkType == PageShortcutType.Normal) //sjekk at siden ikke er en shortcut
                    {
                        if (Treff(pd)) //treff på sidetype eller sideid
                        {
                                UpdateBackup(pd);
                        }
                    }
                }
                catch (Exception)
                {
                }
            }
            sr.Close();
        }


        private void UpdateBackup(PageData pd)
        {
            string regexExp = regex1.Text;
            string doc = pd.Property["MainBody"].ToRawProperty().Value;
            if (doc.Length > 0)
            {
                try
                {
                        PageData wpd = pd.CreateWritableClone();
                        wpd.Property["Backup"].Value = doc;
                        DataFactory.Instance.Save(wpd, SaveAction.Publish);
                        Msg.Text += "<br />" + pd.PageLink.ID + " - " + doc.Length;
                }
                catch (ArgumentException ex)
                {
                    Msg.Text += "<br />" + pd.PageLink.ID + "  " + "Syntax error in the regular expression";
                    Msg.Text += "<br />" + ex.Message;
                }
            }
        }


        //private void UpdatePage(string[] a, PageData pd)
        //{
        //    //PageReference pr = new PageReference(int.Parse(a[0]));
        //    //PageData pd = GetPage(pr);
        //    //if (Treff(pd))
        //    //{
        //    string s = pd.Property["MainBody"].ToRawProperty().Value;
        //    //s.Contains("<br>"
        //    if (s.Contains("<br />&nbsp;<br />"))
        //    {
        //        PageData wpd = pd.CreateWritableClone();
        //        s = s.Replace("<br />&nbsp;<br />", "<br />");
        //        wpd.Property["MainBody"].Value = s;
        //        DataFactory.Instance.Save(wpd, SaveAction.Publish);
        //        Response.Write(a[0] + " - " + s.Length.ToString());
        //        Response.Write("<br />");
        //    }
        //    //}


        //    //PageData wpd = pd.CreateWritableClone();
        //    //wpd.PageName = a[2];
        //    //if (wpd.Property["Heading"] != null)
        //    //    wpd.Property["Heading"].Value = a[3];
        //    //else if (wpd.Property["PageHeader"] != null)
        //    //{
        //    //    wpd.Property["PageHeader"].Value = a[3];
        //    //}
        //    //wpd.URLSegment = a[4];
        //    //wpd.Property["PageExternalURL"].Value = a[5];
        //    //DataFactory.Instance.Save(wpd, EPiServer.DataAccess.SaveAction.Publish);
        //}


    }
}