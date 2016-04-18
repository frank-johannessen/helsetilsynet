<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CalendarEventRegistrationsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CalendarEventRegistrationsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:Repeater ID="repeaterRegistrations" Runat="server">
	<HeaderTemplate>
		<table cellpadding="0" cellspacing="0" border="0" class="epi-default">
			<tr>
			    <th align="left">
			        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Registrant") %>
			    </th>
			    <th align="left">
			        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Email") %>
			    </th>
			    <th align="left">
			        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Calendar.Registered") %>
			    </th>
			</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
		    <td>
		        <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Registrant.Name")) %>
		    </td>
		    <td>
		        <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Registrant.Email")) %>
		    </td>
		    <td>
		        <%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "RegistrationDate")) %>
		    </td>
		</tr>
	</ItemTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</asp:Repeater>
