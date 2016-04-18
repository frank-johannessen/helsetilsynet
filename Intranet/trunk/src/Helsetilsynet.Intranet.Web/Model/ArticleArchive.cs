using EPiServer.Core;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "ArticleArchive",
        Description = "ArticleArchive",
        Filename = "/Templates/Pages/ArticleArchive.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.ArticleArchive,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new[] { typeof(Article), typeof(Folder) })]
// ReSharper disable ClassNeverInstantiated.Global
    public class ArticleArchive : BaseEditorialPage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "HitsPerPage",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof(PropertyNumber))]
        public virtual int? HitsPerPage { get; set; }
    }
}