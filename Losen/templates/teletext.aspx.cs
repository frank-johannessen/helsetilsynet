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
using System.Net;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace development.templates
{
	/// <summary>
	/// Summary description for teletext.
	/// </summary>
	/// 

	public class teletext : System.Web.UI.Page
	{

		protected System.Web.UI.WebControls.Literal output;
		private static bool bShow;

		private void Page_Load(object sender, System.EventArgs e)
		{
			bShow = true;
			string url = "http://www.vg.no";
			string strpage = getHttpPage(url);	
			//strpage = Regex.Replace(strpage,"<a href.[^>]*>","",RegexOptions.IgnoreCase);
			strpage = Regex.Replace(strpage,"src=\"/","src=\"" + url + "/",RegexOptions.IgnoreCase);

			//Match match = Regex.Match(strpage,@"<!--\s*print_start\s*-->\s*(?<val>.+?)\s*<!--\s*print_end\s*-->",RegexOptions.IgnoreCase|RegexOptions.Singleline);
			
			/*
			strpage = Regex.Replace(strpage,"</a>","§",RegexOptions.IgnoreCase);
			string newpage = ""; int idcount = 0;
			for (int x=0; x<strpage.Length; x++) 
			{
				idcount++; 
				string mychar = strpage[x].ToString();
				if (mychar == "§") 
				{
					mychar = idcount.ToString() + "</a>";
				} 
				else 
				{
					newpage += mychar;
				}
			}

			output.Text = "<textarea rows=5 cols=80>" + strpage + "</textarea>";
			output.Text += strpage;
			*/
		}

		public static string getHttpPage(String url) 
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
