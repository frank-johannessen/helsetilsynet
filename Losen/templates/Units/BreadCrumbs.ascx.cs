namespace development.templates.Units
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using EPiServer;
	using EPiServer.Core;

	/// <summary>
	///		Summary description for BreadCrumbs.
	/// </summary>
	public abstract class BreadCrumbs : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label lblBreadCrumb;

		private void Page_Load(object sender, System.EventArgs e)
		{			
			PageBase oPage = (PageBase)this.Page;
			PageData oData = oPage.CurrentPage;

			string sPath =  "";

			while (oData.ParentLink != (PageReference)oData.Property["MainMenuContainer"].Value && 
				oData.ParentLink != PageReference.EmptyReference && oData.ParentLink.ID != 2026 )
			{
				oData = oPage.GetPage(oData.ParentLink);

				if (oData.VisibleInMenu == true && !(oData.Property.Exists("DummyPage") && oData.Property["DummyPage"].Value != null))
					sPath = MakeHtmlLink(oData) + sPath;
			}
			lblBreadCrumb.Text = sPath;
		}

		private string MakeHtmlLink(PageData page)
		{
			string sName = "";
			int maxLenForName = 30;

			//if (System.Configuration.ConfigurationSettings.AppSettings["BreadCrumbNameLength"] != null)
				//maxLenForName = Convert.ToInt32(System.Configuration.ConfigurationSettings.AppSettings["BreadCrumbNameLength"]);

			sName = page.PageName;
			if (sName.Length >= maxLenForName)
				sName = sName.Substring(0, maxLenForName - 3) + "...";

			return "<a href=\"" + page.LinkURL + "\">" + sName + " / </a>";
		}

		private bool HasAccessTo(PageReference pageRef) 
		{
			//Fetch page data, do not perform access control
			PageData pageData = EPiServer.Global.EPDataFactory.GetPage(pageRef, EPiServer.Security.AccessControlList.NoAccess);

			if ((pageData.QueryAccess() & EPiServer.Security.AccessLevel.Read) != EPiServer.Security.AccessLevel.Read) 
				return false; //User does not have access to page, return empty banner content

			if (!pageData.CheckPublishedStatus(PagePublishedStatus.Published))
				return false; //The page is either not yet published or it has a StartPublish date in the future or StopPublish date in the past

			if (pageData.IsDeleted)
				return false; //The page resides in the waste basket (is deleted)

			return true;
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
