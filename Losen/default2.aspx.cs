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
	public class default2 : TemplatePage
	{

		protected System.Web.UI.WebControls.Repeater	news1Repeater;
		protected System.Web.UI.WebControls.Repeater	news2Repeater;
		protected System.Web.UI.WebControls.Repeater news3Repeater;
		protected EPiServer.WebControls.Property		MainBody;		
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;

		private void Page_Load(object sender, System.EventArgs e)
		{			
			DataBind();	
			generatelist();
		}


		public string GetTeaser(int DisplayType) 
		{
			string temp = "";
			int count = 0;
			string Container = "";
			
			switch (DisplayType)
			{
				case 1:
					Container = ((EPiServer.PageBase)Page).CurrentPage.Property["PageContainerFrontpage1"].ToString();
					break;
				case 2:
					Container = ((EPiServer.PageBase)Page).CurrentPage.Property["PageContainerFrontpage2"].ToString();
					break;
				case 3:
					Container = ((EPiServer.PageBase)Page).CurrentPage.Property["PageContainerFrontpage3"].ToString();
					break;
				default:
					break;
			}			

			if (Container != "") 
			{
				string [] ArrayList = Container.Split(',');
		
				if (ArrayList.Length > 0)
				{
					PageData oPage;
					foreach(string id in ArrayList)
					{
						oPage = Global.EPDataFactory.GetPage(new PageReference(id.Trim()));
						
						if (DisplayType == 1)
						{
							temp += "<div class=\"teaser\"><div class=\"title\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a></div>";
							temp += oPage.Property["MetaDescription"];
							temp += " <span class=\"teaserDate\">" + oPage.Created.ToString("dd.MM.yyyy") + "</span> <a href=\"" + oPage.LinkURL + "\"><img src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" alt=\"\" class=\"arrow-right\"></a></div>";
						}
						else if(DisplayType == 2)
						{
							count += 1;
							if (count == 1)
								temp += "<tr>";

							temp += "<td width=\"50%\" valign=\"top\"><div class=\"teaser\">";
							temp += "<div class=\"subTitle\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a></div>";
							temp += oPage.Property["MetaDescription"];
							temp += " <span class=\"teaserDate\">" + oPage.Created.ToString("dd.MM.yyyy") + "</span> <a href=\"" + oPage.LinkURL + "\"><img src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" alt=\"\" class=\"arrow-right\"></a>";
							temp += "</div></td>";
							
							//if (ArrayList.Length == 1)
							//	temp += "<td width=\"50%\" valign=\"top\"><div class=\"teaser\">&nbsp;</td>";
							
							if (count == 2)
							{
								temp += "</tr>";
								count = 0;
							}
						}
						else if(DisplayType == 3)
						{
							temp += "<div class=\"teaserLink\"><a href=\"" + oPage.LinkURL + "\">" + oPage.Property["PageHeader"] + "</a> <a href=\"" + oPage.LinkURL + "\"><img src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" alt=\"\" class=\"arrow-right\"></a></div>";
						}
					}

					if (DisplayType == 2)
					{
						temp = "<table width=\"100%\" bordercolor=\"yellow\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + temp + "</table>";
					}

				}
			}
			return temp;
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
		protected string GetPageName()
		{
			IPageSource thisPage = (IPageSource)Page;
			PageData thisData;
			thisData = thisPage.CurrentPage;

			//Does the property exist?
			if(thisData.Property.Exists("PageHeader"))
			{
				//Does it have a value?
				if(thisData.Property["PageHeader"].Value != null)
				{
					return thisData.Property["PageHeader"].ToString();
				}
				else
					return thisData.Property["PageName"].ToString();
			}
			else
				return thisData.Property["PageName"].ToString();
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
