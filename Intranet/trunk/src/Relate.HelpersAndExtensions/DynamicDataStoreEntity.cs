using System;
using EPiServer.Common;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions
{
    /// <summary>
    /// The DynamicDataStoreEntity class can be used when we need to store custom entity info
    /// The DynamicDataStoreEntity class works as a bridge between the custom entity and community entity system.
    /// </summary>
    public abstract class DynamicDataStoreEntity : FrameworkEntityBase, IDynamicData
    {
        protected DynamicDataStoreEntity()
            : base(-1)
        {
            Id = Identity.NewIdentity();
        }

        #region IDynamicData Members

        public EPiServer.Data.Identity Id
        {
            get;
            set;
        }

        #endregion

        #region override

        public override int ID
        {
            get
            {
                return Id.StoreId != 0 ? (int)Id.StoreId : -1;
            }
            protected set
            {
            }
        }

        public override Guid UniqueID
        {
            get
            {
                return Id.ExternalId;
            }
        }

        #endregion
    }
}
