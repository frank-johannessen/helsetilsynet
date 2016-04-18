using System;
using System.Xml;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	/// <summary>
	/// One xml file with property import information
	/// </summary>
	public class XmlImportFile
	{
		private string _name;
		private string _filename;
		private string _localFile;
		private string _description;
		private PropertyTypeXmlCollection _properties;

		public XmlImportFile(string virtualPath)
		{
			_filename = virtualPath;
			_localFile = System.Web.HttpContext.Current.Server.MapPath(virtualPath);

			// Read the file, get the name and description, and all the properties
			// We really don't need the xml document at the moment
			ReadFromFile(_localFile);
		}

		public string Description
		{
			get
			{
				return _description;
			}
		}

		/// <summary>
		/// The server local filename and path
		/// </summary>
		/// <value></value>
		public string LocalFile
		{
			get
			{
				return _localFile;
			}
		}

		/// <summary>
		/// Gets the virtual path and filename of the xml file
		/// </summary>
		/// <value></value>
		public string Filename
		{
			get
			{
				return _filename;
			}
		}
		
		public string Name
		{
			get
			{
				return _name;
			}
		}

		public PropertyTypeXmlCollection Properties
		{
			get
			{
				return _properties;
			}
		}


		private System.Xml.XmlDocument ReadFromFile(string path)
		{

			_properties = new PropertyTypeXmlCollection();

			XmlDocument doc = new XmlDocument();
			doc.Load(path);

			XmlNode nameNode = doc.SelectSingleNode("import/importinfo/name");
			if (nameNode != null)
				_name = nameNode.InnerText;

			XmlNode descNode = doc.SelectSingleNode("import/importinfo/description");
			if (descNode != null)
				_description = descNode.InnerText;

			// Read all properties from file
			XmlNodeList nodes = doc.SelectNodes("import/properties/property");
			foreach(XmlNode node in nodes)
			{
				PropertyTypeXml prop = new PropertyTypeXml(node);
				_properties.Add(prop);
			}

			return doc;
		}

	}
}
