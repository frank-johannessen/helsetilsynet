using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using EPiServer;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Core;
using EPiServer.Web;
using PageTypeBuilder;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace Relate.HelpersAndExtensions
{
    public partial class RelateTemplatePage<T> : TemplatePage<T> where T : TypedPageData
    {
        protected virtual void Page_Load(object sender, EventArgs e)
        {
            if (CurrentUser != null) 
                return;
            if(CurrentPage != NotMemberPage)
                NotLoggedInRedirect();
        }
        public static void ClearRelateGlobalSettings()
        {
            _relateGlobalSettings = null;
        }
        #region private properties
        /// <summary>
        /// The current logged in user
        /// </summary>        
        private IUser _currentUser;

        /// <summary>
        /// The user that owns the page we are looking at
        /// </summary>
        private IUser _displayUser;

        /// <summary>
        /// The start page
        /// </summary>
        private static RelateGlobalSettings _relateGlobalSettings;
        public static RelateGlobalSettings RelateGlobalSettings
        {
            get
            {
                return _relateGlobalSettings ?? 
                    DataFactory.Instance.GetPage(new PageReference(((PageReference)DataFactory.Instance.GetPage(PageReference.StartPage)["RelateGlobalSettingsPage"]).ID)) as RelateGlobalSettings;
            }
        } 
        
        /// <summary>
        /// The image galleries page
        /// </summary>
        private static PageData _imageGalleriesPage;

        /// <summary>
        /// The My Page
        /// </summary>
        private static PageData _myPage;

        /// <summary>
        /// The my image gallery page
        /// </summary>
        private static PageData _myImageGalleryPage;

        /// <summary>
        /// The my images page
        /// </summary>
        private static PageData _myImagesPage;

        /// <summary>
        /// The my blog page
        /// </summary>
        private static PageData _myBlogPage;

        /// <summary>
        /// The video gallery page
        /// </summary>
        private static PageData _videoGalleryPage;

        /// <summary>
        /// The my settings page
        /// </summary>
        private static PageData _mySettingsPage;

        /// <summary>
        /// The club page
        /// </summary>
        private static PageData _clubPage;

        /// <summary>
        /// The club home page
        /// </summary>
        private static PageData _clubHomePage;

        /// <summary>
        /// The club event page
        /// </summary>
        private static PageData _clubEventPage;

        /// <summary>
        /// The club members page
        /// </summary>
        private static PageData _clubMembersPage;

        /// <summary>
        /// The club forum page
        /// </summary>
        private static PageData _clubForumPage;

        /// <summary>
        /// The club image gallery page
        /// </summary>
        private static PageData _clubImageGalleryPage;

        /// <summary>
        /// The Club error page
        /// </summary>
        private static PageData _clubErrorPage;

        /// <summary>
        /// The club wall page
        /// </summary>
        private static PageData _clubWallPage;

        /// <summary>
        /// The Club article page
        /// </summary>
        private static PageData _clubArticlePage;

        /// <summary>
        /// The topic page
        /// </summary>
        private static PageData _topicPage;

        /// <summary>
        /// The room page
        /// </summary>
        private static PageData _roomPage;
        /// <summary>
        /// The not member page
        /// </summary>
        private static PageData _notMemberPage;

        /// <summary>
        /// The general error page
        /// </summary>
        private static PageData _generalErrorPage;

        /// <summary>
        /// The access violation page
        /// </summary>
        private static PageData _accessViolationPage;

        /// <summary>
        /// The member deleted page
        /// </summary>
        private static PageData _memberDeletedPage;

        
        #endregion

        #region Properties

        /// <summary>
        /// Gets the current user in the form of a IUser interface
        /// </summary>
        public IUser CurrentUser
        {
            get
            {
                if (_currentUser != null)
                    return _currentUser;

                _currentUser = CommunitySystem.CurrentContext.DefaultSecurity.CurrentUser;

                #region Helsetilsynet specific

                if (_currentUser == null && IsGoogleMiniIP())
                {
                    var username = ConfigurationManager.AppSettings["GoogleMini.UserAccountName"];
                    var password = ConfigurationManager.AppSettings["GoogleMini.UserAccountPassword"];

                    IUser user;
                    SecurityHandler.Instance.AuthenticateUser(username, password, out user);
                    if (user != null)
                        _currentUser = user;
                }

                #endregion

                return _currentUser;
            }
        }

        #region Helsetilsynet specific
        private bool IsGoogleMiniIP()
        {
            return Request.UserHostAddress == ConfigurationManager.AppSettings["GoogleMini.HostAddress"];
        }
        #endregion

        // YOU NEED TO IMPLEMENT WHAT THIS USER SHOULD BE!
        private AnonymousUser _currentAnonymousUser;
        public AnonymousUser CurrentAnonymousUser
        {
            get
            {
                if (_currentAnonymousUser == null)
                {
                    _currentAnonymousUser = (AnonymousUser)HttpContext.Current.Session[RelateConstants.AnonymousUserName];

                    if (_currentAnonymousUser == null)
                    {
                        _currentAnonymousUser = new AnonymousUser(RelateConstants.AnonymousUserName);
                        HttpContext.Current.Session[RelateConstants.AnonymousUserName] = _currentAnonymousUser;
                    }
                }

                return _currentAnonymousUser;
            }
        }
        private IEntity _globalTarget;
        public IEntity GlobalTarget
        {
            get {
                return _globalTarget ??
                       (_globalTarget =
                        SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityMembersGroupName) ??
                        SecurityHandler.Instance.AddGroup(new Group(RelateConstants.CommunityMembersGroupName)));
            }
        }

        /// <summary>
        /// Gets or sets the user to display data from
        /// </summary>
        public IUser DisplayUser
        {
            get
            {
                if (_displayUser == null)
                {
                    // Get the user id from the query string
                    int userId;
                    var isUserId = int.TryParse(Request.QueryString[QueryStrings.UserID], out userId);
                    _displayUser = isUserId ? CommunitySystem.CurrentContext.DefaultSecurity.GetUser(userId) : CurrentUser;
                }

                return _displayUser;
            }
        }



        /// <summary>
        /// Gets whether the logged in user is part of the administrator group
        /// </summary>
        public bool IsAdmin
        {
            get
            {
                // If there is user that is logged in check that user
                if (CurrentUser != null)
                {
                    return CurrentUser.IsAdmin();
                }

                return false;
            }
        }

        #endregion
        #region Public static properties

        /// <summary>
        /// Gets my page.
        /// </summary>
        /// <value>My page.</value>
        public static PageData MyPage
        {
            get { return _myPage ?? (_myPage = DataFactory.Instance.GetPage(RelateGlobalSettings.MyPage ?? GeneralErrorPage.PageLink)); }
        }

        /// <summary>
        /// Gets the image galleries page.
        /// </summary>
        /// <value>The image galleries page.</value>
        public static PageData ImageGalleriesPage
        {
            get
            {
                return _imageGalleriesPage ??
                       (_imageGalleriesPage =
                        DataFactory.Instance.GetPage(RelateGlobalSettings.ImageGalleriesPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets my image gallery page.
        /// </summary>
        /// <value>My image gallery page.</value>
        public static PageData MyImageGalleryPage
        {
            get
            {
                return _myImageGalleryPage ??
                       (_myImageGalleryPage =
                        DataFactory.Instance.GetPage(RelateGlobalSettings.MyImageGalleryPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets my images page.
        /// </summary>
        /// <value>My images page.</value>
        public static PageData MyImagesPage
        {
            get
            {
                return _myImagesPage ??
                       (_myImagesPage = DataFactory.Instance.GetPage(RelateGlobalSettings.MyImagesPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets my blog page.
        /// </summary>
        /// <value>My blog page.</value>
        public static PageData MyBlogPage
        {
            get
            {
                return _myBlogPage ??
                    (_myBlogPage = DataFactory.Instance.GetPage(RelateGlobalSettings.MyBlogPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the video gallery page.
        /// </summary>
        /// <value>The video gallery page.</value>
        public static PageData VideoGalleryPage
        {
            get
            {
                return _videoGalleryPage ??
                       (_videoGalleryPage = DataFactory.Instance.GetPage(RelateGlobalSettings["VideoGalleryPage"] as PageReference ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets my settings page.
        /// </summary>
        /// <value>My settings page.</value>
        public static PageData MySettingsPage
        {
            get
            {
                return _mySettingsPage ??
                       (_mySettingsPage = DataFactory.Instance.GetPage(RelateGlobalSettings.MySettingsPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club page.
        /// </summary>
        /// <value>The club page.</value>
        public static PageData ClubPage
        {
            get { return _clubPage ?? (_clubPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubPage ?? GeneralErrorPage.PageLink)); }
        }

        /// <summary>
        /// Gets the club page.
        /// </summary>
        /// <value>The club page.</value>
        public static PageData ClubHomePage
        {
            get
            {
                return _clubHomePage ??
                       (_clubHomePage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubHomePage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club event page.
        /// </summary>
        /// <value>The club event page.</value>
        public static PageData ClubEventPage
        {
            get
            {
                return _clubEventPage ??
                       (_clubEventPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubEventPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club members page.
        /// </summary>
        /// <value>The club members page.</value>
        public static PageData ClubMembersPage
        {
            get
            {
                return _clubMembersPage ??
                       (_clubMembersPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubMembersPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club forum page.
        /// </summary>
        /// <value>The club forum page.</value>
        public static PageData ClubForumPage
        {
            get
            {
                return _clubForumPage ??
                       (_clubForumPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubForumPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club image gallery page.
        /// </summary>
        /// <value>The club image gallery page.</value>
        public static PageData ClubImageGalleryPage
        {
            get
            {
                return _clubImageGalleryPage ??
                       (_clubImageGalleryPage =
                        DataFactory.Instance.GetPage(RelateGlobalSettings.ClubImageGalleryPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club error page.
        /// </summary>
        /// <value>The club error page.</value>
        public static PageData ClubErrorPage
        {
            get
            {
                return _clubErrorPage ??
                       (_clubErrorPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubErrorPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club Wall page.
        /// </summary>
        /// <value>The club wall pagedata.</value>
        public static PageData ClubWallPage
        {
            get
            {
                return _clubWallPage ??
                       (_clubWallPage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubWallPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the club article page.
        /// </summary>
        /// <value>The club article page.</value>
        public static PageData ClubArticlePage
        {
            get
            {
                return _clubArticlePage ??
                       (_clubArticlePage = DataFactory.Instance.GetPage(RelateGlobalSettings.ClubArticlePage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the topic page.
        /// </summary>
        /// <value>The topic page.</value>
        public static PageData TopicPage
        {
            get
            {
                return _topicPage ??
                       (_topicPage = DataFactory.Instance.GetPage(RelateGlobalSettings.TopicPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the room page.
        /// </summary>
        /// <value>The room page.</value>
        public static PageData RoomPage
        {
            get { return _roomPage ?? (_roomPage = DataFactory.Instance.GetPage(RelateGlobalSettings.RoomPage ?? GeneralErrorPage.PageLink)); }
        }

        /// <summary>
        /// Gets the not member page.
        /// </summary>
        /// <value>The not member page.</value>
        public static PageData NotMemberPage
        {
            get {
                return _notMemberPage ??
                       (_notMemberPage = DataFactory.Instance.GetPage(RelateGlobalSettings.NotMemberPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the error page to which the requesting browser is redirected in the event of an unhandled page exception.
        /// </summary>
        /// <value>The error page to which the browser is redirected.</value>
        public static PageData GeneralErrorPage
        {
            get
            {
                return _generalErrorPage ??
                       (_generalErrorPage = DataFactory.Instance.GetPage(RelateGlobalSettings.GeneralErrorPage ?? PageReference.StartPage));
            }
        }

        /// <summary>
        /// Gets the access violation page.
        /// </summary>
        /// <value>The access violation page.</value>
        public static PageData AccessViolationPage
        {
            get
            {
                return _accessViolationPage ??
                       (_accessViolationPage =
                        DataFactory.Instance.GetPage(RelateGlobalSettings.AccessViolationPage ?? GeneralErrorPage.PageLink));
            }
        }

        /// <summary>
        /// Gets the member deleted page.
        /// </summary>
        /// <value>The member deleted page</value>
        public static PageData MemberDeletedPage
        {
            get
            {
                return _memberDeletedPage ??
                       (_memberDeletedPage =
                        DataFactory.Instance.GetPage(RelateGlobalSettings.MemberDeletedPage ?? GeneralErrorPage.PageLink));
            }
        }
        

        #endregion

        #region Public methods
        /// <summary>
        /// Checks if the supplied user is the same user as the current logged in user.
        /// </summary>
        /// <param name="objectOwner">The user that owns the object</param>
        /// <returns>True if the current logged in user is owner</returns>
        public bool IsLoggedInUser(IUser objectOwner)
        {
            var isOwner = CurrentUser != null && objectOwner != null && objectOwner.ID == CurrentUser.ID;

            // If there exists a current user

            return isOwner;
        }

        /// <summary>
        /// Checks if the supplied user is the same user as the current logged in user.
        /// </summary>
        /// <param name="objectAuthor">The author of the object</param>
        /// <returns>True if the current logged in user is author</returns>
        protected bool IsLoggedInUser(IAuthor objectAuthor)
        {
            var isOwner = false;

            var userAuthor = objectAuthor as UserAuthor;

            // If there exists a current user
            if (userAuthor != null && userAuthor.User != null && IsLoggedInUser(userAuthor.User))
            {
                isOwner = true;
            }

            return isOwner;
        }

        ///// <summary>
        ///// Checks if the current user is member of administrator group or
        ///// the same user as the owner
        ///// </summary>
        ///// <param name="objectOwner">The user that owns the object</param>
        ///// <returns>True if the current logged in user is admin or owner</returns>
        //public bool IsCurrentUserAdminOrOwner(IUser objectOwner)
        //{
        //    var isAdminOrOwner = CurrentUser != null && ((objectOwner != null && objectOwner.ID == CurrentUser.ID) || IsAdmin);

        //    return isAdminOrOwner;
        //}
        protected bool IsCurrentUserAdminOrOwner(ISecurableEntity entity)
        {
            return CurrentUser.IsAdmin() || HasRemoveAccessRights(entity);
        }
        
        ///// <summary>
        ///// Checks if the current user is member of administrator group or
        ///// the same user as the owner
        ///// </summary>
        ///// <param name="objectOwner">The user that owns the object</param>
        ///// <returns>True if the current logged in user is admin or owner</returns>
        //public bool IsCurrentUserAdminOrOwner(IAuthor objectOwner)
        //{
        //    var isAdminOrOwner = false;

        //    var author = objectOwner as UserAuthor;

        //    // If there exists a current user
        //    if (CurrentUser != null &&
        //        (CurrentUser.CompareUserId(author) || IsAdmin))
        //    {
        //        isAdminOrOwner = true;
        //    }

        //    return isAdminOrOwner;
        //}

        /// <summary>
        /// Check if the current user has access rights to remove an entity.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns>
        /// 	<c>true</c> if [has remove access rights] [the specified entity]; otherwise, <c>false</c>.
        /// </returns>
        protected virtual bool HasRemoveAccessRights(ISecurableEntity entity)
        {
            if (entity == null)
            {
                return false;
            }

            if (IsAdminOrModerator)
            {
                return true;
            }
            FrameworkEntityAccessRights entryAccessRights = new FrameworkEntityAccessRights();
            entryAccessRights.Remove = true;
            return CurrentUser.CheckAccess(entity, entryAccessRights);
        }

        /// <summary>
        /// Gets whether the logged in user is part of the administrator group
        /// </summary>
        public bool IsAdminOrModerator
        {
            get
            {
                // If there is user that is logged in check that user
                if (CurrentUser != null)
                {
                    // Go through the groups of the current user and see if the administrator group is among these
                    GroupCollection groups = CurrentUser.Groups;
                    foreach (Group group in groups)
                    {
                        if (group.Name == RelateConstants.AdministratorGroupName ||
                            group.Name == RelateConstants.CommunityAdminsGroupName ||
                            group.Name == RelateConstants.CommunityModeratorGroupName)
                        {
                            return true;
                        }
                    }
                }
                return false;
            }
        }

        /// <summary>
        /// Redirect to start page with return url
        /// </summary>
        public void NotLoggedInRedirect()
        {
            // Create url to start page with return url
            var url = new UrlBuilder(NotMemberPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ReturnUrl, Request.RawUrl);

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                //Global.UrlRewriteProvider.ConvertToExternal(url, PageReference.StartPage, Encoding.UTF8);
                Global.UrlRewriteProvider.ConvertToExternal(url, NotMemberPage, Encoding.UTF8);
            }

            // Redirect to start page with return url
            Response.Redirect((string)url);
        }

        /// <summary>
        /// Redirects to a general error page
        /// </summary>
        public void RedirectToGeneralErrorPage()
        {
            // Create url to general error page
            var url = new UrlBuilder(GeneralErrorPage.LinkURL);

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, GeneralErrorPage.LinkURL, Encoding.UTF8);
            }

            // Redirect to General error page
            Response.Redirect((string)url);
        }

        /// <summary>
        /// Redirect to access violation page
        /// </summary>
        public void RedirectToAccessViolationPage()
        {
            RedirectToAccessViolationPage(null);
        }

        /// <summary>
        /// Redirect to access violation page
        /// </summary>
        public void RedirectToAccessViolationPage(Uri returnUrl)
        {
            // Create url to access violation page
            var url = new UrlBuilder(AccessViolationPage.LinkURL);

            if (returnUrl != null)
            {
                url.QueryCollection.Add(QueryStrings.ReturnUrl, returnUrl.AbsolutePath);
            }

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, AccessViolationPage.LinkURL, Encoding.UTF8);
            }

            // Redirect to Access violation page
            Response.Redirect((string)url);
        }

        /// <summary>
        /// Redirect to access violation page
        /// </summary>
        public void RedirectToClubErrorPage(int clubId)
        {
            // Create url to general error page
            var url = new UrlBuilder(ClubErrorPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, clubId.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, ClubErrorPage.LinkURL, Encoding.UTF8);
            }

            // Redirect to Club error page with club id
            Response.Redirect((string)url);
        }

        public void RedirectToMemberDeletedPage()
        {
            // Create url to general error page
            var url = new UrlBuilder(MemberDeletedPage.LinkURL);

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, MemberDeletedPage.LinkURL, Encoding.UTF8);
            }

            // Redirect to member deleted page
            Response.Redirect((string)url);
        }
        #endregion
    }
}
