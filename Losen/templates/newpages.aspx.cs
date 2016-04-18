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
using System.Text.RegularExpressions;
using EPiServer;
using EPiServer.Core;

namespace development.templates
{
	/// <summary>
	/// Summary description for newpages.
	/// </summary>
	/// 

	/* MAIN CLASS FOR WEBFORM */
	public class newpages : TemplatePage
	{
		public EPiServer.WebControls.PageList output;
		public ArrayList aKeywordList = new ArrayList();
		public ArrayList aPageDataCollection = new ArrayList();
		public PageDataCollection masterCollection = new PageDataCollection();
		public int keywordcount = 0;
		public string keywordheader = "";
		public bool bkeywords = true;
		public bool bGroup = false;


		/* CLASS FOR OBJECTS HOLDING KEYWORD DATA */
		public class KeyWordObject 
		{
			public string keyword;
			public string keywordlist;
			
			public KeyWordObject(string keyword, string keywordlist) 
			{
				this.keyword = keyword;
				this.keywordlist = keywordlist;
			}
		}

		/* CLASS FOR OBJECTS HOLDING PAGEDATACOLLECTION FOR A KEYWORD */
		public class KeyWordDataCollection 
		{
			public PageDataCollection collection;
			public string keyword;
			public string keywordlist;
		
			public KeyWordDataCollection(PageDataCollection collection, string keyword, string keywordlist) 
			{
				this.keyword = keyword;
				this.collection = collection;
				this.keywordlist = keywordlist;
			}
		}

		/* CLASS FOR COMPAREINTERFACE FOR SORTING */
		private sealed class SortPagesByDateComparer : IComparer
		{
			public int Compare(object firstObject, object secondObject)
			{
				PageData firstPage = (PageData) firstObject;
				PageData secondPage = (PageData) secondObject;
				string firstProperty = "PageStartPublish";
				string secondProperty = "PageStartPublish";
				DateTime firstDate = DateTime.Parse(firstPage[firstProperty].ToString());
				DateTime secondDate = DateTime.Parse(secondPage[secondProperty].ToString());
				return secondDate.CompareTo(firstDate);
			}
		}

		/* SET HEADER */
		public string setHeader(string header) 
		{
			keywordheader = header;
			return "";
		}

		/* COUNT AND RETURN */
		public string getCount(bool bcount) 
		{
			if (bcount) keywordcount++;
			return keywordcount.ToString();
		}

		/* RESET COUNT*/
		public string resetCount() 
		{
			keywordcount=0;
			return "";
		}

		/* CONVERT A STRING LIST TO ARRAY AND ADD TO ARRAYLIST */
		protected ArrayList addListToArrayList(ArrayList alList, string strList, string strListName) 
		{
			// LOOP THROUGH EACH KEYWORD IN LIST AND ADD IT TO KEYWORDARRAYLIST
			foreach (string item in strList.Split(',')) 				
			{		
				bool bExists = false; int row = 0;
				if (item.Trim() != "") 
				{
					for (row=0; row<alList.Count; row++) {
						if ( ((KeyWordObject)alList[row]).keyword == item.Trim()) { bExists=true; break; }
					}
					// UPDATE LIST REFERENCE WHEN KEYWORD IS USED IN MULTIPLE LISTS
					if (bExists) ((KeyWordObject)alList[row]).keywordlist += "," + strListName;
					// ADD KEYWORD TO LIST
					if (!bExists) alList.Add(new KeyWordObject(item.Trim(),strListName));
				}
			}
			return alList;
		}

		/* RETURN PAGEDATACOLLECTION FOR KEYWORD */
		public PageDataCollection GetPagesWithKeyword(string keyword, string keywordlist) 
		{
			foreach (KeyWordDataCollection kwdc in aPageDataCollection) 
			{
				if (kwdc.keyword == keyword) return kwdc.collection;
			}
			return null;		 
		}

