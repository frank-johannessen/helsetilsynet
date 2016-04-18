<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MegaMenuTab1.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MegaMenuTab1" %>
<%@ OutputCache Duration="1800"  VaryByParam="none" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>

<a class="header" href="#mega-menu-tab-1" id="mega-menu-tab-1"><%= CurrentPage.MegaMenuSettings.Col1Title %></a>
<ul class="menu">
	<li>
        <a href="<%= GetPageData(Col1RootNode).LinkURL %>" class="header <%= Col1Category.GetClassName() %>"><%= GetDescription(Col1Category) %></a>
        <asp:Repeater runat="server" ID="rptCol1">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                    <li><a href="<%# ((PageData)Container.DataItem).LinkURL %>"><%# ((PageData)Container.DataItem).PageName %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
	</li>
	<li>
        <a href="<%= GetPageData(Col2RootNode).LinkURL %>" class="header <%= Col2Category.GetClassName() %>"><%= GetDescription(Col2Category) %></a>
        <asp:Repeater runat="server" ID="rptCol2">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                    <li><a href="<%# ((PageData)Container.DataItem).LinkURL %>"><%# ((PageData)Container.DataItem).PageName %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
	</li>
	<li>
        <a href="<%= GetPageData(Col3RootNode).LinkURL %>" class="header <%= Col3Category.GetClassName() %>"><%= GetDescription(Col3Category) %></a>
        <asp:Repeater runat="server" ID="rptCol3">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                    <li><a href="<%# ((PageData)Container.DataItem).LinkURL %>"><%# ((PageData)Container.DataItem).PageName %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
	</li>
	<li>
        <a href="<%= GetPageData(Col4RootNode).LinkURL %>" class="header <%= Col4Category.GetClassName() %>"><%= GetDescription(Col4Category) %></a>
        <asp:Repeater runat="server" ID="rptCol4">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                    <li><a href="<%# ((PageData)Container.DataItem).LinkURL %>"><%# ((PageData)Container.DataItem).PageName %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
	</li>
	<li class="last-child">
		<a href="<%= GetPageData(Col5RootNode).LinkURL %>" class="header <%= Col5Category.GetClassName() %>"><%= GetDescription(Col5Category) %></a>
        <asp:Repeater runat="server" ID="rptCol5">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                    <li><a href="<%# ((PageData)Container.DataItem).LinkURL %>"><%# ((PageData)Container.DataItem).PageName %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
	</li>
</ul>