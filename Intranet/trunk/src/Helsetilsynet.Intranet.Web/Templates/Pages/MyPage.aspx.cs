using System;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community.MyPage;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class MyPage : RelateTemplatePage<Model.MyPage>
    {
        private EPiServer.Community.MyPage.MyPage _myPage;
        public EPiServer.Community.MyPage.MyPage CurrentMyPage
        {
            get
            {
                if (_myPage == null && DisplayUser != null)
                {
                    _myPage = MyPageHandler.Instance.GetMyPage(DisplayUser);
                }

                return _myPage;
            }
        }

        protected bool EditUserAsAdmin { get; set; }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            //set page title to more than "my-page"
            Page.Title = GetTitle();

            CurrentPage.LayoutClassName = "groups-and-persons user-profile " +
                                          (DisplayUser != CurrentUser ? "other-user" : "current-user");

            
            CheckCredentials();
            ucMyInfo.Users = new UserCollection{DisplayUser};
            ucMyInfo.DataBind();

            if(CurrentUser == DisplayUser || EditUserAsAdmin)
            {
                //Denne binder controllen, selv under pageload, som gjør at de gamle verdiene blir lastet inn. Må FIXES
                SetDisplayMode();
                
            }

            btnEditUserAsAdmin.Visible = DisplayUser != CurrentUser && CurrentUser.IsAdmin();
        }

        private void SetDisplayMode()
        {
            if (CurrentUser == DisplayUser || EditUserAsAdmin)
            {
                pnlPersonalInfo.Visible = false;
                ucEditProfile.DataBind();
                ucEditProfile.Visible = true;
                ucMyBookmarks.Visible = true;
                ucMyContacts.Visible = true;
                btnOpenSettings.Visible = true;
                plhLogOut.Visible = true;
                if (CurrentUser.IsFirstTimeLogin())
                {
                    ucMySettings.DataBind();
                    ucMySettings.Visible = true;
                }
            }
        }

        public string GetTitle()
        {
            return CurrentUser != DisplayUser ? string.Format("{0} - {1}", Translate("/general/othersmypage"), DisplayUser.GetPresentationName()) : Translate("/general/mypage");
        }

        private void CheckCredentials()
        {
            if (DisplayUser == null || DisplayUser.Status != EntityStatus.Approved)
            {
                RedirectToMemberDeletedPage();
                return;
            }
            if (CurrentUser.ID != DisplayUser.ID)
            {
                if (CurrentMyPage.Status == EntityStatus.Removed)
                {
                    RedirectToAccessViolationPage();
                }

                if (CurrentMyPage.Status != EntityStatus.Approved && !IsCurrentUserAdminOrOwner(CurrentMyPage.User))
                {
                    RedirectToAccessViolationPage();
                }
            }
        }
        
        protected void btnOpenSettings_OnClick(object sender, EventArgs e)
        {
            ucMySettings.DataBind();
            ucMySettings.Visible = true;
        }

        protected void btnEditUserAsAdmin_OnClick(object sender, EventArgs e)
        {
            EditUserAsAdmin = true;
            pnlPersonalInfo.Visible = false;
            ucEditProfile.DataBind();
            ucEditProfile.BindEditControls(); 
            ucEditProfile.Visible = true;
            //SetDisplayMode();
        }
    }
}