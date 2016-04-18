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
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace development
{
	/// <summary>
	/// Summary description for Login.
	/// </summary>
	public class Login : SystemPage
	{
		protected TextBox Username;
		protected TextBox Password;
		protected Button LoginButton;
		protected RequiredFieldValidator RequiredUsernameValidator;
		protected CheckBox PersistCookie;
		protected EPiServer.WebControls.Translate Translate1;
		protected EPiServer.WebControls.Translate UsernameLabel;
		protected EPiServer.WebControls.Translate PasswordLabel;
		protected EPiServer.WebControls.Translate PersistentLabel;
		protected Label Message;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			RequiredUsernameValidator.Text = Translate("/login/usernamerequired");
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
			this.LoginButton.Click += new System.EventHandler(this.Login_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void Login_Click(object sender, System.EventArgs e)
		{
			IPrincipal principal = AuthenticationProvider.Authenticate(this, Username.Text, Password.Text);
			if (principal == null)
			{
				Message.Text = Translate("/login/loginfailed");
				return;
			}

			FormsAuthentication.Initialize();
			FormsAuthenticationTicket ticket = new FormsAuthenticationTicket( 1, Username.Text, DateTime.Now, DateTime.Now.AddMinutes(Configuration.LogoffTimeout), PersistCookie.Checked, Password.Text, FormsAuthentication.FormsCookiePath );
			string cookiestr = FormsAuthentication.Encrypt(ticket);
			string url = FormsAuthentication.GetRedirectUrl( Username.Text, PersistCookie.Checked );

			Response.Cookies[FormsAuthentication.FormsCookieName].Value = cookiestr;
			if (PersistCookie.Checked)
				Response.Cookies[FormsAuthentication.FormsCookieName].Expires = DateTime.Today.AddYears( 1 );

			Response.Redirect( url );
		}
	}
}
