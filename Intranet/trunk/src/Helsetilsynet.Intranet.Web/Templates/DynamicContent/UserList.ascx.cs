using System;
using System.Linq;
using EPiServer.Common.Security;
using EPiServer.DynamicContent;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions.PropertyUserPickerControl;
using PropertyUserPicker = MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.PropertyUserPickerControl.PropertyUserPicker;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{

    [DynamicContentPlugIn(DisplayName = "UserList",
        ViewUrl = "~/Templates/DynamicContent/UserList.ascx")]
    public partial class UserList : UserControlBase<BasePage>
    {
        public PropertyUserPicker UserPicker { get; set;}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserPicker == null)
                return;

            var value = UserPicker.Value;
            if (value == null || string.IsNullOrEmpty(value.ToString()))
                return;

            var userList = value.ToString().Trim(',').Split(',');

            var users = new UserCollection();
            foreach (var user in userList.Where(userName => !string.IsNullOrWhiteSpace(userName))
                .Select(userName => userName.GetUserFromUserName())
                .Where(user => user != null && !users.Contains(user)))
            {
                users.Add(user);
            }

            //var users2 = new UserCollection() {users};

            ucDisplayUserCollection.Users = users;
            ucDisplayUserCollection.DataBind();
        }
    }
}