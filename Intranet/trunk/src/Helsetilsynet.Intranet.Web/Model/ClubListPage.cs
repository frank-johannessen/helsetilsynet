using System;
using EPiServer.Core;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [PageType(
        Name = "ClubListPage",
        Description = "This page type is used for showing a list of all Clubs (not hidden)",
        Filename = "/Templates/Pages/ClubListPage.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = (int)PageTypeSortOrder.ClubListPage,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })] 
// ReSharper disable ClassNeverInstantiated.Global
    public class ClubListPage : BasePage
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(
            DisplayInEditMode = true,
            EditCaption = "LetUsersAddProjectrooms",
            HelpText = "This (when true) will let regular users add new projectrooms",
            Type = typeof(PropertyBoolean))]
        public virtual bool LetUsersAddProjectrooms { get; set; }
    }
}