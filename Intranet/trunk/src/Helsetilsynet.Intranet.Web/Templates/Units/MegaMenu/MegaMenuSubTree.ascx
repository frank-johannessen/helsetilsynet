<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MegaMenuSubTree.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.MegaMenu.MegaMenuSubTree" %>
<EPiServer:PageTree runat="server" ShowRootPage="True" ExpandAll="True" PageLink="<%# PageLink %>" NumberOfLevels="2">
    <IndentTemplate><ul></IndentTemplate>
    <UnindentTemplate></ul></UnindentTemplate>
    <ExpandedTopTemplate><EPiServer:Property runat="server" PropertyName="PageLink"/></ExpandedTopTemplate>
    <ExpandedItemTemplate><EPiServer:Property runat="server" PropertyName="PageLink"/></ExpandedItemTemplate>
    <ItemHeaderTemplate><li></ItemHeaderTemplate>
    <ItemFooterTemplate></li></ItemFooterTemplate>
</EPiServer:PageTree>
