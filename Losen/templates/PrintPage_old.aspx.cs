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
using System.Net;
using System.IO;
using System.Text;
using EPiServer;
using System.Text.RegularExpressions;

namespace development
{
	/// <summary>
	/// Summary description for Page.
	/// </summary>
	public class PrintPage_old : TemplatePage
	{
		
		protected System.Web.UI.WebControls.Label output;
		protected System.Web.UI.HtmlControls.HtmlInputHidden bhideimage;
		protected System.Web.UI.WebControls.Label showimagetext;
		protected System.Web.UI.WebControls.Literal printtitle;

		private void Page_Load(object sender, System.EventArgs e)
		{
			string strpage = "";
			strpage = ((EPiServer.PageBase)Page).CurrentPage["MainBody"].ToString();
			Response.Write(strpage);

			/* remove links from pagedata */			
			strpage = Regex.Replace(strpage,"<a href.[^>]*>","",RegexOptions.IgnoreCase);
			strpage = strpage.Replace("</a>","");			

			/* remove images from pagedata */			
			if (bhideimage.Value == "true") 
			{	
				showimagetext.Text = "Vis bilder";
				bhideimage.Value = "true";				
				strpage = Regex.Replace(strpage,"<img.[^>]*>","",RegexOptions.IgnoreCase);						
			} 
			else 
			{
				showimagetext.Text = "Skjul bilder";
			}

			//output.Text = strpage;
		}

	}
}
