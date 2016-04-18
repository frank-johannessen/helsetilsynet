<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SearchCalendarsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SearchCalendarsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript" src="Administration.js"></script>
<script language="javascript" src="Js/StarSuite.js"></script>
<script language="javascript">
	EPiServerCommonAddLoadEvent(FocusTextBox);

	function FocusTextBox()
	{
		document.getElementById('<% = textBoxSearch.ClientID %>').focus();
	}
</script>

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.calendar")%></h1>
<asp:Panel runat="server" ID="CalendarSearchPanel" DefaultButton="ButtonSearch">
<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Calendar") %></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="menu">
			    <button class="button" onclick="SCCalendarCreateNewCalendar();return false;" runat="server" id="buttonNewCalendar"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.NewCalendar") %></button>
			</td>
			<td>
			    <asp:TextBox ID="textBoxSearch" Runat="server" CssClass="input" width="50%" />
			    <asp:Button runat="server" ID="ButtonSearch" CssClass="button" OnClick="ButtonSearch_Click" />
			</td>
		</tr>
	</tbody>
</table>
<asp:Repeater ID="repeaterSearchResult" Runat="server" EnableViewState="False">
	<HeaderTemplate>
		<br />
		<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.BrowseResult") %> (<% = TotalHits %>)</th>
				</tr>
			</thead>
			<tbody>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td><a href="javascript:SCCalendarOpenCalendarInfo(<%#DataBinder.Eval(Container.DataItem, "ID") %>)"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Name")) %></a></td>
		</tr>
	</ItemTemplate>
	<FooterTemplate>
		<% if (TotalHits == 0) { %>
		<tr>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.NoResult") %>.</td>
		</tr>
		<% } %>
		</tbody></table>
	</FooterTemplate>
</asp:Repeater>
</asp:Panel>
