<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinksInternal.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.LinksInternal" %>
<%@ Import Namespace="EPiServer.SpecializedProperties" %>

<asp:Repeater runat="server" ID="rptLinks">
    <HeaderTemplate>
        <ul class="internal-links-list">
    </HeaderTemplate>
    <ItemTemplate>
        <li><a href="<%# ((LinkItem)Container.DataItem).Href %>"><%# ((LinkItem)Container.DataItem).Text %></a></li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>