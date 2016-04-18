using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Community.Calendar;
using EPiServer.DataAbstraction;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Calendar = EPiServer.Community.Calendar.Calendar;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages
{
    public partial class CalendarYearOverview : RelateTemplatePage<Model.CalendarYearOverview>
    {
        private readonly Calendar _calendar = RelateTemplatePage<RelateGlobalSettings>.GlobalCalendar;
        private bool? _searchEarlierEvents;
        public bool SearchEarlierEvents
        {
            get
            {
                if (!_searchEarlierEvents.HasValue)
                {
                    if (ViewState["SearchEarlierEvents"] != null)
                    {
                        _searchEarlierEvents = bool.Parse(ViewState["SearchEarlierEvents"].ToString());
                    }
                    else
                        return false;
                }
                return _searchEarlierEvents.Value;
            }
            set
            {
                _searchEarlierEvents = value;
                ViewState["SearchEarlierEvents"] = value;
            }
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            CurrentPage.LayoutClassName = "filtered calendar-year";

            if(!IsPostBack)
            {
                BindServiceAreas();
                BindCalendarEvents();
            }
        }

        private void BindCalendarEvents()
        {
            ucAddCalendarEvent.Calendar = _calendar;
            ucAddCalendarEvent.DataBind();

            ucCalendarMinimalView.EventCollection = GetCalendarEvents(SearchEarlierEvents);
            ucCalendarMinimalView.DataBind();
        }

        private IEnumerable<Event> GetCalendarEvents(bool searchErlierEvents)
        {
            var YearsToShow = 1;
            if(CurrentPage.NumberOfYearsToShow != null && CurrentPage.NumberOfYearsToShow >0)
                 YearsToShow = (int) CurrentPage.NumberOfYearsToShow;
            
            var categoryList = (from ListItem serviceArea in cblServiceAreas.Items where serviceArea.Selected select Category.Find(int.Parse(serviceArea.Value))).ToList();
            int totalEvents;
            var events = searchErlierEvents
                       ? CurrentUser.GetCalendarEvents(categoryList, pager.CurrentPagingNumber, 500, DateTime.Now.AddYears(-YearsToShow), DateTime.Now, out totalEvents).Reverse()
                       : CurrentUser.GetCalendarEvents(categoryList, pager.CurrentPagingNumber, 500, DateTime.Now, DateTime.Now.AddYears(YearsToShow), out totalEvents);
            pager.BindPagerControl(500, totalEvents);
            return events;
        }

        private void BindServiceAreas()
        {
            cblServiceAreas.DataSource = Category.GetRoot().Categories;
            cblServiceAreas.DataTextField = "Name";
            cblServiceAreas.DataValueField = "ID";
            cblServiceAreas.DataBind();
        }

        protected void btnChangeSearchErlierEvents_OnCommand(object sender, CommandEventArgs e)
        {
            SearchEarlierEvents = bool.Parse(e.CommandArgument.ToString());
            BindCalendarEvents();
        }

        protected void cblServiceAreas_OnChange(object sender, EventArgs e)
        {
            BindCalendarEvents();
        }
    }
}