using System;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "Section",
        Description = "Section",
        Filename = "/Templates/Pages/Section.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Article,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = true,
        AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public class Section : BaseEditorialPage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(EditCaption = "SelectedArticles",
            HelpText = "SelectedArticles",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection SelectedArticles { get; set; }

        [PageTypeProperty(
            EditCaption = "SectionMainCategory",
            DisplayInEditMode = true,
            SortOrder = 40,
            Type = typeof(PropertyDropDownList))]
        public virtual string SectionMainCategory { get; set; }

        public Category SectionMainCat
        {
            get
            {
                int mainCat;
                int.TryParse(SectionMainCategory, out mainCat);
                return EPiServer.DataAbstraction.Category.Find(mainCat);
            }
        }


        [PageTypeProperty(
            EditCaption = "NumberOfItemsInLastPublished",
            HelpText = "Number of items to show in LastPublished",
            DisplayInEditMode = true,
            SortOrder = 60,
            Type = typeof(PropertyNumber))
        ]
        public virtual int? NumberOfItemsInLastPublished { get; set; } 
    }
}