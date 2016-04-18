using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Personalization;
using System.Web.Security;
using System.Text.RegularExpressions;

namespace Avenir.Templates.Units.Placeable
{
    public partial class Subscription : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string q = Request.QueryString["r"];
                if (!string.IsNullOrEmpty(q))
                {
                    if (q == "ok")
                    {
                        RecitAera.Visible = true;
                        return;
                    }
                    Msg.Text = " Feil i e-postadresse";
                }
                if (!HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    LoginAera.Visible = true;
                    return;
                }
                string email = EPiServerProfile.Current.Email;
                if (!string.IsNullOrEmpty(email))
                {
                    LoginAera.Visible = false;
                    SubscriptionArea.Visible = true;
                    Email.Text = email;
                    Email.Enabled = false;

                    foreach (ListItem item in Interval.Items)
                    {
                        item.Selected = Int32.Parse(item.Value) == EPiServer.Personalization.Subscription.Interval;
                    }
                    SubscriptionList.DataBind();
                }
                else LoginAera.Visible = true;
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            //MembershipUser u = Membership.GetUser(EmailLogin.Text);
            if (!ValidEmail(EmailLogin.Text))
                Response.Redirect(CurrentPage.LinkURL + "&r=" + EmailLogin.Text);
            
            if (!Membership.ValidateUser(EmailLogin.Text, EmailLogin.Text))
            {
                if (!AddUser(EmailLogin.Text))
                {
                    Message.Text = "Abonnement kan ikke registreres på denne adressen.";
                    return;
                }
                Message.Text = string.Empty;
                AddSubscriber(EmailLogin.Text);
            }
            Login(EmailLogin.Text);
            Response.Redirect(CurrentPage.LinkURL);
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            Membership.DeleteUser(EmailLogin.Text);
            Server.Transfer(CurrentPage.LinkURL + "&r=ok");
            //Response.Redirect(CurrentPage.LinkURL + "&r=ok");
        }

        protected void Delete2_Click(object sender, EventArgs e)
        {
            Membership.DeleteUser(Email.Text);
            try
            {
                EPiServerProfile.Current.Email = null;
            }
            catch (Exception)
            {
            }
            Server.Transfer(CurrentPage.LinkURL + "&r=ok");
        }
        
        protected void Subscribe_Click(object sender, EventArgs e)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Login(Email.Text);
            }
            //EPiServerProfile.Create(Email.Text, false);
            //EPiServerProfile user = EPiServerProfile.Get(Email.Text);

            //return;
            EPiServerProfile user = EPiServerProfile.Current;

            user.SubscriptionInfo.Interval = Int32.Parse(Interval.SelectedItem.Value);

            if (Email.Enabled)
            {
                user.Email = Email.Text;
            }
            user.Save();
            Response.Redirect(CurrentPage.LinkURL + "&r=ok");
        }
  
  
        private void AddSubscriber(string address)
        {
            string litGenericConfirmationMessage = "bla bla bla";
            IList<EPiServerProfile> profiles = EPiServerProfile.GetProfiles(address);

            if (profiles.Count > 1) // Specified address returned group
            {
               litGenericConfirmationMessage = string.Format("Specified e-mail address returned {0} profiles.Subscriptions cannot be added for groups.");
               return;
            }
            // Get the existing/new profile
            EPiServerProfile profile = profiles[0];

            // Cancel if subscription already exists
            //if (profile.SubscriptionInfo.IsSubscribingTo(subscriptionTargetPageLink))
            //{
            //   litGenericConfirmationMessage = string.Format("Subscription to <strong>{0}</strong> is already active for e-mail address <strong>{1}</strong>.", subscriptionTargetPage.PageName, address);
            //   return;
            //}
            // Add the subscription
            profile.Email = address;
            //profile.SubscriptionInfo.SubscribeTo(subscriptionTargetPageLink, ddLanguage.SelectedValue);
            profile.Save();
        }

        private bool AddUser(string address)
        {
             try
            {
                Membership.CreateUser(address, address, address);
            }
             catch {
                 return false;
             }
            string[] users = { address };
            try
            {
                Roles.AddUsersToRole(users, "Abonnement");
            }
            catch { };
            return true;
        }

        private void Login(string address)
        {
                FormsAuthentication.Initialize();
                String strRole = "Abonnent";

                //The AddMinutes determines how long the user will be logged in after leaving
                //the site if he doesn't log off.
                FormsAuthenticationTicket fat = new FormsAuthenticationTicket(1, address, DateTime.Now,
                    DateTime.Now.AddMinutes(5), false, strRole,
                    FormsAuthentication.FormsCookiePath);
                Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName,
                    FormsAuthentication.Encrypt(fat)));
                //Response.Redirect(FormsAuthentication.GetRedirectUrl(address, false));
        }

        private bool ValidEmail(string strEmail)
        {
            Regex rx = new Regex(@"^([a-zA-ZÀ-ÿ0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
            //validate email-input
            bool valid = rx.IsMatch(strEmail);
            return valid;
        }

        //private bool SubListIsChecked()
        //{
        //    bool selected = false;
        //    CheckBoxList cblSubList = (CheckBoxList)SubscriptionList.Controls[0];

        //    //check if subscriptionlist has some selected values
        //    foreach (ListItem subitem in cblSubList.Items)
        //    {
        //        if (subitem.Selected)
        //            selected = true;
        //    }
        //    return selected;
        //}
    
    
    
    }
}