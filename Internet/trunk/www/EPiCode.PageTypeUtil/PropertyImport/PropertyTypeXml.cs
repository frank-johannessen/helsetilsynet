using System;
using System.Xml;
using EPiServer.DataAbstraction;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	public class PropertyTypeXml
	{
		/*
	<property>
		<name>MyName</name>
		<editcaption>My Name</editcaption>
		<editdesc>Description</editdesc>
		<required>false</required>
		<searchable>false</searchable>
		<tab>Advanced Information</tab>
		<type>
			<name>Divider</name>
			<basetype>Number</basetype>
			<!-- Custom ones -->
			<fulltype>BVNetwork.PropertyTypes.PropertyDivider</fulltype>
			<assemblyname>EPiNito</assemblyname>
		</type>
	</property>

		*/

	    /// <summary>
	    /// The base type, among the PropertyPageType enums
	    /// </summary>
	    public string BaseType { get; set; }
	    public string FullType { get; set; }
	    public string AssemblyName { get; set; }
	    public string TypeName { get; set; }

	    /// <summary>
	    /// Gets or sets the type id for built in properties
	    /// </summary>
	    /// <remarks>
	    /// Built-in Property types
	    /// String: 6 
	    /// LongString: 7
	    /// Boolean: 0
	    /// PageReference: 4
	    /// Number: 1
	    /// PageType: 3
	    /// ...
	    /// </remarks>
	    /// <value></value>
	    public int TypeId { get; set; }
	    public string Tab { get; set; }
	    public bool Searchable { get; set; }
	    public bool Required { get; set; }
	    public bool LanguageSpecific { get; set; }
	    public string EditDescription { get; set; }
	    public string EditCaption { get; set; }
	    public string Name { get; set; }

	    public PropertyTypeXml(XmlNode node)
		{
			Name = GetNodeValue(node, "name", "Missing Name");
			EditCaption = GetNodeValue(node, "editcaption");
			EditDescription = GetNodeValue(node, "editdescription");
			Required = bool.Parse(GetNodeValue(node, "required", "false"));
			Searchable = bool.Parse(GetNodeValue(node, "searchable", "false"));
			LanguageSpecific = bool.Parse(GetNodeValue(node, "languagespecific", "false"));
			Tab = GetNodeValue(node, "tab", "Information");
			
			this.TypeName = GetNodeValue(node, "type/name");
			this.BaseType = GetNodeValue(node, "type/basetype");
			this.FullType = GetNodeValue(node, "type/fulltype");
			this.AssemblyName = GetNodeValue(node, "type/assemblyname");
		}
        
		private string GetNodeValue(XmlNode node, string elementName)
		{
			return GetNodeValue(node, elementName, "");
		}

		private string GetNodeValue(XmlNode node, string elementName, string defaultValue)
		{
			XmlNode subNode = node.SelectSingleNode(elementName);
			if (subNode == null)
				return defaultValue;
			else
			{
				if (subNode.InnerText.Length > 0)
					return subNode.InnerText;
				else
					return defaultValue;
			}
		}

		public PageDefinition GetPropertyFromXmlData()
		{
			PageDefinition def = new PageDefinition();
			def.Name = Name;
			def.EditCaption = EditCaption;
			def.Required = Required;
			def.Searchable = Searchable;
			def.Tab = TabDefinition.Load(Tab);
			def.LanguageSpecific = LanguageSpecific;

			/*
			PageDefinitionType defType = new PageDefinitionType();
			defType.Name = this.TypeName;
			defType.DataType = (EPiServer.Core.PropertyDataType)Enum.Parse(typeof(EPiServer.Core.PropertyDataType), this.BaseType, true);
			defType.AssemblyName = this.AssemblyName;
			defType.TypeName = this.FullType;
			*/
			PageDefinitionType defType = FindType();
			if (defType == null)
				throw new Exception("PageDefinitionType " + this.TypeName + " not found.");
			def.Type = defType;

			return def;
		}

		/// <summary>
		/// Finds the corresponding EPiServer type based on the values in the config file.
		/// </summary>
		/// <remarks>
		/// Loops through all propertytypes and tries to match against the name first.
		/// If there is no name, tries the full typename instead.
		/// Last, we try the basetype.
		/// The search is case insensitive
		/// </remarks>
		/// <returns>The PageDefinitionType if found, null if not</returns>
		public PageDefinitionType FindType()
		{
			PageDefinitionTypeCollection types = PageDefinitionType.List();
			foreach(PageDefinitionType defType in types)
			{
				if (string.Compare(this.TypeName, defType.Name, /* IgnoreCase */ true) == 0)
				{
					// Matched typename
					return defType;																		   
				}
			}

			foreach(PageDefinitionType defType in types)
			{
				if (string.Compare(this.FullType, defType.TypeName, /* IgnoreCase */ true) == 0)
				{
					// Found a fulltype match, return this
					return defType;
				}
			}
			foreach(PageDefinitionType defType in types)
			{
				if (string.Compare(this.BaseType, defType.DataType.ToString(), /* IgnoreCase */ true) == 0)
				{
					// Matched basetype
					return defType;																		   
				}
			}
			return null;
		}


		public bool ExistOnPageType(int pageTypeId)
		{
			return PropertyUtil.PropertyExistOnPageType(pageTypeId, this.Name);
		}

		/// <summary>
		/// Saves the page type based on the parsed xml.
		/// </summary>
		/// <param name="pageTypeId">ID of the PageType to save this property on</param>
		/// <returns>The saved pagetype if success. Note! If the type already exists, an exception is thrown</returns>
		public PageDefinition SaveOnPageType(int pageTypeId)
		{
			if (ExistOnPageType(pageTypeId))
				throw new ArgumentException("Property " + Name + " already exist on pagetype (" + pageTypeId.ToString() + ")", "pageTypeId");

			// Check if it exists	
			PageDefinition def = GetPropertyFromXmlData();
			def.PageTypeID = pageTypeId;
			// First save datatype
			def.Save();
			return def;
		}

	}
}
