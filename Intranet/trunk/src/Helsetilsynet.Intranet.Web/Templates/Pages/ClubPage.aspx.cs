using System;
using System.Web.UI.WebControls;
using EPiServer.Community.Blog;
using EPiServer.Community.Club;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;
using SecurityStatus = EPiServer.Community.Club.SecurityStatus;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class ClubPage : RelateTemplatePage<Model.ClubPage>
    {
        private Club _currentClub;
        public Club CurrentClub
        {
            get
            {
                if (_currentClub == null)
                {
                    // The id 
                    int currentClubId;

                    // Get the club to display
                    int.TryParse(Request.QueryString[QueryStrings.ClubID], out currentClubId);

                    // Get the current club
                    _currentClub = ClubHandler.Instance.GetClub(currentClubId);
                    if (_currentClub == null)
                        RedirectToClubErrorPage(currentClubId);
                }

                return _currentClub;
            }
            set { _currentClub = value; }
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "groups-and-persons project";

            if (CurrentClub.SecurityStatus == SecurityStatus.Closed && !CurrentClub.IsClubMember(CurrentUser))
                RedirectToAccessViolationPage();


            BindCalendar();
            BindWall();
            
            if (!CurrentClub.IsCalmayersCorner())
            {
                BindMembers();
                ucClubMembers.Visible = true;
            }
            BindBlogToWall();
            if (CurrentClub.IsClubMember(CurrentUser))
            {
                plhClubForumTab.Visible = true;
                BindBlogToForum();
            }
        
            SetRightsForButtons();
        }

        private void SetRightsForButtons()
        {
            btnEditClub.Visible = IsCurrentUserAdminOrOwner(CurrentClub);
        }

        private void BindWall()
        {
            if (CurrentClub != null)
            {
                BindNews();
                if (CurrentClub.IsClubMember(CurrentUser))
                    BindForum();
            }
        }

        private void BindNews()
        {
            int totalnews;
            lvProjectWall.DataSource = CurrentClub.NewsBlog.GetNewsWithQuery(newsPager.CurrentPagingNumber, 20, out totalnews);
            lvProjectWall.DataBind();
            newsPager.BindPagerControl(20, totalnews);            
        }

        private void BindForum()
        {
            int totalForumEntries;
            lvProjectForum.DataSource = CurrentClub.MessageBlog.GetNewsWithQuery(newsPager.CurrentPagingNumber, 20, out totalForumEntries);
            lvProjectForum.DataBind();
            forumPager.BindPagerControl(20, totalForumEntries);
        }

        private void BindMembers()
        {
            ucClubMembers.DisplayClub = CurrentClub;
            ucClubMembers.DataBind();
        }

        private void BindCalendar()
        {
            ucCalendar.Calendar = CurrentClub.Calendar;
            ucCalendar.ShowAddEventButton = CurrentClub.IsClubMember(CurrentUser);
            ucCalendar.DataBind();
        }
        
        protected void lbDeleteEntry_OnClick(object sender, CommandEventArgs e)
        {
            var entry = BlogHandler.Instance.GetEntry(int.Parse(e.CommandArgument.ToString()));
            if(entry != null && HasRemoveAccessRights(entry))
            {
                BlogHandler.Instance.RemoveEntry(entry);
            }
            BindWall();
        }

        protected void BindBlogToWall()
        {
            ucCreateBlogEntryWall.Blog = CurrentClub.NewsBlog;
            ucCreateBlogEntryWall.RedirectUrl = string.Format("{0}#wall", Request.RawUrl);
            ucCreateBlogEntryWall.DataBind();
        }
        
        protected void BindBlogToForum()
        {
            ucCreateBlogEntryForum.Blog = CurrentClub.MessageBlog;
            ucCreateBlogEntryForum.RedirectUrl = string.Format("{0}#forum", Request.RawUrl);
            ucCreateBlogEntryForum.DataBind();
        }
        
        protected void btnEditClub_OnClick(object sender, EventArgs e)
        {
            ucAddNewClub.Visible = true;
            ucAddNewClub.DataBind();
        }
        protected string GetConfirmDelete()
        {
            return string.Format("return confirm('{0}');", Translate("/confirmdeletequestions/blogentry"));
        }
    }
}