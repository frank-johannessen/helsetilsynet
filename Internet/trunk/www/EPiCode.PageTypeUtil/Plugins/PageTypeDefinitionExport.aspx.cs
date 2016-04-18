using System;
using System.Web.UI.WebControls;
using EPiServer.DataAbstraction;
using EPiCode.PageTypeUtil.PropertyImport;

namespace EPiCode.PageTypeUtil.Plugins
{
	/// <summary>
	/// Summary description for PageTypeDefinitionExport.
	/// </summary>
	public class PageTypeDefinitionExport : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Repeater rptPagetypesDef;
		protected Label lblPageTypeName, lblResult;
		protected System.Web.UI.WebControls.Button cmdSave;
		protected TextBox TextboxFileName, TextboxInfoName, TextboxInfoDesc;
		protected LinkButton LinkButtonSelectAll, LinkButtonSelectNone;

		private void Page_Load(object sender, System.EventArgs e)
		{
			PageType pagetype = GetSelectedPageType();
			lblPageTypeName.Text = pagetype.Name + " (" + pagetype.LocalizedName + ")";
			TextboxFileName.Text = pagetype.Name + ".xml";
			TextboxInfoName.Text = pagetype.Name;

			if (!IsPostBack)
			{
				FillPageTypePropertiesList(pagetype, rptPagetypesDef);	
			}
		}

		private PageType GetSelectedPageType()
		{
			// No exception handling
			int pageTypeId = int.Parse(Request.QueryString["pagetypeid"]);
			PageType pagetype = PageType.Load(pageTypeId);
			return pagetype;
		}

		private void FillPageTypePropertiesList(PageType pageType, Repeater repeaterCtrl)
		{
			repeaterCtrl.DataSource = pageType.Definitions;
			repeaterCtrl.DataBind();
		}

		private void cmdSave_Click(object sender, System.EventArgs e)
		{
			XmlCreator xml = new XmlCreator();

			xml.Create("import");
			xml.Create("importinfo");
			xml.Create("name", TextboxInfoName.Text);
			xml.Create("description", TextboxInfoDesc.Text);
			xml.LoadParent();
			xml.LoadParent();
			xml.Create("properties");

			foreach (RepeaterItem itm in rptPagetypesDef.Items)
			{
				CheckBox chk = (CheckBox)itm.FindControl("chkImport");
				if (chk.Checked)
				{
					xml.Create("property");
					xml.Create("name", ((Label)itm.FindControl("LabelName")).Text);
					xml.Create("editcaption", ((Label)itm.FindControl("LabelEditCaption")).Text);
					xml.Create("editdesc", ((Label)itm.FindControl("LabelHelpText")).Text);
					xml.Create("required", ((Label)itm.FindControl("LabelRequired")).Text);
					xml.Create("searchable", ((Label)itm.FindControl("LabelSearchable")).Text);
					xml.Create("languagespecific", ((Label)itm.FindControl("LabelLanguageSpecific")).Text);
					xml.Create("tab", ((Label)itm.FindControl("LabelTab")).Text);
					xml.Create("type");
					xml.Create("name", ((Label)itm.FindControl("LabelTypeName")).Text);
					xml.Create("basetype", ((Label)itm.FindControl("LabelTypeDataType")).Text);
					xml.Create("fulltype", ((Label)itm.FindControl("LabelTypeTypeName")).Text);
					xml.Create("assemblyname", ((Label)itm.FindControl("LabelTypeAssemblyName")).Text);
					xml.LoadParent();
					xml.LoadParent();
				}
			}

			try 
			{
				string localPath = System.Web.HttpContext.Current.Server.MapPath(Configuration.VirtualImportDirectory);

				xml.Document.Save(localPath + "\\" + TextboxFileName.Text);
				WriteFeedBack("The XML file " + localPath + "\\" + TextboxFileName.Text + " has been created.");
			} 
			catch(UnauthorizedAccessException uax) 
			{
				WriteFeedBack(uax.Message);
			}

			WriteFeedBack(""); // add an extra <br />
		}

		private void WriteFeedBack(string text)
		{
			lblResult.Text += text + "<br />";
			lblResult.Visible = true;
		}

		private void SelectAll(bool check) 
		{
			foreach (RepeaterItem itm in rptPagetypesDef.Items)
			{
				CheckBox chk = (CheckBox)itm.FindControl("chkImport");
				chk.Checked = check;
			}
		}

		private void SelectAll_Click(object sender, System.EventArgs e)
		{
			SelectAll(true);
		}

		private void SelectNone_Click(object sender, System.EventArgs e)
		{
			SelectAll(false);
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
			this.LinkButtonSelectAll.Click += new System.EventHandler(this.SelectAll_Click);
			this.LinkButtonSelectNone.Click += new System.EventHandler(this.SelectNone_Click);
			this.Load += new System.EventHandler(this.Page_Load);
		}

		#endregion
	}
}
