using System;
using EPiServer.Common;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    public abstract class DynamicCommunityEntity : FrameworkEntityBase, IDynamicData
    {
        protected DynamicCommunityEntity()
            : base(-1)
        {
        }

        protected DynamicCommunityEntity(Identity id)
            : base(-1)
        {
            DdsIdentity = id;
        }

        Identity IDynamicData.Id { get; set; }

        /// <summary>
        /// DDS identity
        /// </summary>
        public virtual Identity DdsIdentity
        {
            get
            {
                return ((IDynamicData)this).Id;
            }
            set
            {
                Identity identity = value;

                if (identity != null)
                {
                    if (identity.StoreId > (long)Int32.MaxValue)
                    {
                        throw new InvalidOperationException("DDS StoreId outside range for Community entity IDs");
                    }
                }
                ((IDynamicData)this).Id = identity;
            }
        }

        /// <summary>
        /// Community identity
        /// </summary>
        public override int ID
        {
            get
            {
                if (DdsIdentity == null)
                    return -1;
                else
                    return checked((int)DdsIdentity.StoreId);
            }
            protected set
            {
                throw new NotSupportedException("Community ID only settable implicitly through DDS StoreId");
            }
        }

        public override Guid UniqueID
        {
            get
            {
                return DdsIdentity.ExternalId;
            }

        }
    }
}
