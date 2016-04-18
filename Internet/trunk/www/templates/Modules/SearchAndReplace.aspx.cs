using System;
using System.Data;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.PlugIn;

namespace Avenir
{
	/// <summary>
	/// Summary description for SearchAndReplace.
	/// </summary>
    [GuiPlugIn(DisplayName = "Search and replace", Description = "Search and replace values", Area = PlugInArea.AdminMenu, Url = "~/templates/Modules/SearchAndReplace.aspx")]
    //[GuiPlugIn("Search and replace","Search and replace values",PlugInArea.AdminMenu,"~/templates/Modules/SearchAndReplace.aspx")]
	public partial class SearchAndReplace : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.TextBox SearchProperty;
		protected System.Web.UI.WebControls.TextBox SearchValue;
		protected System.Web.UI.WebControls.TextBox ReplaceWithValue;
		protected System.Web.UI.WebControls.Button SearchAndReplaceButton;
		protected System.Web.UI.WebControls.Button SearchButton;
		protected System.Web.UI.WebControls.DataGrid ResultForm;

		private const string ReplaceStartRed = "STARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAGSTARTREDTAG";
		protected System.Web.UI.WebControls.Label Message;
		private const string ReplaceStopRed = "STOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAGSTOPREDTAG";
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			SearchAndReplaceButton.Attributes.Add("OnClick","return confirm('Are you sure you wish to replace \"' + " + SearchValue.ClientID + ".value + '\" with \"' + " + ReplaceWithValue.ClientID + ".value + '\" ? ')");
		}

		private void SearchAndReplaceInProperty(string propertyName,string searchText,string replaceWith,bool save)
		{
			var report = new DataTable();
			report.Columns.Add("Page",typeof(string));
			report.Columns.Add("From",typeof(string));
			report.Columns.Add("To",typeof(string));
            

			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
			PropertyCriteria criteria;
			PageDataCollection matchingPages;
            //int currentSid = 0; // EPiServer.Security.UnifiedPrincipal.CurrentSid;
			string propertyValue;
			int count = 0;
 
			// Define start page for search (here we search the entire site)
 //           //PageReference startPage = new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnRootID"]);
            PageReference startPage = new PageReference(5); //5 2048
 
			// Setup criterias to search for text in a property
			criteria = new EPiServer.PropertyCriteria();
            criteria.Type =PropertyDataType.LongString;
			criteria.Name = propertyName;
			criteria.Value = searchText;
            criteria.Condition = EPiServer.Filters.CompareCondition.Contained;

			criterias.Add(criteria);

			matchingPages = DataFactory.Instance.FindPagesWithCriteria(startPage, criterias);
 
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
					row["Page"] = "<a target=_blank href=\"" + page.LinkURL + "\">" + page.PageName + " [" + page.PageLink + "]</a>";
					row["From"] = Server.HtmlEncode(txtBlock.Replace(searchText,ReplaceStartRed + searchText + ReplaceStopRed));
					row["To"] = Server.HtmlEncode(txtBlock.Replace(searchText,ReplaceStartRed + replaceWith + ReplaceStopRed));

					row["From"] = ((string)row["From"]).Replace(ReplaceStartRed,"<font color=red>");
					row["To"] = ((string)row["To"]).Replace(ReplaceStartRed,"<font color=red>");

					row["From"] = ((string)row["From"]).Replace(ReplaceStopRed,"</font>");
					row["To"] = ((string)row["To"]).Replace(ReplaceStopRed,"</font>");

					report.Rows.Add(row);



					index = index + searchText.Length;
				}

                if (save)
                {
                    PageData wpd = page.CreateWritableClone();
                    wpd.Property[propertyName].Value =
                        propertyValue.Replace(searchText, replaceWith);
                    DataFactory.Instance.Save(wpd, SaveAction.Publish);
                    //EPiServer.Global.EPDataFactory.Save(wpd, SaveAction.Publish);
                }
				count++;
 			}

			if(save)
				Message.Text = String.Format("Found and replaced {0} matches",count);
			else
				Message.Text = String.Format("Found {0} matches",count);
				

			ResultForm.DataSource = report;
			ResultForm.DataBind();
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

		private void DoSearch(object sender, EventArgs e)
		{
			SearchAndReplaceInProperty(SearchProperty.Text,SearchValue.Text,ReplaceWithValue.Text,false);
		}

		private void DoSearchAndReplace(object sender, EventArgs e)
		{
			SearchAndReplaceInProperty(SearchProperty.Text,SearchValue.Text,ReplaceWithValue.Text,true);
		}
	}
}
