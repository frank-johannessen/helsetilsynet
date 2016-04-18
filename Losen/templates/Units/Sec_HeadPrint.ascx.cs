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
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development.UserControls
{
	/// <summary>
	///		Summary description for ContentHead.
	/// </summary>
	public abstract class Sec_HeadPrint : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.Property Property2;
		protected EPiServer.WebControls.Property Property3;
		protected EPiServer.WebControls.Property Property4;
		protected EPiServer.WebControls.Property Property1;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			DataBind();
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

		protected string GetPageNameSize()
		{
			string StyleValue = "title";
			if (((EPiServer.PageBase)Page).CurrentPage.PageTypeID == 100 )
			{
				StyleValue = "titleTilsyn";
			}
			else
			{
				if (((EPiServer.PageBase)Page).CurrentPage.Property["titleSize"] != null)
				{
					string TitleSize = ((EPiServer.PageBase)Page).CurrentPage.Property["titleSize"].ToString();
					if (TitleSize == "True")
						StyleValue = "titleTilsyn";
				}
			}
			return StyleValue;
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
