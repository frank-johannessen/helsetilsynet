/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer.DataAbstraction;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.Util;
using EPiServer.Security;
using EPiServer.SystemControls;
using System;
using System.Data;
using System.Drawing;
using System.Web.Mail;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;

namespace development.templates.Units
{
	/// <summary>
	///		Summary description for Register.
	/// </summary>
	public abstract class Register : UserControlBase
	{
		protected NTForm			_formHandler;
		protected PropertyDataForm	EditForm;
		protected Panel				SaveFailed, SaveSucceded, CreateEditUser, DenyRegistring;
		protected Label				ErrorMessage, savedMessage;
		protected EPiServer.WebControls.Translate Translate3;
		protected EPiServer.WebControls.Translate Translate1;
		protected EPiServer.WebControls.Translate Translate2;
		protected System.Web.UI.WebControls.Button ApplyButton;
		protected System.Web.UI.WebControls.Panel Login;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(! (bool)EPiServer.Global.EPConfig["EPfEnableFreeRegistring"] )
			{
				DenyRegistring.Visible = true;
				CreateEditUser.Visible = false;
			}

			DataBind();
		}

		protected virtual void ApplyButton_Click(object sender, EventArgs e)
		{
			if(_formHandler.Properties["Email"].Value == null)
			{
				SaveFailed.Visible = true;
				ErrorMessage.Text = ((EPiServer.PageBase)Page).Translate("#invalidemail");
				return;
			}
			if(_formHandler.Properties["PassWord"].Value == null)
			{
				SaveFailed.Visible = true;
				ErrorMessage.Text = ((EPiServer.PageBase)Page).Translate("#invalidpassword");
				return;
			}
			if((bool)ViewState["LoggedOn"])
			{
				if(!((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated)
				{
					SaveFailed.Visible = true;
					SaveSucceded.Visible = false;
					CreateEditUser.Visible = false;
					ErrorMessage.Text = ((EPiServer.PageBase)Page).Translate("#expiredidentity");
					return;
				}
			}
			
			ViewState.Add("LoggedOn", ((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated);

			try
			{
				if (Page.IsValid)
				{
					if(!((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated)
					{
						_formHandler.Properties["Active"].Value = (bool)EPiServer.Global.EPConfig["EPfAutoActivateUser"];
						int[] defaultGroup = { (int)WellKnownSid.Everyone };
						int configGroup = (int)EPiServer.Global.EPConfig["EPnDefaultGroup"];
						if (configGroup != 0)
							defaultGroup[0] = configGroup;
						((ExtranetForm)_formHandler).MemberOfGroups = defaultGroup;
					}
					
					_formHandler.SaveForm();

					if (((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated)
						UnifiedPrincipal.RemoveFromCache();

					if(_formHandler.SID > 0)
					{
						CreateEditUser.Visible = false;
						SaveSucceded.Visible = true;
						SaveFailed.Visible = false;
					}
					else
					{
						SaveFailed.Visible = true;
						SaveSucceded.Visible = false;
						ErrorMessage.Text = ((EPiServer.PageBase)Page).Translate("#usernotsaved");
					}
				}
			}
			catch
			{
				SaveFailed.Visible = true;
				SaveSucceded.Visible = false;
				ErrorMessage.Text = ((EPiServer.PageBase)Page).Translate("#errorwhilesavinguser");
			};

			if(!((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated && SaveSucceded.Visible)
				SendMail();
		}

		private void SendMail()
		{
			SendUserActivationRequestToAdmin();
			SendInformationToUser();
		}
		
		private void SendInformationToUser()
		{
			MailMessage Mail		= new MailMessage();
			Mail.From				= (string)EPiServer.Global.EPConfig["EPsRegistryEmailFrom"];
			Mail.To					= (string)_formHandler.Properties["Email"].Value;

			if (Mail.From.Length == 0)
			{
				if ((bool)EPiServer.Global.EPConfig["EPfAutoActivateUser"])
					// If we allow self-registering with auto-activation, there is no need to send an email
					return;
				// A self-registered user that is not auto-activated MUST generate an email, otherwise he
				// might never get the attention of an admin that can activate the account.
				throw new EPiServerException(((EPiServer.PageBase)Page).Translate("#invalidsettings"));
			}

			if((bool)EPiServer.Global.EPConfig["EPfAutoActivateUser"])
			{
				Mail.Subject		= (string)EPiServer.Global.EPConfig["EPsActivationEmailSubject"];
				Mail.Body			= (string)EPiServer.Global.EPConfig["EPsActivationEmailBody"];
				savedMessage.Text	= ((EPiServer.PageBase)Page).Translate("#usersavedandactivated");
			}
			else
			{
				Mail.Subject		= (string)EPiServer.Global.EPConfig["EPsRegistryEmailSubject"];
				Mail.Body			= (string)EPiServer.Global.EPConfig["EPsRegistryEmailBody"];
				savedMessage.Text	= ((EPiServer.PageBase)Page).Translate("#usersaved");
			}
			SmtpMail.Send(Mail);
		}

		private void SendUserActivationRequestToAdmin()
		{
			MailMessage Mail = new MailMessage();

			Mail.From		= (string)EPiServer.Global.EPConfig["EPsRegistryEmailFrom"];
			Mail.To			= (string)EPiServer.Global.EPConfig["EPsRegistryEmailTo"];

			if (Mail.To.Length == 0 || Mail.From.Length == 0)
			{
				if ((bool)EPiServer.Global.EPConfig["EPfAutoActivateUser"])
					// If we allow self-registering with auto-activation, there is no need to send an email
					return;
				// A self-registered user that is not auto-activated MUST generate an email, otherwise he
				// might never get the attention of an admin that can activate the account.
				throw new EPiServerException(((EPiServer.PageBase)Page).Translate("#invalidsettings"));
			}
		
			Mail.Subject	= ((EPiServer.PageBase)Page).Translate("#applyemailsubject");
			Mail.Body		= ((EPiServer.PageBase)Page).Translate("#applyemailbodyprefix") + " \n" + 
				EPiServer.Global.EPConfig.HostUrl + 
				EPiServer.Global.EPConfig.RootDir + 
				"admin/edituser.aspx?id=" + 
				_formHandler.SID + "&type=2";

			SmtpMail.Send(Mail);
		}

		public void SetupForm()
		{
			if(((EPiServer.PageBase)Page).CurrentUser.Identity.GetType() == typeof(System.Security.Principal.WindowsIdentity))
			{
				_formHandler = new NTForm();
			}
			else
			{
				_formHandler = new ExtranetForm();
			}
			
			// Remove unwanted fields
			//_formHandler.Propertys["FirstName"].OwnerTab = -1;
			_formHandler.Properties["FirstName"].OwnerTab = -1;
			_formHandler.Properties["LastName"].OwnerTab = -1;
			_formHandler.Properties["Company"].OwnerTab = -1;
			_formHandler.Properties["Title"].OwnerTab = -1;
			_formHandler.Properties["Address"].OwnerTab = -1;
			_formHandler.Properties["Description"].OwnerTab = -1;
			_formHandler.Properties["PostalNumber"].OwnerTab = -1;
			_formHandler.Properties["PostalAddress"].OwnerTab = -1;			
			_formHandler.Properties["Telephone"].OwnerTab = -1;
			_formHandler.Properties["Mobile"].OwnerTab = -1;
			_formHandler.Properties["Language"].OwnerTab = -1;

			EditForm.Data = _formHandler.Properties;
			_formHandler.LoadValues();
			//EditForm.TabInfoList = new TabInfo[] { new TabInfo(0,"") };
			EditForm.Tabs.Add(new TabDefinition(0,""));
			EditForm.DataBind();

			if (ViewState["LoggedOn"] == null)
				ViewState.Add("LoggedOn", ((EPiServer.PageBase)Page).CurrentUser.Identity.IsAuthenticated);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
			SetupForm();
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
