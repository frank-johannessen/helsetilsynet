/*
Copyright (c) 2007 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published in 20 August 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/

using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using EPiServer.Core;
using EPiServer.Core.Html;
using EPiServer;

namespace Avenir.Templates.Units.Static
{
    /// <summary>
    /// The header of the website. Generates metadata tags, rss and css links.
    /// </summary>
    public partial class Header : UserControlBase
    {
        protected System.Web.UI.WebControls.PlaceHolder plhMetaAvenir;

        protected System.Web.UI.WebControls.PlaceHolder plhMetaDataArea;

        protected string GoogleScript
        {
            get
            {
                if (CurrentPage.PageTypeName == "Search page")
                    return @"<script type=""text/javascript"" src=""http://www.google.com/jsapi""></script><script type=""text/javascript"" src=""~/Templates/Avenir/scripts/googlesearch.js""></script>";
                return "";
            }
        }

        
        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            plhMetaAvenir = new System.Web.UI.WebControls.PlaceHolder();
            plhMetaDataArea = new System.Web.UI.WebControls.PlaceHolder();
            CreateMetaData();
            RenderMetaTagger();

        }

        /// <summary>
        /// Gets the link to a RSS source page
        /// </summary>
        /// <param name="page">The RSS source page</param>
        /// <returns>A string representation of a link</returns>
        protected string GetRss(PageData page)
        {
            string rssLinkTag = "<link rel=\"alternate\" type=\"application/rss+xml\" href=\"{0}\" title=\"{1}\" />";
            return string.Format(rssLinkTag, Server.HtmlEncode(page.LinkURL), page.PageName);
        }


        /// <summary>
        /// Creates the metadata tags for the website
        /// </summary>
        private void CreateMetaData()
        {
            string dateFormat = "{0:yyyy'-'MM'-'dd}";
            // Charset ISO-8859-15 //UTF-8
            CreateMetaTag("Content-Type", string.Format("text/html; charset={0}", "utf-8"), true);


            // Description - use MetaDescription property if it exists, otherwise use contents 
            // from MainIntro property. Do not display the meta tag if none of these options return 
            // values.

            string metaDescription = GetPropertyString("MetaDescription", CurrentPage);
            if (metaDescription.Equals(string.Empty))
            {
                metaDescription = GetPropertyString("MainIntro", CurrentPage);
                if (!metaDescription.Equals(string.Empty))
                {
                    metaDescription = TextIndexer.StripHtml(metaDescription, 0);
                    if (metaDescription.Length > 255)
                        metaDescription = metaDescription.Substring(0, 252) + "...";
                }
            }
            if (metaDescription.Equals(string.Empty))
            {
                metaDescription = GetPropertyString("DefaultMetaDescription", CurrentPage);
            }
                        

            // Keywords
            CreateMetaTag("keywords", "MetaKeywords", CurrentPage, false);

            // Emne
            CreateMetaTag("emne", "KeyWordSelectList", CurrentPage, false);

            // Title
            if (CurrentPage.Property["PageName"].ToString() == "Emner")
            {
                string emne = StripNumber(Request.QueryString["emne"]);
                CreateMetaTag("description", emne, false);
                CreateMetaTag("DC.Title", "Emne " + emne, false);
            }
            else
            {
                if (!metaDescription.Equals(string.Empty))
                {
                    CreateMetaTag("description", metaDescription, false);
                }
                if (CurrentPage.Property["Heading"] != null && CurrentPage.Property["Heading"].ToString() != string.Empty)
                    CreateMetaTag("DC.Title", "Heading", CurrentPage, false);
                else
                    CreateMetaTag("DC.Title", "PageName", CurrentPage, false);               
            }

            // Author
            if (CurrentPage.Property["MetaAuthor"] != null && CurrentPage.Property["MetaAuthor"].ToString() != string.Empty)
                CreateMetaTag("DC.Publisher", "MetaAuthor", CurrentPage, false);
            else
                CreateMetaTag("DC.Publisher", "Statens helsetilsyn", false);

            if (CurrentPage.StartPublish != DateTime.MinValue)
            {
                string date = string.Format(dateFormat, CurrentPage.StartPublish);
                CreateMetaTagAvenir("publication_date", date, false);
                //CreateMetaTagAvenir("publication_date", CurrentPage.StartPublish.ToString("R"), false);
            }

            CreateMetaTag("kode", "Htil", false);

            CreateMetaTag("pageid", CurrentPage.PageLink.ToString(), false);

            CreateMetaTag("parentid", CurrentPage.ParentLink.ID.ToString(), false);

            CreateMetaTag("dokumenttype", "DocType", CurrentPage, false);
            CreateMetaTag("DC.Type", "DocType", CurrentPage, false);
            //hh quick fix
            if (CurrentPage.Property["Fylke"] != null && CurrentPage.Property["Fylke"].ToString() != string.Empty)
            {
                if (CurrentPage.Property["Fylke"].ToString().Length < 100)
                    CreateMetaTag("fylke", "Fylke", CurrentPage, false);
            }

            if (CurrentPage.Property["MetaYear"] != null && CurrentPage.Property["MetaYear"].ToString() != string.Empty)
            {
                string yMeta = CurrentPage.Property["MetaYear"].ToString();
                if (Avenir.Lib.ArchiveYear(yMeta))
                    yMeta += " Eldre";
                if (CurrentPage.Created != DateTime.MinValue)
                {
                    DateTime dt = CurrentPage.Created;
                    TimeSpan ts = TimeSpan.FromDays(31);
                    if (DateTime.Now.Subtract(dt) < ts)
                        yMeta += " lastmonth";
                }
                CreateMetaTag("year", yMeta, false);
            }
            //    if (yMeta.Length == 4)
            //    {
            //        int meta;
            //        if(int.TryParse(yMeta,out meta))
            //        {
            //            int y = DateTime.Now.Year - 5;
            //            if (meta < y)
            //                yMeta += " Arkiv";
            //            CreateMetaTag("year", yMeta, false);
            //        }
            //    }
            //}

            // Kommune
            CreateMetaTag("kommune", "CouncilName", CurrentPage, false);

            // region
            //hh quick fix
            if (CurrentPage.Property["Region"] != null && CurrentPage.Property["Region"].ToString() != string.Empty)
            {
                if (CurrentPage.Property["Region"].ToString().Length < 50)
                    CreateMetaTag("region", "Region", CurrentPage, false);
            }

            // Institution
            CreateMetaTag("institusjon", "Helseforetak", CurrentPage, false);

            //Tilsynssaker
            CreateMetaTag("hpkategori", "PersonellK", CurrentPage, false);
            CreateMetaTag("virksomheter", "VirksomhetK", CurrentPage, false);
            CreateMetaTag("reaksjon", "ReaksjonstypeK", CurrentPage, false);
            CreateMetaTag("tjeneste", "TjenesteomradeK", CurrentPage, false);
            CreateMetaTag("vurdering", "VurderingsgrunnlagK", CurrentPage, false);
            CreateMetaTag("VirksomhetIndividSaker", "VirksomhetIndividSakerK", CurrentPage, false);
            CreateMetaTag("Undersokelsessaker", "UndersokelsessakerK", CurrentPage, false);
 
            // Landsomfatende
            CreateMetaTag("landsomfattende", "CountryWide", CurrentPage, false);

            //Menugroup (Menygren er dynamisk egenskap
            CreateMetaTag("menugroup", "Menygren", CurrentPage, false);

            // Categories
            string s = Avenir.Lib.findCategories(CurrentPage);
            if (!string.IsNullOrEmpty(s))
                CreateMetaTag("kategori", s, false);

            //Robots
            if (CurrentPage.Property["DummyPage"] != null)
                if(CurrentPage.Property["DummyPage"].ToString() == "True")
                    CreateMetaTagAvenir("ROBOTS", "noindex, follow", false);


            //// Rating
            //CreateMetaTag("rating", "General", false);

            //// Revisit each month
            //CreateMetaTag("revisit-after", "4 weeks", false);

            //// Generator
            //CreateMetaTag("generator", "EPiServer", false);

            //// Robots
            //CreateMetaTag("robots", "all", false);

            // Created - GMT format
            if (CurrentPage.Created != DateTime.MinValue)
            {
                string date = string.Format(dateFormat, CurrentPage.Created);
                CreateMetaTag("creation_date", date, false);
            }
            // Last modified data, in GMT format - Note, same as revised
            if (CurrentPage.Changed != DateTime.MinValue)
            {
                string date = string.Format(dateFormat, CurrentPage.Changed);
                CreateMetaTagAvenir("last-modified", date, false);
                CreateMetaTagAvenir("revised", date, false);
                //CreateMetaTag("last-modified", CurrentPage.Changed.ToString("R"), false);
            }

            if (!string.IsNullOrEmpty(CurrentPage.LinkURL))
                CreateMetaTag("DC.Identifier.URL", "https://www.helsetilsynet.no" + GetFriendlyUrl(CurrentPage), false); // CurrentPage.LinkURL, false);
            
            // Revised - GMT format
            //if (CurrentPage.Changed != DateTime.MinValue)
            //{

            //    CreateMetaTag("revised", CurrentPage.Changed.ToString("R"), false);
            //}
            //CreateMetaTag("Content-Language", CurrentPage.LanguageBranch, true);
        }

        /// <summary>
        /// Adds a meta tag control to the page header
        /// </summary>
        /// <param name="name">The name of the meta tag</param>
        /// <param name="content">The content of the meta tag</param>
        /// <param name="httpEquiv">True if the meta tag should be HTTP-EQUIV</param>
        private void CreateMetaTag(string name, string content, bool httpEquiv)
        {
            HtmlMeta tag = new HtmlMeta();
            if(httpEquiv)
            {
                tag.HttpEquiv = name;
            }
            else
            {
                tag.Name = name;
            }
            tag.Content = content;
            plhMetaDataArea.Controls.Add(tag);
        }


        private void RenderMetaTagger()
        {
            System.IO.StringWriter sw = new System.IO.StringWriter();
            using (System.Web.UI.HtmlTextWriter  htw = new System.Web.UI.HtmlTextWriter(sw))
            {
                htw.Write("\r\n");
                foreach (HtmlMeta c in plhMetaAvenir.Controls)
                {
                    c.RenderControl(htw);
                    htw.Write("\r\n");
                }
                foreach (HtmlMeta c in plhMetaDataArea.Controls)
                {
                    c.RenderControl(htw);
                    htw.Write("\r\n");
                }
            }
            meta.Text = sw.ToString();
        }

        private void CreateMetaTagAvenir(string name, string content, bool httpEquiv)
        {
            HtmlMeta tag = new HtmlMeta();
            if (httpEquiv)
            {
                tag.HttpEquiv = name;
            }
            else
            {
                tag.Name = name;
            }
            tag.Content = content;
            plhMetaAvenir.Controls.Add(tag);
        }

        /// <summary>
        /// Adds a meta tag control to the page header
        /// </summary>
        /// <param name="name">The name of the meta tag</param>
        /// <param name="propertyName">The name of the me tag page property</param>
        /// <param name="pageData">The page from where to get the property</param>
        /// <param name="httpEquiv">True if the meta tag should be HTTP-EQUIV</param>
        private void CreateMetaTag(string name, string propertyName, PageData pageData, bool httpEquiv)
        {
            string property = pageData[propertyName] as string;
            if (property != null)
            {
                //CreateMetaTag(name, Server.UrlEncode(property), httpEquiv);
                CreateMetaTag(name, property, httpEquiv);
            }
        }

        /// <summary>
        /// Gets a page property as a string
        /// </summary>
        /// <param name="PropertyName">The name of the property to get</param>
        /// <param name="pageData">The page from where to get the property</param>
        /// <returns>A string representation of the page property</returns>
        private static string GetPropertyString(string PropertyName, PageData pageData)
        {
            return pageData[PropertyName] as string ?? String.Empty;
        }

        //public static string GetFriendlyURL(PageReference PageLink, string URL)
        //{
        //    var url = new UrlBuilder(URL);
        //    Global.UrlRewriteProvider.ConvertToExternal(url, PageLink, System.Text.UTF8Encoding.UTF8);
        //    return url.Uri.AbsoluteUri;
        //}
        public static string GetFriendlyUrl(PageData pd)
        {
            var url = new UrlBuilder(pd.LinkURL);
            Global.UrlRewriteProvider.ConvertToExternal(url, pd.PageLink, UTF8Encoding.UTF8);
            return url.ToString();
        }

        protected string StripNumber(string s)
        {
            int p = s.IndexOf('0');
            if (p > 0)
                return s.Substring(0, p);
            return s;
        }

    }
}