		/* RETURN PAGEDATACOLLECTION FOR KEYWORD FROM MASTERCOLLECTION */
		public bool FindPagesWithKeywordFromMasterCollection(string keyword,string keywordlist) 
		{
			// EXIT IF GROUPING IS DISABLED
			if (bGroup==false) return false;
			
			// SPLIT KEYWORDLIST IN CASE OF MULTIPLE VALUES
			string[] akeywordlist = keywordlist.Split(',');
			PageDataCollection pages = new PageDataCollection();
			string keywordproperty = "";

			// LOOP THROUGH KEYWORDLIST, ONE KEYWORD MAY BE USED IN SEVERAL KEYWORDLISTS, COLLECT PAGES FOR ALL OF THEM
			foreach (string list in akeywordlist) 
			{
				if (list=="CouncilList") keywordproperty = "CouncilName";
				if (list=="InstitutionList") keywordproperty = "InstitutionName";
				if (list=="DynamicSortingList") keywordproperty = "DynamicSorting";
				
				// LOOP THROUGH MASTER PAGECOLLECTION
				foreach (PageData mypage in masterCollection) 
				{
					if (CurrentPage[list]!=null) 
					{
						if (mypage.Property.Exists(keywordproperty) && mypage[keywordproperty]!=null)
						{
							// LOOP THROUGH KEYWORDLIST IN PAGE
							foreach (string key in mypage[keywordproperty].ToString().Split(','))
							{
								if (key == keyword) pages.Add(mypage);	
							}						
						}
					}
				}
			}

			// ADD FOUND PAGES TO KEYWORDPAGECOLLECTION
			aPageDataCollection.Add(new KeyWordDataCollection(pages,keyword,keywordlist));
			// SET GLOBAL STATUS AND RETURN LOCAL STATUS
			if (pages.Count>0) { bkeywords = true; return true; }
			bkeywords = false; return false;
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			// CREATE ARRAYLIST FROM DYNAMIC LIST PROPERTIES 
			if (CurrentPage["CouncilList"] != null) aKeywordList = addListToArrayList(aKeywordList,CurrentPage["CouncilList"].ToString(),"CouncilList");
			if (CurrentPage["InstitutionList"] != null) aKeywordList = addListToArrayList(aKeywordList,CurrentPage["InstitutionList"].ToString(),"InstitutionList");
			if (CurrentPage["DynamicSortingList"] != null) aKeywordList = addListToArrayList(aKeywordList,CurrentPage["DynamicSortingList"].ToString(),"DynamicSortingList");

			// GRUPPESWITCH
			if (CurrentPage["ListingGroupDynamic"]!=null && aKeywordList.Count>0) bGroup = true;

			// SET LISTING MAXCOUNT 
			int maxcount = CurrentPage["ListingMaxCount"]!=null?int.Parse(CurrentPage["ListingMaxCount"].ToString()):-1;

			// SETUP CRITERIA COLLECTION
			PropertyCriteriaCollection col = new PropertyCriteriaCollection();
            	
			// ADD DATEINTERVAL TO CRITERIA COLLECTION 
			try 
			{
				int days = int.Parse(CurrentPage["ListingDays"].ToString());
				DateTime dateAfter = DateTime.Now.Subtract(new TimeSpan(days,0,0,0));
				DateTime dateBefore = DateTime.Now;

				PropertyCriteria critBefore = new PropertyCriteria();
				critBefore.Condition = EPiServer.Filters.CompareCondition.LessThan;
				critBefore.Type = PropertyDataType.Date;
				critBefore.Name = "PageStartPublish";
				critBefore.Value = dateBefore.ToString();
				critBefore.Required = true;            
				col.Add(critBefore);

				PropertyCriteria critAfter = new PropertyCriteria();
				critAfter.Condition = EPiServer.Filters.CompareCondition.GreaterThan;
				critAfter.Type = PropertyDataType.Date;
				critAfter.Name = "PageStartPublish";
				critAfter.Value = dateAfter.ToString();
				critAfter.Required = true;
				col.Add(critAfter);		
			}
			catch 
			{
				// DO NOTHING
			}
		
			// ADD CRITERIAS FOR PAGETYPES 
			string[] includedPageTypes = CurrentPage["ListingPageTypes"].ToString().Split(',');

			// ADD CRITERIA FOR ALLE PAGETYPES INCLUDED
			foreach (EPiServer.DataAbstraction.PageType pagetype in EPiServer.DataAbstraction.PageType.List())  
			{
				bool bInclude = false;
				foreach (string includedID in includedPageTypes) 
				{
					if (includedID == pagetype.ID.ToString()) bInclude = true;
				}
				if (bInclude) 
				{
					PropertyCriteria critPageType = new PropertyCriteria();
					critPageType.Condition = EPiServer.Filters.CompareCondition.Equal;
					critPageType.Type = PropertyDataType.PageType;
					critPageType.Name = "PageTypeID";
					critPageType.Value = pagetype.ID.ToString();
					critPageType.Required = false;
					col.Add(critPageType);	
				}
			}
			
	        // FIND PAGES MATCHING CRITERIAS 
			masterCollection = Global.EPDataFactory.FindPagesWithCriteria((PageReference)CurrentPage["ListingContainer"], col,EPiServer.Security.AccessLevel.Read);		

			// SORT PAGES BY PUBLISHED DATE DESCENDING 
			masterCollection.Sort(new SortPagesByDateComparer());			
			
			// CUT DOWN COLLECTIONSIZE TO MAXCOUNT
			if (!bGroup && masterCollection.Count>maxcount) masterCollection.RemoveRange(maxcount,masterCollection.Count-maxcount);
			
			// CONNECT PAGELIST DATASOURCE TO MASTERCOLLECTION 
			if (!bGroup) output.DataSource = masterCollection;
						
			// BIND GLOBALLY 
			DataBind();

		}

		private void output_Filter(object sender, EPiServer.Filters.FilterEventArgs e)
		{
			PageDataCollection pages = e.Pages;
		
			//remove dummy-pages from list
			for (int i=0; i < pages.Count; i++)
			{
				if (pages[i].Property.Exists("DummyPage") && pages[i].Property["DummyPage"].Value != null)
				{
					pages.RemoveAt(i);
					i--;
				}
			}
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
			this.output.Filter += new EPiServer.WebControls.FilterEventHandler(output_Filter);
		}
		#endregion

	}
}
