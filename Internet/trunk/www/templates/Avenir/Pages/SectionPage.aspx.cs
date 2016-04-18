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
using EPiServer.Core;


namespace Avenir.Templates.Pages
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
    public partial class SectionPage : EPiCode.WebParts.TemplatePageWebPartBase  //TemplatePage
	{
		protected System.Web.UI.WebControls.Label Label1;
        protected EPiServer.Web.WebControls.PageList EpiPageList;

        /// <summary>
        /// Returns the property Heading if set; otherwise the PageName is returned.
        /// </summary>
        protected string Heading
        {
            get
            {
                if (CurrentPage["Heading"] != null)
                {
                    return CurrentPage.Property["Heading"].ToWebString();
                }
                return CurrentPage.Property["PageName"].ToWebString();
            }
        }


		private void Page_Load(object sender, System.EventArgs e)
		{
            bool showList = false;
            if (CurrentPage.Property["ShowSubpages"] != null && CurrentPage.Property["ShowSubpages"].ToString() != string.Empty)
                showList = bool.Parse(CurrentPage.Property["ShowSubpages"].ToString());
            if (showList)
                EpiPageList.PageLink = CurrentPage.PageLink;
            string testing = Request.QueryString["testing"];
            if (testing == "nyno")
            {
                Response.Write(Lib.TestNyno(false));
            }
            if (testing == "avenir")
            {
                Response.Write(Lib.TestNyno(true));
            }

		}

		protected string GetImage()
		{
			
			PageBase page = (PageBase)Page;
            if (page.CurrentPage.Property["Image"] != null && page.CurrentPage["Image"] != null)
				return (string)page.CurrentPage["Image"];
				
			return "";

		}

        protected string GetPreviewText(PageData page)
        {
            if (page.Property["MainIntro"] != null && page.Property["MainIntro"].ToString().Length > 0)
                return page.Property["MainIntro"].ToWebString();
            return "";
        }

        //protected string getGoogleList()
        //{
        //    string g = Request.QueryString["g"];
        //    if (!string.IsNullOrEmpty(g))
        //        return Avenir.Lib.googleSearch(g);
        //    if (CurrentPage.Property["GoogleList"] != null && CurrentPage.Property["GoogleList"].ToString() != string.Empty)
        //        return Avenir.Lib.googleSearch(CurrentPage.Property["GoogleList"].ToString());
        //    return string.Empty;
        //}

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
