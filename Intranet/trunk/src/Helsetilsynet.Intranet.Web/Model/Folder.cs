using System;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "Folder",
        Description = "Mappe for organisering av sider",
        Filename = "/Templates/Pages/Folder.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.GlobalSettings,
        DefaultVisibleInMenu = false,
        AvailableInEditMode = true,
        AvailablePageTypes = new Type[] { })]
    public class Folder : BasePage, IVirtualFolder
    {
    }
}