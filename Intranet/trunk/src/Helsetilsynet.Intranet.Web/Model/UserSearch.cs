using System;
using EPiServer.Core;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{

    [PageType(
        Name = "UserSearch",
        Description = "UserSearch",
        Filename = "/Templates/Pages/UserSearch.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int) PageTypeSortOrder.UserSearch,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] {})]
// ReSharper disable ClassNeverInstantiated.Global
    public class UserSearch : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            EditCaption = "MaxResult",
            DisplayInEditMode = true,
            SortOrder = 10,
            Type = typeof (PropertyNumber),
            HelpText = "Max number of users in result list. To display the full result, set the value to 0 or ''.")
        ]
        public virtual int? MaxResult { get; set; }
    }
}