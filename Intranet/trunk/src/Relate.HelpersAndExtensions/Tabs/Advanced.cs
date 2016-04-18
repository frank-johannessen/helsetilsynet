using EPiServer.Security;
using PageTypeBuilder;

namespace Relate.HelpersAndExtensions.Tabs
{
    internal class Advanced : Tab
    {
        public override string Name
        {
            get { return "Advanced"; }
        }

        public override AccessLevel RequiredAccess
        {
            get { return AccessLevel.Read; }
        }

        public override int SortIndex
        {
            get { return 3; }
        }

    }
}
