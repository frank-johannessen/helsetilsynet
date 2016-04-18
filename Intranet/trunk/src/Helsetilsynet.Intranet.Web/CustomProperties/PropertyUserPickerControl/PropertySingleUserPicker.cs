using System;
using EPiServer.PlugIn;
using Relate.HelpersAndExtensions.PropertyUserPickerControl;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.PropertyUserPickerControl
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