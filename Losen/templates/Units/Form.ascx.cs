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
using EPiServer.Core;
using EPiServer.WebControls;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.templates.Units
{
	/// <summary>
	///		Summary description for Form.
	/// </summary>
	public abstract class Form : System.Web.UI.UserControl
	{
		protected Panel				StatisticsPanel, FormPanel;
		protected Literal			NumberOfVotes,PostedMessage;
		protected LinkButton		Switch;
		protected Property			FormProperty;
		protected FormStatistics	Statistics;

		private void Page_Load(object sender, System.EventArgs e)
		{
			bool enableStatistics = false;
			try
			{
				enableStatistics = (bool)((EPiServer.PageBase)Page).CurrentPage["EnableStatistics"];
			}
			catch(Exception)
			{}

			Switch.Visible = enableStatistics;
			DataBind();

			NumberOfVotes.Text = string.Format(((EPiServer.PageBase)Page).Translate("#numberofvotes"), Statistics.NumberOfVotes);
		}

		protected void SwitchView(object sender, System.EventArgs e)
		{
			if (StatisticsPanel.Visible)
			{
				StatisticsPanel.Visible = false;
				Switch.Text = ((EPiServer.PageBase)Page).Translate("#showstat");
			}
			else
			{
				StatisticsPanel.Visible = true;
				Switch.Text = ((EPiServer.PageBase)Page).Translate("#showform");
			}
			FormPanel.Visible = !StatisticsPanel.Visible;
		}

		private void Page_PreRender(object sender, System.EventArgs e)
		{
			PropertyForm form = FormProperty.InnerProperty as PropertyForm;

			if (form == null)
				return;

			if (!form.IsPosted)
				return;

			FormProperty.Visible = false;
			PostedMessage.Visible = true;

			DenyPostingReason d = EPiServer.Util.FormAction.PostedAction( form.Form, (EPiServer.PageBase)Page );
			if (d == DenyPostingReason.DenyAnonymous)
			{
				PostedMessage.Text = ((EPiServer.PageBase)Page).Translate("#requirelogon");
			}
			else if (d == DenyPostingReason.DenyMultiple)
			{
				PostedMessage.Text = ((EPiServer.PageBase)Page).Translate("#denymultipleposts");
			}
			else
			{
				PostedMessage.Text = ((EPiServer.PageBase)Page).Translate("#postedmessage");
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			this.PreRender += new System.EventHandler(this.Page_PreRender);
		}
		#endregion
	}
}
