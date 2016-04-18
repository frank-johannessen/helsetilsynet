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
	public class SectionPageStatic : TemplatePage
	{
		private void Page_Load(object sender, System.EventArgs e)
		{

			if(!IsPostBack)
				DataBind();
		}

		protected string ExternalLinks()
		{
			string text;
			text = "";

			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkRight1"].Value != null) && (((EPiServer.PageBase)Page).CurrentPage.Property["TextRight1"].Value != null))
			{			
				text = text + "<P><A target=\"_blank\" href=\"" + ((EPiServer.PageBase)Page).CurrentPage["LinkRight1"] + "\">" + ((EPiServer.PageBase)Page).CurrentPage["TextRight1"] + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\"></A><BR></P>";				
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkRight2"].Value != null) && (((EPiServer.PageBase)Page).CurrentPage.Property["TextRight2"].Value != null))
			{			
				text = text + "<P><A target=\"_blank\" href=\"" + ((EPiServer.PageBase)Page).CurrentPage["LinkRight2"] + "\">" + ((EPiServer.PageBase)Page).CurrentPage["TextRight2"] + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\"></A><BR></P>";				
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkRight3"].Value != null) && (((EPiServer.PageBase)Page).CurrentPage.Property["TextRight3"].Value != null))
			{			
				text = text + "<P><A target=\"_blank\" href=\"" + ((EPiServer.PageBase)Page).CurrentPage["LinkRight3"] + "\">" + ((EPiServer.PageBase)Page).CurrentPage["TextRight3"] + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\"></A><BR></P>";				
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkRight4"].Value != null) && (((EPiServer.PageBase)Page).CurrentPage.Property["TextRight4"].Value != null))
			{			
				text = text + "<P><A target=\"_blank\" href=\"" + ((EPiServer.PageBase)Page).CurrentPage["LinkRight4"] + "\">" + ((EPiServer.PageBase)Page).CurrentPage["TextRight4"] + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\"></A><BR></P>";				
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkRight5"].Value != null) && (((EPiServer.PageBase)Page).CurrentPage.Property["TextRight5"].Value != null))
			{			
				text = text + "<P><A target=\"_blank\" href=\"" + ((EPiServer.PageBase)Page).CurrentPage["LinkRight5"] + "\">" + ((EPiServer.PageBase)Page).CurrentPage["TextRight5"] + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\"></A><BR></P>";				
			}
			return text;
		}


		
		// Get property value
		protected string GetPropRefValue(string propName, string propType)
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

				//text = ((DateTime)link1.Property["PageLastPublished"].Value).ToString("dd.MM.yy");
				//for (int x=0; x<link1.Property.Count; x++) 
				//{
				//	text+=link1.Property[x].Name + " - " + link1.Property[x].Type.ToString() + "<br>";
				//}
				if(propType == "date")
				{
					text = link1.Changed.ToString("dd.MM.yy");
				}
				else if(propType == "link")
				{
					text = link1.LinkURL;
				}
				else
				{
					text = link1.PageName;
				}

			}

			return text;
		}
		

		protected string LinkListLeft()
		{
			string text;
			text = "";

			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkLeft1"].Value != null))
			{			
				text += "<DIV class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><br></DIV><DIV class=\"link\"><A href=\"" + GetPropRefValue("LinkLeft1","link") + "\">" +  GetPropRefValue("LinkLeft1","date") + " " + GetPropRefValue("LinkLeft1","name") + "</A></DIV>";
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkLeft2"].Value != null))
			{			
				text += "<DIV class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><br></DIV><DIV class=\"link\"><A href=\"" + GetPropRefValue("LinkLeft2","link") + "\">" + GetPropRefValue("LinkLeft2","date") + " " + GetPropRefValue("LinkLeft2","name") + "</A></DIV>";
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkLeft3"].Value != null))
			{			
				text += "<DIV class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><br></DIV><DIV class=\"link\"><A href=\"" + GetPropRefValue("LinkLeft3","link") + "\">" +  GetPropRefValue("LinkLeft3","date") + " " + GetPropRefValue("LinkLeft3","name") + "</A></DIV>";
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkLeft4"].Value != null))
			{			
				text += "<DIV class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><br></DIV><DIV class=\"link\"><A href=\"" + GetPropRefValue("LinkLeft4","link") + "\">" +  GetPropRefValue("LinkLeft4","date") + " " + GetPropRefValue("LinkLeft4","name") + "</A></DIV>";
			}
			if((((EPiServer.PageBase)Page).CurrentPage.Property["LinkLeft5"].Value != null))
			{			
				text += "<DIV class=\"hr\"><IMG src=\"/images/pxl.gif\" alt=\"\"><br></DIV><DIV class=\"link\"><A href=\"" + GetPropRefValue("LinkLeft5","link") + "\">" +  GetPropRefValue("LinkLeft5","date") + " " + GetPropRefValue("LinkLeft5","name") + "</A></DIV>";
			}
			//lag tre til og med strek over
			return text;
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
