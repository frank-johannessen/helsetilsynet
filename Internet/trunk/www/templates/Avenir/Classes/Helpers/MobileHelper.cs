using EPiServer;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Util;

namespace Helsetilsynet.templates.Avenir.Classes.Helpers
{
    public class MobileHelper
    {
        private const string MobileHideCssClass = "mobile-hide";

        /// <summary>
        /// Based on a property saved on Start Page, method returns "mobile-hide" css class (if property is checked) or string.empty (if property is unchecked)
        /// </summary>
        public static string ShowCheckBoxList(string propertyName)
        {
            if (PropertyHelper.GetBooleanValue(propertyName, DataFactory.Instance.GetPage(PageReference.StartPage)))
            {
                return MobileHideCssClass;
            }

            return string.Empty;
        }
    }
}