using EPiServer.DynamicContent;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{
    // Simple walk-through on DynamicContent:
    // http://blog.fredrikhaglund.se/blog/2011/06/28/dynamic-content-in-episerver-cms-6-r2/

    [DynamicContentPlugIn(DisplayName = "Iframe",
        ViewUrl = "~/Templates/DynamicContent/Iframe.ascx")]
    public partial class Iframe : UserControlBase<BasePage>
    {
// ReSharper disable MemberCanBeProtected.Global
        public string Url { get; set; }
        public int Width { get; set; }
        public int Height { get; set; }
// ReSharper restore MemberCanBeProtected.Global
    }
}