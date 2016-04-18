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
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using System;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Collections;


namespace development.templates.Units
{
	/// <summary>
	///		Summary description for Search.
	/// </summary>
	public abstract class Search : UserControlBase
	{
		protected TextBox				SearchQuery;
		protected TextBox				Query2;
		protected CheckBox				SearchFiles;
		protected HtmlGenericControl	SearchHelp,Message;
		//protected System.Web.UI.WebControls.Button SearchButton;
		protected System.Web.UI.WebControls.ImageButton SearchButton;
		protected EPiServer.WebControls.Translate Translate1;
		protected System.Web.UI.WebControls.CheckBox OnlyWholeWords;
		protected EPiServer.WebControls.Translate Translate2;
		protected EPiServer.WebControls.Translate Translate6;
		protected EPiServer.WebControls.Translate Translate4;
		protected EPiServer.WebControls.Property Property1;
		protected EPiServer.WebControls.Translate Translate3;
		protected System.Web.UI.WebControls.DropDownList DropDownList1;
		protected System.Web.UI.WebControls.DropDownList KeyWordDropdownlist;
		protected EPiServer.WebControls.PageList Listing1;
		protected EPiServer.WebControls.PageList Pagelist1;
		protected EPiServer.WebControls.PageList Pagelist2;
		protected System.Web.UI.WebControls.CheckBox title;
		protected System.Web.UI.WebControls.CheckBox SortDate;
		protected System.Web.UI.WebControls.CheckBox Tilsyn;
		protected System.Web.UI.WebControls.CheckBox News;
		protected EPiServer.WebControls.Property Property4;
		protected EPiServer.WebControls.Property Property3;
		protected EPiServer.WebControls.Property Property2;
		protected EPiServer.WebControls.Property Property5;
		protected EPiServer.WebControls.Property Property6;
		protected EPiServer.WebControls.Property Property7;
		protected EPiServer.WebControls.Property Property8;
		protected PageSearch			SearchResults;
		protected System.Web.UI.HtmlControls.HtmlTable HelpTextTable;
		protected EPiServer.WebControls.FileTree Filetree1;
		protected string DirList = "";
		public PageDataCollection sortedPageList = new PageDataCollection();		
		protected DataView								fileResultsDW;
		protected System.Web.UI.WebControls.Repeater	rptResultsByCategory;
		protected DataTable								pageHitsDT = new DataTable("PageHits");

		private enum SORTBY { RANK, DATE };
		private SORTBY sortBy = SORTBY.RANK;


		/// <summary>
		/// Adds all submenuitems for a main search item, IF it has 
		/// set that subitems should be added/make searchable.
		/// E.g.: 'Aktuelt 2002' will be added to dropdown after "Aktuelt"
		/// if property "IncludeChildNodesInSeachX" i set.  
		/// </summary>
		/// <param name="containerName"></param>
		/// <param name="pageID"></param>
		/// <param name="pageName"></param>
		/// <param name="typeID"></param>
		/// <returns></returns>
		/// 

		private sealed class SortPagesByDateComparer : IComparer
		{
			public int Compare(object firstObject, object secondObject)
			{
				PageData firstPage = (PageData) firstObject;
				PageData secondPage = (PageData) secondObject;
				string firstProperty = "PageStartPublish";
				string secondProperty = "PageStartPublish";
				if (firstPage[firstProperty]==null) firstProperty = "PageChanged";
				if (secondPage[secondProperty]==null) secondProperty = "PageChanged";
				DateTime firstDate = DateTime.Parse(firstPage[firstProperty].ToString());
				DateTime secondDate = DateTime.Parse(secondPage[secondProperty].ToString());
				return secondDate.CompareTo(firstDate);
			}
		}

