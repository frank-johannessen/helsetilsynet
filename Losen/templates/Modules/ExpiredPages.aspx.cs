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
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Runtime.Remoting;
using System.Configuration;
using System.Web.Mail;
using EPiServer;
using EPiServer.Core;
using System.Collections.Specialized;
using EPiServer.DataAccess;
using EPiServer.Security;
using EPiServer.Personalization;
using EPiServer.PlugIn;
using EPiServer.Filters;


namespace development
{
	public class ExpiredPages : TemplatePage
	{

		protected EPiServer.WebControls.PropertySearch PropertySearchControl;
		protected System.Web.UI.HtmlControls.HtmlInputText DateStart;
		protected System.Web.UI.HtmlControls.HtmlInputText DateEnd;

		public void generatelist() 
		{
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.Condition = CompareCondition.GreaterThan;
			criteria.Type = PropertyDataType.Date;
			criteria.Value = DateStart.Value.ToString();
			criteria.Name = "Revision";
			criteria.Required = true;
			PropertySearchControl.Criterias.Add(criteria);
			

			EPiServer.PropertyCriteria criteria2 = new PropertyCriteria();
			criteria2.Condition = CompareCondition.LessThan;
			criteria2.Type = PropertyDataType.Date;
			criteria2.Value = DateEnd.Value.ToString();
			criteria2.Name = "Revision";
			criteria2.Required = true;
			PropertySearchControl.Criterias.Add(criteria2);
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (DateStart.Value=="") DateStart.Value = System.DateTime.Now.ToString();
			if (DateEnd.Value=="") DateEnd.Value = System.DateTime.Now.AddDays(7).ToString();						
			generatelist();
			DataBind();
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

