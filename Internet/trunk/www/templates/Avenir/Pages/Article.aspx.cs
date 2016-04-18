/*
Copyright © 1997-2002 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using System;
using EPiServer.Core.Html;
using EPiServer.Core;

namespace Avenir.Templates.Pages
{

	/// <summary>
	/// Summary description for Page.
	/// </summary>
    public partial class Article : EPiCode.WebParts.TemplatePageWebPartBase  //TemplatePage
	{
		protected System.Web.UI.WebControls.Label Label1;
        protected System.Web.UI.HtmlControls.HtmlControl PdfStyle;
        protected System.Web.UI.UserControl LetterHead;
        protected Units.Placeable.PageList PageList;

       private void Page_Load(object sender, System.EventArgs e)
        {
            string pdf = Request.QueryString["pdf"];
            if (!string.IsNullOrEmpty(pdf))
                PdfStyle.Visible = true;
            if (CurrentPage.Property["WidePage"] != null)
            {
                Master.NoRightColumn();
            }
            if (CurrentPage.Property["LetterFrom"] != null)
                this.LetterHead.Visible = true;
        }


        protected string getNavigator()
        {
            if (CurrentPage.Property["ShowContentlist"] != null && CurrentPage.Property["ShowContentlist"].ToString() == "True")
                return "";
            return "<div id=\"jQarticleNavigator\"></div>";
        }

        /// <summary>
        /// Returns the property Heading if set; otherwise the PageName is returned.
        /// </summary>
        protected string Heading
        {
            get
            {
                if (CurrentPage["PageHeader"] != null)
                {
                    return CurrentPage.Property["PageHeader"].ToWebString();
                }
                return CurrentPage.Property["PageName"].ToWebString();
            }
        }

        protected string Date
        {
            get {
                return CurrentPage["AltPubDate"] != null && CurrentPage["AltPubDate"].ToString() != string.Empty
                           ? DateTime.Parse(CurrentPage.Property["AltPubDate"].ToString()).ToShortDateString()
                           : CurrentPage.StartPublish.ToShortDateString();
            }
        }


        protected string Intro
        {
            get
            {
                if (CurrentPage["MainIntro"] != null)
                {
                    string s = CurrentPage.Property["MainIntro"].ToWebString();
                    TextIndexer.StripHtml(s, 130);
                    return TextIndexer.StripHtml(s, 2000);
                }
                return string.Empty;
            }
        }

        protected string GetPdfPage()
        {
            if (CurrentPage.Property["PdfConverter"] == null)
                return null;
            PageReference pr = new PageReference(CurrentPage.Property["PdfConverter"].ToString());
            PageData pd = DataFactory.Instance.GetPage(pr);
            return pd.LinkURL;
        }

        protected string GetAdresseInfo()
        {
            if (CurrentPage.Property["AdresseInfo"] == null || CurrentPage.Property["AdresseInfo"].ToString() == string.Empty)
                return string.Empty;
            string s = "<div class=\"documentInfo\">" + CurrentPage.Property["AdresseInfo"] + "</div>";
            return s;
        }


        protected string GetSocialLinks()
        { 
			PageBase page = (PageBase)Page;
            if (page.CurrentPage.Property["ArticleSocialLinks"] != null && page.CurrentPage["ArticleSocialLinks"] != null)
				return (string)page.CurrentPage["ArticleSocialLinks"];
			return "";
        }

        protected string GetPreviewText(PageData page)
        {
            if (page.Property["MainIntro"] != null && page.Property["MainIntro"].ToString().Length > 0)
                return page.Property["MainIntro"].ToWebString();
            return "";
        }

        protected string GetBoxClass()
        {
            if (CurrentPage.Property["LeftBody"] != null && CurrentPage.Property["LeftBody"].ToString() != string.Empty)
                return "box";
            return "";
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
