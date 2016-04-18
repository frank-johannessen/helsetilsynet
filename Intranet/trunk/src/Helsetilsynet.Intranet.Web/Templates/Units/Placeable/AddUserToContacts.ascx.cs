using System;
using System.Linq;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class AddUserToContacts : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = CurrentPage.PageLink.ID == RelateTemplatePage<RelateGlobalSettings>.MyPage.PageLink.ID && DisplayUser != CurrentUser;
            if(CurrentUser.GetContacts().Contains(DisplayUser))
            {
                lbAddToContacts.Visible = false;
                lbRemoveFromContacts.Visible = true;
            }
        }

        protected void lbAddToContacts_OnClick(object sender, EventArgs e)
        {
            if(CurrentUser != null && DisplayUser != null && CurrentUser != DisplayUser)
            {
                CurrentUser.AddContact(DisplayUser);
                ActivityFeedHandler.SubscribeUserToUser(CurrentUser, DisplayUser);
                Response.Redirect(Request.RawUrl);    
            }
        }

        protected void lbRemoveFromContacts_OnClick(object sender, EventArgs e)
        {
            var contactToRemove = CommunitySystem.CurrentContext.DefaultSecurity.GetUser(DisplayUser.ID);

            if (contactToRemove != null && DisplayUser != CurrentUser)
            {
                CurrentUser.RemoveContact(contactToRemove);
                ActivityFeedHandler.UnSubscribeUserFromUser(CurrentUser, DisplayUser);
            }
            Response.Redirect(Request.RawUrl);
        }
    }
}