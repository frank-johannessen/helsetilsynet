<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewMenu.ascx.cs" Inherits="Helsetilsynet.templates.Avenir.Units.Static.NewMenu" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Register TagPrefix="ht" TagName="BreadCrumbs" Src="~/templates/Avenir/Units/Static/BreadCrumbs.ascx" %>
<EPiServer:PageTree runat="server" ID="Menu" ExpandAll="True">
    <HeaderTemplate>
        <div class="mainMenu l-640-table-cell">
    </HeaderTemplate>
    <IndentTemplate>
        <ul class="clearfix <%#GetMenuLevel((PageData)Container.DataItem)%>">
    </IndentTemplate>
    <ItemHeaderTemplate>
        <li <%# GetExpandedClass(Container.DataItem) %>> 
    </ItemHeaderTemplate>
    <ExpandedTopTemplate>
            <EPiServer:Property runat="server" PropertyName="PageLink" /> <span class="icon-arrow-right"></span>
    </ExpandedTopTemplate>
    <SelectedExpandedTopTemplate>
            <EPiServer:Property runat="server" PropertyName="PageLink" CssClass="selected" /> <span class="icon-arrow-right"></span>
    </SelectedExpandedTopTemplate>
    <ExpandedItemTemplate>
            <EPiServer:Property runat="server" PropertyName="PageLink" /> <span class="icon-arrow-right"></span>
    </ExpandedItemTemplate>
    <SelectedExpandedItemTemplate>
            <EPiServer:Property runat="server" PropertyName="PageLink" CssClass="selected" /> <span class="icon-arrow-right"></span>
    </SelectedExpandedItemTemplate>
    <ItemFooterTemplate>
        </li>
    </ItemFooterTemplate>
    <UnindentTemplate>
        </ul>
    </UnindentTemplate>
    <FooterTemplate>
        </div>
        <ht:BreadCrumbs runat="server" ID="BreadCrumbs" />
    </FooterTemplate>
</EPiServer:PageTree>
