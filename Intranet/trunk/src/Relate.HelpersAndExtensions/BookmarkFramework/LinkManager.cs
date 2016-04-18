using System;
using System.Linq;
using System.Collections.Generic;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    public class LinkManager
    {
        private static LinkManager _instance = new LinkManager();
        public static LinkManager Instance { get { return _instance; } }

        public LinkContainer AddLinkContainer(LinkContainer linkContainer)
        {
            return (LinkContainer)DynamicCommunityEntitiesManager.Instance.AddDynamicCommunityEntity(linkContainer);
        }

        public LinkContainer GetLinkContainer(Guid guid)
        {
            return (LinkContainer)DynamicCommunityEntitiesManager.Instance.GetDynamicCommunityEntity(guid);
        }

        public BookmarkLink GetLink(Guid guid)
        {
            return (BookmarkLink)DynamicCommunityEntitiesManager.Instance.GetDynamicCommunityEntity(guid);
        }

        public void RemoveLinkContainer(LinkContainer linkContainer)
        {
            DynamicCommunityEntitiesManager.Instance.RemoveDynamicCommunityEntity(linkContainer.UniqueID);
        }

        public BookmarkLink AddLink(BookmarkLink bookmarkLink)
        {
            if (bookmarkLink == null || bookmarkLink.Container == null)
                throw new Exception("Invalid BookmarkLink");
            return (BookmarkLink)DynamicCommunityEntitiesManager.Instance.AddDynamicCommunityEntity(bookmarkLink);
        }

        public IEnumerable<BookmarkLink> GetLinks(LinkContainer linkContainer)
        {
            if (linkContainer == null)
                return null;

            DynamicDataStore store = DynamicCommunityEntitiesManager.Instance.GetOrCreateStore(typeof(BookmarkLink));
            return store.Items<BookmarkLink>().Where(l => l.Container == linkContainer);
        }

        public void RemoveLink(BookmarkLink bookmarkLink)
        {
            DynamicCommunityEntitiesManager.Instance.RemoveDynamicCommunityEntity(bookmarkLink.UniqueID);
        }
    }
}
