using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPiServer;
using EPiServer.Community.Calendar;
using EPiServer.Core;
using EPiServer.Web;

// ReSharper disable CheckNamespace
namespace Relate.HelpersAndExtensions
// ReSharper restore CheckNamespace
{
    public partial class RelateTemplatePage<T>
    {
        public static void ClearStaticSettings()
        {
            _accessViolationPage = null;
            _addCalendarEventDescription = null;
            _calendarYearOverview = null;
            _clubArticlePage = null;
            _clubErrorPage = null;
            _clubEventPage = null;
            _clubForumPage = null;
            _clubHomePage = null;
            _clubImageGalleryPage = null;
            _clubMembersPage = null;
            _clubPage = null;
            _clubWallPage = null;
            _departments = null;
            _fylkesmannsEmbete = null;
            _generalErrorPage = null;
            _globalCalendar = null;
            _helsetilsynetStandardRssFeed = null;
            _imageGalleriesPage = null;
            _memberDeletedPage = null;
            _myBlogPage = null;
            _myImageGalleryPage = null;
            _myImagesPage = null;
            _myPage = null;
            _mySettingsPage = null;
            _notMemberPage = null;
            _nurseSpecialties = null;
            _otherProfessions = null;
            _physicianSpecialties = null;
            _professions = null;
            _roomPage = null;
            _searchPage = null;
            _tasks = null;
            _topicPage = null;
            _userSearchPage = null;
            _videoGalleryPage = null;
        }

        private static List<string> _departments;
        public static List<string> Departments
        {
            get
            {
                return _departments ??
                    (_departments = RelateGlobalSettings.Departments != null ? RelateGlobalSettings.Departments.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _professions;
        public static List<string> Professions
        {
            get
            {
                return _professions ??
                    (_professions = RelateGlobalSettings.Profession != null ? RelateGlobalSettings.Profession.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _physicianSpecialties;
        public static List<string> PhysicianSpecialties
        {
            get
            {
                return _physicianSpecialties ??
                    (_physicianSpecialties = RelateGlobalSettings.DoctorSpecialties != null ? RelateGlobalSettings.DoctorSpecialties.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _nurseSpecialties;
        public static List<string> NurseSpecialties
        {
            get
            {
                return _nurseSpecialties ??
                    (_nurseSpecialties = RelateGlobalSettings.NurseSpecialties != null ? RelateGlobalSettings.NurseSpecialties.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _otherProfessions;
        public static List<string> OtherProfessions
        {
            get
            {
                return _otherProfessions ??
                    (_otherProfessions = RelateGlobalSettings.OtherProfessions != null ? RelateGlobalSettings.OtherProfessions.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _tasks;
        public static List<string> Tasks
        {
            get
            {
                return _tasks ??
                    (_tasks = RelateGlobalSettings.Tasks != null ? RelateGlobalSettings.Tasks.Split(',').ToList() : new List<string>());
            }
        }
        private static List<string> _fylkesmannsEmbete;
        public static List<string> FylkesmannsEmbete
        {
            get
            {
                return _fylkesmannsEmbete ??
                    (_fylkesmannsEmbete = RelateGlobalSettings.FylkesmannsEmbete != null ? RelateGlobalSettings.FylkesmannsEmbete.Split(',').ToList() : new List<string>());
            }
        }

        private static PageData _calendarYearOverview;
        public static PageData CalendarYearOverview
        {
            get { return _calendarYearOverview ?? (_calendarYearOverview = DataFactory.Instance.GetPage(RelateGlobalSettings.CalendarYearOverview ?? GeneralErrorPage.PageLink)); }
        }

        private static PageData _userSearchPage;
        public static PageData UserSearchPage
        {
            get { return _userSearchPage ?? (_userSearchPage = DataFactory.Instance.GetPage(RelateGlobalSettings.UserSearchPage ?? GeneralErrorPage.PageLink)); }
        }
        
        private static PageData _searchPage;
        public static PageData SearchPage
        {
            get { return _searchPage ?? (_searchPage = DataFactory.Instance.GetPage(RelateGlobalSettings.SearchPage ?? GeneralErrorPage.PageLink)); }
        }
        public static string GetSearchPageUrl(string search)
        {
            // Create url to search page
            UrlBuilder url = new UrlBuilder(SearchPage.LinkURL);
            url.QueryCollection.Add("q", search);

            if (UrlRewriteProvider.IsFurlEnabled)
            {
                Global.UrlRewriteProvider.ConvertToExternal(url, SearchPage.LinkURL, Encoding.UTF8);
            }

            return (string)url;
        }


        private static string _addCalendarEventDescription;
        public static string AddCalendarEventDescription
        {
            get
            {
                return _addCalendarEventDescription ??
                       (_addCalendarEventDescription = RelateGlobalSettings.AddCalendarEventDescription ?? string.Empty);
            }
        }

        private static Calendar _globalCalendar;
        public static Calendar GlobalCalendar
        {
            get
            {
                return _globalCalendar ??
                    (_globalCalendar = CalendarHandler.Instance.GetCalendar(RelateGlobalSettings.RelateGlobalCalenderID.HasValue ? RelateGlobalSettings.RelateGlobalCalenderID.Value : 0));
            }
        }

        private static string _helsetilsynetStandardRssFeed;
        public static string HelsetilsynetStandardRssFeed
        {
            get
            {
                return _helsetilsynetStandardRssFeed ??
                       (_helsetilsynetStandardRssFeed = RelateGlobalSettings.HelsetilsynetStandardRssFeed ?? string.Empty);
            }
        }
    }
}
