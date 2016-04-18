using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using EPiServer;
using EPiServer.Common;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.Community.MyPage;
using EPiServer.SpecializedProperties;
using EPiServer.Web;
using PageTypeBuilder;
using Relate.HelpersAndExtensions.BookmarkFramework;
using Relate.HelpersAndExtensions.Constants;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class UserExtensionMethods
    {
        // IUser extensions
        public static string GetTelephone(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.Telephone).FormatContentTextNoHtml();
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetTelephone(this IUser user, string telephone)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Telephone, telephone);
            }
            catch (FrameworkException)
            {

            }
        }
        public static string GetMobile(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.Mobile).FormatContentTextNoHtml();
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetMobile(this IUser user, string mobile)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Mobile, mobile);
            }
            catch (FrameworkException)
            {

            }
        }
        public static string GetSearchMetadata(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.SearchMetadata).FormatContentTextNoHtml();
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }
        public static void SetSearchMetadata(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.SearchMetadata, data);
            }
            catch (FrameworkException)
            {

            }
        }
        //public static string GetDepartment(this IUser user)
        //{
        //    try
        //    {
        //        return user.GetAttributeValue<string>(AttributeNames.Department);
        //    }
        //    catch (FrameworkException)
        //    {
        //        return String.Empty;
        //    }
        //}
        public static string GetTitle(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.Title).FormatContentTextNoHtml();
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetTitle(this IUser user, string title)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Title, title);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static string GetMisc(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.Misc);//.FormatOrEncodeContentText(); Can be imported from Relate templates from episerver if needed!
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetMisc(this IUser user, string misc)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Misc, misc);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static bool IsAdmin(this IUser user)
        {
            var isAdmin = false;

            // If there is user that is logged in check that user
            if (user != null)
            {
                // Go through the groups of the current user and see if the administrator group is among these
                var groups = user.Groups;
                foreach (var group in groups)
                {
                    if (group.Name == RelateConstants.AdministratorGroupName
                        || group.Name == RelateConstants.CommunityModeratorGroupName
                        || group.Name == RelateConstants.CommunityAdminsGroupName)
                    {
                        isAdmin = true;
                    }
                }
            }

            return isAdmin;
        }
        /// <summary>
        /// Checks that the user has status Approved and if so has access to the secured entity.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="securableEntity">The securable entity.</param>
        /// <param name="accessRightsMask">The access rights mask.</param>
        /// <returns></returns>
        public static bool CheckAccess(this IUser user, ISecurableEntity securableEntity, IAccessRights accessRightsMask)
        {
            if (user == null || (user.Status & EntityStatus.Approved) == 0)
            {
                return false;
            }

            return EntitySecurityHandler.Instance.CheckAccess(securableEntity, user, accessRightsMask);
        }

        /// <summary>
        /// Compares the user id with the user id on an author.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="author">The author.</param>
        /// <returns>True if the user id is the same as the auther user id</returns>
        public static bool CompareUserId(this IUser user, IAuthor author)
        {
            var compareUser = author.GetUser();
            if (user == null || compareUser == null)
            {
                return false;
            }

            return user.ID == compareUser.ID;
        }

        /// <summary>
        /// Gets the name to present on the web site for a user
        /// </summary>
        /// <param name="user">The user to get presentation name for</param>
        /// <returns>The presentation name</returns>
        public static string GetPresentationName(this IUser user)
        {
            return user.GetPresentationName(Int32.MaxValue, true);
        }

        /// <summary>
        /// Gets the name to present on the web site for a user
        /// </summary>
        /// <param name="user">The user to get presentation name for</param>
        /// <param name="maxLength">The max length of the name</param>
        /// <returns>The presentation name</returns>
        public static string GetPresentationName(this IUser user, int maxLength)
        {
            return user.GetPresentationName(maxLength, true);
        }

        /// <summary>
        /// Gets the name to present on the web site for a user
        /// </summary>
        /// <param name="user">The user to get presentation name for</param>
        /// <param name="maxLength">The max length of the name</param>
        /// <param name="formatText">Whether to format the username</param>
        /// <returns>The presentation name</returns>
        public static string GetPresentationName(this IUser user, int maxLength, bool formatText)
        {
            if (user == null)
                return string.Empty;
            var presentationName = GetPresentationName(user.GivenName, user.SurName, maxLength);

            if (formatText)
            {
                presentationName = HttpUtility.HtmlEncode(presentationName);
            }

            return presentationName;
        }

        //for showing lastname first
        public static string GetPresentationNameLastnameFirst(this IUser user, int maxLength)
        {
            string presentationName;

            if ((user.SurName.Length + 3) <= maxLength && user.GivenName.Length > 0)
            {
                // This will result in: P. Smith
                //presentationName = String.Format("{0}. {1}", givenName.Substring(0, 1), surName);
                // This will be Peter Smith
                presentationName = string.Format("{0}, {1}", user.SurName, user.GivenName);
            }
            else if (user.SurName.Length <= maxLength)
            {
                // This will result in: Smith
                presentationName = user.SurName;
            }
            else if (maxLength > 2)
            {
                // This will result in: Smit...
                presentationName = String.Format("{0}...", user.SurName.Substring(0, maxLength - 3));
            }
            else
            {
                // This will result in: Sm
                presentationName = user.SurName.Substring(0, maxLength);
            }

            return presentationName;
        }

        private static string GetPresentationName(string givenName, string surName, int maxLength)
        {
            string presentationName;

            if ((surName.Length + 3) <= maxLength && givenName.Length > 0)
            {
                // This will result in: P. Smith
                //presentationName = String.Format("{0}. {1}", givenName.Substring(0, 1), surName);
                // This will be Peter Smith
                presentationName = string.Format("{0} {1}", givenName, surName);
            }
            else if (surName.Length <= maxLength)
            {
                // This will result in: Smith
                presentationName = surName;
            }
            else if (maxLength > 2)
            {
                // This will result in: Smit...
                presentationName = String.Format("{0}...", surName.Substring(0, maxLength - 3));
            }
            else
            {
                // This will result in: Sm
                presentationName = surName.Substring(0, maxLength);
            }

            return presentationName;
        }
        /// <summary>
        /// Gets the url for the users MyPage
        /// </summary>
        /// <returns>The uri to the users MyPage</returns>
        public static Uri GetMyPageUri(this IUser user)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MyPage.LinkURL);

            if (user != null)
                url.QueryCollection.Add(QueryStrings.UserID, user.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.MyPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }
        
       
        /// <summary>
        /// Gets my settings page URL.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns>The Uri to settings page</returns>
        public static Uri GetMySettingsPageUri(this IUser user)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MySettingsPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.UserID, user.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.MySettingsPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the My clubs URL.
        /// </summary>
        /// <param name="user">The IUser.</param>
        /// <returns>The Uri to myclubs</returns>
        public static Uri GetMyClubsUri(this IUser user)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.UserID, user.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the url for the users Blog
        /// </summary>
        /// <returns>The uri to the users Blog</returns>
        public static Uri GetBlogUri(this IUser user)
        {
            var myPage = MyPageHandler.Instance.GetMyPage(user);

            return myPage.Blog.GetBlogUri();
        }

        /// <summary>
        /// Gets the url for the users portrait
        /// </summary>
        /// <param name="size">The size of the portrait to get the url for</param>
        /// <returns>The url to the users portrait</returns>
        public static Uri GetPortraitUri(this IUser user, Enums.ImageSize size)
        {
            if (user != null)
            {
                var myPage = MyPageHandler.Instance.GetMyPage(user);
                var portraitImage = myPage.Portrait;
                if (portraitImage != null)
                {
                    // Only display approved portraits, or pending portraits if the requested portrait is the current user's portrait
                    if ((portraitImage.Status == EntityStatus.Approved) ||
                        ((EPiServer.Community.CommunitySystem.CurrentContext.DefaultSecurity.CurrentUser == user) && portraitImage.Status == EntityStatus.Pending))
                        return portraitImage.GetThumbnailUri(size);
                }
            }

            var imageUrl = VirtualPathUtilityEx.ToAbsolute(RelateConstants.PathToRelateImagesFolder);
            var url = new UrlBuilder(UriSupport.Combine(imageUrl, string.Format("/UserUnknown{0}.png", ImageExtensionMethods.GetSizeName(size))));
            return url.Uri;
        }
        /// <summary>
        /// Gets my image gallery URL.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns>The Uri to my image gallery</returns>
        public static Uri GetMyImageGalleryUri(this IUser user)
        {
            // Get the user's my page
            var myPage = MyPageHandler.Instance.GetMyPage(user);

            return myPage.ImageGallery.GetMyImageGalleryUri(user);
        }
        /// <summary>
        /// Gets my video gallery URL.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns>The Uri to My Video gallery</returns>
        public static Uri GetMyVideoGalleryUri(this IUser user)
        {
            UrlBuilder url = new UrlBuilder(RelateTemplatePage<TypedPageData>.VideoGalleryPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.UserID, user.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.VideoGalleryPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Check if the user is member of a specify group.
        /// </summary>
        /// <param name="user">The <see cref="IUser"/> to verify the membership.</param>
        /// <param name="club">The <see cref="Club"/> that has the group defined.</param>
        /// <param name="groupType">The <see cref="Enums.ClubGroupType"/> of the club's group.</param>
        /// <returns>Return true if the <see cref="IUser"/> is member of a group, otherwise return false.</returns>
        public static bool IsMemberOfClubGroup(this IUser user, Club club, Enums.ClubGroupType groupType)
        {
            var group = club.GetGroup(groupType);

            return @group != null && user.Groups.Any(g => g.ID == @group.ID);
        }
        public static LinkContainer GetOrCreateLinkContainer(this IUser user)
        {
            LinkContainer linkContainer = null;
            var linkContainerGuid = user.GetAttributeValue<string>(AttributeNames.LinkContainerGuid);
            Guid guid;
            if (Guid.TryParse(linkContainerGuid, out guid))
            {

                //Get
                linkContainer = LinkManager.Instance.GetLinkContainer(guid);
            }

            if (linkContainer == null)
            {
                //Create
                linkContainer = new LinkContainer() { Name = String.Format("LinkContainer for user {0}", user.Alias) };
                linkContainer = LinkManager.Instance.AddLinkContainer(linkContainer);

                //Set
                user = (IUser)user.Clone();
                user.SetAttributeValue<string>(AttributeNames.LinkContainerGuid, linkContainer.UniqueID.ToString());
                CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(user);
            }

            return linkContainer;
        }

        public static IEnumerable<BookmarkLink> GetBookmarks(this IUser user)
        {
            var links = HttpRuntime.Cache.Get(RelateConstants.BookmarkCacheKey + user.ID) as IEnumerable<BookmarkLink>;
            if (links == null)
            {
                var container = user.GetOrCreateLinkContainer();
                links = LinkManager.Instance.GetLinks(container).ToList();
                
                HttpRuntime.Cache.Insert(RelateConstants.BookmarkCacheKey + user.ID, links, null, DateTime.Now.AddMinutes(15), System.Web.Caching.Cache.NoSlidingExpiration);
            }

            return links;
        }

        public static void AddBookmark(this IUser user, string title, string url, bool external)
        {
            var container = user.GetOrCreateLinkContainer();
            var bookmarkLink = new BookmarkLink(new LinkItem { Title = title, Href = url, Target = external ? "_blank" : string.Empty }, container);
            LinkManager.Instance.AddLink(bookmarkLink);
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + user.ID);
        }

        public static void RemoveBookmark(this IUser user, string url)
        {
            var bookmarkLink = user.GetBookmarks().ToList().FirstOrDefault(bookmark => bookmark.Link.Href == url);
            if (bookmarkLink != null)
            {
                LinkManager.Instance.RemoveLink(bookmarkLink);
            }
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + user.ID);
        }
        public static void RemoveBookmark(this IUser user, BookmarkLink bookmarkLink)
        {
            if (bookmarkLink != null)
            {
                LinkManager.Instance.RemoveLink(bookmarkLink);
            }
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + user.ID);
        }
        
        public static bool IsBookmarkedPage(this IUser user, string page)
        {
            var bookmarks = user.GetBookmarks().ToList();
            var isBookmarked =  bookmarks.Any(o => o.Link.Href == page);
            return isBookmarked;
        }

        // IAuthor extensions
        
        /// <summary>
        /// Gets the user from the author if the author is an user author
        /// </summary>
        /// <param name="author">The author.</param>
        /// <returns>The author user</returns>
        public static IUser GetUser(this IAuthor author)
        {
            return GetUser(author, true);
        }

        /// <summary>
        /// Gets the user from the author if the author is an user author, or if the author is an anonymous author and anonymous authors are accepted.
        /// </summary>
        /// <param name="author">The author.</param>
        /// <param name="acceptAnonymousAuthor">if set to <c>true</c> anonymous authors are accepted</param>
        /// <param name="acceptAnonymousFlag">if set to <c>true</c> the user will be returned even if the anonymous flag on the author is set to true.</param>
        /// <returns>The author user</returns>
        public static IUser GetUser(this IAuthor author, bool acceptAnonymousAuthor)
        {
            var userAuthor = author as UserAuthor;
            if (userAuthor == null)
            {
                return null;
            }

            if (!acceptAnonymousAuthor && userAuthor.IsAnonymous)
            {
                return null;
            }

            return userAuthor.User;
        }

        /// <summary>
        /// Gets the action value from the author user.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="author">The author.</param>
        /// <param name="defaultValue">The default value to return if author user is null.</param>
        /// <param name="action">The action to perform.</param>
        /// <returns>The action value, or default value if author user is null</returns>
        public static T GetActionValueFromUserOrDefault<T>(this IAuthor author, T defaultValue, Func<IUser, T> action)
        {
            var user = author.GetUser();

            return user == null ? defaultValue : action(user);
        }
        /// <summary>
        /// Gets the url for the users MyPage
        /// </summary>
        /// <returns>The uri to the users MyPage</returns>
        public static Uri GetMyPageUri(this IAuthor author)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.MyPage.LinkURL);

            if (author != null)
                url.QueryCollection.Add(QueryStrings.UserID, author.GetUser().ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.MyPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the name to present on the web site for a user
        /// </summary>
        /// <param name="author">The author.</param>
        /// <returns></returns>
        public static string GetPresentationName(this IAuthor author)
        {
            return author.GetPresentationName(Int32.MaxValue, false);
        }

        /// <summary>
        /// Gets the name to present on the web site for a user
        /// </summary>
        /// <param name="author">The author to get presentation name for</param>
        /// <param name="maxLength">The max length of the name</param>
        /// <param name="formatText">Whether to format the name</param>
        /// <returns>The presentation name</returns>
        public static string GetPresentationName(this IAuthor author, int maxLength, bool formatText)
        {
            return author == null ? string.Empty : author.GetUser().GetPresentationName(maxLength, formatText);
        }

        /// <summary>
        /// Gets the url for the author portrait
        /// </summary>
        /// <param name="size">The size of the portrait to get the url for</param>
        /// <returns>The url to the users portrait</returns>
        public static Uri GetPortraitUri(this IAuthor author, Enums.ImageSize size)
        {
            UserAuthor userAuthor = author as UserAuthor;

            return GetPortraitUri((userAuthor != null) ? userAuthor.User : null, size);
        }
        public static ClubCollection GetMyClubs(this IUser user, int page, int pageSize)
        {
            int totalItems;
            ClubCollection clubs = ClubHandler.Instance.GetMyClubs(user, ClubHideStatus.NotHidden, EntityStatus.Approved , null, page, pageSize,
                out totalItems, new ClubSortOrder(ClubSortField.Created, SortingDirection.Descending));

            return clubs;
        }
        public static ClubCollection GetMyClubs(this IUser user)
        {
            int totalItems;
            ClubCollection clubs = ClubHandler.Instance.GetMyClubs(user, ClubHideStatus.NotHidden, EntityStatus.Approved, null, 1, 1000,
                out totalItems, new ClubSortOrder(ClubSortField.Created, SortingDirection.Descending));
            
            return clubs;
        }
    }
}
