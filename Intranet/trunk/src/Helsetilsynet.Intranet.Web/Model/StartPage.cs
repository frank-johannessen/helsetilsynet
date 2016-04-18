using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "StartPage",
        Description = "This page type is used for the start page",
        Filename = "/Templates/Pages/StartPage.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.StartPage,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })] 
// ReSharper disable ClassNeverInstantiated.Global
    public class StartPage : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(EditCaption = "GlobalSettings",
            HelpText = "PageReference to the GlobalSettings page",
            SortOrder = 100,
            UniqueValuePerLanguage = false,
            Searchable = false,
            Required = false,
            DisplayInEditMode = true,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference GlobalSettingsReference { get; set; }

        [PageTypeProperty(EditCaption = "RelateGlobalSettingsPage",
            HelpText = "PageReference to the RelateGlobalSettingsPage",
            SortOrder = 200,
            UniqueValuePerLanguage = false,
            Searchable = false,
            Required = false,
            DisplayInEditMode = true,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference RelateGlobalSettingsPage { get; set; }

        [PageTypeProperty(EditCaption = "MegaMenuSettingsPage",
            HelpText = "PageReference to the MegaMenuSettingsPage",
            SortOrder = 300,
            UniqueValuePerLanguage = false,
            Searchable = false,
            Required = false,
            DisplayInEditMode = true,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MegaMenuSettingsPage { get; set; }

        [PageTypeProperty(EditCaption = "MediaWatch",
            HelpText = "MediaWatch",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection MediaWatch { get; set; }
    }
}