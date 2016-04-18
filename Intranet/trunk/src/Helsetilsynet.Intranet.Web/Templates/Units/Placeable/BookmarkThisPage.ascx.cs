using System;
using EPiServer.Core;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class BookmarkThisPage : RelateUserControlBase<Model.BasePage>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Visible = CurrentPage.PageLink.ID != PageReference.StartPage.ID && CurrentPage.PageLink.ID != RelateTemplatePage<RelateGlobalSettings>.MyPage.PageLink.ID;
            if (CurrentUser.IsBookmarkedPage(Request.RawUrl))
            {
                btnBookMarkPage.Visible = false;
                btnRemoveBookMarkPage.Visible = true;
            }
                
        }

        protected void btnBookMarkPage_OnClick(object sender, EventArgs e)
        {
            if (CurrentPage.PageLink.ID == RelateTemplatePage<RelateGlobalSettings>.MyPage.PageLink.ID)
                CurrentUser.AddBookmark(CurrentUser != DisplayUser
                        ? string.Format("{0} - {1}", Translate("/general/othersmypage"), DisplayUser.GetPresentationName())
                        : Translate("/general/mypage"), Request.RawUrl, false);

            else if (CurrentPage.PageLink.ID == RelateTemplatePage<RelateGlobalSettings>.ClubHomePage.PageLink.ID)
                CurrentUser.AddBookmark(string.Format("{0} - {1}", Translate("/general/projectroom"), CurrentClub.Header), Request.RawUrl, false);
            else
                CurrentUser.AddBookmark(CurrentPage.PageName, Request.RawUrl, false);
            Response.Redirect(Request.RawUrl);
        }

        protected void btnRemoveBookMarkPage_OnClick(object sender, EventArgs e)
        {
            CurrentUser.RemoveBookmark(Request.RawUrl);
            Response.Redirect(Request.RawUrl);
        }
    }
}