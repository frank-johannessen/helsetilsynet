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
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Collections;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.DataAbstraction;

using System.Diagnostics;

namespace development.UserControls
{
	/// <summary>
	///		Summary description for MainBody.
	/// </summary>
	public abstract class CategoryCouncilList : UserControlBase
	{
		protected EPiServer.WebControls.Property pageBody;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here	
		}
		
		public PageDataCollection SQLgetPages(string key, int parentID, int propertydefinitionID) 
		{			
			PageDataCollection myCollection = new PageDataCollection();
			string sConnectionString = System.Configuration.ConfigurationSettings.AppSettings["EPsConnection"];
			SqlConnection myConnection = new SqlConnection(sConnectionString);
			try
			{
				myConnection.Open();
				SqlDataReader myReader = null;
				SqlCommand myCommand = new SqlCommand("sp_GetPagesByListValue", myConnection);
				myCommand.CommandType = CommandType.StoredProcedure;
				myCommand.Parameters.Add("@key", SqlDbType.VarChar,256).Value = key;
				myCommand.Parameters.Add("@parentId", SqlDbType.Int).Value = parentID;
				myCommand.Parameters.Add("@definitionID", SqlDbType.Int).Value = propertydefinitionID;				
				myReader = myCommand.ExecuteReader();
				while(myReader.Read())
				{
					PageData myPage = GetPage(new PageReference(int.Parse(myReader["fkPageID"].ToString())));
					myCollection.Add(myPage);
				}
			}
			finally 
			{
				if (myConnection!=null) myConnection.Close();
			}
			return myCollection;
		}


		protected string ListCategories()
		{
			string names = "";
			string returnString = "";
			string reports = "";
			string linken = "";
			string tempIntro = "";

			//get dynamic property and insert it into an array
			string CouncilList = "";

			if (((EPiServer.PageBase)Page).CurrentPage["CouncilList"] != null) CouncilList = ((EPiServer.PageBase)Page).CurrentPage["CouncilList"].ToString();
			
			string[] aCouncilList = CouncilList.Split(',');
		
			if(aCouncilList.Length > 0)
			{		
				reports = "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";
				
				for (int i = 0; i < aCouncilList.Length; i++)
				{		
					if (aCouncilList[i].Trim()!="") 
					{
						/* get pages from stored procedure */
						PageDataCollection pages = SQLgetPages(aCouncilList[i].Trim(),int.Parse(CurrentPage.Property["getReportListFrom"].ToString()),1306);

						if(pages.Count != 0)
						{
							// Create list of categories - with anchor link to list of articles of the specific category
							names = names + "<DIV class=\"catlink\"><a href=\"#" + i + "\">" + aCouncilList[i].Trim().ToString() + "</a></div>";
					
							//List the reports for the specific category
							reports = reports + "<tr><td valign=bottom><div class=cattitle><a name=" + i + ">" + aCouncilList[i].Trim() + "</a></div><br></tr>";
							foreach(PageData page in pages) 
							{ 
								// If the page has a property
								if (page.Property.Exists("Link"))
								{
									if (page.Property["Link"].Value != null)
									{
										//remove div-tags from link-property
										linken = Regex.Replace(page.Property["Link"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase);
									}
									else
									{
										linken = "<a href=\"" + page.LinkURL + "\">" + page.PageName +  "</a>";
									}
								}
								else
								{
									linken = "<a href=\"" + page.LinkURL + "\">" + page.PageName +  "</a>";
								}
							
								reports = reports + "<tr><td width=\"100%\"><DIV class=\"link\">" + linken + "&nbsp;";
							
								if (((EPiServer.PageBase)Page).CurrentPage.Property.Exists("ShowIntro"))
								{
									// Check if intro is to be shown on list
									if (((EPiServer.PageBase)Page).CurrentPage.Property["ShowIntro"].Value != null )
									{
										if ((page.Property["MainIntro"].Value != null) && (page.Property.Exists("MainIntro")))
										{
											tempIntro = Regex.Replace(page.Property["MainIntro"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase);
											reports = reports + "<br>" + tempIntro;
										}
									}
								}								
								reports = reports +	"</DIV><br></td></tr>";						

							} 
						}
					}
				}
				reports = reports + "</table>";
				
				returnString = names + reports;
				return returnString;
			}
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
