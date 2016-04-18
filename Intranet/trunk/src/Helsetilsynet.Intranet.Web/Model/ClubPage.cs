using System;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "ClubPage",
        Description = "This page type is used for showing a Club page",
        Filename = "/Templates/Pages/ClubPage.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.ClubPage,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public class ClubPage : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
    }
}