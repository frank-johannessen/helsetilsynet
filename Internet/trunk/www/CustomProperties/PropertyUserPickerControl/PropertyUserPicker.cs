using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace Helsetilsynet.CustomProperties.PropertyUserPickerControl
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName = "PropertyUserPicker")]
    public class PropertyUserPicker : PropertyLongString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new PropertyUserPickerControl();
        }
    }
}