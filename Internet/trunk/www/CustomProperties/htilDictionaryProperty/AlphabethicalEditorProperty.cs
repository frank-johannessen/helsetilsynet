using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace Helsetilsynet.CustomProperties.htilDictionaryProperty
{
    [Serializable]
    [PageDefinitionTypePlugIn]
    public class AlphabethicalEditorProperty : PropertyString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new AlphabethicalEditorControl();
        }
    }
}