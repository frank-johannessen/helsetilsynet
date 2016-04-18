<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttributeValueControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AttributeValueControl" %>
<table class="epi-default" cellSpacing="0" cellPadding="0">
<thead>
<tr>
    <th width="70%"><asp:Label ID="labelAttributeName" runat="server"></asp:Label></th>
    <th><asp:Button ID="buttonAdd" runat="server"  OnClick="buttonAdd_Click" CssClass="button" /></th>
</tr>
</thead>
<tbody>
<tr>
<asp:Panel ID="panelAttributeValues" runat="Server"></asp:Panel>
</tr>
</tbody>
</table>