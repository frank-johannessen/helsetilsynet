<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoGalleryControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.VideoGalleryControl" %>
<%@ Register TagPrefix="sc" TagName="VideoListControl" Src="VideoListControl.ascx" %>
<asp:Panel ID="panelMain" runat="server" Visible="false">
	<asp:PlaceHolder ID="placeHolderVideoGallery" Runat="server">
        <sc:VideoListControl ID="ctlVideoListControl" runat="server" />
    </asp:PlaceHolder>
</asp:Panel>