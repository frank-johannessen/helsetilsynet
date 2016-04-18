using System;
using EPiServer.Core;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "CalendarYearOverview",
        Description = "This page type is used for the calendar yearoverview",
        Filename = "/Templates/Pages/CalendarYearOverview.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Default,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })]
    // ReSharper disable ClassNeverInstantiated.Global
    public class CalendarYearOverview : BasePage
    // ReSharper restore ClassNeverInstantiated.Global
    {

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "NumberOfYearsToShow",
            HelpText = "how many years do you want to show the events of.",
            DefaultValue = 1,
            Type = typeof(PropertyNumber))]
        public virtual int? NumberOfYearsToShow { get; set; }
    }

}
