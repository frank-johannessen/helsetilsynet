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
using EPiServer;

namespace Avenir.Templates.Units.Placeable
{
	/// <summary>
	///		Summary description for Listing.
	/// </summary>
    public abstract partial class LetterHead : UserControlBase
	{
        protected System.Web.UI.HtmlControls.HtmlControl LetterFrom;
        protected System.Web.UI.HtmlControls.HtmlControl LetterTo;
        protected System.Web.UI.HtmlControls.HtmlControl LetterDate;
        protected System.Web.UI.HtmlControls.HtmlControl LetterOure;
        protected System.Web.UI.HtmlControls.HtmlControl LetterYours;

		private void Page_Load(object sender, System.EventArgs e)
		{
            if (CurrentPage["LetterFrom"] == null)
                LetterFrom.Visible = false;
            if (CurrentPage["LetterTo"] == null)
                LetterTo.Visible = false;
            if (CurrentPage["LetterDate"] == null)
                LetterDate.Visible = false;
            if (CurrentPage["LetterOure"] == null)
                LetterOure.Visible = false;
            if (CurrentPage["LetterYours"] == null)
                LetterYours.Visible = false;
        }

        public string DateOfLetter()
        {
            string ld = "";
            if (CurrentPage["LetterDate"] != null)
                ld = ((DateTime)CurrentPage["LetterDate"]).ToString("d. MMMM yyyy");
            return ld;
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
