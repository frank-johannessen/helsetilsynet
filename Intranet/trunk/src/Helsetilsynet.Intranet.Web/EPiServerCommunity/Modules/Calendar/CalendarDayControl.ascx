<%@ Import Namespace="System.Globalization"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarDayControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarDayControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<table border="0" cellpadding="0" cellspacing="0" style="width: 100px; height: 100px" class="epi-default">
	<tr>
		<td align="right" class="label" style="height: 16px"><% = Date.Day %>&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" style="height: 84px;">
			<div style="width: 92px; height: 65px; overflow: auto">
				<asp:Repeater ID="repeaterEvents" Runat="server">
					<ItemTemplate>
						<a href="javascript:SCCalendarOpenEventInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<% = this.UniqueID %>');"><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Header").ToString())%></a>
						<br />
					</ItemTemplate>
				</asp:Repeater>
			</div>
			<% if (Calendar != null) { %><a href="javascript:SCCalendarCreateNewEvent(<% = Calendar.ID %>, '<% = Date.AddHours(12).ToString(CultureInfo.InvariantCulture) %>', '<% = this.UniqueID %>')"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.NewEventLabel") %></a><% } %>
		</td>
	</tr>
</table>