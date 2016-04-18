<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserSearchShortVersion.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.UserSearchShortVersion" %>
<%@ Import Namespace="EPiServer.SpecializedProperties" %>
<%@ Import Namespace="Relate.HelpersAndExtensions" %>

<div class="section">
    <h2 class="heading"><%= Translate("/usercontrolheadings/usersearchshort")%></h2>
    <asp:ListView ID="lvSearchTerms" ItemPlaceholderID="pnlItemContainer" runat="server"  >
        <LayoutTemplate>
            <p>
                <asp:Panel ID="pnlItemContainer" runat="server" />
            </p>
        </LayoutTemplate>
        <ItemTemplate>
            <a class="shortcut-button" href="<%# ((LinkItem)Container.DataItem).Href %>" title="<%# ((LinkItem)Container.DataItem).Title %>"><%# ((LinkItem)Container.DataItem).Text %></a>
        </ItemTemplate>      
    </asp:ListView>
    <a href="<%= RelateTemplatePage<RelateGlobalSettings>.UserSearchPage.LinkURL  %>" class="competence-search-link" title="<%= RelateTemplatePage<RelateGlobalSettings>.UserSearchPage.PageName %>"><%= Translate("/UserSearchFilter/searchincompetencecatalog")%></a>
</div>