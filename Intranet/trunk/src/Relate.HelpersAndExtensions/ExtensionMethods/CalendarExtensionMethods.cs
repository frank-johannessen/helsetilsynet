using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Queries;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using EPiServer.Community.Calendar;
using EPiServer.Community.Calendar.Queries;
using EPiServer.Community.Club;
using EPiServer.DataAbstraction;
using Relate.HelpersAndExtensions.Constants;
using SecurityStatus = EPiServer.Community.Club.SecurityStatus;

namespace Relate.HelpersAndExtensions.ExtensionMethods
{
    public static class CalendarExtensionMethods
    {
        public static void SetServiceAreas(this Event calendarEvent, string data)
        {
            try
            {
                calendarEvent.SetAttributeValue<string>(AttributeNames.ServiceAreas, data);
            }
            catch (FrameworkException)
            {

            }
        }
        public static List<Category> GetServiceAreas(this Event calendarEvent)
        {
            try
            {
                var propertyValue = calendarEvent.GetAttributeValue<string>(AttributeNames.ServiceAreas);
                if (propertyValue != null)
                {
                    var spilt = propertyValue.Split(',');
                    return spilt.Where(id => id != string.Empty).Select(id => Category.Find(int.Parse(id))).Where(category => category != null).ToList();
                }
                return new List<Category>();
            }
            catch (FrameworkException)
            {
                return new List<Category>();
            }
        }

        private static List<string> GetListFromString(string propertyValue)
        {
            var returnList = new List<string>();
            if (propertyValue != null)
            {
                var spilt = propertyValue.Split(',');
                returnList.AddRange(spilt.Where(s => !string.IsNullOrWhiteSpace(s)));
            }
            return returnList;
        }

        public static EventCollection GetCalendarEvents(this Calendar calendar, int page, int pageSize)
        {
            int totalEvents;
            return CalendarHandler.Instance.GetEvents(calendar, EventPublishState.Published, page, pageSize, DateTime.Now, DateTime.Now.AddYears(2), out totalEvents,
                                                         new EventSortOrder(EventSortField.StartDate, SortingDirection.Ascending));
        }

        public static EventCollection GetCalendarEvents(this Calendar calendar, IEnumerable<Category> categories, int page, int pageSize)
        {
            int totalEvents;
            var eventQuery = new EventQuery {Calendar = new CalendarCriterion {ID = new IntegerCriterion {Value = calendar.ID}}};
            
            if (categories != null)
            {
                var criteriaGroup = new CriteriaGroup();
                foreach (var cat in categories)
                {
                    eventQuery[AttributeNames.ServiceAreas] = new StringCriterion { WildCardType = WildCardType.Both, Value = cat.ID.ToString() };
                    criteriaGroup.AddCriterion(LogicalOperator.Or, eventQuery[AttributeNames.ServiceAreas]);
                }
                eventQuery.CriteriaGroups.Add(criteriaGroup);
            }

            return QueryHandler.Instance.GetQueryResult<Event, EventCollection>(eventQuery, TimeSpan.MinValue, page, pageSize, out totalEvents);
        }
        public static EventCollection GetCalendarEvents(this IUser currentUser, IEnumerable<Category> categories, int page, int pageSize, DateTime startDate, DateTime endDate, out int totalEvents)
        {
            var eventQuery = new EventQuery();
            eventQuery.StartDate = new DateTimeCriterion
            {
                Operator = ComparisonOperator.GreaterThan | ComparisonOperator.Equals,
                Value = startDate,
                Operator2 = ComparisonOperator.LessThan | ComparisonOperator.Equals,
                Value2 = endDate
            };


            if (categories.Any())
            {
                var criteriaGroup = new CriteriaGroup();
                foreach (var cat in categories)
                {
                    eventQuery[AttributeNames.ServiceAreas] = new StringCriterion { WildCardType = WildCardType.Both, Value = cat.ID.ToString() };
                    criteriaGroup.AddCriterion(LogicalOperator.Or, eventQuery[AttributeNames.ServiceAreas]);
                }
                eventQuery.CriteriaGroups.Add(criteriaGroup);
            }
            eventQuery.OrderBy.Add(new CriterionSortOrder(eventQuery.StartDate, SortingDirection.Ascending));

            var results = QueryHandler.Instance.GetQueryResult<Event, EventCollection>(eventQuery, TimeSpan.MinValue, page, pageSize, out totalEvents);

            foreach (var calEvent in results)
            {
                var club = calEvent.GetClub();
                if (club != null)
                {
                    if (!club.IsClubMember(currentUser) && club.SecurityStatus == SecurityStatus.Closed)
                        results.Remove(calEvent);
                }
            }
            return results;
        } 
        
        public static EventCollection GetCalendarEvents(this IUser currentUser, IEnumerable<Category> categories, int page, int pageSize, out int totalEvents)
        {
            var eventQuery = new EventQuery();
            eventQuery.StartDate = new DateTimeCriterion
            {
                Operator = ComparisonOperator.GreaterThan | ComparisonOperator.Equals,
                Value = DateTime.Now
            };


            if (categories.Any())
            {
                var criteriaGroup = new CriteriaGroup();
                foreach (var cat in categories)
                {
                    eventQuery[AttributeNames.ServiceAreas] = new StringCriterion { WildCardType = WildCardType.Both, Value = cat.ID.ToString() };
                    criteriaGroup.AddCriterion(LogicalOperator.Or, eventQuery[AttributeNames.ServiceAreas]);
                }
                eventQuery.CriteriaGroups.Add(criteriaGroup);
            }
            eventQuery.OrderBy.Add(new CriterionSortOrder(eventQuery.StartDate, SortingDirection.Ascending));

            var results = QueryHandler.Instance.GetQueryResult<Event, EventCollection>(eventQuery, TimeSpan.MinValue, page, pageSize, out totalEvents);

            foreach (var calEvent in results)
            {
                var club = calEvent.GetClub();
                if (club != null)
                {
                    if (!club.IsClubMember(currentUser) && club.SecurityStatus == SecurityStatus.Closed)
                            results.Remove(calEvent);
                }
            }
            return results;
        }

        public static Club GetClub(this Event calendarEvent)
        {
            if (calendarEvent.Calendar.OwnedBy != null && calendarEvent.Calendar.OwnedBy.Entity != null)
            {
                if (calendarEvent.Calendar.OwnedBy.Entity.GetType() == typeof(Club))
                {
                    return (Club)calendarEvent.Calendar.OwnedBy.Entity;
                }
            }
            return null;
        }
    }
}
