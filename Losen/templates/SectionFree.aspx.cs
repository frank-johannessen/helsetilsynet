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
using EPiServer.Core;
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
using System.Runtime.Remoting;
using System.Configuration;

namespace development
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
	public class SectionFree : TemplatePage
	{
		protected System.Web.UI.WebControls.Label Label1;
		protected EPiServer.WebControls.ChangedPages RecentList;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
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
