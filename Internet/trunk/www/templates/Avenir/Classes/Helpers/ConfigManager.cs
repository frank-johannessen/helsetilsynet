using System.Configuration;

namespace Helsetilsynet.templates.Avenir.Classes.Helpers
{
    public class ConfigManager
    {
        private const string _defaultLanguage = "DefaultLanguage";

        public static string DefaultLanguage
        {
            get { return ConfigurationManager.AppSettings[_defaultLanguage]; }
        }
    }
}