using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Community.Club;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.BookmarkFramework;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MyBookmarks : RelateUserControlBase<Model.BasePage>
    {
        public bool IsClubBookMarks { get; set; }
        public bool ShowRemoveButton { get; set; }
        public bool ShowHelp { get; set; }
        private Club _currentClub;
        public Club CurrentClub
        {
            get
            {
                if (IsClubBookMarks)
                {
                    if (_currentClub == null)
                    {
                        // The id 
                        int currentClubId;

                        // Get the club to display
                        int.TryParse(Request.QueryString[QueryStrings.ClubID], out currentClubId);

                        // Get the current club
                        _currentClub = ClubHandler.Instance.GetClub(currentClubId);
                    }
                    return _currentClub;
                }
                return null;
            }
            set
            {
                _currentClub = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            BindBookmarks();

            if (!ShowRemoveButton)
                pnlAddLinkSection.Visible = false;
            if(IsClubBookMarks)
            {
                plhInternalBookmarks2.Visible = false;
                pnlAddLinkSection.Visible =
                    CurrentUser.IsMemberOfClubGroup(CurrentClub, Enums.ClubGroupType.MembersGroup) ||
                    CurrentUser.IsAdmin();
                if (plhExternalLinks.Visible == false && pnlAddLinkSection.Visible == false)
                    pnlExternalLinksAndAddLink.Visible = false;
            }
            if(ShowHelp)
            {
                plhExternalLinksHelp.Visible = true;
                plhInternalLinksHelp.Visible = true;
            }
        }
        private void BindBookmarks()
        {
            if(CurrentClub != null)
                lvExternalBookmarks.DataSource = CurrentClub.GetBookmarks();
            else
            {
                var bookmarks = CurrentUser.GetBookmarks().ToList();
                var internalLinks = new List<BookmarkLink>();
                var externalLinks = new List<BookmarkLink>();
                foreach (var bookmarkLink in bookmarks)
                {
                    if(bookmarkLink.Link.Target != string.Empty)
                        externalLinks.Add(bookmarkLink);
                    else
                        internalLinks.Add(bookmarkLink);
                }
                lvBookmarks.DataSource = internalLinks;
                lvBookmarks.DataBind();
                lvExternalBookmarks.DataSource = externalLinks;
            }
            lvExternalBookmarks.DataBind();
        }

        protected void lbRemoveBookmark_Command(object sender, CommandEventArgs e)
        {
            var guid = e.CommandArgument.ToString();
            if (CurrentUser == null && !string.IsNullOrWhiteSpace(guid))
                return;
            if (CurrentClub != null)
            {
                var clubBookmarks = CurrentClub.GetBookmarks().Where(bookmarkLink => bookmarkLink.UniqueID.ToString() == guid).ToList();
                foreach (var bookmarkLink in clubBookmarks)
                {
                    CurrentClub.RemoveBookmark(bookmarkLink);
                }
            }
            else
            {
                var userBookmarks = CurrentUser.GetBookmarks().Where(bookmarkLink => bookmarkLink.UniqueID.ToString() == guid).ToList();
                foreach (var bookmarkLink in userBookmarks)
                {
                    CurrentUser.RemoveBookmark(bookmarkLink);
                }    
            }
            
            BindBookmarks();
        }

        protected void btnAddBookmark_Clicked(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                if (CurrentClub != null)
                    CurrentClub.AddBookmark(tbNewLinkName.Text.FormatContentTextNoHtml(), tbNewLinkUrl.Text.FormatContentTextNoHtml(), true);
                else
                    CurrentUser.AddBookmark(tbNewLinkName.Text.FormatContentTextNoHtml(), tbNewLinkUrl.Text.FormatContentTextNoHtml(), true);
            }
            tbNewLinkName.Text = string.Empty;
            tbNewLinkUrl.Text = string.Empty;
            BindBookmarks();
        }

        protected bool ShowRemoveBtn()
        {
            if (IsClubBookMarks)
                return CurrentClub.IsClubMember(CurrentUser) && ShowRemoveButton;
            return CurrentUser == DisplayUser && ShowRemoveButton;
        }
        protected string GetConfirmDelete()
        {
            return string.Format("return confirm('{0}');", Translate("/confirmdeletequestions/bookmark"));
        }
    }
}