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
using EPiServer;
using EPiServer.Core;
using EPiServer.Personalization;
using EPiServer.WebControls;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer.Security;
using EPiServer.DataAbstraction;
using System.Text.RegularExpressions;

namespace development.templates.Units
{
	/// <summary>
	///		Summary description for Subscribe.
	/// </summary>
	public abstract class Subscribe : System.Web.UI.UserControl
	{
		protected DropDownList		interval;
		protected Panel				SubscribeArea;
		protected SubscriptionList	subList;
		protected Panel				ReceiptArea;	
		protected TextBox			txtEmail;
		protected Label				lblErrorMessage;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				ReceiptArea.Visible = false;
				CheckBoxList cblSubList = (CheckBoxList) subList.Controls[0];
				cblSubList.ClearSelection();
				
				foreach(ListItem item in interval.Items)
				{
					item.Selected = Int32.Parse(item.Value) == Subscription.Interval;
					item.Text = ((PageBase)Page).Translate(item.Text);
				}				
			}	
		}
		protected void Save_Click(object sender, EventArgs e)
		{
			if(ValidEmail() && SubListIsChecked())
			{
				UnifiedPrincipal originalUser = ((PageBase)Page).CurrentUser;
				int intInterval = Int32.Parse(interval.SelectedItem.Value);

				PersonalizedData user = HandleUser();

				if(user != null)
				{
					SubscriptionInfo subscriptionInfo = new SubscriptionInfo(user); 

					//Set interval
					subscriptionInfo.Interval = intInterval; 
					//Loop through list of subscription alternatives, and
					//add or remove from user			
					CheckBoxList cblSubList = (CheckBoxList) subList.Controls[0];

					foreach (ListItem subitem in cblSubList.Items)
					{
						if (subitem.Selected == true)
							subscriptionInfo.SubscribeTo(PageReference.Parse(subitem.Value));        
						else
							subscriptionInfo.UnSubscribe(PageReference.Parse(subitem.Value));
					}

					//Save the new data on the user
					user.Save();

					//Show receipt
					SubscribeArea.Visible = false;
					ReceiptArea.Visible = true;
				}
				else
				{
					lblErrorMessage.Text = "Kunne ikke opprette abonnement";
				}
				
				//Reset CurrentUser object
				((PageBase)Page).CurrentUser = originalUser;
			}
			else
			{
				if (!ValidEmail())
					lblErrorMessage.Text = ((PageBase)Page).Translate("#error/emailformat");// "E-post er ikke på riktig format";
				else if (!SubListIsChecked())
					lblErrorMessage.Text = ((PageBase)Page).Translate("#error/checkedlist");//"Du må krysse av i abonnementslisten.";
			}
		}

		private PersonalizedData HandleUser()
		{
			string strUserName = txtEmail.Text;

			//Return if email field is blank
			if(strUserName == string.Empty)
				return null;

			//If user already exists, retrieve this one			
			UserSid existinguser = UserSid.Load(strUserName);

			//Return existing user
			if(existinguser != null)
			{
				//Update the user's email address
				existinguser.Email = strUserName;
			
				//Check if user is in the subscription-group
				if(!(GroupSid.LoadGroup(Global.EPConfig["EPsSubscribeGroup"].ToString()).GroupMembers.Contains(existinguser)))
					existinguser.MemberOfGroups.Add(GroupSid.LoadGroup(Global.EPConfig["EPsSubscribeGroup"].ToString()));
				
				//If user not active, set active
				if (existinguser.Active == false)
					existinguser.Active = true;

				try
				{
					existinguser.Save();
					return PersonalizedData.Load(existinguser.Name);
				}
				catch (DataAbstractionException error)
				{
					return null;
				}
				
			}
			else  //Create new user
			{
				UserSid newuser = new UserSid(SecurityIdentityType.ExtranetUser);

				//Add the user to the subscription-group				
				GroupSid subscriptionGroup = GroupSid.LoadGroup(Global.EPConfig["EPsSubscribeGroup"].ToString());
				if(subscriptionGroup != null)
					newuser.MemberOfGroups.Add(subscriptionGroup);

				//Set the user to active
				newuser.Active = true;

				//Set user properties
				newuser.Name   = strUserName;
				newuser.Email   = strUserName;
			
				try
				{
					newuser.Save();
					return PersonalizedData.Load(newuser.Name);
				}
				catch(DataAbstractionException error)
				{
					return null;
				}
			}
		}

		private bool ValidEmail()
		{
			Regex rx = new Regex(@"^([a-zA-ZÀ-ÿ0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
			string strEmail = txtEmail.Text;
			
			//validate email-input
			bool valid = rx.IsMatch(strEmail);
			return valid;
		}

		private bool SubListIsChecked()
		{
			bool selected = false;	
			CheckBoxList cblSubList = (CheckBoxList) subList.Controls[0];
			
			//check if subscriptionlist has some selected values
			foreach (ListItem subitem in cblSubList.Items)
			{
				if (subitem.Selected)
					selected = true;
			}
			return selected;
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