		public class PublishDateComparer : IComparer
		{
			public int Compare(object obj1, object obj2)
			{
				PageData pd1 = obj1 as PageData;
				PageData pd2 = obj2 as PageData;

				if (pd1.StartPublish < pd2.StartPublish)
					return 1;
				if (pd1.StartPublish > pd2.StartPublish)
					return -1;

				return 0;
			}
		}
		
		
		protected string MakeSectionDropdown (string VisibleInMenu, string pageName, PageReference typeID)
		{
			IPageSource thisPage = (IPageSource)Page;
			PageData thisData;

			thisData = thisPage.CurrentPage;
			if (! IsPostBack )
			{
				if (VisibleInMenu == "True")
					this.DropDownList1.Items.Add(new ListItem(pageName, typeID.ToString()));
			}
			return "";
		}
		
		
		protected void MakeKeyWordListDropdown ()
		{
			//
			KeyWordDropdownlist.Items.Add(new ListItem(((EPiServer.PageBase)Page).CurrentPage.VisibleInMenu.ToString(), "test"));
		}

		public PageDataCollection getSortedCollection() 
		{
			sortedPageList.Sort(new SortPagesByDateComparer());
			return sortedPageList;
		}

		public string AddToPageList(PageData mypage) 
		{
			sortedPageList.Add(mypage); return "";
		}
		
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			
			
			
			MakeKeyWordListDropdown();
			//if (SortDate.Checked) SearchResults.MaxCount = 100;
			
			SearchButton.ImageUrl = "/images/search.gif";
			if (((EPiServer.PageBase)Page).CurrentPage["SearchButtonEnglish"] != null)
				SearchButton.ImageUrl = "/images/search_eng.gif";

			DropDownList1.Items[0].Text = ((EPiServer.PageBase)Page).CurrentPage["SearchDropDownFormText"].ToString();
			DropDownList1.Items[0].Value = ((EPiServer.PageBase)Page).CurrentPage["MainContainer"].ToString();
			
			string selectedVal;
			int istartID;
			PageReference page;
							
			selectedVal = DropDownList1.SelectedItem.Value.ToString();
			istartID = Convert.ToInt16(selectedVal);
			page = new PageReference(istartID);
			SearchResults.PageLink = page;

			if (SortDate.Checked == true) 
			{
				//SearchResults.SortBy = null;
				//EPiServer.Filters.FilterSort filterSort = new EPiServer.Filters.FilterSort ( EPiServer.Filters.FilterSortOrder.PublishedDescending );
				//SearchResults.Filter += new EPiServer.WebControls.FilterEventHandler( filterSort.Filter );
			}
			
			if (Tilsyn.Checked == true) 
			{
				EPiServer.Filters.FilterCompareTo filterCompareTo = new EPiServer.Filters.FilterCompareTo ("PageTypeID", "100");
				SearchResults.Filter += new EPiServer.WebControls.FilterEventHandler( filterCompareTo.Filter );
			}

			if (News.Checked == true) 
			{
				EPiServer.Filters.FilterCompareTo filterCompareTo = new EPiServer.Filters.FilterCompareTo ("PageTypeID", "101");
				SearchResults.Filter += new EPiServer.WebControls.FilterEventHandler( filterCompareTo.Filter );
			}

			//drop pages with property "DummyPage" = true
			//SearchResults.Filter += new FilterEventHandler(SearchFilter);
			this.SearchResults.Filter += new FilterEventHandler(SearchResults_Filter);

