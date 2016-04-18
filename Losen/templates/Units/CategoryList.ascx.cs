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
	public abstract class CategoryList : UserControlBase
	{
		protected EPiServer.WebControls.Property pageBody;
		public string output = "test";

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			DataBind();			
		}

		protected string ListCategories()
		{
			string names = "";
			string returnString = "";
			string reports = "";
			string linken = "";
			string tempIntro = "";
			
			//Get all child-categories for Emne
			Category emneCat = Category.Find("Emne");
			PageReference rStartPage = PageReference.EmptyReference;
			try 
			{
				rStartPage = (PageReference)CurrentPage["getReportListFrom"];
			}
			catch 
			{
				//DO NOTHING
			}

			if(emneCat!=null && !rStartPage.IsEmpty())
			{		
				CategoryCollection List = emneCat.Categories;
				reports = "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";				
				
				foreach (Category cat in List) 
				{					
					//Find all pages marked with each category
					EPiServer.PropertyCriteria criteria = new EPiServer.PropertyCriteria(); 
					criteria.Type = PropertyDataType.Category;
					criteria.Name = "PageCategory"; 
					criteria.Value = cat.Name.ToString(); 
					//criteria.Condition = EPiServer.Filters.CompareCondition.Equal;

					PropertyCriteriaCollection criterias = new PropertyCriteriaCollection(); 
					criterias.Add(criteria); 

					PageDataCollection pages = Global.EPDataFactory.FindPagesWithCriteria(rStartPage,criterias); 
					
					// The category (and its related pages) are only to be shown if there a assigned articles to the category
					if(pages.Count != 0)
					{
						output += cat.Name.ToString();
						// Create list of categories - with anchor link to list of articles of the specific category
						names = names + "<DIV class=\"catlink\"><a href=\"#" + cat.Description.ToString() + "\">" + cat.Name.ToString() + "</a></div>";
					
						//List the reports for the specific category
						reports = reports + "<tr><td valign=bottom><div class=cattitle><A name=" + cat.Description.ToString() + ">" + cat.Name.ToString() + "</a></div><br></tr>";
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

							// If DocType exists show it
							//if (page.Property.Exists("DocType"))
							//{
								//if (page.Property["DocType"].Value != null)
									//reports = reports + "(" +  page.Property["DocType"].Value.ToString() + ")<br>";
							//}							
							
							try 
							{
								if (((EPiServer.PageBase)Page).CurrentPage.Property.Exists("ShowIntro"))
								{
									// Check if intro is to be shown on list
									if (((EPiServer.PageBase)Page).CurrentPage.Property["ShowIntro"].Value != null )
									{
										if (page.Property.Exists("MainIntro") && page.Property["MainIntro"].Value!=null) 
										{
											tempIntro = Regex.Replace(page.Property["MainIntro"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase);
											reports = reports + "<br>" + tempIntro;
										}
									}
								}
							}
							catch 
							{
								//DO NOTHING
							}
							
			
							//if (page.Property["PageTypeName"].Value.ToString() == "Tilsynsrapport - med lenkeliste")
							//{								
								//reports = reports + "&nbsp;<a href=\"" + page.LinkURL + "\">Sammendrag&nbsp;<img valign=\"absmiddle\" alt=\"\" border=\"0\" src=\"/images/arrow-red.gif\"></a>";
							//}
							reports = reports +	"</DIV><br></td></tr>";						

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
