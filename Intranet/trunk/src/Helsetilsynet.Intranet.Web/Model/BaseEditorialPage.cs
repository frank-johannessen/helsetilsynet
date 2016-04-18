using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.SpecializedProperties;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    public abstract class BaseEditorialPage : BasePage
    {
        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Heading",
            HelpText = "The heading for the page",
            SortOrder = 1,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyString))]
        public virtual string Heading
        {
            get
            {
                var heading = this.GetPropertyValue(page => page.Heading);
                return string.IsNullOrEmpty(heading) ? PageName : heading;
            }
        }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "Keywords",
            HelpText = "The keywords for the page",
            SortOrder = 10,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Information),
            Type = typeof(PropertyString))]
        public virtual string Keywords { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "RightContent",
            HelpText = "The RightContent for the page",
            SortOrder = 20,
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.RightColumn),
            Type = typeof(PropertyXhtmlString))]
        public virtual string RightContent { get; set; }

        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "IsCommentable",
            HelpText = "The article will have comments",
            Tab = typeof(Tabs.Information),
            SortOrder = 9998
            )]
        public virtual bool IsCommentable { get; set; }        
        
        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "IsC1Only",
            HelpText = "This content is only relevant for C1",
            Tab = typeof(Tabs.Information),
            SortOrder = 9999
            )]
        public virtual bool IsC1Only { get; set; }

        public static string GetMainCategoryClass(PageReference currentPageRef)
        {
            if (currentPageRef == null)
                return string.Empty;

            if (currentPageRef == PageReference.StartPage)
                return string.Empty;

            var currentPage = DataFactory.Instance.GetPage(currentPageRef);
            if (currentPage == null)
                return string.Empty;

            var section = currentPage as Section;
            if (section != null)
                return section.SectionMainCat.GetClassName();

            var parentLink = currentPage.ParentLink;
            return parentLink == null 
                ? string.Empty 
                : GetMainCategoryClass(parentLink);
        }
    }
}