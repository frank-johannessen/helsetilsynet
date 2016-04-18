using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using MakingWaves.EPiImage;
using PageTypeBuilder;
using PropertySingleUserPicker = MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.PropertyUserPickerControl.PropertySingleUserPicker;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "Article",
        Description = "Article",
        Filename = "/Templates/Pages/Article.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Article,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = true,
        AvailablePageTypes = new Type[] { })] 
    public class Article : BaseEditorialPage
    {
        [PageTypeProperty(
            EditCaption = "ToBeRevised",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof(PropertyDate))
        ]
        public virtual DateTime? ToBeRevised { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Description",
            HelpText = "The Description for the page (used by google mini)",
            SortOrder = 15,
            Required = true,
            Type = typeof(PropertyString))]
        public virtual string Description { get; set; }

        [PageTypeProperty(
            EditCaption = "MainIntro",
            DisplayInEditMode = true,
            SortOrder = 20,
            Type = typeof(PropertyLongString))
        ]
        public virtual string MainIntro { get; set; }        
        
        [PageTypeProperty(
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainBody { get; set; }

        [PageTypeProperty(
            EditCaption = "DocumentType",
            DisplayInEditMode = true,
            SortOrder = 40,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string DocumentType { get; set; }

        [PageTypeProperty(EditCaption = "MainImage",
            HelpText = "Article image",
            SortOrder = 50,
            UniqueValuePerLanguage = false,
            Required = false,
            Type = typeof(EPiImageProperty))]
        public virtual EPiImagePropertyData MainImage { get; set; }

        [PageTypeProperty(EditCaption = "ResponsibleAuthor",
            HelpText = "ResponsibleAuthor",
            SortOrder = 60,
            UniqueValuePerLanguage = false,
            Required = false,
            Type = typeof(PropertySingleUserPicker))]
        public virtual string ResponsibleAuthor { get; set; }

        [PageTypeProperty(
            EditCaption = "AttachedDocument",
            HelpText = "AttachedDocument",
            SortOrder = 70,
            UniqueValuePerLanguage = false,
            Required = false,
            Type = typeof(PropertyUrl)
            )]
        public virtual string AttachedDocument { get; set; }
    }
}