			try 
			{
				Page.RegisterStartupScript("FocusToInput",String.Format("<script>document.all['{0}'].focus();</script>",SearchQuery.ClientID));
				Page.RegisterClientScriptBlock("SearchHelp", "<script language='javascript'>function ToggleHelp(){" + SearchHelp.ClientID + ".style.display=(" + SearchHelp.ClientID + ".style.display=='none' ? 'block':'none');}</script>");
				SearchHelp.InnerHtml = Global.EPLang.Translate("/templates/search/help");

				if ( IsPostBack )
				{
					//Response.Write("postback");
					SearchHelp.Style["display"] = "none";
					Message.Style["display"] = "none";

					//Hide keyword search after posting freetext search
					HelpTextTable.Visible = false;
					
					// Make sure all words are treated with OR in search (+ in front of the word)
					string words2 = "";
					string[] words = SearchQuery.Text.Split (' ');
					foreach(string x in words)
					{
						if((x.StartsWith("+") == false) && (x.StartsWith("-") == false))
						{
							words2 = words2 + "+" + x + " ";
						}
						else
						{
							words2 = words2 + x + " ";
						}
						Query2.Text = words2;
					}
					
				}
				else if (SearchQuery.Text.Length == 0)
				{
					try
					{
						if(Request.QueryString["quicksearchquery"] != null)
						{	
							//Hide keyword search after posting freetext search
							HelpTextTable.Visible = false;
							
							SearchQuery.Text = HttpContext.Current.Server.UrlDecode(Request.QueryString["quicksearchquery"]);
							// Make sure all words are treated with OR in search (+ in front of the word)
							string words2 = "";
							string[] words = SearchQuery.Text.Split (' ');
							foreach(string x in words)
							{
								if((x.StartsWith("+") == false) && (x.StartsWith("-") == false))
								{
									words2 = words2 + "+" + x + " ";
								}
								else
								{
									words2 = words2 + x + " ";
								}
								Query2.Text = words2;
							}
							HandleSearch();
						}
					}
					catch(Exception) { } /* don't care */
				}
			}
			catch (Exception exc)
			{
				HandleError(exc);
			}
			DataBind();
		}


		public string StrLength(string FileName)
		{
			string Str = FileName;
			Str = Str.Replace("_"," ");
			return Str;
		}
		
		
		public string HitString()
		{
			int countResult = SearchResults.DataCount;
			string text1 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount1"].ToString();
			string text2 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount2"].ToString();
			string text3 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount3"].ToString();
			string text4 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount4"].ToString();
			string text6 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount5"].ToString();
			string text5 = "";
			string total = "";
			int MaxNumber = 100;

			if (countResult >= MaxNumber)
			{
				text5 = text4 + " " + "100";//SearchResults.MaxCount.ToString();
				text3 = text6;
			}
			else
			{
				text5 = countResult.ToString();
			}
			total = text1 + " \"" + SearchQuery.Text + "\" "+ text2 + " " + text5 + " " + text3;
			
			return total;
		}
		public string HitString2()
		{
			int countResult = SearchResults.DataCount;
			string text1 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount1"].ToString();
			string text2 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount2"].ToString();
			string text3 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount3"].ToString();
			string text4 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount4"].ToString();
			string text6 = ((EPiServer.PageBase)Page).CurrentPage["SearchHitCount5"].ToString();
			string text5 = "";
			string total = "";
			int MaxNumber = 100;

			if (countResult >= MaxNumber)
			{
				text5 = text4 + " " + "100";//SearchResults.MaxCount.ToString();
				text3 = text6;
			}
			else
			{
				text5 = rptResultsByCategory.Items.Count.ToString(); 
			}
			total = text1 + " \"" + SearchQuery.Text + "\" "+ text2 + " " + text5 + " " + text3;
			
			return total;
		}
		public string SearchHitResult()
		{
			string textString = ((EPiServer.PageBase)Page).CurrentPage["SearchHitResult"].ToString();
			return textString;
		}
		
		
		protected virtual void HandleError(Object sender, EventArgs e)
		{
			HandleError(Server.GetLastError());
		}

		private void HandleError(Exception e)
		{
			string errorMessage;

			if (e.Message.ToLower().IndexOf("index server") > -1)
			{
				errorMessage = Global.EPLang.Translate("/templates/search/indexservererror");
				SearchFiles.Checked = false;
				SearchFiles.Enabled = false;
			}
			else
			{
				errorMessage = "*** Error: " + e.Message + " (" + e.Source + ")";

				//throw new Exception(errorMessage, e);
			}

			Message.InnerHtml = String.Format("<font size=\"2\"color=\"aa0000\"><b>{0}</b></font>", errorMessage);
			Message.Style["display"] = "block";
		}

