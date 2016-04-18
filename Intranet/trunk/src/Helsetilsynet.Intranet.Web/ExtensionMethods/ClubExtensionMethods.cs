using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.DataAbstraction;
using EPiServer.SpecializedProperties;
using Relate.HelpersAndExtensions.BookmarkFramework;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class ClubExtensionMethods
    {
        public static List<Category> GetServiceAreas(this Club club)
        {
            try
            {
                var propertyValue = club.GetAttributeValue<string>(AttributeNames.ServiceAreas);
                if (propertyValue != null)
                {
                    var spilt = propertyValue.Split(',');
                    return spilt.Where(id => id != string.Empty).Select(id => Category.Find(int.Parse(id))).Where(category => category != null).ToList();
                }
                return new List<Category>();
            }
            catch (FrameworkException)
            {
                return new List<Category>();
            }
        }
        public static string GetServiceAreaNamesString(this Club club)
        {
            var returnValue = string.Empty;
            foreach (var serviceArea in club.GetServiceAreas())
            {
                if (returnValue != string.Empty)
                    returnValue += ",";
                returnValue += serviceArea.Name;
            }
            return returnValue;
        }

        public static void SetServiceAreas(this Club club, string data)
        {
            try
            {
                club.SetAttributeValue<string>(AttributeNames.ServiceAreas, data);
            }
            catch (FrameworkException)
            {

            }
        }

        public static string GetProjectGoal(this Club club)
        {
            try
            {
                return club.GetAttributeValue<string>(AttributeNames.ProjectGoal);
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetProjectGoal(this Club club, string data)
        {
            try
            {
                club.SetAttributeValue<string>(AttributeNames.ProjectGoal, data);
            }
            catch (FrameworkException)
            {

            }
        }

        public static string GetProjectPeriod(this Club club)
        {
            try
            {
                return club.GetAttributeValue<string>(AttributeNames.ProjectPeriod);
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }

        public static void SetProjectPeriod(this Club club, string data)
        {
            try
            {
                club.SetAttributeValue<string>(AttributeNames.ProjectPeriod, data);
            }
            catch (FrameworkException)
            {

            }
        }


        public static IEnumerable<BookmarkLink> GetBookmarks(this Club club)
        {
            var links = HttpRuntime.Cache.Get(RelateConstants.BookmarkCacheKey + club.ID) as IEnumerable<BookmarkLink>;
            if (links == null)
            {
                var container = club.GetOrCreateLinkContainer();
                links = LinkManager.Instance.GetLinks(container);
                HttpRuntime.Cache.Insert(RelateConstants.BookmarkCacheKey + club.ID, links, null, DateTime.Now.AddMinutes(15), System.Web.Caching.Cache.NoSlidingExpiration);
            }

            return links;
        }

        public static void AddBookmark(this Club club, string title, string url, bool external)
        {
            var container = club.GetOrCreateLinkContainer();
            var bookmarkLink = new BookmarkLink(new LinkItem { Title = title, Href = url, Target = external ? "_blank" : string.Empty }, container);
            LinkManager.Instance.AddLink(bookmarkLink);
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + club.ID);
        }

        public static void RemoveBookmark(this Club club, string url)
        {
            var bookmarkLink = club.GetBookmarks().FirstOrDefault(bookmark => bookmark.Link.Href == url);
            if (bookmarkLink != null)
            {
                LinkManager.Instance.RemoveLink(bookmarkLink);
            }
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + club.ID);
        }
        public static void RemoveBookmark(this Club club, BookmarkLink bookmarkLink)
        {
            if (bookmarkLink != null)
            {
                LinkManager.Instance.RemoveLink(bookmarkLink);
            }
            HttpRuntime.Cache.Remove(RelateConstants.BookmarkCacheKey + club.ID);
        }
        public static LinkContainer GetOrCreateLinkContainer(this Club club)
        {
            LinkContainer linkContainer = null;
            var linkContainerGuid = club.GetAttributeValue<string>(AttributeNames.LinkContainerGuid);
            Guid guid;
            if (Guid.TryParse(linkContainerGuid, out guid))
            {

                //Get
                linkContainer = LinkManager.Instance.GetLinkContainer(guid);
            }

            if (linkContainer == null)
            {
                //Create
                linkContainer = new LinkContainer { Name = String.Format("LinkContainer for club {0}", club.Header) };
                linkContainer = LinkManager.Instance.AddLinkContainer(linkContainer);

                //Set
                club = (Club)club.Clone();
                club.SetAttributeValue<string>(AttributeNames.LinkContainerGuid, linkContainer.UniqueID.ToString());
                ClubHandler.Instance.UpdateClub(club);
            }

            return linkContainer;
        }
        public static bool IsCalmayersCorner(this Club club)
        {
            return club == ClubHandler.Instance.GetClub(int.Parse(ConfigurationManager.AppSettings[GlobalName.AppSettings.CalmeyersCornerClubId]));
        }
    }
}