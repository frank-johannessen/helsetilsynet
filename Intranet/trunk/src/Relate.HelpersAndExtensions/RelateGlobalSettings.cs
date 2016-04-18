using System;
using EPiServer.Core;
using PageTypeBuilder;

namespace Relate.HelpersAndExtensions
{
    [PageType(
        Name = "RelateGlobalSettings",
        Description = "Relate Global settings for the site",
        Filename = "/Templates/Pages/Settings.aspx",
        DefaultChildSortOrder = EPiServer.Filters.FilterSortOrder.Index,
        SortOrder = 2,
        DefaultVisibleInMenu = true,
        AvailableInEditMode = false,
        AvailablePageTypes = new Type[] { })]
// ReSharper disable ClassNeverInstantiated.Global
    public partial class RelateGlobalSettings : TypedPageData
// ReSharper restore ClassNeverInstantiated.Global
    {
        [PageTypeProperty(EditCaption = "My Page",
            HelpText = "PageReference to the users My Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MyPage { get; set; }

        [PageTypeProperty(EditCaption = "My Settings Page",
            HelpText = "PageReference to the users settings page (mypage/edit)",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MySettingsPage { get; set; }

        [PageTypeProperty(EditCaption = "Image Galleries Page",
            HelpText = "PageReference to the Image gallery page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ImageGalleriesPage { get; set; }

        [PageTypeProperty(EditCaption = "My Image Gallery Page",
            HelpText = "PageReference to the users Image gallery page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MyImageGalleryPage { get; set; }

        [PageTypeProperty(EditCaption = "My Images Page",
            HelpText = "PageReference to the users Images page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MyImagesPage { get; set; }

        [PageTypeProperty(EditCaption = "My Blog Page",
            HelpText = "PageReference to the users blog page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MyBlogPage { get; set; }

        [PageTypeProperty(EditCaption = "Video Gallery Page",
            HelpText = "PageReference to the video gallery page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference VideoGalleryPage { get; set; }
        
        [PageTypeProperty(EditCaption = "ClubPage",
            HelpText = "PageReference to the club page (overview of clubs)",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Home Page",
            HelpText = "PageReference to the club home page (page for specified club)",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubHomePage { get; set; }

        [PageTypeProperty(EditCaption = "Club Event Page",
            HelpText = "PageReference to the club event page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubEventPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Members Page",
            HelpText = "PageReference to the Club Members Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubMembersPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Forum Page",
            HelpText = "PageReference to the Club Forum Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubForumPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Image Gallery Page",
            HelpText = "PageReference to the club image gallery page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubImageGalleryPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Error Page",
            HelpText = "PageReference to the club error page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubErrorPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Wall Page",
            HelpText = "PageReference to the club wall page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubWallPage { get; set; }

        [PageTypeProperty(EditCaption = "Club Article Page",
            HelpText = "PageReference to the club article page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference ClubArticlePage { get; set; }

        [PageTypeProperty(EditCaption = "Topic Page",
            HelpText = "PageReference to the Topic Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference TopicPage { get; set; }

        [PageTypeProperty(EditCaption = "Room Page",
            HelpText = "PageReference to the Room Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference RoomPage { get; set; }

        [PageTypeProperty(EditCaption = "Not Member Page",
            HelpText = "PageReference to the Not Member Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference NotMemberPage { get; set; }

        [PageTypeProperty(EditCaption = "General Error Page",
            HelpText = "PageReference to the General Error Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference GeneralErrorPage { get; set; }

        [PageTypeProperty(EditCaption = "Access Violation Page",
            HelpText = "PageReference to the Access Violation Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference AccessViolationPage { get; set; }

        [PageTypeProperty(EditCaption = "MemberDeletedPage",
            HelpText = "PageReference to the Member Deleted Page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference MemberDeletedPage { get; set; }

    }
}