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


namespace development
{

	[GuiPlugIn("Statistikk Abonnering", "Statistikk på abonnering", PlugInArea.AdminMenu,"~/templates/Modules/SubscriptionStatistics.aspx")]	

	public class SubscriptionStatistics : TemplatePage
	{

		protected System.Web.UI.WebControls.Literal output;
		protected System.Web.UI.HtmlControls.HtmlInputText DateStart;
		protected System.Web.UI.HtmlControls.HtmlInputText DateEnd;

		public void generatelist() 
		{
			DataSet ds = (new SidDB()).List(SecurityIdentityType.AnyUserSid, null);
			EPiServer.PropertyCriteria criteria = new EPiServer.PropertyCriteria(); 
			criteria.Type = PropertyDataType.Boolean; 
			criteria.Name = "EPSUBSCRIBE"; 
			criteria.Value = "true"; 
			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection(); 
			criterias.Add(criteria); 
			PageDataCollection pages = Global.EPDataFactory.FindPagesWithCriteria(Global.EPConfig.StartPage,criterias); 			

			output.Text = "";
			foreach(PageData data in pages) 
			{
				output.Text += data.PageName; 				
				int count = 0;
				foreach(DataRowView row in ds.Tables[0].DefaultView) 
				{
					PersonalizedData persData = PersonalizedData.Load(int.Parse(row["SID"].ToString()));
					if (persData["PageRefString"] != null) 
					{
						if (persData["PageRefString"].ToString().IndexOf(data.PageLink.ID.ToString())>-1) 
						{
							if (persData["Sub" + data.PageLink.ID.ToString()]!= null) 
							{
								
								if (DateTime.Compare(DateTime.Parse(persData["Sub" + data.PageLink.ID.ToString()].ToString()),DateTime.Parse(DateStart.Value))>0) 
								{
									if (DateTime.Compare(DateTime.Parse(persData["Sub" + data.PageLink.ID.ToString()].ToString()),DateTime.Parse(DateEnd.Value))<0) count++;
								}								
							}
						}
					}				
				}
				output.Text += " (" + count.ToString()+ ")<br>";
			}	
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (DateStart.Value=="") DateStart.Value = "2003-01-01 12:00";
			if (DateEnd.Value=="") DateEnd.Value = System.DateTime.Now.ToString();						
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

