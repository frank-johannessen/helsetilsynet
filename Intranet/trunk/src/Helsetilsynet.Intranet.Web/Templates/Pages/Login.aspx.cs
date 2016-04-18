using System;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class Login : RelateTemplatePage<Model.Login>
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            var returnUrl = Request.QueryString[QueryStrings.ReturnUrl] ?? "/";
            if (IsGoogleMiniIP())
            {
            
                var username = ConfigurationManager.AppSettings[GlobalName.GoogleMini.UserAccountName];
                var password = ConfigurationManager.AppSettings[GlobalName.GoogleMini.UserAccountPassword];

                IUser user;
                SecurityHandler.Instance.AuthenticateUser(username, password, out user);
                if (user != null)
                {
                    username.CreateAuthenticatedUserCookie(true);
                    if (user.IsFirstTimeLogin())
                        user.IsFirstTimeLogin(false);
                }
                    
                Response.Redirect(returnUrl);
            }
            if(Request.QueryString[QueryStrings.ReturnUrl] != null && CurrentUser != null)
                Response.Redirect(returnUrl);

            if(Convert.ToBoolean(Request.QueryString[QueryStrings.ChangePasswordSuccess]))
            {
                litInfoText.Text = Translate("/login/passwordchanged");
                litInfoText.DataBind();
            }
        }

        protected void OnAuthenticate(object sender, AuthenticateEventArgs e)
        {
            bool authenticated;

            string username = ((System.Web.UI.WebControls.Login) (sender)).UserName;
            string password = ((System.Web.UI.WebControls.Login) (sender)).Password;
            
            try
            {
                authenticated = Membership.ValidateUser(username, password);
            }
            catch
            {
                authenticated = false;
            }
            e.Authenticated = authenticated;
        }

        private bool IsGoogleMiniIP()
        {
            return Request.UserHostAddress == ConfigurationManager.AppSettings[GlobalName.GoogleMini.HostAddress];
        }
    }
}