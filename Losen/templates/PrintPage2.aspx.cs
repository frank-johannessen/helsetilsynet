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
	public class PrintPage2 : TemplatePage
	{
		
		protected System.Web.UI.WebControls.Label output;
		protected EPiServer.WebControls.Translate print;
		protected EPiServer.WebControls.Translate close;
		protected System.Web.UI.HtmlControls.HtmlInputHidden bhideimage;
		protected System.Web.UI.WebControls.Label showimagetext;
		private static bool bShow;


		private void Page_Load(object sender, System.EventArgs e)
		{

			DataBind(); bShow = true; output.Text = "";
			string strpage = getPage(Request.QueryString["url"]); 			
			strpage = Regex.Replace(strpage,"<a href.[^>]*>","",RegexOptions.IgnoreCase);
			//strpage = Regex.Replace(strpage,"<a.[^>]*>","",RegexOptions.IgnoreCase);
			strpage = strpage.Replace("</a>","");
			if (bhideimage.Value == "true") 
			{	
				showimagetext.Text = "Vis bilder";
				bhideimage.Value = "true";
				strpage = strpage.Replace("<img src=\"/images/patharrow.gif\">","<path>");
				strpage = Regex.Replace(strpage,"<img.[^>]*>","",RegexOptions.IgnoreCase);		
				strpage = strpage.Replace("<path>","<img src=\"/images/patharrow.gif\">");
			} 
			else 
			{
				showimagetext.Text = "Skjul bilder";
			}
			Match match = Regex.Match(strpage,@"<!--\s*print_start\s*-->\s*(?<val>.+?)\s*<!--\s*print_end\s*-->",RegexOptions.IgnoreCase|RegexOptions.Singleline);
			while (match.Success)
			{
				output.Text += match.Groups["val"].ToString();
				match = match.NextMatch();
			}
		}

		public static string getPage(String url) 
		{
			WebResponse result = null;
			string getpagecontent = "";

			try 
			{
				WebRequest req = WebRequest.Create(url);
				result = req.GetResponse();
				Stream ReceiveStream = result.GetResponseStream();
				Encoding encode = System.Text.Encoding.GetEncoding("utf-8");
				StreamReader sr = new StreamReader( ReceiveStream, encode );
				Console.WriteLine("\r\nResponse stream received");
				if (bShow) 
				{
					Char[] read = new Char[256];
					int count = sr.Read( read, 0, 256 );
					
					while (count > 0) 
					{
						String str = new String(read, 0, count);
						getpagecontent += str;
						count = sr.Read(read, 0, 256);
					}
					getpagecontent += "";
				}
			} 
			catch(Exception) 
			{
				getpagecontent += "\r\nThe request URI could not be found or was malformed";
			} 
			finally 
			{
				if ( result != null ) 
				{
					result.Close();
				}
			}
			return getpagecontent;
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
