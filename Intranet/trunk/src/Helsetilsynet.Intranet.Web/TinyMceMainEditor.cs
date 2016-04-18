using EPiServer.Editor.TinyMCE;

namespace MakingWaves.Helsetilsynet.Intranet.Web
{
    // http://world.episerver.com/Modules/Forum/Pages/thread.aspx?id=44857

    [TinyMCEPluginNonVisual(
        AlwaysEnabled = true, 
        EditorInitConfigurationOptions = "{ extended_valid_elements: 'iframe[src|frameborder=0|alt|title|width|height|align|name]' }")]
    public class TinyMceMainEditor
    {
    }
}