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
	///		Summary description for Conference.
	/// </summary>
	public abstract class Conference : UserControlBase// System.Web.UI.UserControl
	{
		private bool								_editMode;
		protected EPiServer.WebControls.Property	WriterName,MainBody,PageName;
		protected System.Web.UI.WebControls.Button	publish;
		protected LinkButton						DeleteButton;
		private PageReference						_treeRoot,_nextPage,_previousPage;
		protected System.Web.UI.WebControls.Panel	PreviousPageLink, NextPageLink, Change, 
													Delete, ViewPanel, EditPanel, StartPage,
													CreateNew, Reply;
		protected bool								_newPost;
		private int									_pagetypeID;

		private void Page_Load(object sender, System.EventArgs e)
		{
			CheckEditMode();
			
			if(_editMode)
			{
				EditPanel.Visible = true;
			}
			else if(IsRootPage())
			{
				StartPage.Visible = true;
				if(((PageBase)Page).CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Publish))
					CreateNew.Visible = true;
			}			
			else
			{
				ViewPanel.Visible = true;
				if(((PageBase)Page).CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Publish))
				{
					Reply.Visible = true;				
					if (PageBase.CurrentUser.Sid == CurrentPage.ACL.Creator || (CurrentPage.QueryAccess() & EPiServer.Security.AccessLevel.Administer) == EPiServer.Security.AccessLevel.Administer)
						Change.Visible = true;					
				}

				if(((PageBase)Page).CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Delete))
				{
					if (PageBase.CurrentUser.Sid == CurrentPage.ACL.Creator || (CurrentPage.QueryAccess() & EPiServer.Security.AccessLevel.Administer) == EPiServer.Security.AccessLevel.Administer)
					{
						Delete.Visible = true;
						AddDeleteConfirmationScript();
					}
				}				
				CreateParentTree();
				
				if(_previousPage != PageReference.EmptyReference)
					PreviousPageLink.Visible = true;
				if(_nextPage != PageReference.EmptyReference)
					NextPageLink.Visible = true;
			}
			if(!IsPostBack)
				DataBind();
		}

		protected string GetCurrentUserName()
		{
			if (PageBase.CurrentUser.Identity.IsAuthenticated)
				return PageBase.CurrentUser.UserData.FirstName + " " + PageBase.CurrentUser.UserData.LastName;
			else
				return "";
		}

		protected void CheckEditMode()
		{
			if (Request.Params["parent"] != null)
			{
				_newPost	= true;
				_editMode	= true;
				PageName.InnerProperty.IsRequired	= false;
				PageName.InnerProperty.Value		= string.Empty;
				WriterName.InnerProperty.Value		= string.Empty;
				MainBody.InnerProperty.Value		= string.Empty;
				PageName.InnerProperty.IsRequired	= true;

				_pagetypeID = Int32.Parse(Request.QueryString["type"]);
			}
			else if(Request.Params["change"] != null)
			{
				_newPost	= false;
				_editMode	= true;
				PageName.InnerProperty.IsRequired = true;
			}
			else
			{
				_newPost	= true;
				_editMode = false;
			}
		}
		protected PageReference TreeRoot
		{
			get
			{
				if(_editMode)
					_treeRoot = PageReference.EmptyReference;
				else
					_treeRoot = ((PageBase)Page).CurrentPageLink;

				return _treeRoot;
			}
		}
		protected void CreateParentTree()
		{
			_previousPage  =	PageReference.EmptyReference;
			_nextPage =			PageReference.EmptyReference;

			PageDataCollection siblings = Global.EPDataFactory.GetChildren(((PageBase)Page).CurrentPage.ParentLink);

			bool passedCurrentPage = false;
			foreach(PageData currentPage in siblings)
			{
				if(_nextPage != PageReference.EmptyReference)
					break;
				if(((PageBase)Page).CurrentPage.PageLink.ID == currentPage.PageLink.ID)
				{
					passedCurrentPage = true;
					continue;
				}
				else if(!passedCurrentPage)
					_previousPage = currentPage.PageLink;
				else
					_nextPage = currentPage.PageLink;	
			}
		}

		protected string NextPageURL
		{
			get
			{
				string URL = String.Empty;
				if(_nextPage != PageReference.EmptyReference)
					URL = ((PageBase)Page).GetPage(_nextPage).LinkURL;
				return URL;
			}
		}

		protected string PreviousPageURL
		{
			get
			{
				string URL = String.Empty;
				if(_previousPage != PageReference.EmptyReference)
					URL = ((PageBase)Page).GetPage(_previousPage).LinkURL;
				return URL;
			}
		}

		protected void DeletePage(object sender, System.EventArgs e)
		{
			PageReference parentPage = ((PageBase)Page).CurrentPage.ParentLink;
			Global.EPDataFactory.Delete( ((PageBase)Page).CurrentPageLink, true );

			PageData parentData = ((PageBase)Page).GetPage(parentPage);

			Response.Redirect(parentData.LinkURL,true);
		}	

		protected bool IsRootPage()
		{
			if(((PageBase)Page).CurrentPage["ConferenceContainer"] != null &&((PageReference)((PageBase)Page).CurrentPage["ConferenceContainer"]) == ((PageBase)Page).CurrentPage.PageLink)
				return true;
			else
				return false;
		}
		private void AddDeleteConfirmationScript()
		{
			Page.RegisterStartupScript("DeleteConfirmation",@"
			<script language='JavaScript'>
			<!--
				function OnDelete()
				{
					return confirm('" + ((PageBase)Page).Translate("#deleteconfirm") + @"');
				}
				document.all['" + DeleteButton.ClientID + @"'].attachEvent('onclick',OnDelete);
			// -->
			</script>");
		}
		protected void SavePage(object sender, System.EventArgs e)
		{
			if(_newPost)
			{
				Page.Validate();
				if(!Page.IsValid)
				{
					Page.DataBind();
					return;
				}
				PageData newPage		= Global.EPDataFactory.GetDefaultPageData(((PageBase)Page).CurrentPageLink,_pagetypeID);
				newPage.PageName		= PageName.InnerProperty.Value.ToString();
				if(!MainBody.InnerProperty.IsNull)
					newPage["MainBody"]		= MainBody.InnerProperty.Value.ToString();
				if(!WriterName.InnerProperty.IsNull)
					newPage["WriterName"]	= WriterName.InnerProperty.Value.ToString();

				Global.EPDataFactory.Save(newPage, EPiServer.DataAccess.SaveAction.Publish);
				Response.Redirect("Conference.aspx?id=" + newPage.PageLink.ID);
			}
			else
			{
				Global.EPDataFactory.Save(((PageBase)Page).CurrentPage, EPiServer.DataAccess.SaveAction.Publish);
				Response.Redirect("Conference.aspx?id=" + ((PageBase)Page).CurrentPageLink.ID);
			}
		}
		protected void CheckIf_newPost()
		{
			if (Request.Params["Parent"] != null)
			{
				_newPost = true;
			}
			else
				_newPost = false;
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
