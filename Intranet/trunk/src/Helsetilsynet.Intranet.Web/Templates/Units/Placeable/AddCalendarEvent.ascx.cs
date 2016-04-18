using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Common;
using EPiServer.Community.Calendar;
using EPiServer.Community.Club;
using EPiServer.Community.MyPage;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Calendar = EPiServer.Community.Calendar.Calendar;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class AddCalendarEvent : RelateUserControlBase<Model.BasePage>
    {
        private Event _editEvent;
        public Event EditEvent
        {
            get
            {
                if (_editEvent == null && ViewState[ViewStateNames.EventId] != null)
                {
                    _editEvent = CalendarHandler.Instance.GetEvent(Convert.ToInt32(ViewState[ViewStateNames.EventId]));
                }

                return _editEvent;
            }
            set
            {
                _editEvent = value;
                ViewState[ViewStateNames.EventId] = (value != null) ? (object)value.ID : null;
            }
        }

        private Calendar _calendar;
        public Calendar Calendar
        {
            get
            {
                if (_calendar == null && ViewState[ViewStateNames.CalendarId] != null)
                {
                    _calendar = CalendarHandler.Instance.GetCalendar(Convert.ToInt32(ViewState[ViewStateNames.CalendarId]));
                }

                return _calendar;
            }
            set
            {
                _calendar = value;
                ViewState[ViewStateNames.CalendarId] = (value != null) ? (object)value.ID : null;
            }
        }
        //public Calendar Calendar { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public override void DataBind()
        {
            base.DataBind();
            if(!IsPostBack)
            {
                BindServiceAreas();
                BindClockValues();
                BindDateField();
            }
            if (EditEvent != null)
            {
                BindServiceAreas();
                BindClockValues();

                txtTitle.Text = EditEvent.Header;
                txtDescription.Text = EditEvent.Body;
                txtArticleLink.Text = EditEvent.GetArticleLink();
                //date
                tbStartDate.Text = EditEvent.StartDate.Date.ToShortDateString();
                tbEndDate.Text = EditEvent.EndDate.Date.ToShortDateString();
                //hours
                ddlStartDateHours.SelectedValue = EditEvent.StartDate.Hour < 10 ? string.Format("0{0}", EditEvent.StartDate.Hour) : EditEvent.StartDate.Hour.ToString();
                ddlEndDateHours.SelectedValue = EditEvent.EndDate.Hour < 10 ? string.Format("0{0}", EditEvent.EndDate.Hour) : EditEvent.EndDate.Hour.ToString();
                //minutes
                tbStartDateMinutes.Text = EditEvent.StartDate.Minute.ToString();
                tbEndDateMinutes.Text = EditEvent.EndDate.Minute.ToString();

                pnlCreateEvent.Visible = true;
                btnShowCreateEvent.Visible = false;
            }
            btnCreateEvent.Text = EditEvent != null ? Translate("/general/save") : Translate("/general/add");
        }

        private void BindDateField()
        {
            tbStartDate.Text = DateTime.Today.Date.ToShortDateString();
            tbEndDate.Text = DateTime.Today.Date.ToShortDateString();
        }

        private void BindClockValues()
        {
            ddlStartDateHours.DataSource = GetHours();
            ddlStartDateHours.DataBind();
            ddlEndDateHours.DataSource = GetHours();
            ddlEndDateHours.DataBind();
        }

        private List<string> GetHours()
        {
            var hours = new List<string>();
            for (int i = 0; i < 24; i++)
            {
                if(i<10)
                    hours.Add("0" + i.ToString());    
                else
                    hours.Add(i.ToString());
            }
            return hours;
        }

        private void BindServiceAreas()
        {
            cblServiceAreas.DataSource = Category.GetRoot().Categories;
            cblServiceAreas.DataTextField = "Name";
            cblServiceAreas.DataValueField = "ID";
            cblServiceAreas.DataBind();
        }

        protected void btnShowCreateEvent_OnClick(object sender, EventArgs e)
        {
            pnlCreateEvent.Visible = true;

        }

        protected void btnCreateEvent_OnClick(object sender, EventArgs e)
        {
            if ((Calendar == null && EditEvent == null) || !Page.IsValid) 
                return;
            
            Event calendarEvent;

            var startDate = CreateDate(tbStartDate.Text, int.Parse(ddlStartDateHours.SelectedValue), int.Parse(tbStartDateMinutes.Text));
            var endDate = CreateDate(tbEndDate.Text, int.Parse(ddlEndDateHours.SelectedValue), int.Parse(tbEndDateMinutes.Text));
            
            if(startDate.Hour == endDate.Hour && startDate.Minute == endDate.Minute)
                endDate = new DateTime(endDate.Year, endDate.Month, endDate.Day, 23, 59, 59);

            var header = txtTitle.Text.FormatContentTextNoHtml();
            var text = txtDescription.Text.FormatContentTextNoHtml();
            var articleLink = txtArticleLink.Text;

            var selectedServiceAreas =
                cblServiceAreas.Items
                    .Cast<ListItem>()
                    .Where(cat => cat.Selected)
                    .Aggregate(string.Empty, (current, cat) => current + (cat.Value + ","));


            if(EditEvent != null)
            {
                calendarEvent = (Event)EditEvent.Clone();

                calendarEvent.Header = header;
                calendarEvent.Body = text;
                calendarEvent.StartDate = startDate;
                calendarEvent.EndDate = endDate;
                calendarEvent.SetServiceAreas(selectedServiceAreas);
                calendarEvent.AddArticleLink(articleLink);

                CalendarHandler.Instance.UpdateEvent(calendarEvent);
            }
            else
            {
                var calEvent = new Event(Calendar, header, text, new UserAuthor(CurrentUser), startDate, endDate, header, string.Empty);
                calEvent.SetServiceAreas(selectedServiceAreas);
                calEvent.AddArticleLink(articleLink);

                calendarEvent = (Event)CalendarHandler.Instance.AddEvent(calEvent).Clone();
            }

            //var serviceAreas = cblServiceAreas.Items.Cast<ListItem>().Where(cat => cat.Selected).Aggregate(string.Empty, (current, cat) => current + (cat.Value + ","));
            //calendarEvent.SetServiceAreas(cblServiceAreas.Items.Cast<ListItem>().Where(cat => cat.Selected).Aggregate(string.Empty, (current, cat) => current + (cat.Value + ",")));

            //calendarEvent.AddArticleLink(txtArticleLink.Text);

            //CalendarHandler.Instance.UpdateEvent(calendarEvent);
            //ActivityFeedHandler.PublishCalendarEvent(calendarEvent);
                
            pnlCreateEvent.Visible = false;
            Response.Redirect(Request.RawUrl);
        }
        
        /// <summary>
        /// to create a date
        /// </summary>
        /// <param name="date">Date format in = 'dd.mm.yyyy'</param>
        /// <param name="hours"></param>
        /// <param name="minutes"></param>
        /// <returns></returns>
        private DateTime CreateDate(string date, int hours, int minutes)
        {
            var returnDate = DateTime.Parse(date);
            return returnDate.AddHours(hours).AddMinutes(minutes);
        }

        protected void cvValidateDate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = IsValidDate(args.Value);
        }
        protected void cvValidateMinutes(object source, ServerValidateEventArgs args)
        {
            args.IsValid = IsValidMinutes(args.Value);
        }
        protected bool IsValidDate(string date)
        {
            if (date.Length > 10)
                return false;
            
            var strDate = Regex.Replace(date, @"[\.]", String.Empty);
            var regDigits = new Regex(@"^\d{2}\d{2}\d{4}$");
            var matDigits = regDigits.Match(strDate);

            return matDigits.Success;
        }
        protected bool IsValidMinutes(string minutes)
        {
            int parsedMinutes;
            return int.TryParse(minutes, out parsedMinutes) && parsedMinutes < 60;
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void cblServiceAreas_OnDataBound(object sender, EventArgs e)
        {
            if(EditEvent != null)
            {
                var preSelected = EditEvent.GetServiceAreas();
                foreach (ListItem li in ((CheckBoxList)sender).Items)
                {
                    foreach (var category in preSelected)
                    {
                        if (li.Value == category.ID.ToString())
                        {
                            li.Selected = true;
                        }
                    }
                }    
            }
        }
    }
}