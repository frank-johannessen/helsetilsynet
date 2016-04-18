using System.Collections.Generic;
using System.Linq;
using EPiServer.Core;
using EPiServer.Core.PropertySettings;
using EPiServer.SpecializedProperties;
using EPiServer.Web.PropertyControls.PropertySettings;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util
{
    public static class CheckBoxLists
    {
        public static Dictionary<string, string> GetCheckBoxListSettings(PageData pageData, string propertyName)
        {
            var retval = new Dictionary<string,string>();

            if (pageData.Property[propertyName].GetType() == typeof(PropertyCheckBoxList))
            {
                var listProp = (PropertyCheckBoxList)pageData.Property[propertyName];
                IPropertySettingsRepository propRepository = new PropertySettingsRepository();

                PropertySettingsContainer container;

                if (propRepository.TryGetContainer(listProp.SettingsID, out container))
                {
                    var multiSelectSettings =
                        (container.Settings.Values
                            .Where(value => value.PropertySettings.GetType() == typeof (MultipleOptionsListSettings))
                        ).FirstOrDefault();

                    if (multiSelectSettings != null)
                    {
                        var settings = ((MultipleOptionsListSettings)multiSelectSettings.PropertySettings);
                        retval = settings.ListOptions;
                    }
                }
            }

            return retval;
        }
    }
}