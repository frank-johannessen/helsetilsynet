<%@ Control Language="c#" AutoEventWireup="True" Codebehind="AccessRightsPanel.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AccessRightsPanel" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellpadding="0" cellspacing="0" width="100%" class="accessRightsPanel">
<asp:Repeater ID="repeaterAccessRights" Runat="server">
	<ItemTemplate>
		<tr><td><%# DataBinder.Eval(Container.DataItem, "Name") %>:</td><td><%# ((System.Reflection.PropertyInfo)Container.DataItem).GetValue(AccessRights, null) %></td></tr>
	</ItemTemplate>
</asp:Repeater>
</table>