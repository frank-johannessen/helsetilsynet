using System;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ResponsibleAuthor : UserControlBase<Model.BasePage>
    {
        public string UserName { private get; set; }

        protected IUser User { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UserName))
            {
                Visible = false;
                return;
            }
            User = UserName.GetUserFromUserName();
            phEmail.Visible = String.Empty != GetEmailToShow();

        }

        protected string GetEmailToShow()
        {
            if (User == null)
            {
                return String.Empty;
            }
            var email = User.EMail.Split('@')[1].Split('.')[0].ToLower();

            return !IsDepartmentUser(email) ? User.EMail : string.Empty;
        }

        private static bool IsDepartmentUser(string email)
        {
            return email == AttributeNames.DepartmentUser;
        }
    }
}