using System;
using System.Data.Common;
using EPiServer.Common;
using EPiServer.Common.Data;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    public class DynamicCommunityEntityProvider : IEntityProvider
    {
        private static IEntityProvider _instance = new DynamicCommunityEntityProvider();

        public static IEntityProvider GetProviderInstance()
        {
            return _instance;
        }

        public IEntity GetEntityInstance(Type type, int id)
        {
            if (!type.IsSubclassOf(typeof(DynamicCommunityEntity)))
            {
                throw new NotSupportedException(string.Format("The type '{0}' is not supported by this provider.", type.ToString()));
            }

            Guid guid = EntityProviderHandler.Instance.GetEntityUniqueID(new EntityReference(type, id));

            Identity identity = Identity.NewIdentity(guid);

            DynamicDataStore store = DynamicCommunityEntitiesManager.Instance.GetOrCreateStore(type);
            return store.Load(identity) as DynamicCommunityEntity;
        }

        public object GetEntityInstance(Type type, DbDataReader reader)
        {
            throw new NotImplementedException();
        }

        public IEntity AddEntityInstance(IEntity entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveEntityInstance(IEntity entity)
        {
            throw new NotImplementedException();
        }

        public SupportedOperations GetSupportedOperations(Type type)
        {
            return SupportedOperations.Get;
        }

        public void RemoveEntityInstance(IEntity entity, Type type)
        {
            //DynamicDataStore store = DynamicCommunityEntitiesManager.Instance.GetOrCreateStore(type);
            //DynamicDataStoreFactory.Instance.DeleteStore(type, true);
            throw new NotImplementedException();
        }

        public void UpdateEntityInstance(IEntity entity)
        {
            throw new NotImplementedException();
        }
    }
}
