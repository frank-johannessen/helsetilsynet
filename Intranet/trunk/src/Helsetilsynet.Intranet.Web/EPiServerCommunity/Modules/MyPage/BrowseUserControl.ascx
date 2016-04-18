<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="BrowseUserControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.BrowseUserControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.BrowserUser.Title") %>...'
	setTimeout('FocusTextBox()', 200);

	var idElement = window.opener.document.getElementById('<% = IdElementId %>');
	var nameElement = window.opener.document.getElementById('<% = NameElementId %>');
	
	function SelectUser(id, name)
	{
		idElement.value = id;
		nameElement.innerHTML = name;
		
		window.close();
	}
	
	function FocusTextBox()
	{
		document.getElementById('<% = textBoxSearch.ClientID %>').focus();
	}
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.BrowserUser.Header") %>...</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="searchQuery"><asp:TextBox ID="textBoxSearch" Runat="server" CssClass="input" Width="100%" /></td>
			<td><asp:Button ID="SearchUserButton" runat="server" CssClass="button" OnClick="SearchUserButtonClick" /></td>
		</tr>
	</tbody>
</table>
<asp:Repeater ID="repeaterSearchResult" Runat="server" EnableViewState="False">
	<HeaderTemplate>
		<br />
		<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.BrowserUser.BrowseResult") %> (<% = TotalHits %>)</th>
				</tr>
			</thead>
			<tbody>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td><a href="javascript:SCMyPageOpenEditUser(<%#DataBinder.Eval(Container.DataItem, "ID") %>);"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Alias")) %></a></td>
			<td align="right"><button class="button" onclick="SelectUser(<%#DataBinder.Eval(Container.DataItem, "ID") %>, '<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Alias")) %>');"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.BrowserUser.buttonSelect") %></button></td>
		</tr>
	</ItemTemplate>
	<FooterTemplate>
		<% if (TotalHits == 0) { %>
		<tr>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.MyPage.BrowserUser.NoResult") %>.</td>
		</tr>
		<% } %>
		</tbody></table>
	</FooterTemplate>
</asp:Repeater>
