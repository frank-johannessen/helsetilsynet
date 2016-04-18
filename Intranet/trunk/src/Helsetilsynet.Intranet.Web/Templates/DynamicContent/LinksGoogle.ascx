<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinksGoogle.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent.LinksGoogle" %>
<%@ Register TagPrefix="ht" TagName="fileTypeAndSourceTags" Src="~/Templates/Units/Placeable/FileTypeAndSourceTags.ascx" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Util.GoogleMini" %>

<asp:Repeater runat="server" ID="rptSearchResult">
    <HeaderTemplate>
        <ul class="google-links-list">
    </HeaderTemplate>
    <ItemTemplate>
        <li>
            <a href="<%# ((ResultElement)Container.DataItem).Url %>"><%# ((ResultElement)Container.DataItem).Title %></a>
            <ht:fileTypeAndSourceTags runat="server" ResultElement="<%# (ResultElement)Container.DataItem %>" />
        </li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>
