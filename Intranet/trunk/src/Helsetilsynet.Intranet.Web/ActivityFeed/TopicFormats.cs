using System.Collections.Generic;
using System.Linq;
using EPiServer.Common.Security;
using EPiServer.Community.Club;
using EPiServer.DataAbstraction;
using OpenWaves.ActivityFeed;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public static class TopicFormats
    {
        private const string USER = "User";
        private const string CLUB = "Club";
        private const string SERVICE_AREA = "ServiceArea";

        private const string TOPIC_FORMAT = "{0}/{1}";

        #region Topic formats: User/ID, Calendar/ID, Club/ID
        // ReSharper disable SuggestBaseTypeForParameter
        // ReSharper disable MemberCanBePrivate.Global

        public static string GetSubscriber(IUser user)
        {
            return user.UserName;
        }

        public static string GetTopicString(Club club)
        {
            return string.Format(TOPIC_FORMAT, CLUB, club.ID);
        }

        public static Topic GetTopic(Club club)
        {
            return new Topic(GetTopicString(club));
        }

        public static string GetTopicString(Category category)
        {
            return GetTopicString(category.ID);
        }

        public static Topic GetTopic(Category category)
        {
            return new Topic(GetTopicString(category));
        }

        public static string GetTopicString(int categoryId) // special case for the int - taking it as Category
        {
            return string.Format(TOPIC_FORMAT, SERVICE_AREA, categoryId);
        }

        public static Topic GetTopic(int categoryId)
        {
            return new Topic(GetTopicString(categoryId)); // special case for the int - taking it as Category
        }

        public static string GetTopicString(IUser user)
        {
            return user == null ? string.Empty : string.Format(TOPIC_FORMAT, USER, user.ID);
        }

        public static Topic GetTopic(IUser user)
        {
            return user == null ? null : new Topic(GetTopicString(user));
        }

        // ReSharper restore MemberCanBePrivate.Global

        // ReSharper restore SuggestBaseTypeForParameter

        #endregion

        public static List<Club> GetClubsFromTopicString(IEnumerable<string> topics)
        {
            return (from topic in topics select topic.Split('/') 
                    into topicSplit 
                    where topicSplit[0] == CLUB 
                    select ClubHandler.Instance.GetClub(int.Parse(topicSplit[1])) 
                    into club where club != null 
                    select club).ToList();
        }

        public static List<Category> GetServiceAreasFromTopicString(IEnumerable<string> topics)
        {
            return (from topic in topics select topic.Split('/')
                    into topicSplit 
                    where topicSplit[0] == SERVICE_AREA 
                    select Category.Find(int.Parse(topicSplit[1])) 
                    into category where category != null 
                    select category).ToList();
        }

        public static List<IUser> GetUsersFromTopicString(IEnumerable<string> topics)
        {
            return (from topic in topics select topic.Split('/')
                    into topicSplit where topicSplit[0] == USER 
                    select SecurityHandler.Instance.GetUser(int.Parse(topicSplit[1])) 
                    into user where user != null 
                    select user).ToList();
        }
    }
}