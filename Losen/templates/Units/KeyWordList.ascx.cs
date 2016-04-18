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
using EPiServer.Core;
using EPiServer.Filters;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using development;

namespace development.templates.UserControls
{
	/// <summary>
	///		Summary description for AlphanumericListing.
	/// </summary>
	public abstract class KeyWordList : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Literal Result;
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (Request.QueryString["text"] != null)
			{
				string QueryText = Request.QueryString["text"].ToString();
				QueryText = QueryText.Trim();

				HttpUtility.UrlDecode(QueryText);
				QuerySearch(QueryText);
			}
			DataBind();
		}

		protected string MakeKeywordList ()
		{
			string GetList = ((EPiServer.PageBase)Page).CurrentPage["KeyWordList"].ToString();
			string [] ArrayList = GetList.Split(',');
			
			string temp = "";

			foreach(string keyword in ArrayList)
			{
				temp += "<a href=\"" + ((EPiServer.PageBase)Page).CurrentPage.LinkURL.ToString() + "?text=" + HttpUtility.UrlEncode(keyword) + "\">" + keyword + "</a><br>";
			}
				
			return temp;
		}

		public void QuerySearch(string QueryText)
		{
			Result.Text = "<b>" + QueryText + "</b><br>";
			
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.StringCondition = StringCompareMethod.Contained;
			criteria.Type = PropertyDataType.String;
			criteria.Value = QueryText.ToLower();
			criteria.Name = "KeyWordSelectList".ToLower();
			
			PropertySearchControl.Criterias.Add(criteria);
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
