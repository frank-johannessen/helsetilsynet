<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManagementConsole.ascx.cs" Inherits="Helsetilsynet.templates.Avenir.Webparts.ManagementConsole" %>
<%-- Register Web Part Managment Console --%>
<%@ Register TagPrefix="WebPartManagement" Namespace="EPiCode.WebParts.EPiChrome" Assembly="EPiCode.WebParts.Core" %>
<%-- Register Core Web Parts --%>
<%@ Register TagPrefix="CoreWebParts" Namespace="EPiCode.WebParts" Assembly="EPiCode.WebParts.Core" %>
<%-- Register more Web Parts --%>
<%@ Register TagPrefix="ht" TagName="LongStringWebPart" Src="~/templates/Avenir/Webparts/Units/LongStringWebPart.ascx" %>
<%@ Register TagPrefix="ht" TagName="Tilsynsrapporter" Src="~/templates/Avenir/Webparts/Units/Tilsynsrapporter.ascx" %>

<%@ Register TagPrefix="ht" TagName="Tilsynssaker" Src="~/templates/Avenir/Webparts/Units/Tilsynssaker.ascx" %>
<%@ Register TagPrefix="ht" TagName="SistPubliserte" Src="~/templates/Avenir/Webparts/Units/SistPubliserte.ascx" %>
<%@ Register TagPrefix="ht" TagName="PageListWebPart" Src="~/templates/Avenir/Webparts/Units/PageListWebPart.ascx" %>
<%@ Register TagPrefix="ht" TagName="RssWebPart" Src="~/templates/Avenir/Webparts/Units/RssControl.ascx" %>
<%-- This will render the editor zone with the fake popup dialog --%>
<WebPartManagement:WebPartManagementConsole ID="WebPartManagementConsole1" Runat="server" />
<asp:CatalogZone runat="server" ID="ThemeCatalogZone"> 
    <ZoneTemplate>
        <%-- Page Catalog --%>
        <asp:DeclarativeCatalogPart runat="server" ID="ThemeDeclarativeCatalog">
            <WebPartsTemplate>
                <%-- Registering your own web parts declaratively --%>
<%--                <CoreWebParts:ImageBanner ID="ImageBannerWP" runat="server" />
                <CoreWebParts:PageListItemView id="PageListItemWP" runat="server" />--%>
                <ht:LongStringWebPart id="LongStringWebPart" runat="server" />
                <%--<CoreWebParts:Divider id="DividerWP" runat="server" />--%>
                <ht:PageListWebPart id="PageListWebPart" runat="server" />
                <ht:SistPubliserte id="SistPubliserte" runat="server" />
                <ht:Tilsynsrapporter id="Tilsynsrapporter" runat="server" />
                <ht:Tilsynssaker id="Tilsynssaker" runat="server" />
                <ht:RssWebPart id="RssWebPart" runat="server" />
            </WebPartsTemplate>
        </asp:DeclarativeCatalogPart>
    </ZoneTemplate>
</asp:CatalogZone>