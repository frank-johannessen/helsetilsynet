using System;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "PhoneList",
        Description = "This page type is used for showing a members PhoneList",
        Filename = "/Templates/Pages/PhoneList.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int) PageTypeSortOrder.PhoneList,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = true,
        AvailablePageTypes = new Type[] {})]
// ReSharper disable ClassNeverInstantiated.Global
    public class PhoneList : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "Department",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof (PropertyDropDownList))
        ]
        public virtual string Department { get; set; }
        [PageTypeProperty(
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainBody { get; set; }
    }

}