using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using EPiServer.Community;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.PropertyUserPickerControl;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class UserPicker : RelateUserControlBase<Model.BasePage>
    {
        public List<IUser> Users
        {
            get
            {
                var rawUsers = hfUsersToAdd.Value.Split(',');
                return rawUsers.Select(u => CommunitySystem.CurrentContext.DefaultSecurity.GetUserByUserName(u)).Where(user => user != null).ToList();
            }
        } 
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}