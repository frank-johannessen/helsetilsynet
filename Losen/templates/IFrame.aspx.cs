/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

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
using System.Runtime.Remoting;
using System.Configuration;
using EPiServer;
using EPiServer.Core;

namespace development.Templates
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
	public class IFrame : SimplePage
	{
		private void Page_Load(object sender, System.EventArgs e)
		{			
			if (!IsPostBack)
				DataBind();

			if (CurrentPage["RequiresHTTP"] != null && Request.IsSecureConnection)
			{				
				Response.Redirect("http://" + Request.ServerVariables["HTTP_HOST"] + CurrentPage.LinkURL);
			}

			if (CurrentPage["RequiresHTTPS"] != null && !Request.IsSecureConnection)
			{				
				Response.Redirect("https://" + Request.ServerVariables["HTTP_HOST"] + CurrentPage.LinkURL);
			}
		}

		protected string GetTopPage
		{
			get
			{
				PageData pd = CurrentPage;

				while (pd.ParentLink != PageReference.EmptyReference && pd.ParentLink != Global.EPConfig.StartPage)
				{
					pd = GetPage(pd.ParentLink);
				}

				return Server.HtmlEncode(pd.PageName);

			}
		}

		protected string GetHTTPMethod
		{
			get
			{
				if (Request.IsSecureConnection)
					return "https";
				else
					return "http";
			}
		}

		protected string MakeSSLCompatibleURL(string url)
		{
			string tmpURL = url.Substring(url.IndexOf("://")+3);

			if (Request.IsSecureConnection)
				return "https://" + tmpURL;
			else
				return "http://" + tmpURL;
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
