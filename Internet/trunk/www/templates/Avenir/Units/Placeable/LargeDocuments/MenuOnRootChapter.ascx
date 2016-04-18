<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuOnRootChapter.ascx.cs"
    Inherits="Helsetilsynet.templates.Avenir.Units.Placeable.LargeDocuments.MenuOnRootChapter" %>
<%@ Import Namespace="EPiServer.Core" %>
<a class="details-link" href="<%= GetDetailsLinkUrl() %>">
    <%= GetDetailsLinkText() %></a>
<EPiServer:PageTree PageLink="<%# CurrentPage.PageLink %>" ID="ptLargeDocumentToc"
    runat="server" ExpandAll="True" NumberOfLevels="<%# GetDisplayNumberOfLevels() %>"
    ShowRootPage="False">
    <HeaderTemplate>
        <div class="large-doc-toc">
    </HeaderTemplate>
    <IndentTemplate>
        <ol>
    </IndentTemplate>
    <ItemHeaderTemplate>
        <li class="large-doc-menu-level<%# GetLargeDocumentLevel(Container.DataItem as PageData) %>">
    </ItemHeaderTemplate>
    <ItemFooterTemplate>
        </li>
    </ItemFooterTemplate>
    <ItemTemplate>
        <a href="<%# Container.CurrentPage.LinkURL %>">
            <%# (Container.DataItem as PageData).PageName %></a>
    </ItemTemplate>
    <UnindentTemplate>
        </ol>
    </UnindentTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</EPiServer:PageTree>
