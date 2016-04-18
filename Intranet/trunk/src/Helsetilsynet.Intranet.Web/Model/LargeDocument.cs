using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.PropertyUserPickerControl;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "LargeDocument",
        Description = "LargeDocument",
        Filename = "/Templates/Pages/LargeDocument.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int) PageTypeSortOrder.LargeDocument,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = true,
        AvailablePageTypes = new[] {typeof (LargeDocumentChapter)})]
// ReSharper disable ClassNeverInstantiated.Global
    public class LargeDocument : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "MainIntro",
            DisplayInEditMode = true,
            SortOrder = 20,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainIntro { get; set; }

        [PageTypeProperty(EditCaption = "ResponsibleAuthor",
            HelpText = "ResponsibleAuthor",
            SortOrder = 60,
            UniqueValuePerLanguage = false,
            Required = false,
            Type = typeof(PropertySingleUserPicker))]
        public virtual string ResponsibleAuthor { get; set; }

    }
}