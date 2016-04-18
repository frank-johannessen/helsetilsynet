using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using EPiServer.Common;
using EPiServer.Common.Data;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions
{
    /// <summary>
    /// The class DynamicDataStoreEntityProvider is an entity provider
    /// </summary>
    public class DynamicDataStoreEntityProvider : IEntityProvider
    {
        #region static
        private static DynamicDataStoreEntityProvider _instance;

        public static IEntityProvider GetProviderInstance()
        {
            if (_instance == null)
            {
                _instance = new DynamicDataStoreEntityProvider();
            }

            return _instance;
        }

        #endregion

        #region public

        /// <summary>
        /// Finds the entity instance.
        /// </summary>
        /// <typeparam name="TEntity">The type of the entity.</typeparam>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="propertyValue">The property value.</param>
        /// <returns></returns>
        public IEnumerable<TEntity> FindEntityInstance<TEntity>(string propertyName, object propertyValue) where TEntity : DynamicDataStoreEntity
        {
            DynamicDataStore store = DynamicDataStoreFactory.Instance.GetStore(typeof(TEntity));

            if (store != null)
            {
                return store.Find<TEntity>(propertyName, propertyValue);
            }

            return Enumerable.Empty<TEntity>();
        }


        /// <summary>
        /// Returns all entities which is of the TEntity type.
        /// </summary>
        /// <typeparam name="TEntity">The type of the entity.</typeparam>
        /// <returns></returns>
        public IEnumerable<TEntity> Entities<TEntity>() where TEntity : DynamicDataStoreEntity
        {
            DynamicDataStore store = DynamicDataStoreFactory.Instance.GetStore(typeof(TEntity));

            if (store != null)
            {
                return store.Items<TEntity>();
            }

            return Enumerable.Empty<TEntity>();
        }

        #endregion

        #region IEntityProvider Members

        /// <summary>
        /// Adds the entity instance.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns></returns>
        public IEntity AddEntityInstance(IEntity entity)
        {
            EnsureDynamicDataStoreEntityType(entity.GetType());
            GetOrCreateStore(entity.GetType()).Save(entity);
            return entity;
        }

        /// <summary>
        /// Gets the entity instance.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public IEntity GetEntityInstance(Type type, int id)
        {
            EnsureDynamicDataStoreEntityType(type);
            Guid uniqueId = EntityProviderHandler.Instance.GetEntityUniqueID(new EntityReference(type, id));
            DynamicDataStore store = DynamicDataStoreFactory.Instance.GetStore(type);
            if (store != null)
            {
                return store.Load(uniqueId) as IEntity;
            }
            return null;
        }

        public object GetEntityInstance(Type type, DbDataReader reader)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Gets the supported operations.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <returns></returns>
        public SupportedOperations GetSupportedOperations(Type type)
        {
            EnsureDynamicDataStoreEntityType(type);
            return SupportedOperations.Get | SupportedOperations.Add | SupportedOperations.Update | SupportedOperations.Remove;
        }

        /// <summary>
        /// Removes the entity instance.
        /// </summary>
        /// <param name="entity">The entity.</param>
        public void RemoveEntityInstance(EPiServer.Common.IEntity entity)
        {
            EnsureDynamicDataStoreEntityType(entity.GetType());
            GetOrCreateStore(entity.GetType()).Delete(entity);
        }

        /// <summary>
        /// Updates the entity instance.
        /// </summary>
        /// <param name="entity">The entity.</param>
        public void UpdateEntityInstance(EPiServer.Common.IEntity entity)
        {
            EnsureDynamicDataStoreEntityType(entity.GetType());
            GetOrCreateStore(entity.GetType()).Save(entity);
        }

        #endregion

        #region private and helpers methods

        /// <summary>
        /// Gets the or create store for the type t.
        /// </summary>
        /// <param name="t">The t.</param>
        /// <returns></returns>
        private static DynamicDataStore GetOrCreateStore(Type t)
        {
            return DynamicDataStoreFactory.Instance.GetStore(t) ??
                DynamicDataStoreFactory.Instance.CreateStore(t);
        }

        /// <summary>
        /// Ensures the type of the dynamic data store entity.
        /// </summary>
        /// <exception cref="NotSupportedException">
        /// return the NotSupportedException if the provider can not handle the t.
        /// </exception>
        /// <param name="t">The t.</param>
        private void EnsureDynamicDataStoreEntityType(Type t)
        {
            if (!t.IsSubclassOf(typeof(DynamicDataStoreEntity)))
            {
                throw new NotSupportedException(string.Format("The type '{0}' must derive from type {1} to be handled by type '{2}'", t.FullName, typeof(DynamicDataStoreEntity).FullName, typeof(DynamicDataStoreEntityProvider).FullName));
            }
        }

        #endregion
    }
}
