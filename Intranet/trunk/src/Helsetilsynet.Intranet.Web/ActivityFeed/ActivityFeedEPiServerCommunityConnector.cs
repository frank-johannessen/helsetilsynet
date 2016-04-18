using OpenWaves.ActivityFeed.EPiServer.Community;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class MyEPiServerCommunityConnector : IActivityFeedEPiServerCommunityConnector
    {
        public void OnTopicAdded(EPiServer.Community.Forum.Topic topic)
        {
        }

        public void OnBlogEntryAdded(EPiServer.Community.Blog.Entry entry)
        {
            ActivityFeedHandler.PublishBlogEntry(entry);
        }

        public void OnBlogEntryCommentAdded(EPiServer.Community.Blog.EntryComment entryComment)
        {
        }

        public void OnCalendarEventAdded(EPiServer.Community.Calendar.Event calendarEvent)
        {
            ActivityFeedHandler.PublishCalendarEvent(calendarEvent);
        }

        public void OnClubMembershipAdded(EPiServer.Community.Club.Membership membership)
        {
            ActivityFeedHandler.SubscribeUserToClub(membership.User, membership.Club);
        }

        public void OnPollAdded(EPiServer.Community.Poll.Poll poll)
        {
        }
    }
}