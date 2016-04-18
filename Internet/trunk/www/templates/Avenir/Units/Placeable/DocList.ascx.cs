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

namespace Avenir.Templates.Units.Placeable
{
	/// <summary>
	///		Summary description for Listing.
	/// </summary>
	public abstract partial class DocList : System.Web.UI.UserControl
	{
		protected EPiServer.Web.WebControls.Translate Translate3;
		protected EPiServer.Web.WebControls.NewsList NewsList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Only pages of type "Dokument" are to be listed
			EPiServer.Filters.FilterCompareTo filterCompareTo = new EPiServer.Filters.FilterCompareTo("PageTypeID", "83");
			NewsList.Filter += filterCompareTo.Filter;
			DataBind();
		}

		// To ensure there's always a value for Sort
		protected int GetSortOrder()
		{
		    if(((EPiServer.PageBase)Page).CurrentPage["DocListSort"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["DocListSort"];
		    return 8;
		}

	    // To ensure there's always a value for ListingCount
		protected int GetCount()
		{
		    if(((EPiServer.PageBase)Page).CurrentPage["DocListCount"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["DocListCount"];
		    return -1;
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
		///	Required method for Designer support - do not modify
		///	the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
