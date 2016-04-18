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
	///		Summary description for ArticleList.
	/// </summary>
	public abstract class ArticleList : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.NewsList lstArticles;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			DataBind();
		}

		// To ensure there's always a value for ListingCount
		protected int GetCount()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["ListingCount"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["ListingCount"];
			else
				return -1;
		}

		// To ensure there's always a value for Sort
		protected int GetSortOrder()
		{
			if(((EPiServer.PageBase)Page).CurrentPage["ListingSort"] != null)
				return (int)((EPiServer.PageBase)Page).CurrentPage["ListingSort"];
			else
				return 8;
		}

		private void lstArticles_Filter(object sender, EPiServer.Filters.FilterEventArgs e)
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			this.lstArticles.Filter += new EPiServer.WebControls.FilterEventHandler(lstArticles_Filter);
		}
		#endregion

	}
}
