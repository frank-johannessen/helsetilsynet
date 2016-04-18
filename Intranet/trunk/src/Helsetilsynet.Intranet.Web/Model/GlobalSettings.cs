using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using MakingWaves.EPiImage;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "GlobalSettings",
        Description = "Global settings for the site",
        Filename = "/Templates/Pages/Settings.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.GlobalSettings,
        DefaultVisibleInMenu = false,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public class GlobalSettings : TypedPageData
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(EditCaption = "ArticleArchive",
            HelpText = "PageReference to ArticleArchive",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ArticleArchive { get; set; }


        [PageTypeProperty(EditCaption = "PdfRenderer",
            HelpText = "PageReference to PdfRenderer",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference PdfRenderer { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "GoogleSiteVerification",
            HelpText = "GoogleSiteVerification",
            SortOrder = 9898,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyString))]
        public virtual string GoogleSiteVerification { get; set; }

        [PageTypeProperty(EditCaption = "GoogleAnalyticsAccount",
             HelpText = "GoogleAnalyticsAccount",
             UniqueValuePerLanguage = false,
             Required = false,
             Searchable = true,
             Tab = typeof(Tabs.Information),
             Type = typeof(PropertyString))]
        public virtual string GoogleAnalyticsAccount { get; set; }

        #region Losen A-Å

        [PageTypeProperty(
            EditCaption = "LosenAlphabethicalIndex",
            SortOrder = 50, 
            Type = typeof(LosenAlphabethicalEditorProperty), 
            UniqueValuePerLanguage = false, 
            Tab = typeof(Tabs.LosenIndex))]
        public virtual string LosenAlphabethicalIndex { get; set; }

        #endregion

        #region Footer

        [PageTypeProperty(EditCaption = "FooterLeftLinkList",
            HelpText = "FooterLeftLinkList",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Footer),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection FooterLeftLinkList { get; set; }

        [PageTypeProperty(EditCaption = "FooterRightLinkList",
            HelpText = "FooterRightLinkList",
            SortOrder = 20,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Footer),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection FooterRightLinkList { get; set; }

        [PageTypeProperty(EditCaption = "FooterMainBody",
             HelpText = "FooterMainBody",
             SortOrder = 30,
             UniqueValuePerLanguage = false,
             Required = false,
             Searchable = true,
             Tab = typeof(Tabs.Footer),
             Type = typeof(PropertyXhtmlString))]
        public virtual string FooterMainBody { get; set; }

        [PageTypeProperty(EditCaption = "FooterRightImage",
            HelpText = "FooterRightImage",
            SortOrder = 40,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Footer),
            Type = typeof(EPiImageProperty))]
        public virtual EPiImagePropertyData FooterRightImage { get; set; }

        [PageTypeProperty(EditCaption = "FooterRightImageUrl",
            HelpText = "FooterRightImageUrl",
            SortOrder = 50,
            Required = false,
            Tab = typeof(Tabs.Footer),
            Type = typeof(PropertyUrl))]
        public virtual string FooterRightImageUrl { get; set; }

        #endregion

        #region Email
        // Email from - used in sending email
        [PageTypeProperty(
            EditCaption = "Email from",
            Type = typeof(PropertyString),
            Tab = typeof(Tabs.Email),
            UniqueValuePerLanguage = false)]
        public virtual string EmailFrom { get; set; }

        // Subject
        [PageTypeProperty(
            EditCaption = "Email subject",
            Type = typeof(PropertyString),
            Tab = typeof(Tabs.Email),
            UniqueValuePerLanguage = false)]
        public virtual string EmailSubject { get; set; }

        // Body
        /*
         * Allow to edit custom text and possible insert link-key to substitute with real link
         * */

        [PageTypeProperty(
            EditCaption = "Email body",
            Type = typeof(PropertyLongString),
            Tab = typeof(Tabs.Email),
            UniqueValuePerLanguage = false)]
        public virtual string EmailBody { get; set; }
        #endregion
    }
}