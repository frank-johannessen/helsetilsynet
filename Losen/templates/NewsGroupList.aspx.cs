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
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace development
{
	/// <summary>
	/// Summary description for NewsGroupList.
	/// </summary>
	public class NewsGroupList : NewsGroup
	{
		protected System.Web.UI.WebControls.LinkButton	Subscribe;
		protected System.Web.UI.WebControls.Panel		PersonalSettings;
		protected System.Web.UI.HtmlControls.HtmlTableCell CreateEntry;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(CurrentUser.UserData == null)
			{
				PersonalSettings.Visible = false;
			}
			else if(CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] == null ||(bool)CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] == false )
				Subscribe.Text = Translate("#subscribe");
			else
				Subscribe.Text = Translate("#unsubscribe");
			CreateEntry.Visible = CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Create);
			if(!IsPostBack)
				DataBind();
		}
		protected void ChangeSubscribtion(object sender, System.EventArgs e)
		{
			if(! CurrentPage.Property.Exists("EPSUBSCRIBE") || (CurrentUser.UserData == null))
				return;
			if(CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] == null ||(bool)CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] == false )
			{
				Subscribe.Text = Translate("#unsubscribe");
				CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] = true;
			}
			else
			{
				Subscribe.Text = Translate("#subscribe");
				CurrentUser.UserData["EPSUBSCRIBE",CurrentNewsGroup] = false;
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
		}
		#endregion
	}
}
