<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MegaMenuTab2.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MegaMenuTab2" %>
<%@ OutputCache Duration="1800"  VaryByParam="none" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Model" %>
<%@ Register tagPrefix="ht" tagName="subTree" src="./MegaMenuSubTree.ascx" %>
<%@ Register tagPrefix="ht" tagName="externalSystem" src="./MegaMenuExternalSystem.ascx" %>
<a class="header" href="#mega-menu-tab-2" id="mega-menu-tab-2"><%= CurrentPage.MegaMenuSettings.Col2Title %></a>
<div class="menu">
    <div class="external-systems">
        <div>
        <ht:externalsystem ID="externalSystem1" runat="server" />
        <ht:externalsystem ID="externalSystem2" runat="server" />
        <ht:externalsystem ID="externalSystem3" runat="server" />
        </div>
    </div>    
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol1">
            <ItemTemplate>
                <ht:subTree runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol2">
            <ItemTemplate>
                <ht:subTree runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>   
    </div>
    <div class="column">
         <asp:Repeater runat="server" ID="rptCol3">
            <ItemTemplate>
                <ht:subTree runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    <div class="column">
        <asp:Repeater runat="server" ID="rptCol4">
            <ItemTemplate>
                <ht:subTree runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    <div class="column last-child">
        <asp:Repeater runat="server" ID="rptCol5">
            <ItemTemplate>
                <ht:subTree runat="server" PageLink="<%# ((BasePage)Container.DataItem).PageLink %>" />
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>