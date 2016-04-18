using System.Configuration;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections
{
    // http://jopinblog.wordpress.com/2007/04/20/custom-configurationsections-in-net-20-config-files/
    public class ExternalSystemConfigElement : ConfigurationElement
    {
        [ConfigurationProperty("id", IsKey = true, IsRequired = true)]
        public int ID
        {
            get
            {
                return (int) this["id"];
            } 
            set
            {
                this["id"] = value;
            }
        }

        [ConfigurationProperty("name", IsRequired = true)]
        public string Name
        {
            get
            {
                return this["name"].ToString();
            }
            set
            {
                this["name"] = value;
            }
        }

        [ConfigurationProperty("url", IsRequired = true)]
        public string Url
        {
            get
            {
                return this["url"].ToString();
            }
            set
            {
                this["url"] = value;
            }
        }

        [ConfigurationProperty("logo", IsRequired = false, DefaultValue = "")]
        public string Logo
        {
            get
            {
                return this["logo"].ToString();
            }
            set
            {
                this["logo"] = value;
            }
        }
    }
}