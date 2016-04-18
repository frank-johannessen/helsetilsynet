<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchResult.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.SearchResult" %>
<%@ Register src="../Placeable/ResultPager.ascx" tagPrefix="ht" tagName="pager" %>
<%@ Register src="../Placeable/FileTypeAndSourceTags.ascx" tagPrefix="ht" tagName="fileTypeAndSourceTags" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Util.GoogleMini" %>

<!-- <asp:Literal runat="server" ID="tempLiteral"></asp:Literal> -->
<div class="results-meta">
    <asp:RadioButtonList runat="server" ID="rblSortOrder" RepeatLayout="Flow" AutoPostBack="True" Visible="False" CssClass="results-order"/>

    <span class="results-count">
    <asp:Literal runat="server" ID="ltrSearchCount" />
    </span>
</div>

<div class="search-results">
    <asp:ListView runat="server" ID="lvSearchResult" ItemPlaceholderID="pnlItemContainer">
       <LayoutTemplate>
            <asp:Panel ID="pnlItemContainer" runat="server" />
       </LayoutTemplate>
        <ItemTemplate>
            <div class="result article">
                <h3><a href="<%# ((ResultElement)Container.DataItem).Url %>"><%# ((ResultElement)Container.DataItem).Title %></a></h3>
                <p class="summary"><%# ((ResultElement)Container.DataItem).Description %></p>
                <ht:fileTypeAndSourceTags ID="FileTypeAndSourceTags1" runat="server" ResultElement="<%# (ResultElement)Container.DataItem %>" />
                <span class="pubdate" title="<%#  ((ResultElement)Container.DataItem).Date.FormatToLongDateString() %>"><%#  ((ResultElement)Container.DataItem).Date.FormatToShortDateString() %></span>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
        </EmptyDataTemplate>       

    </asp:ListView>
</div>

<ht:pager runat="server" ID="pager" />

<div class="results-meta">
    <div class="results-help">
        <%= CurrentPage.SearchResultHelp %>
    </div>
</div>
