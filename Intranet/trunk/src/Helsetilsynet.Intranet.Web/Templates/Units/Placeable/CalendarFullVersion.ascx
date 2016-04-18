<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CalendarFullVersion.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.CalendarFullVersion" %>
<%@ Import Namespace="Relate.HelpersAndExtensions" %>

<%@ Register tagPrefix="Relate" tagName="CalendarMinimalView" src="~/Templates/Units/Placeable/MinimalCalendarView.ascx" %>
<%@ Register tagPrefix="Relate" tagName="CalendarGraphicView" src="~/Templates/Units/Placeable/CalendarGraphicView.ascx" %>
<%@ Register tagPrefix="Relate" tagName="AddCalendarEvent" src="~/Templates/Units/Placeable/AddCalendarEvent.ascx" %>

<asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="pnlCalendar" class="section calendar">
    <ContentTemplate>
        <Relate:AddCalendarEvent runat="server" ID="ucAddCalendarEvent" />
        <Relate:CalendarGraphicView runat="server" ID="ucCalendarGraphicView" OnVisibleMonthChanged="ucCalendarGraphicView_OnVisibleMonthChanged" OnSelectedDayChanged="ucCalendarGraphicView_OnSelectedDayChanged" />
        <Relate:CalendarMinimalView runat="server" ID="ucCalendarMinimalView" PageSize="3" PagePosition="1" ShowAddEventButton="False"  />    
        <a href="<%= RelateTemplatePage<RelateGlobalSettings>.CalendarYearOverview.LinkURL %>" class="all-events-link" title="<%= Translate("/calendar/seeall") %>" ><%= Translate("/calendar/seeall") %></a>
    </ContentTemplate>
    <Triggers>
         <asp:AsyncPostBackTrigger ControlID="ucCalendarGraphicView" />
         <asp:PostBackTrigger ControlID="ucAddCalendarEvent" />
         <asp:PostBackTrigger ControlID="ucCalendarMinimalView" />
    </Triggers>
</asp:UpdatePanel>
