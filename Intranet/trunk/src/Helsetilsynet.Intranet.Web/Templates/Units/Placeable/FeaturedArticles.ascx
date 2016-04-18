<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeaturedArticles.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.FeaturedArticles" %>
<%@ Register tagPrefix="ht" tagName="teaser" src="~/Templates/Units/Placeable/ArticleTeaser.ascx" %>
<%@ Register tagPrefix="ht" tagName="archiveButton" src="~/Templates/Units/Placeable/ArticleArciveButton.ascx" %>
<div  class="featured">
<asp:Repeater runat="server" ID="rptArticles">
    <HeaderTemplate>
        <%= string.IsNullOrWhiteSpace(Title) ? string.Empty : string.Format("<h2>{0}</h2>", Title) %>
        <ul>
    </HeaderTemplate>
    <ItemTemplate>
            <li><ht:teaser runat="server" ID="teaser" Article="<%# Container.DataItem %>" ShortTextLength="90" LongTextLength="120" /></li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>
<ht:archiveButton runat="server" />
</div>