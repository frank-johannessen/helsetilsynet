using System;
using EPiServer.Community.Club;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MyClubs : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var clubs = DisplayUser.GetMyClubs();
            var clubsToBind = new ClubCollection();
            foreach (var club in clubs)
            {
                if(club.SecurityStatus == SecurityStatus.Open || club.IsClubMember(CurrentUser))
                {
                    clubsToBind.Add(club);
                }
            }
            lvMyClubs.DataSource = clubsToBind;
            lvMyClubs.DataBind();
        }
    }
}