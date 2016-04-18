using System.Collections.Generic;
using EPiServer.Data;
using EPiServer.Data.Dynamic;
using System.Linq;

namespace Helsetilsynet.CustomProperties.htilDictionaryProperty
{
    public static class AlphabethicalUtils
    {
        public static string DatastoreName
        {
            get { return "TopicKeywordIndex"; }
        }

        public static DynamicDataStore GetStore()
        {
            var store = DynamicDataStoreFactory.Instance.GetStore(DatastoreName);

            if (store == null)
            {
                store = DynamicDataStoreFactory.Instance.CreateStore(DatastoreName, typeof (AlphabethicalItem));
            }
            else
            {
                //If anything in the DDS underlying structure has change - remap the DDS
                var storeDefinition = store.StoreDefinition;
                if (!storeDefinition.ValidateAgainstMappings(typeof (AlphabethicalItem), false))
                {
                    storeDefinition.Remap(typeof(AlphabethicalItem));
                    storeDefinition.CommitChanges();
                }
            }

            return store;
        }

        public static void DeleteStore()
        {
            DynamicDataStoreFactory.Instance.DeleteStore(DatastoreName, true);
        }

        public static IEnumerable<AlphabethicalItem> GlobalKeywordList()
        {
            return GetStore().Items<AlphabethicalItem>().OrderBy(i => i.Title);
        }

        public static void UpdateAlphabethicalItem(AlphabethicalItem item)
        {
            if(!string.IsNullOrEmpty(item.Title))
                item.Title = item.Title.Trim();

            if (!string.IsNullOrEmpty(item.Url))
                item.Url = item.Url.Trim();

            if (!string.IsNullOrEmpty(item.Ingress))
                item.Ingress = item.Ingress.Trim();

            if (string.IsNullOrEmpty(item.Title) || string.IsNullOrEmpty(item.Url))
                return;
            
            GetStore().Save(item);
        }


        public static void DeleteAlphabethicalItem(AlphabethicalItem alphabethicalItem)
        {
            GetStore().Delete(alphabethicalItem.Id);
        }

        public static void InsertAlphabethicalItem(string title, string url, string ingress)
        {
            title = title.Trim();
            url = url.Trim();
            ingress = ingress.Trim();
            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(url))
                return;

            var dataStore = GetStore();
            var wordAlreadyExists = dataStore.Items<AlphabethicalItem>().Where(i => i.Title == title);
// ReSharper disable UseMethodAny.0
            if (wordAlreadyExists.Count() > 0)
// ReSharper restore UseMethodAny.0
            {
                var item = wordAlreadyExists.First();
                item.Url = url;
                item.Ingress = ingress;
                dataStore.Save(item);
            }
            else
            {
                dataStore.Save(new AlphabethicalItem {Id = Identity.NewIdentity(), Title = title, Url = url, Ingress = ingress});
            }
        }
    }
}