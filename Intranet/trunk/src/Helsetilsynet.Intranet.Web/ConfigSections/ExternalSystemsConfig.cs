using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections
{
    // http://jopinblog.wordpress.com/2007/04/20/custom-configurationsections-in-net-20-config-files/
    public class ExternalSystemsConfig
    {
        private static readonly Dictionary<int, ExternalSystemConfigElement> Elements;

        static ExternalSystemsConfig()
        {
            Elements = new Dictionary<int, ExternalSystemConfigElement>();
            var section = (ExternalSystemConfigSection) ConfigurationManager.GetSection("externalSystems");
            foreach (ExternalSystemConfigElement system in section.ExternalSystems)
                Elements.Add(system.ID, system);
        }
        
        public static ExternalSystemConfigElement GetExternalSystem(int externalSystemId)
        {
            return Elements[externalSystemId];
        }

        public static List<ExternalSystemConfigElement> ExternalSystems
        {
            get { return Elements.Values.ToList(); }
        }

        private ExternalSystemsConfig()
        {
        }
    }
}