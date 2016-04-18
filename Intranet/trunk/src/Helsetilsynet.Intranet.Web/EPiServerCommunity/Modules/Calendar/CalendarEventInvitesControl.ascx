<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarEventInvitesControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarEventInvitesControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:Repeater ID="repeaterInvites" Runat="server">
	<HeaderTemplate>
		<table cellpadding="0" cellspacing="0" border="0" class="epi-default">
			<tr>
			    <th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Invitee") %></th>
			    <th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Email") %></th>
			    <th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.InviteDate") %></th>
			</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
		    <td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Invitee.Name")) %></td>
		    <td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Invitee.Email")) %></td>
		    <td><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "InviteDate")) %></td>
		</tr>
	</ItemTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</asp:Repeater>
