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
using System.Web.UI;
using EPiServer;
using System;
using EPiServer.Core.Html;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Util;


namespace Avenir.Templates.Units.Placeable
{
	/// <summary>
	///		Summary description for MainBody.
	/// </summary>
	public abstract partial class PageBody : System.Web.UI.UserControl
	{
		protected EPiServer.Web.WebControls.Property pageBody;

		private void Page_Load(object sender, System.EventArgs e)
		{
            if (CurrentPage.PageLink.ToString() == "10605")
            {
                pageBody.Visible = true;
            }
		}

	    protected string GetBody
	    {
            get
            {
                if (CurrentPage.PageLink.ToString() == "10605") //side med lag lenke til RSS
                {
                    return "";
                }
                string s = string.Empty;
                if (CurrentPage.Property["MainBody"] != null && CurrentPage.Property["MainBody"].ToString() != string.Empty)
                {
                    try{
                    s = CurrentPage.Property["MainBody"].ToWebString();
                    s = EditorSavedEvent.ReplacePdfLinks(s);
                    pageBody.Visible = false;
                    }
                    catch(Exception e)
                    {
                    }
                }
	            return s;
	        }
	    }

        PageData _currentPage = null;
        public PageData CurrentPage
        {
            get
            {
                if (_currentPage == null)
                {
                    _currentPage = FindCurrentPage(this);
                }

                return _currentPage;
            }
        }
        private static PageData FindCurrentPage(Control ctr)
        {
            if (ctr is IPageSource)
            {
                return (ctr as IPageSource).CurrentPage;
            }

            if (ctr.Parent != null)
            {
                return FindCurrentPage(ctr.Parent);
            }

            return null;
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
