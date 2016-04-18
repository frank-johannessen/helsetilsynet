using EPiServer.DataAbstraction;

namespace EPiCode.PageTypeUtil.PropertyImport
{
	public class PropertyUtil
	{
		private PropertyUtil()
		{
		}

		public static bool PropertyExistOnPageType(int pageTypeId, string propertyName)
		{
			PageDefinitionCollection defs = PageDefinition.List(pageTypeId);
			foreach(PageDefinition exisingDef in defs)
			{
				if (string.Compare(exisingDef.Name, propertyName, /* ignoreCase*/ true) == 0)
					return true;
			}
			return false;
		}


	}
}
