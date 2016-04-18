<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.Footer" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Import Namespace="EPiServer.SpecializedProperties" %>
<div class="content-wrapper">
    <div class="site-common-links">
        <asp:Repeater runat="server" ID="rptLeftLinks">
            <ItemTemplate><a href="<%# ((LinkItem)Container.DataItem).Href %>" target="<%# ((LinkItem)Container.DataItem).Target %>"><%# ((LinkItem)Container.DataItem).Text %></a></ItemTemplate>
        </asp:Repeater>
    </div>
    <div>
        <%= CurrentPage.GlobalSettings.FooterMainBody %>
    </div>
    <div>
        <asp:Repeater runat="server" ID="rptRightLinks">
            <ItemTemplate><a href="<%# ((LinkItem)Container.DataItem).Href %>" target="<%# ((LinkItem)Container.DataItem).Target %>"><%# ((LinkItem)Container.DataItem).Text %></a></ItemTemplate>
        </asp:Repeater>
    </div>
    <div>
        <a href="http://htil.no">
        <EPiImage:EPiImageResizer ID="footerRightImage" Width="187" Height="118" Transformation="ScaleToFit" runat="server" LinkCssClass="htil-linked-logo" />
        </a>
    </div>
</div>