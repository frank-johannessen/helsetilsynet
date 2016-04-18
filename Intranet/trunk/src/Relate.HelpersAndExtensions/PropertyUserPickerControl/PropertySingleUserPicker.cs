using System;
using EPiServer.PlugIn;

namespace Relate.HelpersAndExtensions.PropertyUserPickerControl
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName = "PropertySingleUserPicker")]
    public class PropertySingleUserPicker : EPiServer.Core.PropertyLongString
    {
        public override EPiServer.Core.IPropertyControl CreatePropertyControl()
        {
            return new PropertySingleUserPickerControl();
        }
    }
}