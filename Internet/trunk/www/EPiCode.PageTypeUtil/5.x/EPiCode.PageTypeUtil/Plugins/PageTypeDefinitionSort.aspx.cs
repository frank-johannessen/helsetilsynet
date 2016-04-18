using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using EPiCode.PageTypeUtil.Plugins;

namespace EPiCode.PageTypeUtil.Plugins
{
	public class PageTypeDefinitionSort : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Repeater rptPagetypesDef;
		protected Label lblPropertyId, lblPageTypeName, lblResult;
		protected System.Web.UI.WebControls.Button cmdSave;
				
		private PageType GetSelectedPageType()
		{
			// No exception handling
			int pageTypeId = int.Parse(Request.QueryString["pagetypeid"]);
			PageType pagetype = PageType.Load(pageTypeId);
			return pagetype;
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			PageType pagetype = GetSelectedPageType();
			lblPageTypeName.Text = pagetype.Name;

			if (!IsPostBack)
			{
				FillPageTypePropertiesList(pagetype, rptPagetypesDef);	
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
			this.cmdSave.Click += new System.EventHandler(this.cmdSave_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void FillPageTypePropertiesList(PageType pageType, Repeater repeaterCtrl)
		{
			repeaterCtrl.DataSource = pageType.Definitions;
			repeaterCtrl.DataBind();
		}
		private void cmdSave_Click(object sender, System.EventArgs e)
		{
			foreach (RepeaterItem itm in rptPagetypesDef.Items)
			{
				// Get import Setting
				TextBox txt = (TextBox)itm.FindControl("txtFieldOrder");

				try
				{
					int fieldorder = int.Parse(txt.Text);

					// Get id of property
					string sID = ((Label)itm.FindControl("lblPropertyId")).Text;
					int id = int.Parse( sID );

					PageDefinition def = PageDefinition.Load(id);
							
					// change only if fieldorder has been updated
					if(def.FieldOrder != fieldorder)
					{
						UpdateFieldOrder(id,fieldorder);
						def.ClearCache();
					}						
				}
				catch 
				{
					// if user has a non numeric value in a inputfield
					continue;
				}				
			}			

			// repopulate the list
			FillPageTypePropertiesList(GetSelectedPageType(),rptPagetypesDef);
		}

		private void UpdateFieldOrder(int pageDefinitionId, int fieldOrder)
		{
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[EPiCode.PageTypeUtil.Plugins.PageTypePlugin.EPISERVER_CONNECTIONSTRING].ToString());
			conn.Open()	;

			try
			{
				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandType = CommandType.Text;
				string sql  = string.Format("UPDATE tblPageDefinition SET FieldOrder = {0} WHERE pkID = {1}", fieldOrder, pageDefinitionId);
				cmd.CommandText = sql;
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				// Re-throw, but close the connection
				throw ex;
			}
			finally
			{
				conn.Close();
			}
		}
	}
}
