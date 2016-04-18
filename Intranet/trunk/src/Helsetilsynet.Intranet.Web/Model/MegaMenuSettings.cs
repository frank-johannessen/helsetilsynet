using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.ExternalSystemPicker;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
       Name = "MegaMenu",
       Description = "MegaMenu",
       Filename = "/Templates/Pages/MegaMenu.aspx",
       DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
       SortOrder = (int)PageTypeSortOrder.Article,
       DefaultVisibleInMenu = true,
       AvailableInEditMode = false,
       AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public class MegaMenuSettings : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "Col1Title",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof(PropertyString))]
        public virtual string Col1Title { get; set; }

        [PageTypeProperty(
            EditCaption = "Col2Title",
            DisplayInEditMode = true,
            SortOrder = 20,
            Type = typeof(PropertyString))]
        public virtual string Col2Title { get; set; }

        [PageTypeProperty(
            EditCaption = "Col3Title",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyString))]
        public virtual string Col3Title { get; set; }

        #region Tab1

        [PageTypeProperty(EditCaption = "Tab1Col1RootNode",
            HelpText = "Tab1Col1RootNode",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab1),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference Tab1Col1RootNode { get; set; }

        [PageTypeProperty(EditCaption = "Tab1Col1RootNode",
            HelpText = "Tab1Col1RootNode",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab1),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference Tab1Col2RootNode { get; set; }
        
        [PageTypeProperty(EditCaption = "Tab1Col1RootNode",
            HelpText = "Tab1Col1RootNode",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab1),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference Tab1Col3RootNode { get; set; }
        
        [PageTypeProperty(EditCaption = "Tab1Col1RootNode",
            HelpText = "Tab1Col1RootNode",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab1),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference Tab1Col4RootNode { get; set; }
        
        [PageTypeProperty(EditCaption = "Tab1Col1RootNode",
            HelpText = "Tab1Col1RootNode",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab1),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference Tab1Col5RootNode { get; set; }

        #endregion

        #region Tab2

        [PageTypeProperty(EditCaption = "Tab2Col1RootNodes",
            HelpText = "Tab2Col1RootNodes",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab2Col1RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab2Col2RootNodes",
            HelpText = "Tab2Col2RootNodes",
            SortOrder = 20,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab2Col2RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab2Col3RootNodes",
            HelpText = "Tab2Col3RootNodes",
            SortOrder = 30,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab2Col3RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab2Col4RootNodes",
            HelpText = "Tab2Col4RootNodes",
            SortOrder = 40,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab2Col4RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab2Col5RootNodes",
            HelpText = "Tab2Col5RootNodes",
            SortOrder = 50,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab2Col5RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Eksternt system 1",
            HelpText = "Eksternt system 1",
            SortOrder = 60,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyExternalSystem))]
        public virtual string ExternalSystem1 { get; set; }

        [PageTypeProperty(EditCaption = "Eksternt system 2",
            HelpText = "Eksternt system 2",
            SortOrder = 70,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyExternalSystem))]
        public virtual string ExternalSystem2 { get; set; }

        [PageTypeProperty(EditCaption = "Eksternt system 3",
            HelpText = "Eksternt system 3",
            SortOrder = 80,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab2),
            Type = typeof(PropertyExternalSystem))]
        public virtual string ExternalSystem3 { get; set; }

        #endregion

        #region Tab3

        [PageTypeProperty(EditCaption = "Tab3Col1RootNodes",
            HelpText = "Tab3Col1RootNodes",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab3Col1RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab3Col2RootNodes",
            HelpText = "Tab3Col2RootNodes",
            SortOrder = 20,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab3Col2RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab3Col3RootNodes",
            HelpText = "Tab3Col3RootNodes",
            SortOrder = 30,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab3Col3RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab3Col4RootNodes",
            HelpText = "Tab3Col4RootNodes",
            SortOrder = 40,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab3Col4RootNodes { get; set; }

        [PageTypeProperty(EditCaption = "Tab3Col5RootNodes",
            HelpText = "Tab3Col5RootNodes",
            SortOrder = 50,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyLinkCollection))]
        public virtual LinkItemCollection Tab3Col5RootNodes { get; set; }

        [PageTypeProperty(
            EditCaption = "RightColsTitle",
            DisplayInEditMode = true,
            SortOrder = 60,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyString))]
        public virtual string RightColsTitle { get; set; }
        
        [PageTypeProperty(
            EditCaption = "RightColsSubText",
            DisplayInEditMode = true,
            SortOrder = 70,
            Tab = typeof(Tabs.MegaMenuTab3),
            Type = typeof(PropertyString))]
        public virtual string RightColsSubText { get; set; }  

        #endregion
    }
}