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
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.Security;

namespace development.UserControls
{
	
	/// <summary>
	///		Summary description for MainBody.
	/// </summary>
	public abstract class Links : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Literal interne;
		protected System.Web.UI.WebControls.Literal eksterne;
		protected System.Web.UI.WebControls.Literal other;

		private void Page_Load(object sender, System.EventArgs e)
		{
			DataBind();
			PageBase thisPage = (PageBase)Page;
			PageData pageRef;
			string link;

			// make sure the user is allowed to browse the linked page
			try 
			{
				// Check if table-header shold be shown (if at least one link is saved)
				if(thisPage.CurrentPage.Property["LinkInt1"].Value != null || thisPage.CurrentPage.Property["LinkInt2"].Value != null || thisPage.CurrentPage.Property["LinkInt3"].Value != null || thisPage.CurrentPage.Property["LinkInt4"].Value != null || thisPage.CurrentPage.Property["LinkInt5"].Value != null || thisPage.CurrentPage.Property["LinkInt6"].Value != null || thisPage.CurrentPage.Property["LinkInt7"].Value != null || thisPage.CurrentPage.Property["LinkInt8"].Value != null || thisPage.CurrentPage.Property["LinkInt9"].Value != null || thisPage.CurrentPage.Property["LinkInt10"].Value != null)
				{			
					//Check if there is a heading - else show hard coded header
					if(thisPage.CurrentPage.Property["LinkIntHeader"].Value != null)
					{
						link = thisPage.CurrentPage.Property["LinkIntHeader"].ToString();
					}
					else
					{
						link = "Se også";
					}	

					// Print out heading for links
					interne.Text = "<DIV class=\"relations\"><DIV class=\"title\">" + link + "</DIV></div>";
				}
				else
				{
					interne.Visible = false;
				}

				interne.Text = interne.Text + "<table name=\"dominik\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
				for(int j = 1; j < 11; j++)
				{
					try
					{
						// Link
						if(thisPage.CurrentPage.Property["LinkInt" + j].Value != null)
						{
							object linkIntProperty = thisPage.CurrentPage["LinkInt" + j];

							//If a text for the link is saved use that - else use the link 
							if(thisPage.CurrentPage["LinkIntName" + j] != null)
							{
								link = thisPage.CurrentPage["LinkIntName" + j].ToString();
							}
							else
							{
								if (linkIntProperty is PageReference)
								{
									link = Global.EPDataFactory.GetPage((PageReference)thisPage.CurrentPage["LinkInt" + j]).PageName;
								}
								else
								{
									link = Global.EPDataFactory.GetPage((PageReference)PageReference.ParseUrl(Global.EPConfig.HostUrl + thisPage.CurrentPage["LinkInt" + j].ToString())).PageName;
								}
							}					

							string url = "";
							if (linkIntProperty is PageReference)
							{
								url = Global.EPDataFactory.GetPage((PageReference)thisPage.CurrentPage["LinkInt" + j]).LinkURL;
							}
							else
							{
								url = Global.EPDataFactory.GetPage((PageReference)PageReference.ParseUrl(Global.EPConfig.HostUrl + thisPage.CurrentPage["LinkInt" + j].ToString())).LinkURL;
							}
							interne.Text = interne.Text + "<tr><td class=\"content\" valign=\"top\" align=\"right\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"7\" height=\"1\"><a href=\"" + url + "\"><img src=\"/images/arrow-red.gif\" alt=\"\" width=\"6\" height=\"10\" class=\"arrow-right\" hspace=\"5\"></a>&nbsp;</td>" +
								"<td class=\"link\" width=\"95%\"><a " + getTarget(url) + " href=\"" + url + "\">" + link + "</a></td><td>&nbsp;&nbsp;</td></tr>";
							interne.Text = interne.Text + "<tr><td colspan=\"3\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"1\" height=\"10\"></td></tr>";
						}
					}
					catch(EPiServerException ex)
					{
						System.Diagnostics.Debug.WriteLine(ex.ToString());
					}
				}
				interne.Text = interne.Text + "</table>";
			
			}
			catch (Exception ex)
			{
				interne.Text = interne.Text + "</table>";
				System.Diagnostics.Debug.WriteLine(ex.ToString());
			}
			
								
			// EKSTERNE LENKER
			// Check if table-header shold be shown (if at least one link is saved)
			if(thisPage.CurrentPage.Property["LinkExt1"].Value != null || thisPage.CurrentPage.Property["LinkExt2"].Value != null || thisPage.CurrentPage.Property["LinkExt3"].Value != null || thisPage.CurrentPage.Property["LinkExt4"].Value != null || thisPage.CurrentPage.Property["LinkExt5"].Value != null || thisPage.CurrentPage.Property["LinkExt6"].Value != null || thisPage.CurrentPage.Property["LinkExt7"].Value != null || thisPage.CurrentPage.Property["LinkExt8"].Value != null || thisPage.CurrentPage.Property["LinkExt9"].Value != null || thisPage.CurrentPage.Property["LinkExt10"].Value != null)
			{	
				//Check if there is a heading - else show hard coded header
				if(thisPage.CurrentPage.Property["LinkExtHeader"].Value != null)
				{
					link = thisPage.CurrentPage.Property["LinkExtHeader"].ToString();
				}
				else
				{
					link = "Eksterne lenker";
				}	
				
				eksterne.Text = "<DIV class=\"relations\"><DIV class=\"title\">" + link + "</DIV></DIV>";
				
				eksterne.Text = eksterne.Text + "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
				for(int i = 1; i < 11; i++)
				{
				
					// Link
					if(thisPage.CurrentPage.Property["LinkExt" +i].Value != null)
					{
		
						//If a text for the link is saved use that - else use the link 
						if(thisPage.CurrentPage["LinkExtName" +i] != null)
						{
							link = thisPage.CurrentPage["LinkExtName" +i].ToString();
						}
						else
						{
							link = thisPage.CurrentPage["LinkExt" +i].ToString();
						}					
						eksterne.Text = eksterne.Text + "<tr><td class=\"content\" valign=\"top\" align=\"right\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"7\" height=\"1\"><a href=\"" + thisPage.CurrentPage["LinkExt" +i].ToString() + "\"><img src=\"/images/arrow-red.gif\" alt=\"\" width=\"6\" height=\"10\" class=\"arrow-right\" hspace=\"5\"></a>&nbsp;</td>" +
							"<td class=\"link\" width=\"95%\"><a " + getTarget(thisPage.CurrentPage["LinkExt" +i].ToString()) + " href=\"" + thisPage.CurrentPage["LinkExt" +i].ToString() + "\">" + link + "</a></td><td>&nbsp;&nbsp;</td></tr>";
						eksterne.Text = eksterne.Text + "<tr><td colspan=\"3\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"1\" height=\"10\"></td></tr>";
					}
				}
				eksterne.Text = eksterne.Text + "</table>";
				

			}
			else
			{
				eksterne.Visible = false;
			}

			// Andre LENKER
			// Check if table-header shold be shown (if at least one link is saved)
			try
			{
				if(thisPage.CurrentPage.Property["Link31"].Value != null || thisPage.CurrentPage.Property["Link32"].Value != null || thisPage.CurrentPage.Property["Link33"].Value != null || thisPage.CurrentPage.Property["Link34"].Value != null || thisPage.CurrentPage.Property["Link35"].Value != null || thisPage.CurrentPage.Property["Link36"].Value != null || thisPage.CurrentPage.Property["Link37"].Value != null || thisPage.CurrentPage.Property["Link38"].Value != null || thisPage.CurrentPage.Property["Link39"].Value != null || thisPage.CurrentPage.Property["Link310"].Value != null)
				{	
					//Check if there is a heading - else show hard coded header
					if(thisPage.CurrentPage.Property["LinkGroupName3"].Value != null)
					{
						link = thisPage.CurrentPage.Property["LinkGroupName3"].ToString();
					}
					else
					{
						link = "Lenker";
					}	
					
					other.Text = "<DIV class=\"relations\"><DIV class=\"title\">" + link + "</DIV></DIV>";
					
					other.Text = other.Text + "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
					for(int i = 1; i < 11; i++)
					{
					
						// Link
						if(thisPage.CurrentPage.Property["Link3" +i].Value != null)
						{
			
							//If a text for the link is saved use that - else use the link 
							if(thisPage.CurrentPage["Link3" +i+"Name"] != null)
							{
								link = thisPage.CurrentPage["Link3" +i+"Name"].ToString();
							}
							else
							{
								link = thisPage.CurrentPage["Link3" +i].ToString();
							}					
							other.Text = other.Text + "<tr><td class=\"content\" valign=\"top\" align=\"right\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"7\" height=\"1\"><a href=\"" + thisPage.CurrentPage["LinkExt" +i].ToString() + "\"><img src=\"/images/arrow-red.gif\" alt=\"\" width=\"6\" height=\"10\" class=\"arrow-right\" hspace=\"5\"></a>&nbsp;</td>" +
								"<td class=\"link\" width=\"95%\"><a" + getTarget(thisPage.CurrentPage["LinkExt" +i].ToString()) + " href=\"" + thisPage.CurrentPage["LinkExt" +i].ToString() + "\">" + link + "</a></td><td>&nbsp;&nbsp;</td></tr>";
							other.Text = other.Text + "<tr><td colspan=\"3\"><IMG src=\"/images/pxl.gif\" alt=\"\" width=\"1\" height=\"10\"></td></tr>";
						}
					}
					other.Text = other.Text + "</table>";
					

				}
				else
				{
					other.Visible = false;
				}
			} 
			catch
			{
				//Do nothing
			}
		}

		private string getTarget(string url)
		{
			if (!url.StartsWith("/") && !url.StartsWith(".."))
				return " target=\"_blank\" ";
			else
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
