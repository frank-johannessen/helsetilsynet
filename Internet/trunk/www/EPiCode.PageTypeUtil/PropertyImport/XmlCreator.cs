using System.Xml;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	/// <summary>
	/// Summary description for XmlCreator.
	/// </summary>
	public class XmlCreator 
	{
		private XmlDocument _doc;
		private XmlNode _current;

		public XmlCreator() 
		{
			_doc = new XmlDocument();
		}

		public XmlDocument Document 
		{
			get 
			{
				return this._doc;
			}
		}

		public XmlElement Create(string name, string text) 
		{
			XmlElement element = _doc.CreateElement(name);

			if (text != null) 
			{
				element.AppendChild(_doc.CreateTextNode(text));
			}

			if (_current == null) 
			{
				_doc.AppendChild(element);
				_current = (XmlNode) element;
			}
			else 
			{
				_current.AppendChild(element);

				if (text == null) 
					_current = (XmlNode) element;
			}

			return element;
		}

		public XmlElement Create(string name) 
		{
			return Create(name, null);
		}

		public XmlNode LoadParent() 
		{
			if (_current != null && _current != _current.OwnerDocument.FirstChild)
				_current = _current.ParentNode;

			return _current;
		}
	}

}
