/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

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
	public partial class NotFound : SimplePage
	{
       protected override void OnLoad(EventArgs e)
       {
           base.OnLoad(e);
           //Response.StatusCode = 404;
           //Response.Status = "404 File Not Found";
           Master.NoMenu();
       }

       //private void Page_Load(object sender, System.EventArgs e)
       // {			
       //     if (!IsPostBack)
       //     {
       //         Response.StatusCode = 404;
       //         Response.Status = "404 File Not Found";
       //     }
       // }

		protected override void SetCachePolicy()
		{
			//Do nothing
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
            //InitializeComponent();
            //base.OnInit(e);

            //int errorPageID = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["EPsErrorPageID"]);
            //this.CurrentPage = GetPage(new PageReference(errorPageID));
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
        //private void InitializeComponent()
        //{    
        //    this.Load += new System.EventHandler(this.Page_Load);
        //}
		#endregion
	}
}
