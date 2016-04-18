using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Util
{
    public class PropertyHelper
    {
        /// <summary>
        /// Returns a value stored as <see cref="PropertyData"/> in given page -> <see cref="page"/>.
        /// </summary>
        /// <remarks>
        /// If trying to get value of primitive type, use nullable type as <typeparam name="T"/>, e.g. "int?" instead of "int", "bool?" instead of "bool".
        /// </remarks>
        public static T GetPropertyValue<T>(string propertyName, PageData page)
        {
            if (page == null)
                return default(T);

            if (page.Property[propertyName] != null)
            {
                object objectValue = page.Property[propertyName].Value;
                T propertyValue = (T)objectValue;
                return propertyValue;
            }
            return default(T);
        }

        public static bool GetBooleanValue(string propertyName, PageData page)
        {
            if (page != null)
            {
                var property = page.Property[propertyName] as PropertyBoolean;
                return property != null && property.Boolean;
            }
            return false;
        }
    }
}