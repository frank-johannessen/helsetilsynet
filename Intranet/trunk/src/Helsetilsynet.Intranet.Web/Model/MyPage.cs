using System;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "MyPage",
        Description = "This page type is used for showing a members MyPage",
        Filename = "/Templates/Pages/MyPage.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.MyPage,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })] 
// ReSharper disable ClassNeverInstantiated.Global
    public class MyPage : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {

    }
}