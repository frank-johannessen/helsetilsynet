using System;
using EPiServer.Community.Club;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class ClubMembers : RelateUserControlBase<Model.BasePage>
    {
        public Club DisplayClub { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public override void DataBind()
        {
            base.DataBind();
            if (DisplayClub != null)
            {
                int totalUsers;
                ucClubMembers.Users = PeopleHelper.GetUsers(DisplayClub, 1, 1000, out totalUsers);
                ucClubMembers.DataBind();
            }
        }
    }
}