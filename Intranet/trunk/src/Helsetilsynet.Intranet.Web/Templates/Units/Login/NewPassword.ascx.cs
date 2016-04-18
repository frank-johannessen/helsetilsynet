using System;
using EPiServer.Common.Security;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login
{
    public partial class NewPassword : RelateUserControlBase<Model.BasePage>
    {
        public string UserName { get; set; }
        private static IUser _user;
        public bool ShowCurrentEmail { get; set; }
        public bool ShowErrorsDiv { get; set; }
        public bool RedirectToLoginPage { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            phErrors.Visible = ShowErrorsDiv;
            phCurrentEmail.Visible = ShowCurrentEmail;
            
            if (string.IsNullOrEmpty(UserName))
            {
                lblInfo.Text = Translate("/login/wrongurl");
                return;
            }

            _user = PeopleHelper.GetUserByUsernameThenEmail(UserName);
            if(_user == null)
            {
                pnlNewPassword.Visible = false;
                lblInfo.Text = Translate("/login/wrongurl");
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Clone the user so we can make changes
                var clonedUser = _user.Clone() as IUser;

                if (clonedUser != null)
                {
                    // Change user's password
                    clonedUser.Password = txtPassword.Text;
                    // Update the user with the new password
                    CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(clonedUser);

                    lblInfo.Text = Translate("/login/passwordchanged");

                    if (RedirectToLoginPage)
                    {
                        IUser user;
                        SecurityHandler.Instance.AuthenticateUser(clonedUser.UserName, txtPassword.Text, out user);

                        if (user != null)
                            clonedUser.UserName.CreateAuthenticatedUserCookie(false);

                        var loginPageUrl =
                            FriendlyURL.GetFriendlyURL(RelateTemplatePage<RelateGlobalSettings>.NotMemberPage, true);
                        Response.Redirect(string.Format("{0}?{1}={2}&{3}={4}", loginPageUrl, QueryStrings.ChangePasswordSuccess,
                                                        true.ToString(), QueryStrings.ReturnUrl, "/"));
                    }
                }
            }
        }
    }
}