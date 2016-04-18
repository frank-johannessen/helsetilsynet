namespace development.Frameworks
{
	using EPiServer;
	using EPiServer.Core;
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	/// <summary>
	///		Summary description for DefaultFramework.
	/// </summary>
	public abstract class DefaultFramework : EPiServer.WebControls.ContentFramework
	{
		protected EPiServer.WebControls.Region mainRegion;
		protected System.Web.UI.HtmlControls.HtmlImage Img5;
		protected System.Web.UI.HtmlControls.HtmlImage Img2;
		protected System.Web.UI.HtmlControls.HtmlImage Img12;
		protected System.Web.UI.HtmlControls.HtmlImage Img13;
		protected EPiServer.WebControls.Region testRegion;
		protected EPiServer.WebControls.Region AddRegion1;
		protected EPiServer.WebControls.Region RegionTop;
		protected EPiServer.WebControls.Region RegionCenter;
		protected EPiServer.WebControls.Region RegionBody;
		protected System.Web.UI.WebControls.Label Label1;
		protected EPiServer.WebControls.Property Property4;
		protected System.Web.UI.HtmlControls.HtmlImage Img1;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			if(!IsPostBack)
			{
				DataBind();
			}
		}


		public string GetPageURL()
		{
			if (((EPiServer.PageBase)Page).CurrentPage["ShowFrontPageFrom"] != null) 
			{
				int pageID = int.Parse(((EPiServer.PageBase)Page).CurrentPage["ShowFrontPageFrom"].ToString());
				PageData oPage;
				oPage = Global.EPDataFactory.GetPage(new PageReference(pageID));
				return oPage.LinkURL.ToString();
			}
			return "/";
		}

		// To ensure there's always a value for ListingCount
		protected int GetCount()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["NoticeBoardCount"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["NoticeBoardCount"];
			else
				return 3;
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
