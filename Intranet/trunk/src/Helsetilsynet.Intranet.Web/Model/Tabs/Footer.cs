using EPiServer.Security;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model.Tabs
{
    public class Footer : Tab
    {
        public override string Name
        {
            get { return "Footer"; }
        }

        public override AccessLevel RequiredAccess
        {
            get { return AccessLevel.Read; }
        }

        public override int SortIndex
        {
            get { return 2; }
        }
    }
}