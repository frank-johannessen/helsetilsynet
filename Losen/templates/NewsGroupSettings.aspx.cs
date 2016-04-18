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
using EPiServer;
using EPiServer.DataAccess;
using EPiServer.Personalization;
using EPiServer.Security;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Security.Principal;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development
{
	/// <summary>
	/// Summary description for NewsGroupSettings.
	/// </summary>
	public class NewsGroupSettings : TemplatePage
	{
		protected System.Web.UI.WebControls.TextBox			FirstName, LastName, Email;
		protected EPiServer.WebControls.Translate Translate3;
		protected EPiServer.WebControls.Translate Translate1;
		protected EPiServer.WebControls.Translate Translate2;
		protected EPiServer.WebControls.Translate Translate4;
		protected EPiServer.WebControls.Translate Translate5;
		protected System.Web.UI.WebControls.Button ApplyButton;
		protected System.Web.UI.WebControls.DropDownList	Interval;
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(CurrentUser.UserData == null)
				AccessDenied();
			else if(!IsPostBack)
			{
				FirstName.Text	= CurrentUser.UserData.FirstName;
				LastName.Text	= CurrentUser.UserData.LastName;
				Email.Text		= CurrentUser.UserData.Email;

				foreach(ListItem item in Interval.Items)
				{
					item.Text = Translate(item.Text);
					if(CurrentUser.UserData["EPSUBSCRIBE-INTERVAL"] != null && item.Value == CurrentUser.UserData["EPSUBSCRIBE-INTERVAL"].ToString())
						item.Selected = true;
				}
				DataBind();
			}	
		}
		protected virtual void ApplyButton_Click(object sender, EventArgs e)
		{
			CurrentUser.UserData.FirstName	= FirstName.Text;
			CurrentUser.UserData.LastName	= LastName.Text;
			CurrentUser.UserData.Email		= Email.Text;



			CurrentUser.UserData["EPSUBSCRIBE-INTERVAL"] =Int32.Parse(Interval.SelectedItem.Value);
			if(CurrentUser.UserData["EPSUBSCRIBE-LASTMSG"] == null)
				CurrentUser.UserData["EPSUBSCRIBE-LASTMSG"] = System.DateTime.Now;

			UnifiedPrincipal.RemoveFromCache(new GenericIdentity(CurrentUser.Identity.Name));
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
