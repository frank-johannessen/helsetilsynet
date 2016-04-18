<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="BrowseImageGalleryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.BrowseImageGalleryControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css">

<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.Title") %>...'
	//setTimeout('FocusTextBox()', 200);
	
	var idElement = window.opener.document.getElementById('<% = IdElementId %>');
	var nameElement = window.opener.document.getElementById('<% = NameElementId %>');
	
	function SearchImageGallery(name, doSearch)
	{
		if(doSearch)
		{
			<% = callBackSearchResult.ClientID %>.Callback(name);
		}
		else
		{
			if(name.length >= 2)
				setTimeout('SearchImageGallery("' + name + '", true);', 100);
			else
				document.getElementById('<% = callBackSearchResult.ClientID %>').innerHTML = '';
		}
	}
	
	function SelectImageGallery(id, name)
	{
		idElement.value = id;
		nameElement.value = name;
		
		window.close();
	}
	
	function FocusTextBox()
	{
		document.getElementById('<% = textBoxSearch.ClientID %>').focus();
	}
</script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<div id="tabStrip">
    <ComponentArt:TabStrip ID="tabStripBrowse" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageBrowse" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabBrowseGallery">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabNewGallery">
            </ComponentArt:TabStripTab>
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageBrowse" CssClass="multiPage" runat="server">
        <ComponentArt:PageView runat="server">
            <table class="epi-default" border="0" cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.BrowseGallery") %>...
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:TextBox ID="textBoxSearch" runat="server" CssClass="input" Width="100%" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <ComponentArt:CallBack ID="callBackSearchResult" runat="server">
                <Content>
                    <asp:Repeater ID="repeaterSearchResult" runat="server" EnableViewState="False">
                        <HeaderTemplate>
                            <br />
                            <table class="epi-default" border="0" cellpadding="0" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.BrowseResult") %>
                                            (<% = TotalHits %>)
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%#DataBinder.Eval(Container.DataItem, "Header") %>
                                </td>
                                <td align="right">
                                    <button class="button" onclick="SelectImageGallery(<%#DataBinder.Eval(Container.DataItem, "ID") %>, '<%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")).Replace("'", "\\'") %>');">
                                        <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.buttonSelectExisting") %></button>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <% if (TotalHits == 0)
                               { %>
                            <tr>
                                <td>
                                    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.NoResult") %>.
                                </td>
                            </tr>
                            <% } %>
                            </tbody></table>
                        </FooterTemplate>
                    </asp:Repeater>
                </Content>
            </ComponentArt:CallBack>
        </ComponentArt:PageView>
        <ComponentArt:PageView runat="server">
            <table class="epi-default" border="0" cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <th>
                            <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.ImageGallery.BrowseGallery.NewGallery") %>...
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:TextBox ID="textBoxNewGalleryName" runat="server" CssClass="input" Width="200" />&nbsp;<asp:Button ID="buttonCreateNewGallery" runat="server" CssClass="button" /><asp:RequiredFieldValidator ID="validatorImageGalleryName" runat="server" Display="None" EnableClientScript="False" ControlToValidate="textBoxNewGalleryName" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
</div>
