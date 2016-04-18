using System;
using System.Text;
using EPiServer;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Calendar;
using EPiServer.Community.Club;
using EPiServer.Web;
using PageTypeBuilder;
using Relate.HelpersAndExtensions.Constants;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class ClubExtensionMethodscs
    {
        /// <summary>
        /// Gets the club URL.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <returns>The Uri to the club</returns>
        public static Uri GetClubUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubHomePage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubHomePage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }


        /// <summary>
        /// Gets the club forum URL.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <returns>The Uri to the club forum</returns>
        public static Uri GetClubWallUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubWallPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubWallPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the club forum URL.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <returns>The Uri to the club forum</returns>
        public static Uri GetClubForumUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubForumPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubForumPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the club image gallery URL.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <returns>The Uri to the club image gallery</returns>
        public static Uri GetClubImageGalleryUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubImageGalleryPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubImageGalleryPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Gets the club members URL.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <returns>The Uri to the club members</returns>
        public static Uri GetClubMembersUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubMembersPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubMembersPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Determines whether the user is member of the club.
        /// </summary>
        /// <param name="club">The club.</param>
        /// <param name="user">The user.</param>
        /// <returns>
        /// 	<c>true</c> if [is club member] [the specified club]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsClubMember(this Club club, IUser user)
        {
            if (user == null || club == null)
            {
                return false;
            }

            var member = ClubHandler.Instance.GetMembership(club, user);

            if (member == null)
            {
                return false;
            }

            // returns true if type is member
            return (member.MembershipType == MembershipType.Member);
        }

       /// <summary>
        /// Gets the URL to a club events page
        /// </summary>
        /// <param name="club">The club to get event page for</param>
        /// <returns>The Uri to the events page</returns>
        public static Uri GetClubEventsUri(this Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubEventPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubEventPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }
        /// <summary>
        /// Gets the URL to a calendar Event
        /// </summary>
        /// <param name="calendarEvent">The event to get the URL for</param>
        /// <param name="club">The club the event belongs to</param>
        /// <returns>The Uri to the calendar event</returns>
        public static Uri GetClubEventUri(this Event calendarEvent, Club club)
        {
            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.ClubEventPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.ClubID, club.ID.ToString());
            url.QueryCollection.Add(QueryStrings.ClubEventID, calendarEvent.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.ClubEventPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }
        /// <summary>
        /// Get the club admin group
        /// </summary>
        /// <param name="club">A <see cref="Club"/> that has the group</param>
        /// <returns>The club admin <see cref="IGroup"/></returns>
        public static IGroup GetGroup(this Club club, Enums.ClubGroupType groupType)
        {
            String groupName = CommunitySecurityModule.GetClubGroupName(club, groupType);
            return CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(groupName);
        }
        /// <summary>
        /// Gets the presentation image for a club and falls back on the portrait image of the user
        /// if no presentation images is set.
        /// </summary>
        /// <param name="club">The club to get presentation image for</param>
        /// <param name="size">The size of the image</param>
        /// <returns>The uri to the image</returns>
        public static Uri GetPresentationImageUri(this Club club, Enums.ImageSize size)
        {
            var imageUrl = VirtualPathUtilityEx.ToAbsolute(RelateConstants.PathToRelateImagesFolder);
            var url = new UrlBuilder(UriSupport.Combine(imageUrl, String.Empty));

            if (club == null)
            {
                return url.Uri;
            }
            if (club.Logotype != null)
            {
                return club.Logotype.GetThumbnailUri(size);
            }

            switch (size)
            {
                case Enums.ImageSize.Tiny:
                    url = new UrlBuilder(UriSupport.Combine(imageUrl, "/ClubUnknown_tiny.png"));
                    break;
                case Enums.ImageSize.NewsFeed:
                case Enums.ImageSize.Small:
                    url = new UrlBuilder(UriSupport.Combine(imageUrl, "/ClubUnknown_small.png"));
                    break;
                case Enums.ImageSize.Medium:
                    url = new UrlBuilder(UriSupport.Combine(imageUrl, "/ClubUnknown_medium.png"));
                    break;
                case Enums.ImageSize.Large:
                    url = new UrlBuilder(UriSupport.Combine(imageUrl, "/ClubUnknown_large.png"));
                    break;
                case Enums.ImageSize.Huge:
                    url = new UrlBuilder(UriSupport.Combine(imageUrl, "/ClubUnknown_huge.png"));
                    break;
            }

            return url.Uri;
        }
    }
}
