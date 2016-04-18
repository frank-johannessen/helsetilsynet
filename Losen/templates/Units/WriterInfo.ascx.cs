using EPiServer;
using EPiServer.Core;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.templates.Units
{	

	/// <summary>
	///		Summary description for WriterInfo.
	/// </summary>
	public abstract class WriterInfo : System.Web.UI.UserControl
	{
		protected Panel		WriterArea;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(((PageBase)Page).CurrentPage.Property.Exists("WriterName") && ((PageBase)Page).CurrentPage["WriterName"] != null)
			{
				Label creator		= new Label();
				creator.Text		= (string)((PageBase)Page).CurrentPage["WriterName"] + "&nbsp;";
				
				Label publishedDate	= new Label();
				publishedDate.Text	= ((PageBase)Page).CurrentPage.Saved.ToString();

				WriterArea.Controls.Add(creator);
				WriterArea.Controls.Add(publishedDate);
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
		}
		#endregion
	}
}
