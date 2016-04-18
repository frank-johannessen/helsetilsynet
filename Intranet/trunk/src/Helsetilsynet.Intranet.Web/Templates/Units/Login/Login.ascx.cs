#region Copyright
/*
Copyright (c) 2010 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published August 20, 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/
#endregion

#region Known Limitations
/*
The template has no known limitations.
*/
#endregion

using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.Helpers;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login
{
    /// <summary>
    /// This user control handles user login based on asp.net 2.0 LoginView control.
    /// </summary>    
    public partial class Login : RelateUserControlBase<Model.BasePage>
    {
        #region Method overrides

        protected override void OnLoad(EventArgs e)
        {
            ucForgotPassword.PasswordSent += SetInfoMessage;

            //Set active view
            try
            {
                var encryptedUsername = Request.QueryString[QueryStrings.ChangePasswordFor];

                if (!string.IsNullOrEmpty(encryptedUsername))
                {
                    livLogin.Visible = false;

                    ucNewPassword.UserName = Encryptor.DecryptString(encryptedUsername.Replace(' ', '+').Replace('*', '='));
                    ucNewPassword.Visible = true;
                }
            }
            catch (Exception)
            {
                SetInfoMessage(Translate("/login/wrongurl"));
            }

            ucNewPassword.DataBind();
        }

        void SetInfoMessage(string messageToSet)
        {
            litInfoText2.Text = messageToSet;
            litInfoText2.DataBind();
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            // Find the login control
            var login = livLogin.FindControl("lgiCommunityLogin") as System.Web.UI.WebControls.Login;

            if (login == null)
            {
                return;
            }

            // Get the return url if there is one
            string returnUrl = Request.QueryString["returnUrl"];

            if (CurrentUser == null)
            {
                if (!String.IsNullOrEmpty(returnUrl))
                {
                    // Set the return url as destination url of the login
                    login.DestinationPageUrl = returnUrl;
                }
                else 
                {
                    // Redirect to My Page
                    login.DestinationPageUrl = "/";
                }

                // Set focus on username Textbox
                login.Focus();
            }
        }
        #endregion

        #region Event handlers


        protected void onAuthenticate(object sender, AuthenticateEventArgs e)
        {
            bool Authenticated = false;
            // Find the login control
            var login = livLogin.FindControl("lgiCommunityLogin") as System.Web.UI.WebControls.Login;
            string username = ((TextBox) login.FindControl("username")).Text;
            string password = ((TextBox) login.FindControl("password")).Text;
            var changeUser = PeopleHelper.GetUserByUsernameThenEmail(username);
            if (changeUser == null)
                return;

            IUser user;            
            if(SecurityHandler.Instance.AuthenticateUser(changeUser.UserName, password, out user))
            {
                Authenticated = true;
            }
            e.Authenticated = Authenticated;
        }

        protected void login_loggingIn(object sender, EventArgs e)
        {
            
            // Find the login control
            var login = livLogin.FindControl("lgiCommunityLogin") as System.Web.UI.WebControls.Login;
            var tbusername = ((TextBox) login.FindControl("username"));
            string username = ((TextBox)login.FindControl("username")).Text;
            var changeUser = PeopleHelper.GetUserByUsernameThenEmail(username);
            if(changeUser != null)
                tbusername.Text = changeUser.UserName;

        }
        protected void login_loggedIn(object sender, EventArgs e)
        {
            // Find the login control
            var login = livLogin.FindControl("lgiCommunityLogin") as System.Web.UI.WebControls.Login;
            string username = ((TextBox) login.FindControl("username")).Text;
            string password = ((TextBox) login.FindControl("password")).Text;
            
            IUser user;            
            SecurityHandler.Instance.AuthenticateUser(username, password, out user);

            var cbRememberMe = (login.FindControl("RememberMe")) as CheckBox;
            var rememberMe = cbRememberMe != null && cbRememberMe.Checked;
            
            if(user != null)
                username.CreateAuthenticatedUserCookie(rememberMe);

        }
        
        /// <summary>
        /// Handles the Login Error Event
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data</param>
        protected void login_LoginError(object sender, EventArgs e)
        {
            // Find the login control
            var login = sender as System.Web.UI.WebControls.Login;

            // Find the Literal control and set the error message
            login.FindControl("divErrorText").Visible = true;
            ((Literal)login.FindControl("litErrorText")).Text = GetErrorMessage("/login/usernamepassworderror");
        }
        /// <summary>
        /// Handles the Click event of the lbRegistration control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lbRegistration_Click(object sender, EventArgs e) 
        {
            ucRegister.Visible = true;
            ucRegister.DataBind();             
        }
       

        /// <summary>
        /// Handles the click event of the lbForgotPassword control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lbForgotPassword_Click(object sender, EventArgs e)
        {
            ucForgotPassword.Visible = true;
            ucForgotPassword.DataBind();
        }

       #endregion
    }
}