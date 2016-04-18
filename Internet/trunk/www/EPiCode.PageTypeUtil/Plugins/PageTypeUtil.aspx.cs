using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.PlugIn;

namespace EPiCode.PageTypeUtil.Plugins
{
	[GuiPlugIn(DisplayName = "Pagetype Utility",
        Description = "Utility for working with pagetypes",
			Area = EPiServer.PlugIn.PlugInArea.AdminMenu, 
            Url = "~/EPiCode.PageTypeUtil/Plugins/pagetypeutil.aspx")]
	public class PageTypePlugin : System.Web.UI.Page, ICustomPlugInLoader
	{
	    public const string EPISERVER_CONNECTIONSTRING = "EPiServerDB";

	    protected Button cmdSave;
		protected Repeater rptPagetypes;
		protected CheckBox chkShowHidden;
		protected Label lblResult;
		
		private void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{				
				FillPageTypeList(rptPagetypes);	
			}
		}

        private int _maxPageIDsToDisplay = 50;
        public int MaxPageIDsToDisplay
        {
            get 
            {
                if (ConfigurationManager.AppSettings["EPnPageTypeUtilMaxPageIDsToDisplay"] != null)
                {
                    if (int.TryParse(ConfigurationManager.AppSettings["EPnPageTypeUtilMaxPageIDsToDisplay"], out _maxPageIDsToDisplay))
                        return _maxPageIDsToDisplay;
                }

                return _maxPageIDsToDisplay; 
            }
            set { _maxPageIDsToDisplay = value; }
        }

        public PlugInDescriptor[] List()
        {
            PlugInDescriptor[] aDescriptors = null;

            if (HttpContext.Current.User.IsInRole("Administrators") ||
                HttpContext.Current.User.IsInRole("WebAdmins"))
            {
                aDescriptors = new PlugInDescriptor[1];
                aDescriptors[0] = PlugInDescriptor.Load(this.GetType());
            }

            return aDescriptors;
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
			this.chkShowHidden.CheckedChanged += new System.EventHandler(this.chkShowHidden_CheckedChanged);
			this.cmdSave.Click += new System.EventHandler(this.cmdSave_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		
        protected string GetPageName(int pageId)
        {
            PageReference pageref = new PageReference(pageId);

            if (pageref != PageReference.EmptyReference)
            {
                return (DataFactory.Instance.GetPage(pageref)).PageName;
            }

            return "No pagename found for pageid " + pageId;

        }


	    private void FillPageTypeList(Repeater repeaterCtrl)
		{
			PageTypeCollection pageTypes = PageType.List();

			if (chkShowHidden.Checked == false)
			{
				// Remove all hidden ones
				for (int i = pageTypes.Count - 1; i >= 0; i--)
				{
					if (pageTypes[i].IsAvailable == false)					
						pageTypes.RemoveAt(i);
				}
			}

			repeaterCtrl.DataSource = pageTypes;
			repeaterCtrl.DataBind();
		}
		private void cmdSave_Click(object sender, EventArgs e)
		{
			foreach (RepeaterItem itm in rptPagetypes.Items)
			{
				// Get ID of page type
				string sID = ((Label)itm.FindControl("lblPageTypeID")).Text;
				int id = int.Parse( sID );
				// Get Sort Index
				TextBox txtBox = (TextBox)itm.FindControl("txtIndex");
				int sortOrder = int.Parse(txtBox.Text);
				// Get Visible Setting
				CheckBox chk = (CheckBox)itm.FindControl("chkVisible");
				PageType pagetype = PageType.Load(id);
				pagetype.SortOrder = sortOrder;
				pagetype.IsAvailable = chk.Checked;
				// Save it
				pagetype.Save();
			}

			lblResult.Text = "Changes has been saved";
			lblResult.Visible = true;
			
			// Items saved, clear cache
			PageType.ClearCache();
            
			// After Save, refill list
			FillPageTypeList(rptPagetypes);
		}

		private void chkShowHidden_CheckedChanged(object sender, EventArgs e)
		{
			// Refill
			FillPageTypeList(rptPagetypes);
		}

		/// <summary>
		/// Gets the number of pages for a pagetype.
		/// </summary>
		/// <param name="pageTypeId">Page type id</param>
		/// <returns>The number of pages used by the page type</returns>
		protected int GetNumberOfPagesForPageType(int pageTypeId)
		{
			const string query = "SELECT COUNT(*) AS PageCount FROM tblPage WHERE (fkPageTypeID = {0})";

			return GetNumberOfPagesForPageTypeFromDatabase(pageTypeId, query);
		}

		/// <summary>
		/// Gets the number of work pages for a page type.
		/// </summary>
		/// <param name="pageTypeId">Page type id</param>
		/// <returns></returns>
		public int GetNumberOfWorkPagesForPageType(int pageTypeId)
		{
		    const string query = @"SELECT COUNT(*) AS PageCount FROM tblWorkPage 
							 INNER JOIN tblPage ON tblWorkPage.fkPageID = tblPage.pkID 
							 WHERE (tblPage.fkPageTypeID = {0})";

		    return GetNumberOfPagesForPageTypeFromDatabase(pageTypeId, query);
		}

	    protected DataTable GetPageIdsForPageType(int pageTypeId)
		{
            const string query = "SELECT TOP ({0}) pkID FROM tblPage WHERE (fkPageTypeID = {1})";
            
			DataSet ds = GetIDsToPagesForPageTypeFromDatabase(pageTypeId, string.Format(query, MaxPageIDsToDisplay, pageTypeId));

            if (ds == null)
                return null;

            return ds.Tables[0];
		}

		/// <summary>
		/// Gets the number of pages a for page type from database.
		/// </summary>
		/// <param name="pageTypeId">Page type id to count pages for</param>
		/// <param name="query">Query to run against database</param>
		/// <returns></returns>
		private int GetNumberOfPagesForPageTypeFromDatabase(int pageTypeId, string query)
		{
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[EPISERVER_CONNECTIONSTRING].ToString());
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format(query, pageTypeId);
                
            try
            {
                conn.Open();
                object pageCount = cmd.ExecuteScalar();
                conn.Close();

                return (int) pageCount;
            }
            catch (Exception ex)   // ignore missing columns in the database
            {
                lblResult.Text = ex.Message;
                lblResult.Visible = true;
            }
            finally
            {
                conn.Close();
            }

		    return -1;
		}

        private DataSet GetIDsToPagesForPageTypeFromDatabase(int pageTypeId, string query)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[EPISERVER_CONNECTIONSTRING].ToString());
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = string.Format(query, pageTypeId);

            try
            {
                DataSet ds =  new DataSet();
                conn.Open();
                                
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                adapter.Fill(ds);
                return ds;
            }
            catch (Exception ex)   // ignore missing columns in the database
            {
                lblResult.Text = ex.Message;
                lblResult.Visible = true;
            }
            finally
            {
                conn.Close();
            }

            return null;
        }
	}
}
