using System.Configuration;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections
{
    // http://jopinblog.wordpress.com/2007/04/20/custom-configurationsections-in-net-20-config-files/
    public class ExternalSystemConfigSection : ConfigurationSection
    {
        [ConfigurationProperty("", IsRequired = true, IsDefaultCollection = true)]
        public ExternalSystemConfigCollection ExternalSystems
        {
            get
            {
                return (ExternalSystemConfigCollection) this[""];
            }
            set
            {
                this[""] = value;
            }
        }
    }
}