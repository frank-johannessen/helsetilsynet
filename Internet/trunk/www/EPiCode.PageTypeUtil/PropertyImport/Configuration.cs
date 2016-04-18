using System.Configuration;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	/// <summary>
	/// Configuration class for the Property importer
	/// </summary>
	public class Configuration
	{
		private const string KEY_IMPORT_DIRECTORY = "EPsBvnPropertyImportResDirectory";
        private const string DEF_IMPORT_DIRECTORY = "~/EPiCode.PageTypeUtil/importresources";

		// private, only use static methods
		private Configuration()
		{
		}

		/// <summary>
		/// Gets the virtual import directory.
		/// </summary>
		/// <value></value>
		public static string VirtualImportDirectory
		{
			get
			{
				if ( ConfigurationManager.AppSettings[KEY_IMPORT_DIRECTORY] != null)
					return ConfigurationManager.AppSettings[KEY_IMPORT_DIRECTORY].ToString();
				
				return DEF_IMPORT_DIRECTORY;
			}
		}

	}
}
