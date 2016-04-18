using EPiServer.Security;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model.Tabs
{
    public class MegaMenuTab3 : Tab
    {
        public override string Name
        {
            get { return "MegaMenuTab3"; }
        }

        public override AccessLevel RequiredAccess
        {
            get { return AccessLevel.Read; }
        }

        public override int SortIndex
        {
            get { return 303; }
        }
    }
}