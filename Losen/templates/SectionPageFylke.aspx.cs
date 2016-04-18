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
	public class SectionPageFylke : TemplatePage
	{
		protected EPiServer.WebControls.Content ContentTop;
		protected EPiServer.WebControls.Property Property4;
		protected EPiServer.WebControls.Content Fylker;
		protected EPiServer.WebControls.Content contentBody;
		protected int count;
	
		private void Page_Load(object sender, System.EventArgs e)
		{

			if(!IsPostBack)
				DataBind();
			count = 0;
		}

		// To ensure there's always a value for Sort
		protected int GetSortOrder()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["ListingSort"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["ListingSort"];
			else
				return 8;
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
