using System;
using EPiServer.PlugIn;

namespace Relate.HelpersAndExtensions.PropertyUserPickerControl
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName = "PropertyUserPicker")]
    public class PropertyUserPicker : EPiServer.Core.PropertyLongString
    {
        public override EPiServer.Core.IPropertyControl CreatePropertyControl()
        {
            return new PropertyUserPickerControl();
        }
    }
}