using System;
using EPiServer.Community.Club;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class JoinClub : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = CurrentClub != null;
            if(CurrentClub != null)
            {
                btnJoinClub.Visible = !CurrentClub.IsClubMember(CurrentUser);
                btnLeaveClub.Visible = CurrentClub.IsClubMember(CurrentUser);   
            }
        }

        protected void btnJoinClub_OnClick(object sender, EventArgs e)
        {
            // Construct a new Membership object.
            var membership = new Membership(CurrentUser, CurrentClub) { Reason = "Reason I want to join", MembershipType = MembershipType.Member };

            // Add the membership to database.
            ClubHandler.Instance.AddMembership(membership);
            Response.Redirect(Request.RawUrl);
        }
        protected void btnLeaveClub_OnClick(object sender, EventArgs e)
        {
            ClubHandler.Instance.RemoveMembership(ClubHandler.Instance.GetMembership(CurrentClub, CurrentUser));
            Response.Redirect(Request.RawUrl);
        }
    }
}