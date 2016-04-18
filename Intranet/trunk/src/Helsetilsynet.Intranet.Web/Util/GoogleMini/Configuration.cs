using System;
using System.Configuration;
using GSALib.GSA;
using MakingWaves.Helsetilsynet.Util.GoogleMini;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.GoogleMini
{
    /// <summary>
    /// Internal configuration class used by <see cref="DocQuery"/>
    /// </summary>
    internal static class Configuration
    {
        internal static ClientAccess ClientAccess
        {
            get { return new ClientAccess(GoogleMiniHostAddress); }
        }

        private static string GoogleMiniHostAddress
        {
            get { return "http://" + GetConfigValueOrException(GlobalName.GoogleMini.HostAddress); }
        }
        

        private static string GetConfigValueOrException(string configKey)
        {
            var configValue = ConfigurationManager.AppSettings[configKey];

            if (String.IsNullOrEmpty(configValue))
                throw new Exception("Config key '" + configKey + " ' not set or empty.");

            return configValue;
        }
    }
}
