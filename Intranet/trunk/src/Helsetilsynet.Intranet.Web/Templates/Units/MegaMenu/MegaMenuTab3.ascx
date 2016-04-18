<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MegaMenuTab3.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MegaMenuTab3" %>
<%@ OutputCache Duration="1800"  VaryByParam="none" %>
<%@ Register TagPrefix="ht" TagName="subTree" Src="~/Templates/Units/MegaMenu/MegaMenuSubTree.ascx" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Model" %>
<a class="header" href="#mega-menu-tab-3" id="mega-menu-tab-3"><%= CurrentPage.MegaMenuSettings.Col3Title %></a>

<div class="menu">
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol1">
            <ItemTemplate>
                <ht:subTree ID="SubTree1" runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol2">
            <ItemTemplate>
                <ht:subTree ID="SubTree2" runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>   
    </div>
    <div class="column">
         <asp:Repeater runat="server" ID="rptCol3">
            <ItemTemplate>
                <ht:subTree ID="SubTree3" runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    <div class="column-heading"><span><%= CurrentPage.MegaMenuSettings.RightColsTitle%></span></div>
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol4">
            <ItemTemplate>
                <ht:subTree ID="SubTree4" runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>
        <div class="free-text"><%= CurrentPage.MegaMenuSettings.RightColsSubText%></div>   
    </div>
    <div class="column last-child">
        <asp:Repeater runat="server" ID="rptCol5">
            <ItemTemplate>
                <ht:subTree ID="SubTree5" runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
