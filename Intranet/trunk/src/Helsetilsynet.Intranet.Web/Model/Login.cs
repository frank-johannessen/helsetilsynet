using System;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "Login",
        Description = "Login",
        Filename = "/Templates/Pages/Login.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.Login,
        DefaultVisibleInMenu = false,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })] 
// ReSharper disable ClassNeverInstantiated.Global
    public class Login : BasePage
// ReSharper restore ClassNeverInstantiated.Global
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
            EditCaption = "MainBody",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string MainBody { get; set; }
    }
}