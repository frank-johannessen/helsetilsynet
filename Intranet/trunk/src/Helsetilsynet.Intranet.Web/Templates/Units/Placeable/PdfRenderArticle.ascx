<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PdfRenderArticle.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.PdfRenderArticle" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>

<div class="pdf-body section main-content">
    <h1 class="heading"><%= Article.Heading %></h1>
    <p class="main-intro"><%= Article.MainIntro %></p>
    <%--<EPiImage:EPiImageResizer ID="imgMainImage" Width="512" Transformation="ScaleToFit" runat="server" CssClass="floatright" /> this prop is only for showing main image as an icon, not to show on article--%>
    <EPiServer:Property runat="server" PropertyName="MainBody" PageLink="<%# Article.PageLink %>"/>
</div>
