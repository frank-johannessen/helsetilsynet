using EPiServer.SpecializedProperties;
using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    [EPiServerDataContract]
    [EPiServerDataStore(AutomaticallyRemapStore = true)]
    public class BookmarkLink : DynamicCommunityEntity
    {
        public BookmarkLink()
        {
        }

        public BookmarkLink(LinkItem link, LinkContainer container)
        {
            Link = link;
            Container = container;
        }
        
        [EPiServerDataMember]
        public LinkItem Link { get; set; }

        [EPiServerDataMember]
        public LinkContainer Container { get; set; }

        public override string[] CacheKey
        {
            get { return new string[] { "BookmarkLink", ID.ToString() }; }
        }
    }
}
