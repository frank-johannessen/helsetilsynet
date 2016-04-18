<%@ Control Language="c#" AutoEventWireup="True" Codebehind="FindTranslationControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.FindTranslationControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Register TagPrefix="ss" TagName="GlobalizationKeyControl" Src="GlobalizationKeyControl.ascx" %>
<script language="javascript" src="../js/starsuite.js"></script>
<asp:panel id="panelSearch" Width="100%" runat="server">
	<table cellPadding="0" cellspacing="0" width="100%" border="0" class="epi-default">
	<tr>
		<td width="100"><asp:label id="labelSearch" runat="server" CssClass="label"></asp:label></td>
		<td><asp:textbox id="textBoxSearch" runat="server" Width="315" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="validatorSearch" runat="server" ErrorMessage="*" CssClass="requiredField" ControlToValidate="textBoxSearch" Display="Dynamic" />
			&nbsp;<asp:button id="buttonSearch" runat="server" CssClass="button" CausesValidation="False" onclick="buttonSearch_Click"></asp:button></td>
	</tr>
	</table>
	<br />
	<asp:Panel ID="panelResult" Runat="server" Visible="False">
		<table cellPadding="0" cellspacing="0" width="100%" border="0" class="epi-default">
		<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Globalization.searchResult") %></th>
		</tr>
		</thead>
		<asp:Repeater ID="repeaterSearchResult" Runat="server">
			<ItemTemplate>
				<tr><td><a href="javascript:EPiServerCommonOpenEditGlobalizationKey('<%# Server.HtmlEncode((string)Container.DataItem) %>', '<% = this.UniqueID %>');"><%# Server.HtmlEncode((string)Container.DataItem) %></a></td><td align="right"><span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Globalization.RemoveKeyConfirm") %>');"><asp:LinkButton id="linkButtonRemoveKey" runat="server" OnCommand="LinkButtonRemoveKey_Command" CommandArgument="<%# (string)Container.DataItem %>"><img src="../Images/General/remove.png" border="0"></asp:LinkButton></span></td></tr>
			</ItemTemplate>
		</asp:Repeater>
		</table>
	</asp:Panel>
</asp:panel>

					