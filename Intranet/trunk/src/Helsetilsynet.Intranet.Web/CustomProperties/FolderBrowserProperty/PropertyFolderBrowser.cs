using EPiServer.Core;
using EPiServer.PlugIn;


// https://www.coderesort.com/p/epicode/browser/Meridium.FolderBrowserProperty/6.x/Meridium/FolderBrowserProperty/Dialogs/FolderBrowserDialog.aspx
namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.FolderBrowserProperty
{
    [PageDefinitionTypePlugIn(DisplayName = "Folder browser")]
    public class PropertyFolderBrowser : PropertyString
    {
        public override IPropertyControl CreatePropertyControl()
        {
            return new PropertyFolderBrowserControl();
        }
    }
}