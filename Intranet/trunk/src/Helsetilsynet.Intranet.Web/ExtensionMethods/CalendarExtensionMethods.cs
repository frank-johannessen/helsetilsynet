using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Common.Exceptions;
using EPiServer.Community.Calendar;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class CalendarExtensionMethods
    {

        public static string GetServiceAreasCssClasses(this Event calendarEvent)
        {
            var serviceAreas = calendarEvent.GetServiceAreas();
            var returnString = string.Empty;
            foreach (var category in serviceAreas)
            {
                if (returnString != string.Empty)
                    returnString += " ";
                returnString += category.GetClassName();
            }
            return returnString;
        }

        public static void AddArticleLink(this Event calendarEvent, string data)
        {
            try
            {
                calendarEvent.SetAttributeValue<string>(Relate.HelpersAndExtensions.Constants.AttributeNames.ArticleLink, data);
            }
            catch (FrameworkException)
            {

            }
        }
        public static string GetArticleLink(this Event calendarEvent)
        {
            try
            {
                return calendarEvent.GetAttributeValue<string>(Relate.HelpersAndExtensions.Constants.AttributeNames.ArticleLink);
            }
            catch (FrameworkException)
            {
                return String.Empty;
            }
        }
        public static bool IsWithinCalendarEvent(this Event calevent, DateTime date)
        {
            var startDate = calevent.StartDate.Date;
            var dateTime = calevent.EndDate.Date < startDate ? startDate : calevent.EndDate.Date;
            return startDate <= date && date <= dateTime;
        }
    }
}