using EPiServer.Data.Dynamic;

namespace Relate.HelpersAndExtensions.BookmarkFramework
{
    [EPiServerDataContract]
    [EPiServerDataStore(AutomaticallyRemapStore = true)]
    public class LinkContainer : DynamicCommunityEntity
    {
        [EPiServerDataMember]
        public string Name { get; set; }

        public override string[] CacheKey
        {
            get { return new string[] { "LinkContainer", ID.ToString() }; }
        }
    }
}
