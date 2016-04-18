<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="BrowseDocumentArchiveControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.BrowseDocumentArchiveControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script language="javascript">
<!--
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.Title") %>'
	//setTimeout('FocusTextBox()', 200);

	var idElement = window.opener.document.getElementById('<% = IdElementId %>');
	var nameElement = window.opener.document.getElementById('<% = NameElementId %>');
	
	function SearchDocumentArchive(name, doSearch, charCode)
	{
	    var k = "";
	    if (charCode >= 32)
	        k = String.fromCharCode(charCode);
	    var isEnter = (charCode == 13);
	    name = name + k;
		if(doSearch || isEnter)
		{
			<% = callBackSearchResult.ClientID %>.Callback(name);
		}
		else
		{
			if(name.length >= <%= MinimumCharactersForWildcardSearch %>)
				setTimeout('SearchDocumentArchive("' + name + '", true, 0);', 100);
			else
				document.getElementById('<% = callBackSearchResult.ClientID %>').innerHTML = '';
		}
	}
	
	function SelectDocumentArchive(id, name)
	{
		idElement.value = id;
		nameElement.value = name;
		
		window.close();
	}
	
	function FocusTextBox()
	{
		document.getElementById('<% = textBoxSearch.ClientID %>').focus();
	}
-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<div id="tabStrip">
	<ComponentArt:TabStrip id="tabStripBrowse" 
			CssClass="topGroup"
			DefaultItemLookId="DefaultTabLook"
			DefaultSelectedItemLookId="SelectedTabLook"
			DefaultDisabledItemLookId="DisabledTabLook"
			DefaultGroupTabSpacing="0"
			ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
			MultiPageId="multiPageBrowse"
			runat="server">
			<ItemLooks>
				<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
				<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
			</ItemLooks>
			<Tabs>
				<ComponentArt:TabStripTab Runat="server" Text="Browse" ID="tabStripTabBrowseArchive"></ComponentArt:TabStripTab>
				<ComponentArt:TabStripTab Runat="server" Text="New" ID="tabStripTabNewArchive"></ComponentArt:TabStripTab>
			</Tabs>
	</ComponentArt:TabStrip>
	<ComponentArt:MultiPage id="multiPageBrowse" CssClass="multiPage" runat="server">
		<ComponentArt:PageView  runat="server">
			<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.Header") %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><asp:TextBox ID="textBoxSearch" Runat="server" CssClass="input" Width="100%" /></td>
					</tr>

				</tbody>
			</table>
			<ComponentArt:CallBack id="callBackSearchResult" runat="server">
				<Content>
					<asp:Repeater ID="repeaterSearchResult" Runat="server" EnableViewState="False">
						<HeaderTemplate>
							<br />
							<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
								<thead>
									<tr>
										<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.ResultHeader") %> (<% = TotalHits %>)</th>
									</tr>
								</thead>
								<tbody>
						</HeaderTemplate>
						<ItemTemplate>
							<tr>
								<td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Name")) %></td>
								<td align="right"><button id="test" class="button" onclick="SelectDocumentArchive(<%#DataBinder.Eval(Container.DataItem, "ID") %>, '<%# AdministrationUtils.FormatString(((string)DataBinder.Eval(Container.DataItem, "Name")).Replace("'", "\\'")) %>');"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.buttonSelect") %></button></td>
							</tr>
						</ItemTemplate>
						<FooterTemplate>
							<% if (TotalHits == 0) { %>
							<tr>
								<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.NoResult") %>.</td>
							</tr>
							<% } %>
							</tbody></table>
						</FooterTemplate>
					</asp:Repeater>
				</Content>
			</ComponentArt:CallBack>
		</ComponentArt:PageView>
		<ComponentArt:PageView  runat="server">
			<table class="epi-default" border="0" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.DocumentArchive.BrowseDocumentArchive.NewArchiveHeader") %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><asp:TextBox ID="textBoxNewArchiveName" Runat="server" CssClass="input" Width="200" />&nbsp;<asp:Button ID="buttonCreateNewArchive" Runat="server" CssClass="button" /><asp:RequiredFieldValidator id="validatorDocumentArchiveName" Runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxNewArchiveName" /></td>
					</tr>
				</tbody>
			</table>
		</ComponentArt:PageView>
	</ComponentArt:MultiPage>
</div>