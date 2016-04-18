using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Community.Calendar;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.EventArguments;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Calendar = EPiServer.Community.Calendar.Calendar;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class CalendarFullVersion : RelateUserControlBase<Model.BasePage>
    {
        private readonly Calendar _calendar = RelateTemplatePage<RelateGlobalSettings>.GlobalCalendar;
        protected void Page_Load(object sender, EventArgs e)
        {
            ucAddCalendarEvent.Calendar = _calendar;
            ucAddCalendarEvent.DataBind();

            if (!IsPostBack)
            {
                int totalEvents;
                var currentMonthDateTime = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                
                var events = CurrentUser.GetCalendarEvents(new List<Category>(), 1, 1000, currentMonthDateTime.AddDays(-7), currentMonthDateTime.AddMonths(1).AddDays(7), out totalEvents);
                BindGraphicView(DateTime.Now, events);
                BindMinimalView(DateTime.Now, GetEventCollection(events));
            }
        }

        protected void ucCalendarGraphicView_OnVisibleMonthChanged(object sender, CalendarChangedEventArgs e)
        {
            int totalEvents;
            var events = CurrentUser.GetCalendarEvents(new List<Category>(), 1, 1000, e.Date.AddDays(-7), e.Date.AddMonths(1).AddDays(7), out totalEvents);
            BindGraphicView(e.Date, events);
            BindMinimalView(e.Date, GetEventCollection(events));
        }

        protected void ucCalendarGraphicView_OnSelectedDayChanged(object sender, CalendarChangedEventArgs e)
        {
            int totalEvents;
            var currentMonthDateTime = new DateTime(e.Date.Year, e.Date.Month, 1);
            var events = CurrentUser.GetCalendarEvents(new List<Category>(), 1, 1000, currentMonthDateTime.AddDays(-7), currentMonthDateTime.AddMonths(1).AddDays(7), out totalEvents);
            BindGraphicView(e.Date, events);
            BindMinimalView(e.Date.Date, events.Where(o => o.IsWithinCalendarEvent(e.Date.Date)));
        }

        private IEnumerable<Event> GetEventCollection(EventCollection events)
        {
            var returnEvents = events.SkipWhile(o => o.EndDate < DateTime.Now).TakeWhile(o => o.EndDate.Date <= DateTime.Today.Date).ToList();
            returnEvents.RemoveAll(o => o.EndDate < DateTime.Now);

            if (returnEvents.Count() < 3)
            {
                returnEvents = events.Select(o => o).Where(o => o.EndDate > DateTime.Now).Take(3).ToList();
            }
            return returnEvents;
        }

        private void BindGraphicView(DateTime date, EventCollection events)
        {
            ucCalendarGraphicView.CurrentMonth = date;
            ucCalendarGraphicView.CalendarEvents = events;
            ucCalendarGraphicView.DataBind();
        }

        private void BindMinimalView(DateTime currentDate, IEnumerable<Event> events)
        {
            ucCalendarMinimalView.CurrentDate = currentDate;
            ucCalendarMinimalView.EventCollection = events;
            ucCalendarMinimalView.DataBind();
        }
    }
}