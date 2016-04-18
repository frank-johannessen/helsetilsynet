using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Common;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class AddNewClub : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public override void DataBind()
        {
            base.DataBind();
            BindServiceAreas();
            if(CurrentClub != null)
            {
                txtName.Text = CurrentClub.Header;
                txtDescription.Text = CurrentClub.Body;
                txtProjectGoal.Text = CurrentClub.GetProjectGoal();
                txtProjectPeriod.Text = CurrentClub.GetProjectPeriod();
            }
        }
        private void BindServiceAreas()
        {
            cblServiceAreas.DataSource = Category.GetRoot().Categories;
            cblServiceAreas.DataTextField = "Name";
            cblServiceAreas.DataValueField = "ID";
            cblServiceAreas.DataBind();
        }
        protected void btnCreateClub_OnClick(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                Club clubClone;
                bool newClub = false;
                if (CurrentClub != null)
                {
                    clubClone = (Club)CurrentClub.Clone();
                    clubClone.Header = txtName.Text;
                    clubClone.Body = txtDescription.Text;
                    clubClone.SecurityStatus = rblAccessSecurity.SelectedValue != SecurityStatus.Open.ToString()
                                                   ? SecurityStatus.Closed
                                                   : SecurityStatus.Open;
                }
                else
                {
                    var club = new Club(txtName.Text, txtDescription.Text, new UserAuthor(CurrentUser))
                    {
                        Owner = CurrentUser,
                        SecurityStatus = rblAccessSecurity.SelectedValue != SecurityStatus.Open.ToString() ? SecurityStatus.Closed : SecurityStatus.Open
                    };
                    clubClone = (Club) ClubHandler.Instance.AddClub(club).Clone();
                    newClub = true;
                }

                if (fuImage.HasFile)
                {
                    EPiServer.Community.ImageGallery.Image clubLogo = fuImage.ImageUpload(txtName.Text, String.Empty, clubClone.ImageGallery, EntityStatus.Approved, CurrentUser,  null, CurrentPage.LanguageID);

                    if (clubLogo != null)
                    {
                        // Set the Attribute "BelongsToClub" for the image
                        clubLogo.ImageGallery.SetBelongsToClub(clubClone);
                        clubClone.Logotype = clubLogo;
                    }
                    
                }

                clubClone.SetProjectGoal(txtProjectGoal.Text);
                clubClone.SetProjectPeriod(txtProjectPeriod.Text);

                var serviceAreas = cblServiceAreas.Items.Cast<ListItem>().Where(serviceArea => serviceArea.Selected).Aggregate(string.Empty, (current, serviceArea) => current + (serviceArea.Value + ","));
                clubClone.SetServiceAreas(serviceAreas);

                var usersToAdd = ucUserPicker.Users;
                foreach (var user in usersToAdd)
                {
                    var membership = ClubHandler.Instance.GetMembership(clubClone, user);
                    if(membership != null)
                    {
                        var clone = (Membership)membership.Clone();
                        clone.MembershipType = MembershipType.Member;
                        ClubHandler.Instance.UpdateMembership(clone);
                    }
                    else
                    {
                        ClubHandler.Instance.AddMembership(new Membership(user, clubClone) { MembershipType = MembershipType.Member });    
                    }
                }

                ClubHandler.Instance.UpdateClub(clubClone);
                if(newClub)
                    ActivityFeedHandler.PublishNewClub(clubClone);
                Response.Redirect(clubClone.GetClubUri().ToString());
            }
        }
        
        protected void lbCancel_OnClick(object sender, CommandEventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void rblAccessSecurity_OnDataBound(object sender, EventArgs e)
        {
            if (CurrentClub != null)
            {
                rblAccessSecurity.SelectedValue = CurrentClub.SecurityStatus == SecurityStatus.Open ? SecurityStatus.Open.ToString() : SecurityStatus.Closed.ToString();
            }
        }

        protected void cblServiceAreas_OnDataBound(object sender, EventArgs e)
        {
            if (CurrentClub != null)
            {
                var preSelected = CurrentClub.GetServiceAreas();
                foreach (ListItem li in ((CheckBoxList)sender).Items)
                {
                    foreach (var category in preSelected)
                    {
                        if (li.Value == category.ID.ToString())
                        {
                            li.Selected = true;
                        }
                    }
                }
            }
        }

        protected void valFileUpload_OnServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!fuImage.FileName.ValidImageFile())
            {
                valFileUpload.ErrorMessage = GetErrorMessage(Translate("/createclub/imageformatinvalid"));
                valFileUpload.IsValid = false;
            }
            args.IsValid = fuImage.FileName.ValidImageFile();
        }
    }
}