using EPiServer.Core;
using EPiServer.SpecializedProperties;
using PageTypeBuilder;

// ReSharper disable CheckNamespace
namespace Relate.HelpersAndExtensions
// ReSharper restore CheckNamespace
{
    public partial class RelateGlobalSettings
    {
        [PageTypeProperty(
            EditCaption = "Departments",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string Departments { get; set; }

        [PageTypeProperty(
            EditCaption = "Profession",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string Profession { get; set; }

        [PageTypeProperty(
            EditCaption = "DoctorSpecialties",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string DoctorSpecialties { get; set; }

        [PageTypeProperty(
            EditCaption = "NurseSpecialties",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string NurseSpecialties { get; set; }
        
        [PageTypeProperty(
            EditCaption = "OtherProfessions",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string OtherProfessions { get; set; }
        
        [PageTypeProperty(
            EditCaption = "Tasks",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string Tasks { get; set; }

        [PageTypeProperty(
            EditCaption = "FylkesmannsEmbete",
            DisplayInEditMode = true,
            Type = typeof(PropertyCheckBoxList))
        ]
        public virtual string FylkesmannsEmbete { get; set; }

        [PageTypeProperty(
            EditCaption = "RelateGlobalCalenderID",
            DisplayInEditMode = true,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyNumber))
        ]
        public virtual int? RelateGlobalCalenderID { get; set; }

        [PageTypeProperty(EditCaption = "CalendarYearOverview",
            HelpText = "PageReference to the users calendar year overview page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference CalendarYearOverview { get; set; }
        
        [PageTypeProperty(EditCaption = "AddCalendarEventDescription",
            HelpText = "Text to describe the add event functionality",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyXhtmlString))
        ]
        public virtual string AddCalendarEventDescription { get; set; }

        [PageTypeProperty(EditCaption = "HelsetilsynetStandardRssFeed",
            HelpText = "Text to describe the Helsetilsynet Standard Rss Feed",
            DisplayInEditMode = true,
            SortOrder = 30,
            Type = typeof(PropertyString))
        ]
        public virtual string HelsetilsynetStandardRssFeed { get; set; }

        [PageTypeProperty(EditCaption = "UserSearchPage",
            HelpText = "PageReference to the Usersearch page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference UserSearchPage { get; set; }

        [PageTypeProperty(EditCaption = "SearchPage",
            HelpText = "PageReference to the search page",
            UniqueValuePerLanguage = false,
            Required = false,
            Tab = typeof(Tabs.Advanced),
            Type = typeof(PropertyPageReference))]
        public virtual PageReference SearchPage { get; set; }
    }
}