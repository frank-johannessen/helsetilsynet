using System;
using EPiServer.Common;
using EPiServer.Common.Data;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    public class DynamicCommunityEntitiesManager : FrameworkFactoryBase
    {
        private static DynamicCommunityEntitiesManager _instance = new DynamicCommunityEntitiesManager();

        public static DynamicCommunityEntitiesManager Instance { get { return _instance; } }

        public DynamicCommunityEntity AddDynamicCommunityEntity(DynamicCommunityEntity entity)
        {
            // Store dynamic data
            entity = StoreDynamicData(entity);

            // Store Community categories
            UpdateEntity(entity, entity.ID); // This is actually "add"

            return entity;
        }

        public DynamicCommunityEntity UpdateDynamicCommunityEntity(DynamicCommunityEntity entity)
        {
            // Store dynamic data
            entity = StoreDynamicData(entity);

            // Store Community categories
            UpdateEntity(entity);

            return entity;
        }

        private DynamicCommunityEntity StoreDynamicData(DynamicCommunityEntity entity)
        {
            DynamicDataStore store = GetOrCreateStore(entity.GetType());
            entity.DdsIdentity = store.Save(entity);
            return entity;
        }

        public DynamicDataStore GetOrCreateStore(Type type)
        {
            return DynamicDataStoreFactory.Instance.GetStore(type) ?? DynamicDataStoreFactory.Instance.CreateStore(type);
        }

        public DynamicCommunityEntity GetDynamicCommunityEntity(Guid guid)
        {
            DynamicCommunityEntity entity = null;

            EntityReference reference = EntityProviderHandler.Instance.GetEntityReference(guid);

            if (reference != null)
            {
                //var entityInstance = (DynamicCommunityEntity)DynamicCommunityEntityProvider.GetProviderInstance().GetEntityInstance(reference.Type, reference.ID);

                //if (entityInstance != null)
                    //entity = entityInstance;
                    entity = (DynamicCommunityEntity) reference.GetEntity();
            }

            return entity;
        }
        public void RemoveDynamicCommunityEntity(Guid guid)
        {
            DynamicCommunityEntity entity = GetDynamicCommunityEntity(guid);
            if (entity == null)
                return;

            DynamicDataStore store = GetOrCreateStore(entity.GetType());

            Identity id = Identity.NewIdentity(guid);
            store.Delete(id);

            RemoveEntity(entity);
        }
    }
}
