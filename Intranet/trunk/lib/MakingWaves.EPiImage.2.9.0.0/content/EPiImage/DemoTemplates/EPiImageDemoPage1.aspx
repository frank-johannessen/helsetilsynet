<%@ Page Language="C#" AutoEventWireup="False" MasterPageFile="~/Templates/AlloyTech/MasterPages/MasterPage.master" Inherits="EPiServer.TemplatePage" %>
<%-- CMS 6 R1: <%@ Page Language="C#" AutoEventWireup="False" MasterPageFile="~/Templates/Public/MasterPages/MasterPage.master" Inherits="EPiServer.TemplatePage" %>--%>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageGalleryViewer" Src="~/EPiImage/UserControls/EPiImageGalleryViewer.ascx" %>
<asp:Content ContentPlaceHolderID="MainRegion" runat="server">

	<div id="StageArea" class="StartPage">
	<div style="margin: 40px;">
	
	<h1><EPiServer:Property ID="Heading" PropertyName="Heading" runat="server" /></h1>
	
	<div style="overflow: hidden;">
	<div style="float: left;">
	<EPiImage:EPiImageResizer ID="EPiImageProperty" PropertyName="EPiImageProperty" Width="200" Height="200" Transformation="ScaleToFit" runat="server" />
	<div style="padding-top:5px; font-style: italic; font-size: 13px; line-height: 13px;">
	<%= (CurrentPage.Property["EPiImageProperty"] as MakingWaves.EPiImage.EPiImageProperty).ImageDescription %>
	
	</div>
	
	</div>
  <div style="float: left; padding-left: 30px; font-size: 13px; width: 600px;">
  <EPiServer:Property ID="MainBody" PropertyName="MainBody" runat="server" />
	</div>
	</div>
	
  <h2><EPiServer:Property ID="GalleryName" PropertyName="GalleryName" runat="server" /></h2>
  <div style="margin-left: 150px;">
  <EPiImage:EPiImageGalleryViewer id="EPiImageGalleryProperty" PropertyName="EPiImageGalleryProperty" runat="server" /></div>
  
 
  
  </div>
	</div>
	

</asp:Content>

