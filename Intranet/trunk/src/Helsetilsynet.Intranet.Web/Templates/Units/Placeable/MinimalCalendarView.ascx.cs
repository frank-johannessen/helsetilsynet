using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using EPiServer.Community.Calendar;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Calendar = EPiServer.Community.Calendar.Calendar;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MinimalCalendarView : RelateUserControlBase<Model.BasePage>
    {
        public DateTime CurrentDate { get; set; }
        public Calendar Calendar { get; set; }
        public IEnumerable<Event> EventCollection { get; set; }
        public int PagePosition { get; set; }
        public int PageSize { get; set; }
        public List<Category> Categories { get; set; }
        public bool ShowAddEventButton { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void DataBind()
        {
            base.DataBind();

            rptCalendar.DataSource = GetDatesAndEvents(GetCalendarEvents(), CurrentDate);
            rptCalendar.DataBind();

            if (Calendar != null && ShowAddEventButton)
            {
                ucAddCalendarEvent.Calendar = Calendar;
                ucAddCalendarEvent.DataBind();
                ucAddCalendarEvent.Visible = true;
            }
        }

        private static Dictionary<DateTime, EventCollection> GetDatesAndEvents(IEnumerable<Event> calendarEvents, DateTime currentDate)
        {
            var datesAndEvents = new Dictionary<DateTime, EventCollection>();
            foreach (var ce in calendarEvents)
                AddEventToDictionary(ce, datesAndEvents, currentDate);

            return datesAndEvents;
        }

        private IEnumerable<Event> GetCalendarEvents()
        {
            int totalEvents;
            if (EventCollection != null)
                return EventCollection;

            if (Calendar != null && Categories != null)
                return CurrentUser.GetCalendarEvents(Categories, PagePosition, PageSize, out totalEvents);

            if (Calendar != null)
                return Calendar.GetCalendarEvents(PagePosition, PageSize);

            

            return new List<Event>(); // empty list
        }

        private static void AddEventToDictionary(Event ce, IDictionary<DateTime, EventCollection> datesAndEvents, DateTime currentDate)
        {
            var key = ce.StartDate.Date;
            if(ce.StartDate.Date.ToShortDateString() != ce.EndDate.Date.ToShortDateString())
            {
                var isWithinCalEvent = ce.IsWithinCalendarEvent(currentDate.Date);
                key = isWithinCalEvent ? currentDate.Date : ce.StartDate.Date;
            }
            if (!datesAndEvents.ContainsKey(key) || datesAndEvents[key] == null)
                datesAndEvents.Add(key, new EventCollection());

            datesAndEvents[key].Add(ce);
        }

        protected void DateItem_OnEditEvent(object sender, CommandEventArgs e)
        {
            var editEvent = CalendarHandler.Instance.GetEvent(int.Parse(e.CommandArgument.ToString()));
            if(editEvent != null)
            {
                ucAddCalendarEvent.EditEvent = editEvent;
                ucAddCalendarEvent.Visible = true;
                ucAddCalendarEvent.DataBind();
            }
                
        }

        protected void DateItem_OnDeleteEvent(object sender, CommandEventArgs e)
        {
            var editEvent = CalendarHandler.Instance.GetEvent(int.Parse(e.CommandArgument.ToString()));
            if (editEvent != null)
            {
                CalendarHandler.Instance.RemoveEvent(editEvent);
            }
            Response.Redirect(Request.RawUrl); 
        }
    }
}