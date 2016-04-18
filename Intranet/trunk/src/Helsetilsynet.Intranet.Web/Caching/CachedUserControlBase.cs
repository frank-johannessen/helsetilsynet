using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using EPiServer;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Caching
{
    public class CachedUserControlBase<T> : UserControlBase<T> where T : PageTypeBuilder.TypedPageData 
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            SetCacheDependency();
        }

        /// <summary>
        /// Sets a cache dependency to CurrentPage if the user control supports output cache    
        /// </summary>
        public virtual void SetCacheDependency()
        {
            // Check if the user control supports caching
            if (this.CachePolicy.SupportsCaching)
            {
                // Create a dependency to *any* update to *any* page on the site (new, update, move, delete)
                String[] pageCacheDependencyKey = new String[1];
                pageCacheDependencyKey[0] = DataFactoryCache.VersionKey;
                CacheDependency dependency = new CacheDependency(null, pageCacheDependencyKey);
                this.CachePolicy.Dependency = dependency;

            }
        }
    }

}