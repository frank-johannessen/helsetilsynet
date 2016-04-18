using System;
using System.Xml;
using System.Collections;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	
	public class PropertyTypeXmlCollection: CollectionBase
	{
		// public methods...
		#region Add
		public int Add(PropertyTypeXml propertyTypeXml)
		{
			return List.Add(propertyTypeXml);
		}
		#endregion
		#region IndexOf
		public int IndexOf(PropertyTypeXml propertyTypeXml)
		{
			for(int i = 0; i < List.Count; i++)
				if (this[i] == propertyTypeXml)    // Found it
					return i;
			return -1;
		}
		#endregion
		#region Insert
		public void Insert(int index, PropertyTypeXml propertyTypeXml)
		{
			List.Insert(index, propertyTypeXml);
		}
		#endregion
		#region Remove
		public void Remove(PropertyTypeXml propertyTypeXml)
		{
			List.Remove(propertyTypeXml);
		}
		#endregion
		#region Find
		// TODO: If desired, change parameters to Find method to search based on a property of PropertyTypeXml.
		public PropertyTypeXml Find(PropertyTypeXml propertyTypeXml)
		{
			foreach(PropertyTypeXml lPropertyTypeXml in this)
				if (lPropertyTypeXml == propertyTypeXml)    // Found it
					return lPropertyTypeXml;
			return null;    // Not found
		}
		#endregion
		#region Contains
		// TODO: If you changed the parameters to Find (above), change them here as well.
		public bool Contains(PropertyTypeXml propertyTypeXml)
		{
			return (Find(propertyTypeXml) != null);
		}
		#endregion
	
		// public properties...
		#region this[int aIndex]
		public PropertyTypeXml this[int index] 
		{
			get
			{
				return (PropertyTypeXml) List[index];
			}
			set
			{
				List[index] = value;
			}
		}
		#endregion
	}
}