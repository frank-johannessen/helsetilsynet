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
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public class _default : TemplatePage
	{

		protected System.Web.UI.WebControls.Repeater	news1Repeater;
		protected System.Web.UI.WebControls.Repeater	news2Repeater;
		protected System.Web.UI.WebControls.Repeater news3Repeater;
		protected EPiServer.WebControls.Property		MainBody;		
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;
		protected EPiServer.WebControls.ChangedPages RecentList;

		private void Page_Load(object sender, System.EventArgs e)
		{			
			DataBind();	
			//generatelist();
		}

		public string GetPropertyOfNewestPage(string propertyname,string pagelinknameOld,string pagelinknameNew ) 
		{
			PageData mypageOld = new PageData();
			PageData mypageNew = new PageData();
			PageData mypage = new PageData();
			bool bnew = false;
			bool bold = false;

			/* SJEKK OM NORMAL SIDELINK ER PUBLISERT */
			try 
			{
				mypageOld = Global.EPDataFactory.GetPage((PageReference)CurrentPage[pagelinknameOld]);
				/* HVIS NORMAL SIDELINK IKKE ER PUBLISERT KAST FEIL */
				if (!mypageOld.CheckPublishedStatus(EPiServer.Core.PagePublishedStatus.Published)) throw new EPiServer.Core.AccessDeniedException(mypageOld.PageLink);
				bold = true;
			}
			/* OM NORMAL SIDELINK IKK ER PUBLISERT BRUK ALT SIDELINK */
			catch 
			{
				try 
				{
					bold = false; bnew = true;
					mypageNew = Global.EPDataFactory.GetPage((PageReference)CurrentPage[pagelinknameNew]);
					if (!mypageNew.CheckPublishedStatus(EPiServer.Core.PagePublishedStatus.Published)) throw new EPiServer.Core.AccessDeniedException(mypageNew.PageLink);
				}
				catch 
				{
					bnew = false;
				}
			}

			/* SJEKK OM ALT SIDELINK ER PUBLISERT */
			try 
			{
				mypageNew = Global.EPDataFactory.GetPage((PageReference)CurrentPage[pagelinknameNew]);
				/* HVIS ALT SIDELINK IKKE ER PUBLISERT KAST FEIL */
				if (!mypageNew.CheckPublishedStatus(EPiServer.Core.PagePublishedStatus.Published)) throw new EPiServer.Core.AccessDeniedException(mypageNew.PageLink);
				bnew = true;
			}
			/* OM ALT SIDELINK IKK ER PUBLISERT BRUK NORMAL SIDELINK */
			catch 
			{
				try 
				{
					bnew = false; bold = true;
					mypageOld = Global.EPDataFactory.GetPage((PageReference)CurrentPage[pagelinknameOld]);
					if (!mypageOld.CheckPublishedStatus(EPiServer.Core.PagePublishedStatus.Published)) throw new EPiServer.Core.AccessDeniedException(mypageOld.PageLink);
				}
				catch 
				{
					bold = false;
				}
			}

			/* HVIS INGEN AV SIDELINKENE ER PUBLISERT */
			if (bold == false && bnew == false) return "";
			if (bold == true && bnew == false) mypage = mypageOld;
			if (bold == false && bnew == true) mypage = mypageNew;
			if (bold == true && bnew == true) 
			{
				int status = mypageNew.StartPublish.CompareTo(mypageOld.StartPublish);
				if (status<=0) mypage = mypageOld;
				if (status>0) mypage = mypageNew;
			}

			/* RETURNER VALGT EGENSKAP FRA NYESTE PUBLISERTE SIDE */
			try 
			{
				if (propertyname.ToLower()=="linkurl") return mypage.LinkURL;
				if (propertyname.ToLower()=="created") return mypage.Created.ToString("dd.MM.yyyy");
				return Regex.Replace(mypage[propertyname].ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase);
			}
			catch 
			{
				return "";
			}
		}


		
		public void generatelist() 
		{		
			EPiServer.PropertyCriteria criteria = new EPiServer.PropertyCriteria(); 
			criteria.Type = PropertyDataType.PageType; 
			criteria.Name = "PageTypeID"; 
			criteria.Value = "100";
			PropertySearchControl.Criterias.Add(criteria);		
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

			if(((EPiServer.PageBase)Page).CurrentPage[propName] != null)
			{			
				link1 = thisPage.GetPage((PageReference)thisData.Property[propName].Value);

				text = link1.LinkURL;				
			}

			return text;
		}

		// To ensure there's always a value for ListingCount
		protected int GetCount()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["ListingCount"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["ListingCount"];
			else
				return 3;
		}

		// To ensure there's always a value for Sort
		protected int GetSortOrder()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["ListingSort"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["ListingSort"];
			else
				return 8;
		}

		// Get the LinkURL for the links
		protected string GetLinks()
		{
			IPageSource thisPage = (IPageSource)Page;
			PageData link1;
			PageData thisData;
			thisData = thisPage.CurrentPage;
			string text;

			text = "<DIV class=\"link\">";			

			if(((EPiServer.PageBase)Page).CurrentPage["NewsMore"] != null)
			{			
				link1 = thisPage.GetPage((PageReference)thisData.Property["NewsMore"].Value);

				text = text + "<a href=\"" + link1.LinkURL + "\"><img alt=\"\" src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" class=\"arrow-left\">" + ((EPiServer.PageBase)Page).CurrentPage["FrontPageReadMore"].ToString() + "</a>";	
			}

			if(((EPiServer.PageBase)Page).CurrentPage["Subscribe"] != null)
			{			
				link1 = thisPage.GetPage((PageReference)thisData.Property["Subscribe"].Value);

				text = text + "<a href=\"" + link1.LinkURL + "\">&nbsp;&nbsp;<img alt=\"\" src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" class=\"arrow-left\">" + ((EPiServer.PageBase)Page).CurrentPage["FrontPageSubscribeText"].ToString() + "</a>";				
			}

			text = text + "</DIV";
			return text;

		}

		// Get page name (page header if saved)
		protected string GetPageProperty(string pType)
		{
			IPageSource thisPage = (IPageSource)Page;
			PageData thisData;
			thisData = thisPage.CurrentPage;
			string ReturnValue = "";

			//Does the property exist?
			if(thisData.Property.Exists("PageHeader"))
			{
				//Does it have a value?
				if(thisData.Property["PageHeader"].Value != null)
				{
					ReturnValue = thisData.Property["PageHeader"].ToString();
				}
				else
					ReturnValue = thisData.Property["PageName"].ToString();
			}
			else
				ReturnValue = thisData.Property["PageName"].ToString();
			
			if (pType == "date")
				ReturnValue = thisData.Created.ToString("dd.MM.yyyy");
			
			return ReturnValue;
		}

		private void RecentList_Filter(object sender, EPiServer.Filters.FilterEventArgs e)
		{
			PageDataCollection pages = e.Pages;
		
			//remove dummy-pages from list
			for (int i=0; i < pages.Count; i++)
			{
				if (pages[i].Property.Exists("DummyPage") && pages[i].Property["DummyPage"].Value != null)
				{
					pages.RemoveAt(i);
					i--;
				}
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
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
			this.RecentList.Filter += new EPiServer.WebControls.FilterEventHandler(RecentList_Filter);
		}
		#endregion

	}
}
