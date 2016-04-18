using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Data.Dynamic;
using Relate.HelpersAndExtensions.BookmarkFramework;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.DelayedPublish
{
    public class DelayedPageManager
    {
        private static DelayedPageManager _instance = new DelayedPageManager();
        public static DelayedPageManager Instance { get { return _instance; } }

        public DelayedPage GetDelayedPage(Guid guid)
        {
            return (DelayedPage)DynamicCommunityEntitiesManager.Instance.GetDynamicCommunityEntity(guid);
        }
        
        public DelayedPage AddDelayedPage(DelayedPage delayedPage)
        {
            if (delayedPage == null)
                throw new Exception("Invalid delayedPage");
            return (DelayedPage)DynamicCommunityEntitiesManager.Instance.AddDynamicCommunityEntity(delayedPage);
        }

        public IEnumerable<DelayedPage> GetDelayedPages()
        {
            DynamicDataStore store = DynamicCommunityEntitiesManager.Instance.GetOrCreateStore(typeof(DelayedPage));
            return store.Items<DelayedPage>();
        }

        public void RemoveDelayedPage(DelayedPage delayedPage)
        {
            DynamicCommunityEntitiesManager.Instance.RemoveDynamicCommunityEntity(delayedPage.UniqueID);
        }
    }
}