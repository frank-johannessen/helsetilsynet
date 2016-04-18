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

namespace development
{
	/// <summary>
	/// Summary description for NewsGroup.
	/// </summary>
	
	public class NewsGroup : TemplatePage
	{
		private PageReference _newsGroupRoot;
		private PageReference _currentNewsGroup;

		private void Page_Load(object sender, System.EventArgs e)
		{
		}
		private PageReference GetNewsGroupRoot()
		{
			if(CurrentPage.Property.Exists("NewsGroupRoot"))
				return CurrentPageLink;

			int rootPage = 0;
			PageData tmpPageData = GetPage(CurrentPageLink);

			while(rootPage == 0)
			{
				if(tmpPageData.ParentLink == PageReference.EmptyReference)
					return CurrentPageLink;
				else
					tmpPageData = GetPage(tmpPageData.ParentLink);

				if(tmpPageData.Property.Exists("NewsGroupRoot"))
					return tmpPageData.PageLink;
			}
			return CurrentPageLink;
		}
		private PageReference GetNewsGroup()
		{
			if(CurrentPage.Property.Exists("AllowNewsItem"))
				return CurrentPageLink;

			PageData tmpPageData;
				
			if(this.IsNewPage)
				tmpPageData = GetPage(this.NewPageParent);
			else
				tmpPageData = GetPage(CurrentPageLink);

			while(!tmpPageData.Property.Exists("AllowNewsItem"))
			{		
				if(tmpPageData.ParentLink == PageReference.EmptyReference)
						return CurrentPageLink;
				else
					tmpPageData = GetPage(tmpPageData.ParentLink);
			}
			return tmpPageData.PageLink;
		}

		public PageReference NewsGroupRoot
		{
			get
			{
				if(_newsGroupRoot == EPiServer.Core.PageReference.EmptyReference)
					_newsGroupRoot = GetNewsGroupRoot();
				return _newsGroupRoot;
			}
		}
		public PageReference CurrentNewsGroup
		{
			get
			{
				if(_currentNewsGroup == EPiServer.Core.PageReference.EmptyReference)
					_currentNewsGroup = GetNewsGroup();
				return _currentNewsGroup;
			}
		}
		public int ItemPageType
		{	
			get
			{
				try
				{
					PageData newsGroupRoot = GetPage(NewsGroupRoot);		
					PropertyPageType type = (PropertyPageType)newsGroupRoot.Property["NewsGroupPageTypeID"];
					return type.PageTypeID;
				}
				catch(Exception)
				{
					return -1;
				}
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
