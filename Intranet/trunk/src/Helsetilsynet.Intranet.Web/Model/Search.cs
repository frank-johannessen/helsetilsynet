using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "Search",
        Description = "Search",
        Filename = "/Templates/Pages/Search.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Search,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] {})]
// ReSharper disable ClassNeverInstantiated.Global
    public class Search : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "DocumentType",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string DocumentType { get; set; }

        [PageTypeProperty(
            EditCaption= "HitsPerPage",
            DisplayInEditMode = true,
            SortOrder = 20,
            Type = typeof(PropertyNumber))]
        public virtual int? HitsPerPage { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "RightContentHeading",
            HelpText = "The heading for the rightcontent",
            SortOrder = 30,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyString))]
        public virtual string RightContentHeading { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "RightContent",
            HelpText = "The RightContent for the page",
            SortOrder = 40,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyXhtmlString))]
        public virtual string RightContent { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "TilsynssakerOverskrift",
            HelpText = "Overskrift til tilsynssaker i høyrekolonne",
            SortOrder = 50,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyString)
            )]
        public virtual string TilsynssakerOverskrift { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Tilsynssaker-lenke",
            HelpText = "Lenke til tilsynssaker i høyrekolonne",
            SortOrder = 60,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyUrl)
            )]
        public virtual string Tilsynssaker { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Tilsynssaker-lenketekst",
            HelpText = "Lenketekst til tilsynssaker i høyrekolonne",
            SortOrder = 70,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyUrl)
            )]
        public virtual string TilsynssakerLenketekst { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "TilsynsrapporterOverskrift",
            HelpText = "Overskrift til tilsynsrapporter i høyrekolonne",
            SortOrder = 80,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyString)
            )]
        public virtual string TilsynsrapporterOverskrift { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Tilsynsrapporter-lenke",
            HelpText = "Lenke til tilsynsrapporter i høyrekolonne",
            SortOrder = 90,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyUrl)
            )]
        public virtual string Tilsynsrapporter { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Tilsynsrapporter-lenketekst",
            HelpText = "Lenketekst til tilsynsrapporter i høyrekolonne",
            SortOrder = 100,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyString)
            )]
        public virtual string TilsynsrapporterLenketekst { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Søkeside hjelpetekst",
            HelpText = "Søkeside hjelpetekst(boks under siden.",
            SortOrder = 101,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyXhtmlString)
            )]
        public virtual string SearchResultHelp { get; set; }
    }
}