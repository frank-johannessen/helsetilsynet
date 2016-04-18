using System;
using EPiServer.Community.Calendar;

namespace Relate.HelpersAndExtensions.EventArguments
{
    public class CalendarChangedEventArgs : EventArgs
    {
        public CalendarChangedEventArgs(DateTime date)
        {
            _date = date;
        }

        private readonly DateTime _date;
        
        public DateTime Date
        {
            get { return _date; }
        }
    }
}
