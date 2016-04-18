using System;
using System.Collections.Generic;
using System.Web.UI;
using EPiServer.Core;
using EPiServer.Filters;
using EPiServer.Web.WebControls;
using EPiServer;
using System.Web;

namespace Avenir.Templates.Units.Placeable
{
    /// <summary>
    ///	Lists the pages that has been changed in the last x hours, 
    /// where x is the number of hours specified in the property "RecentHours".
    /// </summary>
    public partial class ChangedPages : UserControlBase
    {
        // "RecentContainer" (PropertyPageReference)[Optional, Default value=Start page for site] defines the root page for changed pages.

        // "RecentHours" (PropertyNumber)Required, No default value] Number of hours back in time to check for changed pages.

        private bool _frontPage;

        public bool FrontPage
        {
            get { return _frontPage; }
            set { _frontPage = value; }
        }

        private int _changedHours = 1440; //default = 60 dager = 1440 timer

        public int ChangedHours
        {
            get { return _changedHours; }
            set { _changedHours = value; }
        }

        private int _maxNumber = 3; //default value;

        public int MaxNumber
        {
            get { return _maxNumber; }
            set { _maxNumber = value; }
        }

        private PageReference _rootPage; // = EPiServer.Core.PageReference.StartPage;
        //CurrentPage["ListingContainer"] != null ? CurrentPage["ListingContainer"] : EPiServer.Core.PageReference.StartPage 
        public PageReference RootPage
        {
            get {
                if (_rootPage == null || _rootPage.ID == 0)
                    return PageReference.StartPage;
                return _rootPage; }
            set { _rootPage = value; }
        }


        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Load"/> event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"/> object that contains the event data.</param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            RecentSearchDataSource.PageLink = RootPage;
            AddChangedRecentlyCriteria();
            RecentSearchDataSource.DataBind();

            PageDataCollection selectedValues = RecentSearchDataSource.Select(new DataSourceSelectArguments()) as PageDataCollection;
            var sortedValues = new SortedList<TimeSpan, PageData>();

            if (selectedValues == null)
            {
                return;
            }


            selectedValues.Sort(new FilterPropertySort("Changed", FilterSortDirection.Ascending));


            foreach (PageData data in selectedValues)
            {
                //hopp over dummy sider
                if (data.Property["DummyPage"] != null && data.Property["DummyPage"].ToString() == "True")
                    continue;
                sortedValues.Add(DateTime.MaxValue - data.Changed, data);
            }
            selectedValues.Clear();

            
           
            int i = 0;

            foreach (var element in sortedValues)
            {
                i++;
                selectedValues.Add(element.Value);
                if (i == MaxNumber) break; // Max default number = 3
            }

            Repeater.DataSource = selectedValues;
            Repeater.DataSourceID = null;
            Repeater.DataBind();
        }

        private void AddChangedRecentlyCriteria()
        {
            PropertyCriteriaControl crit = new PropertyCriteriaControl
               {
                   Name = "PageChanged",
                   Value = DateTime.Now.Subtract(TimeSpan.FromHours(CorrectHoursPropertyValue())).ToString(),
                   Condition = CompareCondition.GreaterThan,
                   Type = PropertyDataType.Date
               };

            RecentSearchDataSource.Criteria.Add(crit);
        }

        private int CorrectHoursPropertyValue()
        {
            return ChangedHours;
            //DateTime minSqlValue = new DateTime(1900, 1, 1); // for SQL we count since 01 Jan 1900
            //int hoursAllowed = (int)((DateTime.Now - minSqlValue).TotalHours);
            //int t = (int)CurrentPage[_recentHoursPropertyName] > hoursAllowed ? hoursAllowed : (int)CurrentPage[_recentHoursPropertyName];
            //return t * 24; //convert to days
        }

        protected string LinkHeader(PageData pd)
        {
            string _linkTag = "<a href=\"{0}\">{1}</a>";
            string tittel;

            if (pd["PageHeader"] != null)
            {
                tittel = pd.Property["PageHeader"].ToWebString();
            }
            else
            {
                tittel = pd.Property["PageName"].ToWebString();
            }
            return string.Format(_linkTag, HttpUtility.UrlPathEncode(pd.LinkURL), tittel);
        }

    }
}