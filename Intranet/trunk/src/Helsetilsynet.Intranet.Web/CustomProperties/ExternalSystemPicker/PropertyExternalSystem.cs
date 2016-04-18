using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.ExternalSystemPicker
{
    [Serializable]
    [PageDefinitionTypePlugIn]
    public class PropertyExternalSystem : PropertyString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new PropertyExternalSystemControl();
        }
    }
}