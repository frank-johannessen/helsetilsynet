using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPiServer.Common.Data;

namespace Relate.HelpersAndExtensions
{
    /// <summary>
    /// Helper class to work with CMS Page Data Entity 
    /// </summary>
    public class CMSPageEntityHandler : FrameworkFactoryBase
    {
        #region private

        private static CMSPageEntityHandler _instance;
        private static object _lockObject = new object();

        #endregion

        #region public static

        /// <summary>
        /// Gets the instance of CMSPageEntityHandler. 
        /// </summary>
        /// <value>The instance.</value>
        public static CMSPageEntityHandler Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (_lockObject)
                    {
                        if (_instance == null)
                        {
                            _instance = new CMSPageEntityHandler();
                        }
                    }
                }
                return _instance;
            }
        }

        #endregion

        #region virtual and naming convension methods

        /// <summary>
        /// Gets the CMSPageEntity by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public virtual CMSPageEntity GetEntity(int id)
        {
            return EntityProviderHandler.Instance.GetEntityProvider(typeof(CMSPageEntity)).GetEntityInstance(typeof(CMSPageEntity), id) as CMSPageEntity;
        }

        /// <summary>
        /// Adds the CMSPageEntity to the common framework
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns></returns>
        public virtual CMSPageEntity AddEntity(CMSPageEntity entity)
        {
            CMSPageEntity savedEntity = EntityProviderHandler.Instance.GetEntityProvider(entity.GetType()).AddEntityInstance(entity) as CMSPageEntity;
            FrameworkFactoryBase.UpdateEntity(entity, entity.ID);
            return savedEntity;
        }


        /// <summary>
        /// Removes the CMSPageEntity.
        /// </summary>
        /// <param name="entity">The entity.</param>
        public virtual void RemoveEntity(CMSPageEntity entity)
        {
            EntityProviderHandler.Instance.GetEntityProvider(entity.GetType()).RemoveEntityInstance(entity);
            FrameworkFactoryBase.RemoveEntity(entity);
        }

        /// <summary>
        /// Gets the entity.
        /// </summary>
        /// <param name="pageGuid">The page GUID.</param>
        /// <param name="pageLanguage">The page language.</param>
        /// <param name="pageWorkID">The page work ID.</param>
        /// <returns></returns>
        public virtual CMSPageEntity GetEntity(Guid pageGuid, String pageLanguage, int pageWorkID)
        {
            IEnumerable<CMSPageEntity> res = ((DynamicDataStoreEntityProvider)DynamicDataStoreEntityProvider.GetProviderInstance()).FindEntityInstance<CMSPageEntity>("PageGuid", pageGuid);
            if (!String.IsNullOrEmpty(pageLanguage))
            {
                res = res.Where(pde => pde.PageLanguage == pageLanguage);
            }
            if (pageWorkID != -1)
            {
                res = res.Where(pde => pde.PageWorkID == pageWorkID);
            }
            return res.FirstOrDefault();
        }


        /// <summary>
        /// Get all entities for the CMSPage entity.
        /// </summary>
        /// <returns></returns>
        public IEnumerable<CMSPageEntity> Entities()
        {
            return ((DynamicDataStoreEntityProvider)DynamicDataStoreEntityProvider.GetProviderInstance()).Entities<CMSPageEntity>();
        }
        #endregion
    }
}
