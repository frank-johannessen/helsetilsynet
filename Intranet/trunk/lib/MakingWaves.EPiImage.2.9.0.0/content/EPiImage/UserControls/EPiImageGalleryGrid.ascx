<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="EPiImageGalleryGrid.ascx.cs" Inherits="MakingWaves.EPiImage.UserControls.EPiImageGalleryGrid" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<style type="text/css">
.EPiImageGalleryGrid {width: 100%; overflow: hidden;}
.EPiImageGalleryGrid .EPiImage {float: left; margin: 5px; overflow: hidden; width: <%= ThumbnailWidth %>px; height: <%=GetHeight()%>px;}
.EPiImageGalleryGrid .EPiImage .Image {width: <%= ThumbnailWidth %>px; height: <%=ThumbnailHeight%>px;}
.EPiImageGalleryGrid .Download {font-size: 12px; font-family: Arial; margin-top: 5px;}
.EPiImageGalleryGrid .Description {font-size: 12px; font-family: Arial; margin-top: 5px;}
</style>

<div class="EPiImageGalleryGrid">
<asp:Repeater ID="repImages" runat="server">
  <ItemTemplate>
    <div class="EPiImage">
    <div class="Image"><EPiImage:EPiImageResizer ID="Resizer" 
        ImageUrl="<%# GetImage(Container.DataItem).ImageURL %>" 
        Alt="<%# GetImage(Container.DataItem).Description %>" 
        LinkURL="<%# GetLink(Container.DataItem) %>" 
        Width="<%# ThumbnailWidth %>" 
        Height="<%# ThumbnailHeight %>" 
        Transformation="<%# Transformation %>"
        runat="server" /></div>
    <% if (ShowDownloadLink)
       { %><div class="Download"><a href="<%# GetImage(Container.DataItem).ImageURL %>"><%= DownloadLinkText %></a></div><% } %>    
    <% if (ShowDescription)
       { %><div class="Description"><%# GetImage(Container.DataItem).Description%></div><% } %>
    </div>
  </ItemTemplate>
</asp:Repeater>
</div>
<asp:Literal ID="litMessage" runat="server" />