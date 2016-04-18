<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="CalendarYearOverview.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.CalendarYearOverview" %>
<%@ Register tagPrefix="Relate" tagName="Calendar" src="~/Templates/Units/Placeable/MinimalCalendarView.ascx" %>
<%@ Register tagPrefix="Relate" tagName="AddCalendarEvent" src="~/Templates/Units/Placeable/AddCalendarEvent.ascx" %>
<%@ Register TagPrefix="ht" TagName="pager" Src="~/Templates/Units/Placeable/ResultPager.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="profile" href="http://microformats.org/profile/hcalendar" />
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content section">
        <div class="header">
            <h1 class="heading"><EPiServer:Property runat="server" PropertyName="PageName" /></h1>
            <div class="calendar-timespan-selector">
                <Relate:AddCalendarEvent runat="server" ID="ucAddCalendarEvent" />
                <asp:LinkButton ID="LinkButton1" runat="server" OnCommand="btnChangeSearchErlierEvents_OnCommand" CommandArgument="false" Text="<%$ Resources: EPiServer, calendar.commingevents %>" />
                |
                <asp:LinkButton ID="LinkButton2" runat="server" OnCommand="btnChangeSearchErlierEvents_OnCommand" CommandArgument="true" Text="<%$ Resources: EPiServer, calendar.earlierevents %>" />
            </div>
        </div>
        <div class="calendar">

            <Relate:Calendar runat="server" ID="ucCalendarMinimalView" PageSize="500" PagePosition="1" ShowAddEventButton="False" />
        </div>
        <ht:pager runat="server" ID="pager" />
    </div>
    <div class="filters aside">
        <h2 class="heading"><asp:Literal runat="server" Text="<%$ Resources: EPiServer, personinformation.serviceareas %>" /></h2>
        <asp:CheckBoxList RepeatLayout="UnorderedList" runat="server" ID="cblServiceAreas" OnSelectedIndexChanged="cblServiceAreas_OnChange" AutoPostBack="True" />
    </div>

</asp:Content>
