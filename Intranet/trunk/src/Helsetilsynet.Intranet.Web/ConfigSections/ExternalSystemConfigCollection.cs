using System.Configuration;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections
{
    // http://jopinblog.wordpress.com/2007/04/20/custom-configurationsections-in-net-20-config-files/
    public class ExternalSystemConfigCollection : ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new ExternalSystemConfigElement();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((ExternalSystemConfigElement) element).ID;
        }
    }
}