		private void HandleSearch()
		{
			try
			{
				//fileResultsDW=DoFileSearch();
				//SearchResults.SearchFiles=false;
				//SearchResults.DataBind();
				//rptFileResults.DataSource = fileResultsDW;
				//rptFileResults.DataBind();
			}
			catch (Exception e)
			{
				HandleError(e);
			}
		}

		private DataView DoFileSearch()
		{
			// Catalog Name
			DataView source = null;
			//char QUOT = '"';


			try
			{
				string strCatalog = Convert.ToString(CurrentPage["MainCatalog"]);
				string scope = Convert.ToString(CurrentPage["MainScope"]);
				
				string strQuery;
				
				string[] words=SearchQuery.Text.ToString().Split(' ');
				string contains="";
				foreach (string word in words)
				{
					if(contains=="")
						contains+=" CONTAINS ('"+word+"')";
					else
						contains+=" AND CONTAINS ('"+word+"')";
				}
				
				string underPath="";
				if(DropDownList1.SelectedIndex!=0)
					underPath=DropDownList1.SelectedItem.Text;


				string path=Server.MapPath("//upload//"+underPath+"//");
				strQuery=BuildDynamicSearchQuery(path);
				strQuery += " WHERE "+ contains;
				string connstring = "Provider=MSIDXS;Data Source="+strCatalog;

				System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(connstring);
				conn.Open();

				System.Data.OleDb.OleDbDataAdapter cmd = new System.Data.OleDb.OleDbDataAdapter(strQuery, conn);

				System.Data.DataSet testDataSet = new System.Data.DataSet();

				cmd.Fill(testDataSet, "SearchResults");
				source = new DataView(testDataSet.Tables["SearchResults"]);
			}
			catch (Exception e)
			{
				//HandleError(e);
			}

			return source;
		}

