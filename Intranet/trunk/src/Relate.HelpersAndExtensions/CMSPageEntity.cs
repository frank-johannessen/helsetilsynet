using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using EPiServer.Core;

namespace Relate.HelpersAndExtensions
{
    /// <summary>
    /// CMSPageEntity represents a CMS Page Data entity which can collaborate with Community framework 
    /// </summary>
    [DataContract]
    public class CMSPageEntity : DynamicDataStoreEntity
    {
        #region Constructure

        /// <summary>
        /// Initializes a new instance of the <see cref="CMSPageEntity"/> class by CMS page data.
        /// </summary>
        /// <param name="pageData">The page data.</param>
        public CMSPageEntity(PageData pageData)
        {
            PageGuid = pageData.PageGuid;
            PageLanguage = pageData.LanguageID;
            PageWorkID = pageData.WorkPageID;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="CMSPageEntity"/> class.
        /// </summary>
        /// <param name="pageGuid">The page GUID.</param>
        /// <param name="pageLanguage">The page language.</param>
        /// <param name="pageWorkID">The page work ID.</param>
        public CMSPageEntity(Guid pageGuid, string pageLanguage, int pageWorkID)
        {
            PageGuid = pageGuid;
            PageLanguage = pageLanguage;
            PageWorkID = pageWorkID;
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="CMSPageEntity"/> class.
        /// </summary>
        public CMSPageEntity()
            : this(Guid.Empty, String.Empty, -1)
        {
        }

        #endregion

        #region override

        /// <summary>
        /// Gets the cache key. It Uses in the common framework
        /// </summary>
        /// <value>The cache key.</value>
        public override string[] CacheKey
        {
            get { return new[] { typeof(CMSPageEntity).FullName, ID.ToString() }; }
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets the page guid
        /// </summary>
        /// <value>The page data entry ID.</value>
        [DataMember]
        public Guid PageGuid
        {
            get;
            private set;
        }

        /// <summary>
        /// Gets or sets the page data work ID.
        /// </summary>
        /// <value>The page data work ID.</value>
        [DataMember]
        public int PageWorkID
        {
            get;
            private set;
        }

        /// <summary>
        /// Gets or sets the page data language.
        /// </summary>
        /// <value>The page data language.</value>
        [DataMember]
        public String PageLanguage
        {
            get;
            private set;
        }

        #endregion
    }
}
