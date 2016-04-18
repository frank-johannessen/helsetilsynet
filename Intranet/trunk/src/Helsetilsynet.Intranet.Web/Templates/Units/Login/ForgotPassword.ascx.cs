using System;
using System.Net.Mail;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Common.Data;
using EPiServer.Common.Security;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.Helpers;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login
{
    public delegate void PasswordSentHandler(string messageToSet);
    /// <summary>
    /// This control is  Forgot your Password Pop up. It will create a new password and send it by e-mail to the user.
    /// </summary>
    public partial class ForgotPassword : RelateUserControlBase<Model.BasePage>
    {
        public event PasswordSentHandler PasswordSent;

        private const string NewPasswordUrlKey = "{new_password_url}";
        private const string NewPasswordUserKey = "{new_password_user}";
        
        /// <summary>
        /// Makes the actual pop up visible
        /// </summary>
        public override void DataBind()
        {
            // Show pop up
            pnlForgotPassword.Visible = true;
               
            // Set focus on E-Mail textbox
            Page.SetFocus(txtEmail);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Visible = false;
            txtEmail.Text = String.Empty;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                SetErrorMessage(valRequiredEmail, "/registration/emailmissing");
            }

            var changeUser = PeopleHelper.GetUserByUsernameThenEmail(txtEmail.Text.Trim());
            if (changeUser == null)
            {
                SetErrorMessage(valRequiredEmail, "/login/nouserexistswithloginoremail");
            }
            else
            {
                try
                {
                    DatabaseHandler.Instance.RunInTransaction(delegate
                    {
                        // Clone the user so we can make changes
                        var clonedUser = changeUser.Clone() as IUser;

                        //// Get a new random password
                        //string newPassword = GenerateRandomPassword(8);
                        //clonedUser.Password = newPassword;
                        //// Update the user with the new password
                        //CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(clonedUser);

                        var emailFrom = CurrentPage.GlobalSettings.EmailFrom;
                        if (string.IsNullOrEmpty(emailFrom))
                        {
                            SetErrorMessage(valRequiredEmail, "/registration/emailfrommissing");
                            return;
                        }

                        var emailReceiver = changeUser.EMail;
                        // Create Mail message to send the new password
                        // The Mail Server is specified in Web.Config under <system.net> and <mailsettings>
                        var message = new MailMessage(new MailAddress(emailFrom), new MailAddress(emailReceiver))
                                          {
                                              Subject = string.IsNullOrEmpty(CurrentPage.GlobalSettings.EmailSubject)
                                                            ? Translate("/registration/newpasswordmailsubject")
                                                            : CurrentPage.GlobalSettings.EmailSubject,
                                              Body = GetEmailBody(clonedUser.UserName),
                                              IsBodyHtml = false
                                          };

                        var smtp = new SmtpClient();
                        smtp.Send(message);
                        message.Dispose();

                        // Clear the Textbox and close the popup
                        txtEmail.Text = string.Empty;
                        Visible = false;
                        PasswordSent(GetErrorMessage("/login/passwordsent"));
                    });
                }
                catch (Exception ex)
                {
                    SetErrorMessage(valRequiredEmail, ex.Message + " " + ex.StackTrace);// "/registration/emailservermissing");
                }
            }
        }

        private void SetErrorMessage(BaseValidator validator, string errorMessageKey)
        {
            validator.ErrorMessage = GetErrorMessage(errorMessageKey);
            validator.IsValid = false;
        }

        /// <summary>
        /// Generates a random Password with numbers and letters between 0-9, A-F
        /// </summary>
        /// <param name="length">The length of the password</param>
        /// <returns>A random password</returns>
        /// <remarks>The max length is 32</remarks>
        private string GenerateRandomPassword(int length)
        {
            // generate a new password
            string strGuid = System.Guid.NewGuid().ToString();
            
            // remove "-" from the password
            strGuid = strGuid.Replace("-", String.Empty);
            
            return strGuid.Substring(0, length);
        }

        private string GetEmailBody(string username)
        {
            //Get the email body from Global Settings pagetype
            var emailBody = CurrentPage.GlobalSettings.EmailBody;

            //Get url to login page
            var loginPageUrl = FriendlyURL.GetFriendlyURL(RelateTemplatePage<RelateGlobalSettings>.NotMemberPage, true);

            //Encrypt the username - we need to replace trailing equation characters to make urls clickable from email body
            var encryptedUsername = Encryptor.EncryptString(username).Replace('=', '*');

            //Prepare url to change password, which will be included in the email
            const string format = "{0}?{1}={2}";
            var changePasswordUrl = string.Format(format, loginPageUrl, QueryStrings.ChangePasswordFor, encryptedUsername);

            //Include the url in the email
            emailBody = emailBody.Replace(NewPasswordUserKey, username);
            return emailBody.Replace(NewPasswordUrlKey, changePasswordUrl);
        }
    }
}