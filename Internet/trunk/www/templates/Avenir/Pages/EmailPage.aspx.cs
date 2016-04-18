using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Mail;
//using System.Web.Mail;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Util;
using MailMessage = System.Net.Mail.MailMessage;
using EPiServer.Core;

// http://msdn.microsoft.com/en-us/library/system.net.mail.smtpclient.aspx


namespace Avenir.Templates.Pages
{
	/// <summary>
	/// Summary description for EmailPage.
	/// </summary>
	public partial class EmailPage : TemplatePage
	{
		protected TextBox To, From, Subject, Other;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}
		protected void SendEmailButton_Click(object sender, System.EventArgs e)
		{
			/*if(!IsValid)
				return;

            System.Web.Mail.MailMessage mail = new System.Web.Mail.MailMessage();
            mail.BodyFormat     = MailFormat.Text;
			mail.From			= From.Text;
		    mail.To = CurrentPage.Property["SendTo"].ToString(); // ConfigurationManager.AppSettings["EpostKontaktAdress"];
			mail.Subject		= Subject.Text;
			mail.Body			= Other.Text;
           // mail.Body += "\n\n" +  CurrentPage.LinkURL;  //"\n\n" + Configuration.HostUrl + CurrentPage.LinkURL;
			mail.Body			+= "\n\nMessage was sent from IP address " + Request.UserHostAddress + " at " + DateTime.Now.ToString();

            SmtpMail.SmtpServer = ConfigurationManager.AppSettings["EpostKontaktServer"];
			SmtpMail.Send(mail);

            //int mailReceiptPage = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["MailReceiptPage"]);
            //PageData pd = GetPage(new PageReference(mailReceiptPage));
            PageReference mailReceiptPage = CurrentPage["ResponsePage"] as PageReference;
            PageData pd = GetPage(mailReceiptPage);
            HttpContext.Current.Response.Redirect (pd.LinkURL);*/

            //Page.RegisterStartupScript("CloseWindow", "<script type='text/javascript'>window.returnValue = true;window.parent.close();</script>");
		}

		public override void ValidatePageTemplate()
		{
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
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
