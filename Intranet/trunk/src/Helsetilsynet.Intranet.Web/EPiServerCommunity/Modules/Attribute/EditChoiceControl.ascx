<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditChoiceControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditChoiceControl" %>

<tr>
	<td><asp:TextBox ID="textBoxChoiceName" runat="server" CssClass="input"></asp:TextBox></td>
	<td><asp:Panel ID="panelChoiceValue" runat="server"></asp:Panel></td>
	<td><asp:Button ID="buttonRemoveChoice" runat="server" CssClass="button" OnClick="buttonRemoveChoice_Click" />&nbsp;</td>
</tr>