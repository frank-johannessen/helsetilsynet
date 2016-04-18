using System.Collections;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	public class XmlImportFileCollection: CollectionBase
	{
		// public methods...
		#region Add
		public int Add(XmlImportFile xmlImportFile)
		{
			return List.Add(xmlImportFile);
		}
		#endregion
		#region IndexOf
		public int IndexOf(XmlImportFile xmlImportFile)
		{
			for(int i = 0; i < List.Count; i++)
				if (this[i] == xmlImportFile)    // Found it
					return i;
			return -1;
		}
		#endregion
		#region Insert
		public void Insert(int index, XmlImportFile xmlImportFile)
		{
			List.Insert(index, xmlImportFile);
		}
		#endregion
		#region Remove
		public void Remove(XmlImportFile xmlImportFile)
		{
			List.Remove(xmlImportFile);
		}
		#endregion
		#region Find
		// TODO: If desired, change parameters to Find method to search based on a property of XmlImportFile.
		public XmlImportFile Find(XmlImportFile xmlImportFile)
		{
			foreach(XmlImportFile lxmlImportFile in this)
				if (lxmlImportFile == xmlImportFile)    // Found it
					return lxmlImportFile;
			return null;    // Not found
		}
		#endregion
		#region Contains
		// TODO: If you changed the parameters to Find (above), change them here as well.
		public bool Contains(XmlImportFile xmlImportFile)
		{
			return (Find(xmlImportFile) != null);
		}
		#endregion
 	
		// public properties...
		#region this[int aIndex]
		public XmlImportFile this[int index] 
		{
			get
			{
				return (XmlImportFile) List[index];
			}
			set
			{
				List[index] = value;
			}
		}
		#endregion
	}
 
}
