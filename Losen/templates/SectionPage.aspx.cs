/*
Copyright � 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

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
	public class SectionPage : TemplatePage
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
			IPageSource thisPage = (IPageSource)Page;
			PageData pageRef;
			string link;

			for(int j = 1; j < 6; j++)
			{
				// Link
				if(thisPage.CurrentPage.Property["LinkRight" + j].Value != null)
				{
					pageRef = thisPage.GetPage((PageReference)thisPage.CurrentPage.Property["LinkRight" + j].Value);
					//If a text for the link is saved use that - else use the page name 
					if(thisPage.CurrentPage["TextRight" + j] != null)
					{
						link = thisPage.CurrentPage["TextRight" + j].ToString();
					}
					else
					{
						link = pageRef.PageName.ToString();
					}					
					text = text + "<div><A href=\"" + pageRef.LinkURL + "\">" + link + "<img src=\"/images/arrow-white.gif\" width=\"6\" height=\"10\" class=\"arrow-right\" alt=\"\"></A><BR></div>";		
				}
			}
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
