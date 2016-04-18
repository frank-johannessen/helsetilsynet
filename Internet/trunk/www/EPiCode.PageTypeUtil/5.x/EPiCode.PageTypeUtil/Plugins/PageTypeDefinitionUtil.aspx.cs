using System;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using EPiCode.PageTypeUtil.PropertyImport;

namespace EPiCode.PageTypeUtil.Plugins
{
	public class PageTypeDefinitionUtil : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Repeater rptPagetypesDef;
		protected Label lblPageTypeName, lblResult;
		protected System.Web.UI.WebControls.Repeater rptImportProps, rptImportFiles;
		protected System.Web.UI.WebControls.Button cmdImportXml, cmdSave;
		protected System.Web.UI.WebControls.PlaceHolder Placeholder1;
		protected System.Web.UI.WebControls.Panel pnlImportXml;
		protected Repeater rptTypes;
	
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
				FillImportFilesList(rptImportFiles);
				rptTypes.DataBind();
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
			this.cmdImportXml.Click += new System.EventHandler(this.cmdImportXml_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void FillImportFilesList(Repeater repeaterCtrl)
		{
			PropertyImporter importer = new PropertyImporter();
			repeaterCtrl.DataSource = importer.ImportFiles;
			repeaterCtrl.DataBind();
		}

		private void FillPageTypePropertiesList(PageType pageType, Repeater repeaterCtrl)
		{
			repeaterCtrl.DataSource = pageType.Definitions;
			repeaterCtrl.DataBind();
		}

		private void cmdSave_Click(object sender, System.EventArgs e)
		{
			throw new NotImplementedException("Save event has not been implemented");
/*
			PageType pagetype = GetSelectedPageType();

			
			foreach (RepeaterItem itm in rptPagetypesDef.Items)
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
			
			WriteFeedBack("Changes has been saved");

			// Items saved, clear cache
			PageType.ClearCache();
            
			// After Save, refill list
			FillPageTypePropertiesList(pagetype, rptPagetypesDef);
*/
		}

		private void cmdImportXml_Click(object sender, System.EventArgs e)
		{
			bool selectedItem = false;
			// Need to save it on a specific pagetype.
			PageType pageType = GetSelectedPageType();

			// rptImportFiles
			foreach (RepeaterItem itm in rptImportFiles.Items)
			{
				// Get Checkbox
				CheckBox chk = (CheckBox)itm.FindControl("chkDoImportFile");
				if (chk.Checked)
				{
					selectedItem = true;
					// Get path
					string sPath = ((Label)itm.FindControl("lblImportPath")).Text;

					XmlImportFile file = new XmlImportFile(sPath);
					
					foreach(PropertyTypeXml xmlProp in file.Properties)
					{
						if (!xmlProp.ExistOnPageType(pageType.ID))
						{
							// Check that the PropertyType exists
							PageDefinitionType defType = xmlProp.FindType();
							if (defType == null)
								WriteFeedBack("PropertyType " + xmlProp.TypeName + " does noe exist. Cannot import property with this type.");
							else
							{
								// Import it
								xmlProp.SaveOnPageType(pageType.ID);
								WriteFeedBack("Imported property: " + xmlProp.Name);
							}
						}	
						else
							WriteFeedBack("Property " + xmlProp.Name + " already exist on pagetype. Skipping it.");
					}
				}
			}

			if (selectedItem == false)
			{
				WriteFeedBack("Please select a package to import.");
			}
			else
			{
				// Refill property list
				PageType.ClearCache();
				FillPageTypePropertiesList(pageType, rptPagetypesDef);	
			}

			/*
			PropertyTypesXml propImport = PropertyTypesXml.LoadImportFile("~/MakingWaves/Plugin/propertyimport/propertyimport.xml");

 			rptImportProps.DataSource = propImport.Properties;
			rptImportProps.DataBind();
			*/
		}

		private void WriteFeedBack(string text)
		{
			lblResult.Text += text + "<br />";
			lblResult.Visible = true;
		}

	}
}
