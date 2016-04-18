using System;
using System.Text;
using EPiServer;
using EPiServer.Community.Club;
using EPiServer.Community.Forum;
using EPiServer.Web;
using PageTypeBuilder;
using Relate.HelpersAndExtensions.Constants;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class ForumExtensionMethods
    {
        #region Forum topic extensions
        /// <summary>
        /// Gets the url to a Forum topic
        /// </summary>
        /// <param name="topic">The topic to get url for</param>
        /// <returns>The Uri to the topic</returns>
        public static Uri GetTopicUri(this Topic topic)
        {
            Club club = topic.GetBelongsToClub();

            // check if the topic belongs to a club
            if (club != null)
            {
                var currentUser = EPiServer.Community.CommunitySystem.CurrentContext.DefaultSecurity.CurrentUser;
                if (currentUser != null)
                {
                    // its a club topic, check if currentuser is member of the club
                    if (club.IsClubMember(currentUser) || currentUser.IsAdmin())
                    {
                        //member have right to see the topic

                        // set the url to the club forum
                        var clubURL = new UrlBuilder(club.GetClubForumUri());
                        clubURL.QueryCollection.Add(QueryStrings.TopicID, topic.ID.ToString());

                        // check if EPiServer Friendly URL is enabled
                        if (UrlRewriteProvider.IsFurlEnabled)
                        {
                            Global.UrlRewriteProvider.ConvertToExternal(clubURL, club.GetClubForumUri(), Encoding.UTF8);
                        }

                        return clubURL.Uri;
                    }
                }

                // return link to the club instead of to the topic
                return club.GetClubUri();
            }

            var url = new UrlBuilder(RelateTemplatePage<TypedPageData>.TopicPage.LinkURL);

            url.QueryCollection.Add(QueryStrings.TopicID, topic.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.TopicPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }

        /// <summary>
        /// Sets the "belongs to club" attribute
        /// </summary>
        /// <param name="topic">The topic.</param>
        /// <param name="club">The club.</param>
        public static void SetBelongsToClub(this Topic topic, Club club)
        {
            topic.SetAttributeValue(AttributeNames.BelongsToClub, club);
        }

        /// <summary>
        /// Gets the "belongs to club" attribute.
        /// </summary>
        /// <param name="topic">The topic.</param>
        /// <returns>The club this topic belongs to, null if it doesn't belong to a club</returns>
        public static Club GetBelongsToClub(this Topic topic)
        {
            return topic.Room.OwnedBy.Entity as Club;
        }

        /// <summary>
        /// Helper method to get if the topic is popular or not.
        /// </summary>
        /// <param name="topic">The <see cref="Topic"/> to check popularity.</param>
        /// <returns><see cref="true"/> if the topic is popular and <see cref="false"/> if it isn't popular.</returns>
        public static bool IsHot(this Topic topic)
        {
            return ForumHandler.Instance.IsHot(topic);
        }

        #endregion

        #region Forum room extentions
        /// <summary>
        /// Gets the room URI.
        /// </summary>
        /// <param name="room">The room.</param>
        /// <returns>The Uri to the room</returns>
        public static Uri GetRoomUri(this RoomBase room)
        {
            UrlBuilder url = new UrlBuilder(RelateTemplatePage<TypedPageData>.RoomPage.LinkURL);
            url.QueryCollection.Add(QueryStrings.RoomID, room.ID.ToString());

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, RelateTemplatePage<TypedPageData>.RoomPage.PageLink, Encoding.UTF8);
            }

            return url.Uri;
        }
        #endregion

    }
}
