using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.Data.Dynamic;
using Relate.HelpersAndExtensions.BookmarkFramework;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.DelayedPublish
{
    [EPiServerDataContract]
    [EPiServerDataStore(AutomaticallyRemapStore = true)]
    public class DelayedPage : DynamicCommunityEntity
    {
        public DelayedPage()
        {
        }

        public DelayedPage(PageReference pageRef)
        {
            PageReference = pageRef;
        }
        
        [EPiServerDataMember]
        public PageReference PageReference { get; set; }
        
        public override string[] CacheKey
        {
            get { return new[] { "DelayedPage", ID.ToString() }; }
        }
    }
}