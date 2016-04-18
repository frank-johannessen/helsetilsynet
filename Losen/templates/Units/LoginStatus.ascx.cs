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
using EPiServer.Security;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.UserControls
{
	/// <summary>
	///		Summary description for LoginStatus.
	/// </summary>
	public abstract class LoginStatus : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label UserName;
		protected System.Web.UI.WebControls.LinkButton Login,Logout;
		protected System.Web.UI.HtmlControls.HtmlImage Img3;
		protected System.Web.UI.HtmlControls.HtmlImage Img4;

		private void Page_Load(object sender, System.EventArgs e)
		{
			UnifiedPrincipal user = Context.User as UnifiedPrincipal;
			if (user != null && user.Identity.IsAuthenticated)
			{
				UserName.Text		= user.Identity.Name;
				UserName.Visible	= true;
				Login.Visible		= Global.EPConfig.Authentication == AuthenticationMode.Forms;
				Login.Visible		= false;
			}
			else
			{
				DisplayLoginLink();
			}
		}

		private void Login_Click(Object sender, EventArgs e) 
		{
			EPiServer.PageBase page = this.Page as EPiServer.PageBase;
			if (page == null)
				return;
			page.AccessDenied();
		}
		private void Logout_Click(Object sender, EventArgs e) 
		{
			UnifiedPrincipal user = UnifiedPrincipal.Current;
			if (user.Identity.IsAuthenticated)
			{
				EPiServer.PageBase page = this.Page as EPiServer.PageBase;
				if (Global.EPConfig.Authentication != AuthenticationMode.Forms)
					return;
				FormsAuthentication.SignOut();
				UnifiedPrincipal.RemoveFromCache( user.Identity );
				DisplayLoginLink();
				if (page == null)
					return;
				page.CurrentUser = UnifiedPrincipal.AnonymousUser;

				if(!page.QueryDistinctAccess())
					Response.Redirect(EPiServer.Global.EPConfig.RootDir);
			}
		}

		private void DisplayLoginLink()
		{
			UserName.Visible = false;
			Login.Visible = true;
			Logout.Visible = false;
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
			this.Login.Click += new System.EventHandler(this.Login_Click);
			this.Logout.Click += new System.EventHandler(this.Logout_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
