using System.IO;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	/// <summary>
	/// Main Class for property importing
	/// </summary>
	public class PropertyImporter
	{
		private XmlImportFileCollection _importFiles;

		public XmlImportFileCollection ImportFiles
		{
			get
			{
				return _importFiles;
			}
		}


		/// <summary>
		/// Default constructor. Reads all import files from disk
		/// </summary>
		public PropertyImporter()
		{
			// Get resource folder
			string virtualPath = Configuration.VirtualImportDirectory;
			string localPath = System.Web.HttpContext.Current.Server.MapPath(virtualPath);
			DirectoryInfo dir = new DirectoryInfo(localPath);
			// Get all .xml files
			FileInfo[] files = dir.GetFiles("*.xml");

			_importFiles = new XmlImportFileCollection();

			foreach(FileInfo file in files)
			{
				// New wrapper class
				XmlImportFile xmlFile = new XmlImportFile(virtualPath + "/" + file.Name);
				_importFiles.Add(xmlFile);
			}
		}

		
	}
}
