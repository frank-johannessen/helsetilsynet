using System;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "SystemMessagePage",
        Description = "This page type is used for showing a system message",
        Filename = "/Templates/Pages/SystemMessage.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Default,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public class SystemMessagePage : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainBody { get; set; }
    }
}