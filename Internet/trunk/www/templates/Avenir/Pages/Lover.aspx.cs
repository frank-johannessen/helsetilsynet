/*
Copyright © 1997-2002 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using System;

namespace Avenir.Templates.Pages
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
	public partial class Lover : TemplatePage
	{
		protected System.Web.UI.WebControls.Label Label1;

        /// <summary>
        /// Returns the property Heading if set; otherwise the PageName is returned.
        /// </summary>
        protected string Heading
        {
            get
            {
                if (CurrentPage["Heading"] != null)
                {
                    return CurrentPage.Property["Heading"].ToWebString();
                }
                return CurrentPage.Property["PageName"].ToWebString();
            }
        }

        private void Page_Load(object sender, System.EventArgs e)
        {

        }

		protected string GetImage()
		{
			
			PageBase page = (PageBase)Page;
            if (page.CurrentPage.Property["Image"] != null && page.CurrentPage["Image"] != null)
				return (string)page.CurrentPage["Image"];
				
			return "";

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
