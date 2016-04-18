using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex
{
    [Serializable]
    [PageDefinitionTypePlugIn]
    public class LosenAlphabethicalEditorProperty : PropertyString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new LosenAlphabethicalEditorControl();
        }
    }
}