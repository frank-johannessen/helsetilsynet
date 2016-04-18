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
using System.Collections;
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
	public abstract class KeywordListSearch : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label LinkBack;
		protected EPiServer.WebControls.PageSearch KeywodSearch;
		protected System.Web.UI.WebControls.Literal Result;
		protected EPiServer.WebControls.PropertySearch PropertySearchControl;
		protected EPiServer.WebControls.PageList PageList1;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (Request.QueryString["text"] != null)
			{	
				string QueryText = Request.QueryString["text"].ToString();
				QueryText = QueryText.Trim();

				HttpUtility.UrlDecode(QueryText);
				
				if (QueryText != "")
				{
					Result.Text = QuerySearch(QueryText);
					LinkBack.Text = "<a href=\"javascript:window.history.back()\"><img alt=\"\" src=\"/images/arrow-red.gif\" width=\"6\" height=\"10\" class=\"arrow-left\"> " + ((EPiServer.PageBase)Page).CurrentPage["KeywordLinkBack"].ToString() + "</a>";
				}
			}
			else
			{
				Result.Text = MakeKeywordList();
			}
			DataBind();
		}


		protected ArrayList getPageTypesWithKeywordProperty() 
		{
			ArrayList AlPageTypes = new ArrayList();
			EPiServer.DataAbstraction.PageTypeCollection myPageTypes = EPiServer.DataAbstraction.PageType.List();			
			foreach (EPiServer.DataAbstraction.PageType myPageType in myPageTypes) 
			{
				foreach (EPiServer.DataAbstraction.PageDefinition myPageDefinition in myPageType.Definitions) 
				{
					if (myPageDefinition.Name.ToLower() == "keywordselectlist") {
						if (!AlPageTypes.Contains(myPageType.Name)) 
						{
							AlPageTypes.Add(myPageType.ID);
							break;
						}
					}
				}
			}
			return AlPageTypes;
		}

		protected PageDataCollection getPagesWithKeywordProperty(string keywordlist) 
		{
			PropertyCriteriaCollection col = new PropertyCriteriaCollection();

			ArrayList myPageTypes = getPageTypesWithKeywordProperty();
			foreach (int PageTypeID in myPageTypes) 
			{
				EPiServer.PropertyCriteria criteria = new PropertyCriteria();
				criteria.Required = false;
				criteria.Type = PropertyDataType.PageType;
				criteria.Value = PageTypeID.ToString();
				criteria.Name = "PageTypeID";
				col.Add(criteria);
			}

			foreach (string keyword in keywordlist.Split(',')) 
			{
				EPiServer.PropertyCriteria keywordcriteria = new PropertyCriteria();
				keywordcriteria.Required = false;
				keywordcriteria.StringCondition = StringCompareMethod.Contained;
				keywordcriteria.Type = PropertyDataType.String;
				keywordcriteria.Value = keyword.ToLower();
				keywordcriteria.Name = "KeyWordSelectList".ToLower();			
				col.Add(keywordcriteria);
			}
			return Global.EPDataFactory.FindPagesWithCriteria((PageReference)((EPiServer.PageBase)Page).CurrentPage["MainContainer"],col);
		}

		protected int havePages(PageDataCollection Pages, string keyword) 
		{
			int count =0;
			foreach (PageData page in Pages) 
			{
				if (page["KeyWordSelectList"]!=null && page["KeyWordSelectList"].ToString().IndexOf(keyword)>-1) count++;
			}
			return count;
		}

		class KeywordData 
		{
			public string Name;
			public int Count;
			public KeywordData(string _name, int _count) 
			{
				Name = _name;
				Count  = _count;
			}
		}

		protected string MakeKeywordList ()
		{			
			string GetList = ((EPiServer.PageBase)Page).CurrentPage["KeyWordList"].ToString();
			PageDataCollection myPages = getPagesWithKeywordProperty(GetList);
			string[] KeyWordList = GetList.Split(',');
			
			string temp = "";
			string temp1 = "";
			string temp2 = "";		

			ArrayList newKeywordList = new ArrayList();
			foreach(string keyword in KeyWordList) 
			{
				int count = havePages(myPages,keyword);
				if (count>0) 
				{
					newKeywordList.Add(new KeywordData(keyword,count));
				}
			}

			for (int i=0; i<newKeywordList.Count; i++) 
			{
				if (i<newKeywordList.Count/2) 
				{					
					temp1 += "<div style=\"margin-top:5px\"><a href=\"" + ((EPiServer.PageBase)Page).CurrentPage.LinkURL.ToString() + "?text=" + HttpUtility.UrlEncode(((KeywordData)newKeywordList[i]).Name) + "\">" + ((KeywordData)newKeywordList[i]).Name + "</a> (" + ((KeywordData)newKeywordList[i]).Count +")</div>";
				} 
				else 
				{
					temp2 += "<div style=\"margin-top:5px\"><a href=\"" + ((EPiServer.PageBase)Page).CurrentPage.LinkURL.ToString() + "?text=" + HttpUtility.UrlEncode(((KeywordData)newKeywordList[i]).Name) + "\">" + ((KeywordData)newKeywordList[i]).Name + "</a> (" + ((KeywordData)newKeywordList[i]).Count +")</div>";
				}
			}
		

			temp = "<table width=\"100%\" border=0 cellpadding=0 cellspacing=0><tr><td valign=\"top\">" + temp1 + "</td><td>&nbsp;&nbsp;</td><td nowrap valign=\"top\">" + temp2 + "</td></tr></table>";
			return temp;
		}


		public string QuerySearch(string QueryText)
		{
			string title = "<b>" + QueryText + "</b><br>";
			
			EPiServer.PropertyCriteria criteria = new PropertyCriteria();
			criteria.StringCondition = StringCompareMethod.Contained;
			criteria.Type = PropertyDataType.String;
			criteria.Value = QueryText.ToLower();
			criteria.Name = "KeyWordSelectList".ToLower();

			PropertySearchControl.Criterias.Add(criteria);
			return title;
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
