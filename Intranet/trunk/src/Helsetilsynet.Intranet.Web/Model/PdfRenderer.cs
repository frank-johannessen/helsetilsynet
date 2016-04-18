using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "PdfRenderer",
        Description = "PdfRenderer",
        Filename = "/Templates/Pages/PdfRenderer.aspx",
        SortOrder = (int)PageTypeSortOrder.PdfRenderer,
        DefaultVisibleInMenu = false,
        AvailableInEditMode = false)]
// ReSharper disable ClassNeverInstantiated.Global
    public class PdfRenderer : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
    }
}