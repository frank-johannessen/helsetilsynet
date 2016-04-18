<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuLargeDocuments.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.LeftMenuLargeDocuments" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>

<div class="aside nav">
    <h2 class="heading">
        <asp:HyperLink runat="server" ID="lnkLevel2InMainMenu"/>
    </h2>
    <asp:HyperLink runat="server" ID="lnkDocumentMainPage"/>
    <EPiServer:PageTree runat="server" ID="ptPageTree" ExpandAll="false" NumberOfLevels="5">
        <IndentTemplate><ul></IndentTemplate>

        <ItemHeaderTemplate><li></ItemHeaderTemplate>
                
        <ItemTemplate>
            <a href="<%# Container.CurrentPage.LinkURL %>">  <%# Container.CurrentPage.PageNameWithMaxLength(20)%></a>
        </ItemTemplate>
                
        <ItemFooterTemplate></li></ItemFooterTemplate>
                
        <SelectedItemTemplate>
            <a class="selected" href="<%# Container.CurrentPage.LinkURL %>">  <%# Container.CurrentPage.PageNameWithMaxLength(20)%></a>
        </SelectedItemTemplate>
                
        <UnindentTemplate></ul></UnindentTemplate>
    </EPiServer:PageTree>
</div>