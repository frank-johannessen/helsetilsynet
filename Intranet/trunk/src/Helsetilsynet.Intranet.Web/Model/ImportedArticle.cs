using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "ImportedArticle",
        Description = "ImportedArticle",
        Filename = "/Templates/Pages/ImportedArticle.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int) PageTypeSortOrder.ImportedArticle,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] {})]
// ReSharper disable ClassNeverInstantiated.Global
    public class ImportedArticle : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "PageHeader",
            DisplayInEditMode = true,
            SortOrder = 5,
            Type = typeof(PropertyString))
        ]
        public virtual string PageHeader { get; set; }        
        
        [PageTypeProperty(
            EditCaption = "MainIntro",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainIntro { get; set; }

        [PageTypeProperty(
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 20,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainBody { get; set; }

        [PageTypeProperty(
            EditCaption = "MetaDescription",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyString))
        ]
        public virtual string MetaDescription { get; set; }

        [PageTypeProperty(
            EditCaption = "MetaKeywords",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyString))
        ]
        public virtual string MetaKeywords { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtHeader",
            DisplayInEditMode = true,
            SortOrder = 40,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtHeader { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt1",
            DisplayInEditMode = true,
            SortOrder = 50,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt1 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName1",
            DisplayInEditMode = true,
            SortOrder = 60,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName1 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt2",
            DisplayInEditMode = true,
            SortOrder = 70,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt2 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName2",
            DisplayInEditMode = true,
            SortOrder = 80,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName2 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt3",
            DisplayInEditMode = true,
            SortOrder = 90,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt3 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName3",
            DisplayInEditMode = true,
            SortOrder = 100,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName3 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt4",
            DisplayInEditMode = true,
            SortOrder = 110,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt4 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName4",
            DisplayInEditMode = true,
            SortOrder = 120,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName4 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt5",
            DisplayInEditMode = true,
            SortOrder = 130,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt5 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName5",
            DisplayInEditMode = true,
            SortOrder = 140,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName5 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt6",
            DisplayInEditMode = true,
            SortOrder = 150,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt6 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName6",
            DisplayInEditMode = true,
            SortOrder = 160,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName6 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt7",
            DisplayInEditMode = true,
            SortOrder = 170,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt7 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName7",
            DisplayInEditMode = true,
            SortOrder = 180,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName7 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt8",
            DisplayInEditMode = true,
            SortOrder = 190,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt8 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName8",
            DisplayInEditMode = true,
            SortOrder = 200,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName8 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt9",
            DisplayInEditMode = true,
            SortOrder = 210,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt9 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName9",
            DisplayInEditMode = true,
            SortOrder = 220,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName9 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExt10",
            DisplayInEditMode = true,
            SortOrder = 230,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExt10 { get; set; }

        [PageTypeProperty(
            EditCaption = "LinkExtName10",
            DisplayInEditMode = true,
            SortOrder = 240,
            Type = typeof(PropertyString))
        ]
        public virtual string LinkExtName10 { get; set; }

        [PageTypeProperty(
            EditCaption = "Revision",
            DisplayInEditMode = true,
            SortOrder = 250,
            Type = typeof(PropertyDate))
        ]
        public virtual DateTime Revision { get; set; }

        [PageTypeProperty(
            EditCaption = "KeyWordSelectList",
            DisplayInEditMode = true,
            SortOrder = 260,
            Type = typeof(PropertyLongString))
        ]
        public virtual string KeyWordSelectList { get; set; }

        [PageTypeProperty(
            EditCaption = "DocType",
            DisplayInEditMode = true,
            SortOrder = 270,
            Type = typeof(PropertyLongString))
        ]
        public virtual string DocType { get; set; }

        [PageTypeProperty(
            EditCaption = "MetaYear",
            DisplayInEditMode = true,
            SortOrder = 280,
            Type = typeof(PropertyString))
        ]
        public virtual string MetaYear { get; set; }

        [PageTypeProperty(
            EditCaption = "CouncilName",
            DisplayInEditMode = true,
            SortOrder = 290,
            Type = typeof(PropertyString))
        ]
        public virtual string CouncilName { get; set; }

        [PageTypeProperty(
            EditCaption = "Helseforetak",
            DisplayInEditMode = true,
            SortOrder = 300,
            Type = typeof(PropertyString))
        ]
        public virtual string Helseforetak { get; set; }

        [PageTypeProperty(
            EditCaption = "CountryWide",
            DisplayInEditMode = true,
            SortOrder = 310,
            Type = typeof(PropertyString))
        ]
        public virtual string CountryWide { get; set; }

        [PageTypeProperty(
            EditCaption = "Fylke",
            DisplayInEditMode = true,
            SortOrder = 320,
            Type = typeof(PropertyLongString))
        ]
        public virtual string Fylke { get; set; }

        [PageTypeProperty(
            EditCaption = "Region",
            DisplayInEditMode = true,
            SortOrder = 330,
            Type = typeof(PropertyString))
        ]
        public virtual string Region { get; set; }

        [PageTypeProperty(
            EditCaption = "AltPubDate",
            DisplayInEditMode = true,
            SortOrder = 340,
            Type = typeof(PropertyDate))
        ]
        public virtual DateTime AltPubDate { get; set; }

        [PageTypeProperty(
            EditCaption = "PersonellK",
            DisplayInEditMode = true,
            SortOrder = 350,
            Type = typeof(PropertyLongString))
        ]
        public virtual string PersonellK { get; set; }

        [PageTypeProperty(
            EditCaption = "VirksomhetK",
            DisplayInEditMode = true,
            SortOrder = 360,
            Type = typeof(PropertyLongString))
        ]
        public virtual string VirksomhetK { get; set; }

        [PageTypeProperty(
            EditCaption = "VurderingsgrunnlagK",
            DisplayInEditMode = true,
            SortOrder = 370,
            Type = typeof(PropertyLongString))
        ]
        public virtual string VurderingsgrunnlagK { get; set; }

        [PageTypeProperty(
            EditCaption = "ReaksjonstypeK",
            DisplayInEditMode = true,
            SortOrder = 380,
            Type = typeof(PropertyLongString))
        ]
        public virtual string ReaksjonstypeK { get; set; }

        [PageTypeProperty(
            EditCaption = "TjenesteomradeK",
            DisplayInEditMode = true,
            SortOrder = 390,
            Type = typeof(PropertyLongString))
        ]
        public virtual string TjenesteomradeK { get; set; }

        [PageTypeProperty(
            EditCaption = "Backup",
            DisplayInEditMode = true,
            SortOrder = 400,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string Backup { get; set; }

        [PageTypeProperty(
            EditCaption = "LeftBody",
            DisplayInEditMode = true,
            SortOrder = 410,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string LeftBody { get; set; }

        [PageTypeProperty(
            EditCaption = "RightBody",
            DisplayInEditMode = true,
            SortOrder = 420,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string RightBody { get; set; }
    }
}