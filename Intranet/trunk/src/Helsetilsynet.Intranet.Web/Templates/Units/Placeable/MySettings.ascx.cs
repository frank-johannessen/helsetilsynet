using System;
using System.Configuration;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MySettings : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public override void DataBind()
        {
            base.DataBind();
            BindServiceAreas();
            BindClubs();
            BindUsers();
            BindExternalSystems();
            if (CurrentUser.IsC1FrontPage())
                rbWorkplaceC1.Checked = true;
            else
                rbWorkplaceFylkesmannen.Checked = true;
            
            tbRssFeed.Text = !string.IsNullOrWhiteSpace(CurrentUser.GetHelsetilsynetRssFeed())
                                 ? CurrentUser.GetHelsetilsynetRssFeed()
                                 : RelateTemplatePage<RelateGlobalSettings>.HelsetilsynetStandardRssFeed;
        }
        private void BindUsers()
        {
            var contacts = CurrentUser.GetContacts();
            if(contacts.Count < 1)
            {
                EmptyMembersText.Text = Translate("/mysettings/nousers");
                EmptyMembersText.Visible = true;
            }
            cblUsers.DataSource = contacts;
            cblUsers.DataValueField = "ID";
            cblUsers.DataBind();
        }

        private void BindClubs()
        {
            var clubs = CurrentUser.GetMyClubs();
            if (clubs.Count < 1)
            {
                EmptyProjectRoomText.Text = Translate("/mysettings/noprojectrooms");
                EmptyProjectRoomText.Visible = true;
            }
            cblClubs.DataSource = clubs;
            cblClubs.DataTextField = "Header";
            cblClubs.DataValueField = "ID";
            cblClubs.DataBind();
        }

        private void BindServiceAreas()
        {
            cblServiceAreas.DataSource = Category.GetRoot().Categories;
            cblServiceAreas.DataTextField = "Name";
            cblServiceAreas.DataValueField = "ID";
            cblServiceAreas.DataBind();
        }

        private void BindExternalSystems()
        {
            cblExternalSystems.DataSource = ExternalSystemsConfig.ExternalSystems;
            cblExternalSystems.DataValueField = "id";
            cblExternalSystems.DataTextField = "name";
            cblExternalSystems.DataBind();
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSaveSettings_OnClick(object sender, EventArgs e)
        {
            var returnUrl = Request.RawUrl;
            if(CurrentUser != null)
            {
                var user = (IUser)CurrentUser.Clone();
                
                SaveFrontPageSettings();
                SaveServiceAreas();
                SaveClubs();
                SaveContacts();

                var externalSystems = cblExternalSystems.Items.Cast<ListItem>().Where(externalSystem => externalSystem.Selected).Aggregate
                        (string.Empty, (current, externalSystem) => current + (externalSystem.Value + ","));

                user.SetExternalSystems(externalSystems);

                if (CurrentUser.IsFirstTimeLogin())
                {
                    returnUrl = CurrentUser.GetMyPageUri().ToString();
                    user.IsFirstTimeLogin(false);
                }
                user.SetHelsetilsynetRssFeed(tbRssFeed.Text);
                CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);
            }
            Response.Redirect(returnUrl);
        }

        private void SaveFrontPageSettings()
        {
            var calmeyersCornerClub = ClubHandler.Instance.GetClub(int.Parse(ConfigurationManager.AppSettings[GlobalName.AppSettings.CalmeyersCornerClubId]));
            if (calmeyersCornerClub != null)
            {
                var membership = ClubHandler.Instance.GetMembership(calmeyersCornerClub, CurrentUser);
                if (rbWorkplaceC1.Checked)
                {
                    if (membership == null)
                    {
                        ClubHandler.Instance.AddMembership(new Membership(CurrentUser, calmeyersCornerClub));
                        ActivityFeedHandler.SubscribeUserToClub(CurrentUser, calmeyersCornerClub);
                    }
                    
                }
                else
                {
                    if (membership != null)
                    {
                        ClubHandler.Instance.RemoveMembership(membership);
                        ActivityFeedHandler.UnSubscribeUserFromClub(CurrentUser, calmeyersCornerClub);
                    }
                }
            }
            CurrentUser.IsC1FrontPage(rbWorkplaceC1.Checked);
        }

        private void SaveServiceAreas()
        {
            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetServiceAreasFromTopicString(topics);
            foreach (ListItem listItem in cblServiceAreas.Items)
            {
                var category = Category.Find(int.Parse(listItem.Value));
                if (category != null)
                {
                    if (listItem.Selected && preSelected.All(o => o.ID != int.Parse(listItem.Value)))
                        ActivityFeedHandler.SubscribeUserToServiceArea(CurrentUser, category);

                    else if (listItem.Selected == false && preSelected.Any(o => o.ID == int.Parse(listItem.Value)))
                        ActivityFeedHandler.UnSubscribeUserFromServiceArea(CurrentUser, category);
                }
            }
        }

        private void SaveClubs()
        {
            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetClubsFromTopicString(topics);
            foreach (ListItem listItem in cblClubs.Items)
            {
                var club = ClubHandler.Instance.GetClub(int.Parse(listItem.Value));
                if (club != null)
                {
                    if (listItem.Selected && preSelected.All(o => o.ID != int.Parse(listItem.Value)))
                        ActivityFeedHandler.SubscribeUserToClub(CurrentUser, club);

                    else if (listItem.Selected == false && preSelected.Any(o => o.ID == int.Parse(listItem.Value)))
                        ActivityFeedHandler.UnSubscribeUserFromClub(CurrentUser, club);
                }
            }
        }

        private void SaveContacts()
        {
            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetUsersFromTopicString(topics);
            
            foreach (ListItem listItem in cblUsers.Items)
            {
                var contact = SecurityHandler.Instance.GetUser(int.Parse(listItem.Value));
                if (contact != null)
                {
                    if (listItem.Selected && preSelected.All(o => o.ID != int.Parse(listItem.Value)))
                        ActivityFeedHandler.SubscribeUserToUser(CurrentUser, contact);

                    else if (listItem.Selected == false && preSelected.Any(o => o.ID == int.Parse(listItem.Value)))
                        ActivityFeedHandler.UnSubscribeUserFromUser(CurrentUser, contact);
                }
            }
        }

        protected void cblExternalSystems_OnDataBound(object sender, EventArgs e)
        {
            var preSelected = CurrentUser.GetExternalSystemsId();
            foreach (ListItem externalSystem in cblExternalSystems.Items)
            {
                foreach (var system in preSelected)
                {
                    if (externalSystem.Value == system)
                        externalSystem.Selected = true;
                }
            }
        }

        protected void cblServiceAreas_OnDataBound(object sender, EventArgs e)
        {
            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetServiceAreasFromTopicString(topics);
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                foreach (var serviceArea in preSelected)
                {
                    if (li.Value == serviceArea.ID.ToString())
                    {
                        li.Selected = true;
                    }
                }
            }
        }

        protected void cblClubs_OnDataBound(object sender, EventArgs e)
        {
            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetClubsFromTopicString(topics);
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                foreach (var club in preSelected)
                {
                    if (li.Value == club.ID.ToString())
                    {
                        li.Selected = true;
                    }
                }
            }
        }

        protected void cblUsers_OnDataBound(object sender, EventArgs e)
        {
            foreach (ListItem user in cblUsers.Items)
            {
                user.Text = SecurityHandler.Instance.GetUser(int.Parse(user.Value)).GetPresentationName();
            }

            var topics = CurrentUser.GetActivityfeedTopics();
            var preSelected = TopicFormats.GetUsersFromTopicString(topics);
            
            foreach (ListItem li in ((CheckBoxList)sender).Items)
            {
                foreach (var user in preSelected)
                {
                    if (li.Value == user.ID.ToString())
                    {
                        li.Selected = true;
                    }
                }
            }
        }
    }
}