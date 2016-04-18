<%@ Control Language="c#" AutoEventWireup="True" Codebehind="PortraitControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.PortraitControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<tr>
	<td valign="top" class="topTd"><asp:Label ID="labelFile" Runat="server"></asp:Label></td>
	<td valign="top">
		<input type="file" id="filePortrait" class="file" runat="server" disabled="true">
		<br />
		<asp:CheckBox ID="checkBoxRemovePortrait" Runat="server" CssClass="input" Enabled="False" />
	</td>
	<td colspan="4" align="right">
		<asp:Image ID="imagePortrait" Runat="server" ImageUrl="../../Images/NoImage.gif" /><asp:CustomValidator ID="validatorImageFormat" Runat="server" EnableClientScript="False" Display="None" /><br>
	</td>
</tr>
