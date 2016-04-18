using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer;
using EPiServer.Common.Comments;
using EPiServer.Common.Security;
using EPiServer.Community.Blog;
using EPiServer.Community.Calendar;
using EPiServer.Community.Club;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using OpenWaves;
using OpenWaves.ActivityFeed;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using log4net;
using SecurityStatus = EPiServer.Community.Club.SecurityStatus;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public static class ActivityFeedHandler
    {
        #region Publishing to the feed

        public static void PublishCalendarEvent(Event calendarEvent)
        {
            var club = calendarEvent.GetClub();
            var topics = new List<Topic>();

            if (club != null && club.IsCalmayersCorner())
                return;

            if (club == null || club.SecurityStatus == SecurityStatus.Open)
                topics.AddRange(calendarEvent.GetServiceAreas().Select(TopicFormats.GetTopic));

            if (club != null)
                topics.Add(TopicFormats.GetTopic(club));

            var author = calendarEvent.Author.GetUser();
            if (club == null || (author != club.Owner && club.SecurityStatus == SecurityStatus.Open))
                topics.Add(TopicFormats.GetTopic(calendarEvent.Author.GetUser()));

            var icon = club != null
                            ? club.GetPresentationImageUri(Enums.ImageSize.NewsFeed).ToString()
                            : UriSupport.Combine(GlobalName.PathToRelateImageFolder.PathToRelateImagesFolder, "/standard_calendar_icon.png");

            ServiceLocator.Resolve<IActivityFeedService>()
                .PublishUpdate(
                    new CalendarUpdate(calendarEvent.Header, string.Format("{0} {1}", calendarEvent.StartDate.ToShortDateString(), calendarEvent.StartDate.ToShortTimeString()), icon , calendarEvent.GetArticleLink()),
                    "Losen",
                    "Kalender", 
                    topics, true, Enumerable.Empty<UserGroup>());
        }


        public static void PublishBlogEntry(Entry entry)
        {
            var club = entry.GetClub();
            if (club == null)
                return;

            if (club.IsCalmayersCorner()) // Don¨'t show updates from Calmeyers Hjørne?
                return;

            var topics = new List<Topic> {TopicFormats.GetTopic(club)};

            var author = entry.Author.GetUser();
            bool displayAuthor = author != club.Owner && club.SecurityStatus == SecurityStatus.Open;
            if (displayAuthor)
                topics.Add(TopicFormats.GetTopic(author));

            var entryAuthor = displayAuthor ? author.GetPresentationName() : string.Format("Prosjektrommet {0}", club.Header);
            var icon = displayAuthor ? author.GetPortraitUri(Enums.ImageSize.NewsFeed).ToString() : club.GetPresentationImageUri(Enums.ImageSize.NewsFeed).ToString();

            ServiceLocator.Resolve<IActivityFeedService>()
                .PublishUpdate(
                new BlogEntryUpdate(entry.Header, entryAuthor, icon, 
                    string.Format("{0}#anchorNavBlogEntry{1}", club.GetClubUri(), entry.ID), entry.Body.CropText(100)),
                    TopicFormats.GetSubscriber(author),
                    "Prosjektvegg",
                    topics, true, Enumerable.Empty<UserGroup>());
        }
        
        public static void PublishNewClub(Club club)
        {
            if (club.SecurityStatus != SecurityStatus.Open)
                return;

            var topics = new List<Topic> {TopicFormats.GetTopic(club)};
            topics.AddRange(club.GetServiceAreas().Select(TopicFormats.GetTopic));

            ServiceLocator.Resolve<IActivityFeedService>()
                .PublishUpdate(
                    new ClubUpdate(club.Header, club.Body.CropText(200), club.GetPresentationImageUri(Enums.ImageSize.NewsFeed).ToString(), club.GetClubUri().ToString()), 
                    "Losen",
                    "NewClub",
                    topics, true, Enumerable.Empty<UserGroup>());
        }

        public static void PublishArticleComment(IComment comment, PageData page)
        {
            var topics = new List<Topic>{ TopicFormats.GetTopic(comment.Author.GetUser()) };
            topics.AddRange(GetTopics(page));

            ServiceLocator.Resolve<IActivityFeedService>()
                .PublishUpdate(
                    new PageCommentUpdate(page.PageName,
                        comment.Body.CropText(100), comment.Author.GetPresentationName(), 
                        comment.Author.GetPortraitUri(Enums.ImageSize.NewsFeed).ToString(),
                        string.Format("{0}#anchorNavComment{1}", FriendlyURL.GetFriendlyURL(page, false), comment.ID)),
                    TopicFormats.GetSubscriber(comment.Author.GetUser()),
                    "NewPageComment",
                    topics, true, Enumerable.Empty<UserGroup>());
        }
        #endregion

        #region Subscribe / Unsubscribe

        private static void Subscribe(IUser user, Topic topic)
        {
            try
            {
                ServiceLocator.Resolve<IActivityFeedService>().Subscribe(TopicFormats.GetSubscriber(user), new[] {topic});
            }
            catch (Exception e)
            {
                string userName = (user == null) ? "[NULL]" : user.UserName;
                string topicName = (topic == null) ? "[NULL]" : topic.ToString();
                LogManager.GetLogger("ActivityFeed").Error(string.Format("Unable to subscribe user '{0}' to topic '{1}'.", userName, topicName), e);
            }
        }

        private static void UnSubscribe(IUser user, Topic topic)
        {
            try
            {
                ServiceLocator.Resolve<IActivityFeedService>().Unsubscribe(TopicFormats.GetSubscriber(user), new[] {topic});
            }
            catch (Exception e)
            {
                string userName = (user == null) ? "[NULL]" : user.UserName;
                string topicName = (topic == null) ? "[NULL]" : topic.ToString();
                LogManager.GetLogger("ActivityFeed").Error(string.Format("Unable to unsubscribe user '{0}' from topic '{1}'.", userName, topicName), e);
            }
        }

        public static void SubscribeUserToClub(IUser user, Club club)
        {
            var topic = TopicFormats.GetTopic(club);
            Subscribe(user, topic);
            user.AddActivityfeedTopic(TopicFormats.GetTopicString(club));
        }

        public static void UnSubscribeUserFromClub(IUser user, Club club)
        {
            var topic = TopicFormats.GetTopic(club);
            UnSubscribe(user, topic);
            user.RemoveActivityfeedTopic(TopicFormats.GetTopicString(club));
        }

        public static void SubscribeUserToUser(IUser user, IUser userToFollow)
        {
            var topic = TopicFormats.GetTopic(userToFollow);
            Subscribe(user, topic);
            user.AddActivityfeedTopic(TopicFormats.GetTopicString(userToFollow));
        }

        public static void UnSubscribeUserFromUser(IUser user, IUser userToUnFollow)
        {
            var topic = TopicFormats.GetTopic(userToUnFollow);
            UnSubscribe(user, topic);
            user.RemoveActivityfeedTopic(TopicFormats.GetTopicString(userToUnFollow));
        }

        public static void SubscribeUserToServiceArea(IUser user, EPiServer.DataAbstraction.Category category)
        {
            var topic = TopicFormats.GetTopic(category);
            Subscribe(user, topic);
            user.AddActivityfeedTopic(TopicFormats.GetTopicString(category));
        }

        public static void UnSubscribeUserFromServiceArea(IUser user, EPiServer.DataAbstraction.Category category)
        {
            var topic = TopicFormats.GetTopic(category);
            UnSubscribe(user, topic);
            user.RemoveActivityfeedTopic(TopicFormats.GetTopicString(category));
        }

        #endregion

        public static void PublishArticle(Article article, bool isNew)
        {
            ArticleUpdate update;
            
            if (isNew)
            {
                update = new ArticleUpdate
                {
                    Title = article.Heading,
                    Description = article.MainIntro,
                    ThumbnailUrl = "/Templates/ActivityFeed/CreateThumbnail.aspx?t=1&w=54&h=54&url=" + HttpUtility.UrlEncode(article.GetArticleIcon()), //new EPiImageEngine().ResizeImage(60, 60, EPiImageEngine.Transformation.ScaleToFill, EPiImageEngine.Rotation.NoRotation, article.GetArticleIcon()),
                    Url = GetArticleUrl(article),
                    UpdateType = "NY",
                    ShortIntro = StripHtmlAndCrop(article.MainIntro, article.MainBody)
                };
            }
            else
            {
                update = new ArticleUpdate
                {
                    Title = article.Heading,
                    Description = article.MainIntro,
                    ThumbnailUrl = "/Templates/ActivityFeed/CreateThumbnail.aspx?t=1&w=54&h=54&url=" + HttpUtility.UrlEncode(article.GetArticleIcon()),
                    Url = GetArticleUrl(article),
                    UpdateType = "OPPDATERT",
                    ShortIntro = StripHtmlAndCrop(article.MainIntro, article.MainBody)
                };
            }

            if (HttpContext.Current != null)
            {
                ServiceLocator.Resolve<IActivityFeedService>()
                    .PublishUpdate(
                        update,
                        "Losen",
                        "Artikler",
                        GetTopics(article), !article.IsC1Only, MyUserGroupMembershipProvider.GetGroups(article.IsC1Only));
            }
        }

        private static string GetArticleUrl(Article article)
        {
            var friendlyUrl = FriendlyURL.GetFriendlyURL(article, false);
            return friendlyUrl ?? string.Empty;
        }

        private static string StripHtmlAndCrop(string mainIntro, string mainBody)
        {
            var text = (string.IsNullOrEmpty(mainIntro) ? mainBody : mainIntro).FormatContentTextNoHtml().CropText(100);
            return HttpUtility.HtmlDecode(text);
        }

        private static IEnumerable<Topic> GetTopics(PageData page)
        {
            return page.Category == null ? new List<Topic>() : page.Category.Select(TopicFormats.GetTopic);
        }

        public static void PublishLargeDocument(LargeDocument largeDocument, bool isNew)
        {
            var update = isNew ?
                        new DocumentUpdate(largeDocument.PageName, FriendlyURL.GetFriendlyURL(largeDocument, false), "NYTT") :
                        new DocumentUpdate(largeDocument.PageName, FriendlyURL.GetFriendlyURL(largeDocument, false), "OPPDATERT");

            ServiceLocator.Resolve<IActivityFeedService>()
                .PublishUpdate(
                    update,
                    "Losen",
                    "StortDokument",
                    GetTopics(largeDocument), true, Enumerable.Empty<UserGroup>());
        }
    }
}