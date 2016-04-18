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
namespace development.UserControls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using EPiServer;
	using EPiServer.WebControls;
	using EPiServer.Core;

	/// <summary>
	///		Summary description for Quicksearch.
	/// </summary>
	public abstract class Quicksearch : UserControlBase
	{
		protected System.Web.UI.WebControls.TextBox searchText;
		protected System.Web.UI.WebControls.Label QuicksearchCaption;
		protected System.Web.UI.WebControls.ImageButton QuicksearchButton;
		protected System.Web.UI.WebControls.Label ErrorInfo;
		protected System.Web.UI.HtmlControls.HtmlGenericControl QuickSearchSpan;
		protected System.Web.UI.HtmlControls.HtmlGenericControl AdvancedSearchLink;
		protected EPiServer.WebControls.Property Property1;

		private const string MAIN_SEARCH_PAGE = "MainSearchPage";

		protected string GetSearchLink()
		{
			string linkURL = string.Empty;
			EPiServer.PageBase currentPage = Page as EPiServer.PageBase;

			if (CurrentPage.Property.Exists("AdvancedSearchLink") && CurrentPage.Property["AdvancedSearchLink"].Value != null && (PageReference)currentPage.CurrentPage["AdvancedSearchLink"] == currentPage.CurrentPageLink)
				linkURL = GetPage((PageReference) CurrentPage.Property[MAIN_SEARCH_PAGE].Value).LinkURL;
			else if (CurrentPage.Property.Exists("AdvancedSearchLink") && CurrentPage.Property["AdvancedSearchLink"].Value != null)
				linkURL = GetPage((PageReference) CurrentPage.Property["AdvancedSearchLink"].Value).LinkURL;

			return linkURL;
		}

		protected string GetSearchLinkText()
		{
			string linkText = string.Empty;
			EPiServer.PageBase currentPage = Page as EPiServer.PageBase;

			if (CurrentPage.Property.Exists("AdvancedSearchLink") && CurrentPage.Property["AdvancedSearchLink"].Value != null && (PageReference)currentPage.CurrentPage["AdvancedSearchLink"] == currentPage.CurrentPageLink)
				linkText = Translate("/templates/search/simplesearch");
			else
				linkText = Translate("/templates/search/advancedsearch");
	
			return linkText;
		}

		private void Page_Load(object sender, System.EventArgs e)
		{

			QuicksearchButton.ImageUrl = "/images/search.gif";
			if (((EPiServer.PageBase)Page).CurrentPage["SearchButtonEnglish"] != null)
				QuicksearchButton.ImageUrl = "/images/search_eng.gif";
			
			DataBind();
			EPiServer.PageBase currentPage = Page as EPiServer.PageBase;

			if (currentPage == null)
				return;

			if (currentPage.CurrentPage[MAIN_SEARCH_PAGE] == null)
			{
				ErrorInfo.Text = "Quicksearch not configured (property MainSearchPage must be defined)";
				ErrorInfo.Visible			= true;
				searchText.Enabled			= false;
				QuicksearchButton.Enabled	= false;
				AdvancedSearchLink.Visible	= false;
			}
			else if ((PageReference)currentPage.CurrentPage[MAIN_SEARCH_PAGE] == currentPage.CurrentPageLink || (PageReference)currentPage.CurrentPage["AdvancedSearchLink"] == currentPage.CurrentPageLink)
			{
				QuickSearchSpan.Visible		= false;
				AdvancedSearchLink.Visible	= true;
			}
			else
			{
				QuicksearchButton.Enabled	= true;
				searchText.Enabled			= true;
				AdvancedSearchLink.Visible	= true;
				ErrorInfo.Visible			= false;
			}
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.searchText.TextChanged += new System.EventHandler(this.searchText_TextChanged);
			this.QuicksearchButton.Click += new System.Web.UI.ImageClickEventHandler(this.QuicksearchButton_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void QuickSearch()
		{
			try
			{
				PageReference mainSearchPage = 
					(PageReference) ((EPiServer.PageBase)Page).CurrentPage[MAIN_SEARCH_PAGE];

				string searchUrl = Global.EPDataFactory.GetPage(mainSearchPage).LinkURL;
				
				if(searchUrl.IndexOf("?") > 0)
					searchUrl += "&searchquery=";
				else
					searchUrl += "?searchquery=";

				searchUrl += HttpContext.Current.Server.UrlEncode(searchText.Text);
				
				Response.Redirect(searchUrl, true);
			}
			catch(Exception exc)
			{
				ErrorInfo.Text = exc.Message;
				ErrorInfo.Visible = true;
			}
		}

		private void QuicksearchButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			QuickSearch();
		}

		private void searchText_TextChanged(object sender, System.EventArgs e)
		{
			QuickSearch();
		}

		// Get the LinkURL for the links
		protected string GetLink(string propName)
		{
			IPageSource thisPage = (IPageSource)Page;
			PageData link1;
			PageData thisData;
			thisData = thisPage.CurrentPage;
			string text;

			text = "";
			
			if (thisData.Property["propName"] == null) return "";

			if(((EPiServer.PageBase)Page).CurrentPage.Property[propName].Value != null)
			{			
				link1 = thisPage.GetPage((PageReference)thisData.Property[propName].Value);

				text = link1.LinkURL;				
			}

			//text = "|" + ((EPiServer.PageBase)Page).CurrentPage.Property[propName].Value.ToString() + "|";

			return text;
		}

		protected string visibleClass()
		{
			if(((EPiServer.PageBase)Page).CurrentPage.Property.Exists("DoNotShowAlfabethical"))
			{
				if(((EPiServer.PageBase)Page).CurrentPage.Property["DoNotShowAlfabethical"].Value != null)
				{
					return "noVisibility";
				}
				else
					return "";
			}
			else
				return "";
		}		
	}
}
