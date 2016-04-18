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
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.DataAbstraction;

namespace development.UserControls
{
	/// <summary>
	///		Summary description for MainBody.
	/// </summary>
	public abstract class CategoryInstitutionList : UserControlBase
	{
		protected EPiServer.WebControls.Property pageBody;
		protected System.Web.UI.WebControls.Label test;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			//DataBind();			
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
			string InstitutionList = "";

			if (((EPiServer.PageBase)Page).CurrentPage["InstitutionList"] != null)
				InstitutionList = ((EPiServer.PageBase)Page).CurrentPage["InstitutionList"].ToString();

			
			string[] aInstitutionList = InstitutionList.Split(",".ToCharArray());
			
			if(aInstitutionList.Length > 0)
			{		
				reports = "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";
				
				for (int i = 0; i < aInstitutionList.Length; i++)
				{
					if (aInstitutionList[i].Trim()!="") 
					{
						//Find all pages marked with each category
						EPiServer.PropertyCriteria criteria = new EPiServer.PropertyCriteria(); 
						criteria.Type = PropertyDataType.String; 
						criteria.Name = "InstitutionName"; // 1411
						criteria.Value = aInstitutionList[i];

						/* CHECK IF CATEGORY EXISTS IN LIST */
						criteria.StringCondition = EPiServer.Filters.StringCompareMethod.Contained;

						PropertyCriteriaCollection criterias = new PropertyCriteriaCollection(); 
						criterias.Add(criteria); 

						PageBase thisPage = (PageBase)Page;
						//PageDataCollection pages = Global.EPDataFactory.FindPagesWithCriteria((EPiServer.Core.PageReference)thisPage.CurrentPage.Property["getReportListFrom"].Value,criterias);
						PageDataCollection pages = SQLgetPages(aInstitutionList[i].Trim(),int.Parse(CurrentPage.Property["getReportListFrom"].ToString()),1411);
					
						if(pages.Count != 0)
						{
							// Create list of categories - with anchor link to list of articles of the specific category
							names = names + "<DIV class=\"catlink\"><a href=\"#" + i + "\">" + aInstitutionList[i].ToString() + "</a></div>";
					
							//List the reports for the specific category
							reports = reports + "<tr><td valign=bottom><div class=cattitle><a name=" + i + ">" + aInstitutionList[i] + "</a></div><br></tr>";
							foreach(PageData page in pages) 
							{ 
								// The template does not have a property named Link anymore - this is kept in case Htil changes their mind again
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

								//if (page.Property.Exists("DocType"))
								//{
								//if (page.Property["DocType"].Value != null)
								//	reports = reports + "(" +  page.Property["DocType"].Value.ToString() + ")<br>";
								//}

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
								
								//if (page.Property["PageTypeName"].Value.ToString() == "Tilsynsrapport - med lenkeliste")
								//{								
								//reports = reports + "&nbsp;<a href=\"" + page.LinkURL + "\">Sammendrag&nbsp;<img valign=\"absmiddle\" alt=\"\" border=\"0\" src=\"/images/arrow-red.gif\"></a>";
								//}
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
