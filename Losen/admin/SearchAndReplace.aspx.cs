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
using System.IO;
using System.Text;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.PlugIn;

namespace SearchAndReplacePlugIn
{
	/// <summary>
	/// Summary description for SearchAndReplace.
	/// </summary>
	[GuiPlugIn("Search and replace","Search and replace values",PlugInArea.AdminMenu,"~/admin/SearchAndReplace.aspx")]
	public class SearchAndReplace : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.TextBox searchProperty;
		protected System.Web.UI.WebControls.TextBox searchValue;
		protected System.Web.UI.WebControls.TextBox replaceWithValue;
		protected System.Web.UI.WebControls.Button SearchAndReplaceButton;
		protected System.Web.UI.WebControls.Button SearchButton;
		protected System.Web.UI.WebControls.DataGrid resultForm;

		private const string replaceStartRed = "STARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAG";
		protected System.Web.UI.WebControls.Label Message;
		private const string replaceStopRed = "STOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAG";
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			SearchAndReplaceButton.Attributes.Add("OnClick","return confirm('Are you sure you wish to replace \"' + " + searchValue.ClientID + ".value + '\" with \"' + " + replaceWithValue.ClientID + ".value + '\" ? ')");
		}

		private void SearchAndReplaceInProperty(string propertyName,string searchText,string replaceWith,bool save)
		{
			DataTable report = new DataTable();
			report.Columns.Add("Page",typeof(string));
			report.Columns.Add("From",typeof(string));
			report.Columns.Add("To",typeof(string));

			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
			PropertyCriteria criteria;
			PageDataCollection matchingPages;
			int currentSid = EPiServer.Security.UnifiedPrincipal.CurrentSid;
			string propertyValue;
			int count = 0;
 
			// Define start page for search (here we search the entire site)
			PageReference startPage = Global.EPConfig.RootPage;
 
			// Setup criterias to search for text in a property
			criteria = new EPiServer.PropertyCriteria();
			criteria.Type = PropertyDataType.LongString;
			criteria.Name = propertyName;
			criteria.Value = searchText;
			criteria.StringCondition = EPiServer.Filters.StringCompareMethod.Contained;

			criterias.Add(criteria);
 
			matchingPages = Global.EPDataFactory.FindPagesWithCriteria(startPage, criterias);
 
			foreach(PageData page in matchingPages)
			{
				propertyValue = page.Property[propertyName].ToString();

				int index = 0;
				while(true)
				{
					if(index==(propertyValue.Length-1))
						break;

					index = propertyValue.IndexOf(searchText,index,propertyValue.Length-index-1);
					if(index<0)
						break;

					string txtBlock = propertyValue.Substring(LowIndex(index-20),HighIndex(index-20,propertyValue.Length));


					DataRow row = report.NewRow();
					row["Page"] = "<a target=_blank href=\"" + page.LinkURL + "\">" + page.PageName + " [" + page.PageLink.ToString() + "]</a>";
					row["From"] = Server.HtmlEncode(txtBlock.Replace(searchText,replaceStartRed + searchText + replaceStopRed));
					row["To"] = Server.HtmlEncode(txtBlock.Replace(searchText,replaceStartRed + replaceWith + replaceStopRed));

					row["From"] = ((string)row["From"]).Replace(replaceStartRed,"<font color=red>");
					row["To"] = ((string)row["To"]).Replace(replaceStartRed,"<font color=red>");

					row["From"] = ((string)row["From"]).Replace(replaceStopRed,"</font>");
					row["To"] = ((string)row["To"]).Replace(replaceStopRed,"</font>");

					report.Rows.Add(row);



					index = index + searchText.Length;
				}


				page.Property[propertyName].Value = 
					propertyValue.Replace(searchText, replaceWith);
 
				if(save)
					EPiServer.Global.EPDataFactory.Save(page, SaveAction.Publish);

				count++;
 			}

			if(save)
				Message.Text = String.Format("Found and replaced {0} matches",count);
			else
				Message.Text = String.Format("Found {0} matches",count);
				

			resultForm.DataSource = report;
			resultForm.DataBind();
		}

		private int HighIndex(int val,int count)
		{
            return (val+40) > (count-1) ? count-val : 40;
		}

		private int LowIndex(int val)
		{
			return val < 0 ? 0 : val;
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
			this.SearchButton.Click += new System.EventHandler(this.DoSearch);
			this.SearchAndReplaceButton.Click += new System.EventHandler(this.DoSearchAndReplace);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void DoSearch(object sender, System.EventArgs e)
		{
			SearchAndReplaceInProperty(searchProperty.Text,searchValue.Text,replaceWithValue.Text,false);
		}

		private void DoSearchAndReplace(object sender, System.EventArgs e)
		{
			SearchAndReplaceInProperty(searchProperty.Text,searchValue.Text,replaceWithValue.Text,true);
		}
	}
}
