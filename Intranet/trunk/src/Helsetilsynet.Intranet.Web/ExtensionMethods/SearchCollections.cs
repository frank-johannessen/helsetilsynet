using System.Configuration;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    /// <summary>
    /// This class is reserved for names of different search collections
    /// </summary>
    public static class SearchCollections
    {
        public static string LosenCollection
        {
            get { return ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.Losen]; }
        }

        public static string CompendiaCollection
        {
            get { return ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.Compendia]; }
        }

        public static string HelsetilsynetNO
        {
            get { return ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.HelsetilsynetNO]; }
        }

        public static string CombinedCollection
        {
            get
            {
                return string.Format("{0}|{1}|{2}",
                                     ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.Losen],
                                     ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.Compendia],
                                     ConfigurationManager.AppSettings[GlobalName.GoogleMini.IndexName.HelsetilsynetNO]);
            }
        }
    }
}