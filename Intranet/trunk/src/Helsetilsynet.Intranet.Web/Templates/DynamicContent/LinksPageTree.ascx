<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinksPageTree.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.LinksPageTree" %>

<EPiServer:PageList ID="plPages" runat="server" EnableVisibleInMenu="False" >
        <HeaderTemplate>
            <ul class="node-links-list">
        </HeaderTemplate>
        <ItemTemplate>
            <EPiServer:Property runat="server" CustomTagName="li" PropertyName="PageLink" />
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
</EPiServer:PageList>