using System;
using System.Web.UI.WebControls;
using EPiServer.Community.Calendar;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.EventArguments;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class CalendarGraphicView : RelateUserControlBase<Model.BasePage>
    {
        public EventCollection CalendarEvents { get; set; }
        public DateTime CurrentMonth { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                calGlobalCalendar.SelectedDate = CurrentMonth;
                calGlobalCalendar.VisibleDate = CurrentMonth;
            }
        }
        /// <summary>
        /// Event that Renders all the days in the selected calendar month
        /// </summary>
        /// <param name="sender">The calendar</param>
        /// <param name="e">The day</param>
        protected void calGlobalCalendar_DayRender(object sender, DayRenderEventArgs e)
        {
            if(CalendarEvents == null)
                return; 
            e.Cell.HorizontalAlign = HorizontalAlign.NotSet;
            e.Cell.Width = Unit.Empty;
            e.Cell.Style.Clear();
            // Check if there are any events to add to the calendar
            if (CalendarEvents.Count > 0)
            {
                //e.Cell.Controls.Clear();
                foreach (var calevent in CalendarEvents)
                {
                    if (calevent.IsWithinCalendarEvent(e.Day.Date))
                    {
                        // Set the style
                        e.Cell.CssClass = "calendar-day-marked";
                    }
                }
            }
        }

        

        /// <summary>
        /// Event that is called when the user changes the calendar Month
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.MonthChangedEventArgs"/> instance containing the event data.</param>
        protected void calGlobalCalendar_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            // Update the current month
            CurrentMonth = e.NewDate;
            OnCurrentMonthChanged(e);
        }
        protected override void OnPreRender(EventArgs e)
        {
            CurrentMonth = CurrentMonth;
            base.OnPreRender(e);
        }

        protected void OnCurrentMonthChanged(MonthChangedEventArgs monthChangedEventArgs)
        {
            if (VisibleMonthChanged != null)
                VisibleMonthChanged(this, new CalendarChangedEventArgs(monthChangedEventArgs.NewDate.Date));
        }
        public event EventHandler<CalendarChangedEventArgs> VisibleMonthChanged;

        protected void calGlobalCalendar_OnSelectionChanged(object sender, EventArgs e)
        {
            calGlobalCalendar.VisibleDate = calGlobalCalendar.SelectedDate;
            OnSelectedDayChanged(calGlobalCalendar.SelectedDate);
        }

        private void OnSelectedDayChanged(DateTime date)
        {
            if(SelectedDayChanged != null)
                SelectedDayChanged(this, new CalendarChangedEventArgs(date));
        }
        public event EventHandler<CalendarChangedEventArgs> SelectedDayChanged;
    }
}