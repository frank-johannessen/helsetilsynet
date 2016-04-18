/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using EPiServer.Core;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.UserControls
{
	/// <summary>
	///		Summary description for Menu.
	/// </summary>
	public abstract class Menu : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.PageTree PageTreeControl;
		protected Label		test;
		protected int MenuElementCount = 0;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			/*
			PageDataCollection oPages;
			PageReference oParent = Global.EPConfig.StartPage;
			oPages = Global.EPDataFactory.GetChildren(oParent);
			test.Text = "Count of pages: " + oPages.Count;
			*/
			DataBind();
			
		}

		public string GetPageURL()
		{
			string GetUrl = "";
			string Title = ((EPiServer.PageBase)Page).CurrentPage["MainMenuStartPageTitle2"].ToString();
			
			//get startpage id
			int StartPageID = int.Parse(((EPiServer.PageBase)Page).CurrentPage["ShowFrontPageFrom"].ToString());
			PageData oPage;
			oPage = Global.EPDataFactory.GetPage(new PageReference(StartPageID));
			
			//if this page is startpage
			PageBase thisPage = (PageBase)Page;
			if (((PageBase)Page).CurrentPage.PageLink == (EPiServer.Core.PageReference)thisPage.CurrentPage.Property["ShowFrontPageFrom"].Value)
				Title = ((EPiServer.PageBase)Page).CurrentPage["MainMenuStartPageTitle1"].ToString();
			
			GetUrl = "<a href=\"" + oPage.LinkURL.ToString() + "\">" + Title + "</a>"; 
			return GetUrl;
		}

		
		public string IsStartPage(string trueValue, string falseValue) {
			PageBase thisPage = (PageBase)Page;
			if (((PageBase)Page).CurrentPage.PageLink == (EPiServer.Core.PageReference)thisPage.CurrentPage.Property["MainMenuContainer"].Value) return trueValue;
			return falseValue;
		}

		public string HasChild(string trueValue, string falseValue) 
		{
			PageBase thisPage = (PageBase)Page;
			//if (((PageBase)Page).CurrentPage.ParentLink != EPiServer.Global.EPConfig.StartPage) return trueValue;
			if (((PageBase)Page).CurrentPage.ParentLink != (EPiServer.Core.PageReference)thisPage.CurrentPage.Property["MainMenuContainer"].Value) return trueValue;
			return falseValue;
		}

		public string DisplayParentGif(string trueValue, string falseValue) 
		{
			PageBase thisPage = (PageBase)Page;
			if (((PageBase)Page).CurrentPage.ParentLink == (EPiServer.Core.PageReference)thisPage.CurrentPage.Property["MainMenuContainer"].Value) return trueValue;
			return falseValue;
		}
		
		
		public string DisplayGif(string trueValue, string falseValue) 
		{
			PageDataCollection oPages;
			PageReference oParent = ((PageBase)Page).CurrentPage.PageLink;
			oPages = Global.EPDataFactory.GetChildren(oParent);
			
			if (oPages.Count > 0 || ((PageBase)Page).CurrentPage.ParentLink != EPiServer.Global.EPConfig.StartPage) return trueValue;
			return falseValue;
		}

		public int getpagelevel(EPiServer.Core.PageReference pageLink) 
		{
			PageBase thisPage = (PageBase)Page;
			PageData mypage = thisPage.GetPage(pageLink);
			if (mypage.ParentLink != (EPiServer.Core.PageReference)thisPage.CurrentPage.Property["MainMenuContainer"].Value) 
			{
				return getpagelevel(mypage.ParentLink)+1;				
			} 
			else return 1;
		}

		public string writemenu(EPiServer.Core.PageData mypage, int selected) 
		{
			int level = getpagelevel(mypage.PageLink);
			string output = "";			
			if (getpagelevel(mypage.PageLink)<3) 
			{
				output += "<tr valign=\"top\" class=\"child\"> <td colspan=\"2\" class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><BR></td></tr>";
				output += "<tr valign=\"top\" class=\"child\">";
				output += "<td>" + ((selected==1) ? "<IMG src=\"/images/arrow_closed2.gif\" alt=\"\" class=\"icon\">" : "<IMG alt=\"\" src=\"/images/pxl.gif\" width=\"25\" height=\"1\">") + "<BR></td>";
				output += "<td class=\"off\"><a href=\"" + mypage.LinkURL + "\">" + mypage.PageName + "</td>";
				output += "</tr>";
				return output;
			}
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
