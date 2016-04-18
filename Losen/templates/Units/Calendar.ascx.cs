/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.templates.Units
{
	/// <summary>
	///		Summary description for Calendar.
	/// </summary>
	public abstract class Calendar : System.Web.UI.UserControl
	{
		protected EPiServer.WebControls.Calendar		calendarList;
		protected System.Web.UI.WebControls.Calendar	monthCalendar;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				int nrOfDaysToShow = 0;
				if(((PageBase)Page).CurrentPage.Property.Exists("nDaysToRender"))
					nrOfDaysToShow = (int)((PageBase)Page).CurrentPage["nDaysToRender"];
				monthCalendar.SelectedDates.Clear();
				for(int i = 0 ; i < nrOfDaysToShow ; i++)
					monthCalendar.SelectedDates.Add(DateTime.Now.AddDays(i));

				calendarList.DataBind();
			}
		}
		protected void SetRightDates(object sender, System.EventArgs e)
		{
			calendarList.SelectedDates = monthCalendar.SelectedDates;
			calendarList.DataBind();
		}
		protected void MonthChange(object sender, System.Web.UI.WebControls.MonthChangedEventArgs e)
		{
			monthCalendar.SelectedDates.Clear();
			
			
			/* Note: Use this section to select the predifined number of days at month change
			 * 
			 * int nrOfDaysToShow = 0;
			 * if(CurrentPage.Property.Exists("nDaysToRender"))
			 * 	nrOfDaysToShow = (int)CurrentPage["nDaysToRender"];
			 * for(int i = 0 ; i < nrOfDaysToShow ; i++)
			 *	monthCalendar.SelectedDates.Add(monthCalendar.VisibleDate.AddDays(i));
			*/

			TimeSpan selectedDates = monthCalendar.VisibleDate.AddMonths(1) - monthCalendar.VisibleDate;

			for(int i = 0 ; i < selectedDates.Days ; i++)
				monthCalendar.SelectedDates.Add(monthCalendar.VisibleDate.AddDays(i));

			calendarList.SelectedDates = monthCalendar.SelectedDates;
			calendarList.DataBind();
		}
		protected void RenderDay(object sender, System.Web.UI.WebControls.DayRenderEventArgs e)
		{
			System.Web.UI.WebControls.TableCell cell = e.Cell;

			cell.BackColor = System.Drawing.Color.Empty;
			cell.ForeColor = System.Drawing.Color.Empty;

			if(calendarList.DateIsActive(e.Day.Date))
			{
				cell.CssClass = "dateCellActive";
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			monthCalendar.SelectionChanged += new EventHandler(SetRightDates);
			monthCalendar.VisibleMonthChanged += new System.Web.UI.WebControls.MonthChangedEventHandler(MonthChange);
			monthCalendar.DayRender += new System.Web.UI.WebControls.DayRenderEventHandler(RenderDay);
		}
		#endregion
	}
}