		protected void SearchButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			HandleSearch();
		}

		protected void SearchQuery_TextChanged(object sender, System.EventArgs e)
		{
			HandleSearch();
		}

		protected void Tilsyn_Checked(object sender, System.EventArgs e)
		{
			HandleSearch();
		}

		protected void title_Checked(object sender, System.EventArgs e)
		{
			HandleSearch();
		}

		protected void Regel_Checked(object sender, System.EventArgs e)
		{
			HandleSearch();
		}

		protected void SortDate_Checked(object sender, System.EventArgs e)
		{
			if(SortDate.Checked)//HandleSearch();
				sortBy = SORTBY.DATE;
			else
				sortBy = SORTBY.RANK;
			HandleSearch();
		}

		protected void News_Checked(object sender, System.EventArgs e)
		{
			HandleSearch();
		}

		public void SearchFilter(object sender, FilterEventArgs e)
		{
			/*PageDataCollection pages = e.Pages;
			PageData pageData;
			bool match;

			for (int i = 0; i < pages.Count; i++)
			{
				pageData = pages[i];
				match = true;

				if (pageData["DummyPage"] != null && (bool)pageData["DummyPage"])
				{
					match = false;
				}

				if (!match)
				{
					pages.RemoveAt(i);
					i --;
				}
			}*/
			
		}

		public string GetMainScope() 
		{
			string mainScope = "";
			string [] list = DirList.Split(',');
			string DropDownItem = "";
			try 
			{
				DropDownItem = DropDownList1.SelectedItem.Text.Substring(0,4);
			}
			catch 
			{
			}
			
			foreach(string x in list)
			{
				if (DropDownItem.ToLower().ToString() == x.ToLower().ToString())
				{
					mainScope = EPiServer.Global.BaseDirectory + @"upload/";
					mainScope = mainScope + DropDownList1.SelectedItem.Text + "/";
					mainScope = mainScope.Replace("/",@"\");
				}
			}
			
			if (DropDownList1.SelectedItem.Value == ((EPiServer.PageBase)Page).CurrentPage["MainContainer"].ToString())
				mainScope = "";
			
			return mainScope;
		}


		public string GetDirName(string DirName) 
		{
			string temp = "";
			bool ToIntValue;
			
			try
			{
				Convert.ToInt32(DirName);
				ToIntValue = true;
			}
			catch
			{
				ToIntValue = false;
			}

			if (!ToIntValue) 
			{
				temp = DirName.Substring(0,4);
				if (DirList == "")
					DirList += temp;
				else 
					DirList += "," + temp;
			}
			return "";
		}

		public string FileDate(string DateOnFile) 
		{
			string temp = DateOnFile.Trim();
			try
			{
				temp = temp.Substring(0,10);
			}
			catch
			{
				temp = temp;
			}
			return temp;
		}

		/*public string ReturnFileInfo(string path)
		{
			int recordIndex=fileResultsDW.Find(path);
			return fileResultsDW[recordIndex]["Characterization"].ToString();
		}*/
		public string ReturnFileInfo(string FileName)
		{
		/*	try
			{
				//fileResultsDW=DoFileSearch();
				/*Dim dv As DataView
				Dim i As Integer
				Dim vals(1) As Object
				dv = New DataView(t)
				dv.Sort = "Cusomers"
				' Find the customer named "John Smith".
				vals(0)= "John"
				vals(1) = "Smith"
				i = dv.Find(vals)
				Console.WriteLine(dv(i))*/
				/*Object val = FileName.ToString();
				fileResultsDW.Sort="Filename";*/
		/*		int recordIndex=fileResultsDW.Find(val);
				return "<br/>"+fileResultsDW[recordIndex]["Characterization"].ToString();
			}
			catch
			{
				return "";
			}*/
			return "";
		}

		public string GetFileURL(string path)
		{
			string physicalPath = Request.PhysicalApplicationPath;
			string url = Global.EPConfig.HostUrl + "/";
			
			url += path.ToLower().Replace(physicalPath.ToLower(), "");

			return url;
		}

		public string GetFileIcon(string path)
		{
			string ext = path.Substring(path.Length-3, 3).ToLower();
			string icon;

			switch (ext)
			{
				case "doc":
					icon = "doc.gif";
					break;


				case "xls":
					icon = "xls.gif";
					break;


				case "ppt":
					icon = "ppt.gif";
					break;


				case "pdf":
					icon = "pdf.gif";
					break;

				
				default:
					icon = "default.gif";
					break;
			}

			return icon;
		}

		private void SearchResults_Filter(object sender, EPiServer.Filters.FilterEventArgs e)
		{
			//List all categories with hit count > 0

		/*	int []categoryHits = new int[1000];
			int hitsOther = 0; //Hits with no category
*/			
/*
			Category rootCat = Category.GetRoot();

			foreach (Category cat in rootCat.Categories)
			{
				foreach (PageData pd in e.Pages)
				{
					if (pd.Category.MemberOf(cat.ID))
					{
						categoryHits[cat.ID]++;
					}

					if (pd.Category.Count == 0)
						hitsOther++;
				}
			}

			//Other is counted on time for each category, correct value
			if (hitsOther > 0)
				hitsOther = hitsOther / rootCat.Categories.Count;

			//Build and write category hit list
			for (int i=0;i < 1000; i++)
			{
				if (categoryHits[i] > 0)
				{
					DataRow row = categoryHitsDT.NewRow();
					
					row["CategoryName"] = EPiServer.DataAbstraction.Category.Find(i).Name;
					row["NumHits"] = categoryHits[i];
	
					categoryHitsDT.Rows.Add(row);
				}
			}

			//Add other (non categorized hits)
			if (hitsOther > 0)
			{
				
				DataRow row = categoryHitsDT.NewRow();
					
				row["CategoryName"] = Translate("/templates/search/other");
				row["NumHits"] = hitsOther;
	
				categoryHitsDT.Rows.Add(row);
			}

			//Add document hits
			if (fileResultsDW != null && fileResultsDW.Count > 0)
			{
				DataRow row = categoryHitsDT.NewRow();
					
				row["CategoryName"] = Translate("/templates/search/documents");
				row["NumHits"] = fileResultsDW.Count;
	
				categoryHitsDT.Rows.Add(row);
			}
			*/

			//Add page hits by category to pageHitsDT
			//foreach (Category cat in rootCat.Categories)
			//{
				//Loop through pages and write abstract and link
			PageDataCollection pages = e.Pages;
			PageData pageData;
			bool match;

			for (int i = 0; i < pages.Count; i++)
			{
				pageData = pages[i];
				match = true;

				if (pageData["DummyPage"] != null && (bool)pageData["DummyPage"])
				{
					match = false;
				}

				if (!match)
				{
					pages.RemoveAt(i);
					i --;
				}
			}
			if(DropDownList1.SelectedIndex==0 || !Tilsyn.Checked || !News.Checked)
			{
				fileResultsDW=DoFileSearch();
			}
			else
			{
				fileResultsDW=null;
			}
			foreach (PageData pd in pages)
			{
				DataRow row = pageHitsDT.NewRow();
				row["Rank"] = Convert.ToInt32(pd["PageRank"]);
				row["PageName"] = pd.PageName;
				if(!title.Checked)
				{
					if(pd.PageLink.ID==94)
					{
						row["LinkURL"] = pd.Property["Link"].Value.ToString();
						row["PreviewText"] =  "";
						if(IsValue("DocType"))
							row["DocType"]="(" +pd.Property["DocType"].Value.ToString() + ")";
					}
					else
					{
						row["LinkURL"] = pd.LinkURL;
						try
						{
							row["PreviewText"] =  pd.Property["MetaDescription"].Value.ToString();
						}
						catch
						{
							row["PreviewText"] =  "";
						}
						row["DocType"]="";
					}
					row["StartPublish"]= pd.StartPublish.ToString("u");
					row["Image"]="";
					
				}
				else
				{
					row["LinkURL"] = "";
					row["PreviewText"] =  "";
					row["DocType"]="";
					row["StartPublish"]= pd.StartPublish.ToString("u");
					row["Image"]="";
				}
				pageHitsDT.Rows.Add(row);
			}
			if (fileResultsDW != null && fileResultsDW.Count > 0)
			{
				for(int i=0;i<fileResultsDW.Count;i++)
				{
				
					DataRow row = pageHitsDT.NewRow();
					row["Rank"] = Convert.ToString(Convert.ToInt32(fileResultsDW[i]["Rank"].ToString())*10);//Convert.ToInt32(pd["PageRank"]);
					if(fileResultsDW[i]["docTitle"].ToString()!="")
						row["PageName"] = fileResultsDW[i]["docTitle"].ToString();//pd.PageName;
					else
						row["PageName"] = fileResultsDW[i]["Filename"].ToString();//pd.PageName;
					
					if(!title.Checked)
					{
						row["LinkURL"] = GetFileURL(fileResultsDW[i]["PATH"].ToString());//pd.LinkURL;
						row["PreviewText"] = fileResultsDW[i]["Characterization"].ToString();//GetPreviewText(pd);
						row["StartPublish"]= Convert.ToDateTime(fileResultsDW[i]["Write"].ToString()).ToString("u");//pd.StartPublish.ToShortDateString();
						row["DocType"]="";
						row["Image"]="<IMG src='/images/fileIcon/"+GetFileIcon(fileResultsDW[i]["PATH"].ToString())+"' alt=\"\"\\>";
					}
					else
					{
						row["LinkURL"] = "";
						row["PreviewText"] = "";
						row["StartPublish"]= Convert.ToDateTime(fileResultsDW[i]["Write"].ToString()).ToString("u");//pd.StartPublish.ToShortDateString();
						row["DocType"]="";
						row["Image"]="<IMG src='/images/fileIcon/"+GetFileIcon(fileResultsDW[i]["PATH"].ToString())+"' alt=\"\"\\>";
						
					}
					if(Convert.ToInt32(fileResultsDW[i]["Rank"].ToString())>0)
						pageHitsDT.Rows.Add(row);
					
				}
			}
			DataView pageHitsView=new DataView(pageHitsDT);
			if(SortDate.Checked)//HandleSearch();
				pageHitsView.Sort="StartPublish DESC";
			else
				pageHitsView.Sort="Rank DESC";
			rptResultsByCategory.DataSource=pageHitsView;
			rptResultsByCategory.DataBind();
			//}

			//Loop through pages and write abstract and link for pages without categories
			/*foreach (PageData pd in e.Pages)
			{
				if (pd.Category.Count == 0)
				{
					DataRow row = pageHitsDT.NewRow();

					row["CategoryName"] = Translate("/templates/search/other");
					row["Rank"] = pd["PageRank"];
					row["PageName"] = pd.PageName;
					row["LinkURL"] = pd.LinkURL;
					row["PreviewText"] = GetPreviewText(pd);
					row["StartPublish"]= pd.StartPublish.ToShortDateString();
					
					pageHitsDT.Rows.Add(row);
				}
			}*/
		}

		private string GetPreviewText(PageData pd)
		{
			string intro = Convert.ToString(pd.Property["MainIntro"]);

			if (intro != null && intro != String.Empty)
				return intro;
			

			string body = Convert.ToString(pd.Property["MainBody"]);

			if (body == null || body == "")
				return "";

			string strOutput;
			
			strOutput = Regex.Replace(body, "<[^>]*>", " ");
			
			if (strOutput.Length > 200)
				return strOutput.Substring(0, 200) + "...";			
			else
				return strOutput.Substring(0, strOutput.Length-1);		
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//

			SearchResults.SearchFiles=false;

			//Setup pageHitsDT DataTable
			pageHitsDT.Columns.Add("CategoryName", typeof(string));
			pageHitsDT.Columns.Add("Rank", typeof(int));
			pageHitsDT.Columns.Add("PageName", typeof(string));
			pageHitsDT.Columns.Add("PreviewText", typeof(string));
			pageHitsDT.Columns.Add("LinkURL", typeof(string));
			pageHitsDT.Columns.Add("StartPublish", typeof(string));
			pageHitsDT.Columns.Add("DocType", typeof(string));
			pageHitsDT.Columns.Add("Image", typeof(string));
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			
			this.Load += new System.EventHandler(this.Page_Load);
			

		}
		#endregion

		public static string BuildDynamicSearchQuery(string mainScope)
		{
			ArrayList list1 = new ArrayList();
			ArrayList list2 = new ArrayList();
			ArrayList list3 = new ArrayList();
			ArrayList list4 = new ArrayList();
			ArrayList list5 = new ArrayList();
			ArrayList list6 = new ArrayList();
			ArrayList list7 = new ArrayList();
			list1.Add("SELECT Rank, DocAppName, docTitle, docAuthor, docSubject, docKeywords, docCreatedTm, Characterization, Write, Filename, Size, PATH, URL");
			if (mainScope.Length == 0)
			{
				list1.Add("FROM SCOPE()");
			}
			else
			{
				mainScope = mainScope.Replace("'", "\"");
				if (mainScope.IndexOf("\"") == -1)
				{
					mainScope = string.Format("DEEP TRAVERSAL OF \"{0}\"", mainScope);
				}
				list1.Add(string.Format("FROM SCOPE('{0}')", mainScope));
			}
			
			return ListArrayJoin(list1, " ");
		}
		public static string ListArrayJoin(ArrayList list, string separator)
		{
			return ListArrayJoin(list, separator, string.Empty);
		}
		public static string ListArrayJoin(ArrayList list, string separator, string preText)
		{
			string[] textArray1 = (string[]) list.ToArray(typeof(string));
			if (preText.Length > 0)
			{
				for (int num1 = textArray1.GetLowerBound(0); num1 < textArray1.GetUpperBound(0); num1++)
				{
					textArray1[num1] = preText + textArray1[num1];
				}
			}
			return string.Join(separator, textArray1);
		}
 

 


	}


}
