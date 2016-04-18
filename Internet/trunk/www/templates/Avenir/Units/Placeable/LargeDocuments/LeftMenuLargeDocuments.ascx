<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuLargeDocuments.ascx.cs" Inherits="Helsetilsynet.templates.Avenir.Units.Placeable.LargeDocuments.LeftMenuLargeDocuments" %>
<div class="large-doc-left-menu">
    <EPiServer:PageTree runat="server" ID="ptPageTree" ExpandAll="False" NumberOfLevels="8" ShowRootPage="True">
        <IndentTemplate>
            <ul>
        </IndentTemplate>
        <ItemHeaderTemplate>
            <li>
        </ItemHeaderTemplate>
        <ItemTemplate>
            <a href="<%# Container.CurrentPage.LinkURL %>">
                <%# PageNameWithMaxLength(Container.CurrentPage, 20)%></a>
        </ItemTemplate>
        <ItemFooterTemplate>
            </li></ItemFooterTemplate>
        <SelectedItemTemplate>
            <a class="selected" href="<%# Container.CurrentPage.LinkURL %>">
                <%# PageNameWithMaxLength(Container.CurrentPage, 20)%></a>
        </SelectedItemTemplate>
        <UnindentTemplate>
            </ul></UnindentTemplate>
    </EPiServer:PageTree>
</div>
