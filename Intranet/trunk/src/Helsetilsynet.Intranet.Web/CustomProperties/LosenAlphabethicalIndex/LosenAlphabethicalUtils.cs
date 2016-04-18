using System.Collections.Generic;
using EPiServer.Data;
using EPiServer.Data.Dynamic;
using System.Linq;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex
{
    public static class LosenAlphabethicalUtils
    {
        public static string DatastoreName
        {
            get { return GlobalName.DynamicDataStore.LosenAlphabethicalIndex; }
        }

        public static DynamicDataStore GetStore()
        {
            return DynamicDataStoreFactory.Instance.GetStore(DatastoreName) ??
                   DynamicDataStoreFactory.Instance.CreateStore(DatastoreName, typeof(LosenAlphabethicalItem));
        }

        public static void DeleteStore()
        {
            DynamicDataStoreFactory.Instance.DeleteStore(DatastoreName, true);
        }

        public static IEnumerable<LosenAlphabethicalItem> GlobalKeywordList()
        {
            return GetStore().Items<LosenAlphabethicalItem>().OrderBy(i => i.Title);
        }

        public static void UpdateLosenAlphabethicalItem(LosenAlphabethicalItem losenItem)
        {
            losenItem.Title = losenItem.Title.Trim();
            losenItem.Url = losenItem.Url.Trim();
            if (string.IsNullOrEmpty(losenItem.Title) || string.IsNullOrEmpty(losenItem.Url))
                return;
            
            GetStore().Save(losenItem);
        }


        public static void DeleteLosenAlphabethicalItem(LosenAlphabethicalItem losenAlphabethicalItem)
        {
            GetStore().Delete(losenAlphabethicalItem.Id);
        }

        public static void InsertLosenAlphabethicalItem(string title, string url)
        {
            title = title.Trim();
            url = url.Trim();
            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(url))
                return;

            var dataStore = GetStore();
            var wordAlreadyExists = dataStore.Items<LosenAlphabethicalItem>().Where(i => i.Title == title);
// ReSharper disable UseMethodAny.0
            if (wordAlreadyExists.Count() > 0)
// ReSharper restore UseMethodAny.0
            {
                var item = wordAlreadyExists.First();
                item.Url = url;
                dataStore.Save(item);
            }
            else
            {
                dataStore.Save(new LosenAlphabethicalItem {Id = Identity.NewIdentity(), Title = title, Url = url});
            }
        }
    }
}