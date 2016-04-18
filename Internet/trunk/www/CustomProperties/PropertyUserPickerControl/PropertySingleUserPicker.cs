using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace Helsetilsynet.CustomProperties.PropertyUserPickerControl
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName = "PropertySingleUserPicker")]
    public class PropertySingleUserPicker : PropertyLongString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new PropertySingleUserPickerControl();
        }
    }
}