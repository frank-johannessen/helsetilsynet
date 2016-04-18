using System;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using EPiCode.PageTypeUtil.PropertyImport;

namespace EPiCode.PageTypeUtil.Plugins
{
	public class PageTypeDefinitionCopy : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Repeater rptPagetypesDef;
		protected Label lblPageTypeName, lblResult;
		protected System.Web.UI.WebControls.Button cmdSave;
		protected DropDownList cboDestPageType;
		const string NO_SELECTION_TEXT = "(Select Destination Page Type)";
		const int NO_SELECTION_VALUE = -1;
	
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
			lblPageTypeName.Text = pagetype.Name + " (" + pagetype.LocalizedName + ")";

			if (!IsPostBack)
			{
				FillPageTypePropertiesList(pagetype, rptPagetypesDef);	
				FillDestDropDown(cboDestPageType);
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

		private void FillDestDropDown(DropDownList ctrl)
		{
			PageTypeCollection pageTypes = PageType.List();
			ctrl.Items.Add(new ListItem(NO_SELECTION_TEXT, NO_SELECTION_VALUE.ToString()));
			foreach(PageType pageType in pageTypes)
			{
				ctrl.Items.Add(new ListItem(pageType.Name + " (" + pageType.LocalizedName + ")", pageType.ID.ToString()));
			}
		}

		private void FillPageTypePropertiesList(PageType pageType, Repeater repeaterCtrl)
		{
			repeaterCtrl.DataSource = pageType.Definitions;
			repeaterCtrl.DataBind();
		}
		private void cmdSave_Click(object sender, System.EventArgs e)
		{
			string destIdString = cboDestPageType.SelectedValue;
			int destId = int.Parse(destIdString);
			if (destId == NO_SELECTION_VALUE)
			{
				WriteFeedBack("Please select a destination Page Type.");
				return;
			}

			PageType pagetype = GetSelectedPageType();
			PageType destType = PageType.Load(int.Parse(cboDestPageType.SelectedValue));

			if (pagetype.ID == destType.ID)
			{
				WriteFeedBack("Cannot copy properties from a Page Type to itself.");
				return;
			}
			
			bool copyDone = false;

			foreach (RepeaterItem itm in rptPagetypesDef.Items)
			{
				
				// Get import Setting
				CheckBox chk = (CheckBox)itm.FindControl("chkImport");
				if (chk.Checked)
				{
					// Get ID of page type
					string sID = ((Label)itm.FindControl("lblPageTypePropertyID")).Text;
					int id = int.Parse( sID );
					PageDefinition sourceDef = EPiServer.DataAbstraction.PageDefinition.Load(id);

					// Check that the property does not alread exist
					if (!PropertyUtil.PropertyExistOnPageType(destType.ID, sourceDef.Name))
					{
						
						// Make it "new"
						sourceDef.ID = 0;
						// Attach it to the dest page type
						sourceDef.PageTypeID = destType.ID;
						// Save it
						sourceDef.Save();

						WriteFeedBack("Copy property " + sourceDef.Name + " to destination Page Type");

						copyDone = true;
					}
					else
					{
						WriteFeedBack("Property " + sourceDef.Name + " already exist on destination Page Type");
					}
				}
			}

			if (copyDone)
			{
				// Items saved, clear cache
				PageType.ClearCache();
				WriteFeedBack("Changes has been saved on Page Type: " + destType.Name + " (" + destType.LocalizedName + ")");
			}
			else
				WriteFeedBack("No properties has been copied to Page Type: " + destType.Name + " (" + destType.LocalizedName + ")");
			
            
			// After Save, refill list
			//FillPageTypePropertiesList(pagetype, rptPagetypesDef);
		}


		private void WriteFeedBack(string text)
		{
			lblResult.Text += text + "<br />";
			lblResult.Visible = true;
		}

	}
}
