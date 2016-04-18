<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CalendarGraphicView.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.CalendarGraphicView" %>
<div class="calendar-graphic">
    <asp:Calendar runat="server" ID="calGlobalCalendar" EnableTheming="False" FirstDayOfWeek="Monday" BorderWidth="0" CssClass="calendar-month" OnDayRender="calGlobalCalendar_DayRender" OnSelectionChanged="calGlobalCalendar_OnSelectionChanged" OnVisibleMonthChanged="calGlobalCalendar_VisibleMonthChanged">
        <NextPrevStyle CssClass="calendarText" />
        <OtherMonthDayStyle CssClass="calendar-day-other-month" />
        <SelectedDayStyle BackColor="Transparent" CssClass="calendar-day-selected" />
        <TitleStyle BackColor="Transparent" />
        <TodayDayStyle CssClass="calendar-day-today" />
    </asp:Calendar>
</div>
