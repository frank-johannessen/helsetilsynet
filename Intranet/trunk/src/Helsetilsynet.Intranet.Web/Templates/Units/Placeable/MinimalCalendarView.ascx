<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MinimalCalendarView.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.MinimalCalendarView" %>
<%@ Register tagPrefix="Relate" tagName="AddCalendarEvent" src="~/Templates/Units/Placeable/AddCalendarEvent.ascx" %>
<%@ Register tagPrefix="ht" tagName="dateItems" src="~/Templates/Units/Placeable/MinimalCalendarViewDateItems.ascx" %>
<%@ Import Namespace="EPiServer.Community.Calendar" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>

<asp:Repeater runat="server" ID="rptCalendar">
    <HeaderTemplate>
        <ol class="vCalendar minimal-calendar">
    </HeaderTemplate>
    <ItemTemplate>
            <li>
                <h3><%# ((KeyValuePair<DateTime,EventCollection>)Container.DataItem).Key.ToHumanDateString().ToUpper() %></h3>
                <ht:dateItems runat="server" EventCollection="<%# ((KeyValuePair<DateTime,EventCollection>)Container.DataItem).Value %>" OnEditEvent="DateItem_OnEditEvent" OnDeleteEvent="DateItem_OnDeleteEvent" />
            </li>
    </ItemTemplate>
    <FooterTemplate>
        </ol>
    </FooterTemplate>
</asp:Repeater>
<relate:AddCalendarEvent runat="server" ID="ucAddCalendarEvent" Visible="False"  />