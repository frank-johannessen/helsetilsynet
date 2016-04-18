<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ArticleTeaser.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.ArticleTeaser" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Register TagPrefix="ht" TagName="tags" Src="~/Templates/Units/Placeable/Tags.ascx" %>

<div class="article">
    <a href="<%= Article.LinkURL %>" class="article-link">
        <EPiImage:EPiImageResizer ID="imgMainImage" Width="90" Height="90" Transformation="ScaleToFill" runat="server" CssClass="floatright" />
        <span class="pubdate">
            <span class="date"><%= Article.StartPublish.FormatToShortDateString()%></span>
            <span class="time"><%= Article.StartPublish.ToString("HH:mm") %></span>
        </span>
        <p class="heading"><%= Article.Heading %></p>
        <p class="short-text"><%= CroppedTextFirst %> <%= CroppedTextSecond %></p>
    </a>
    <asp:HyperLink runat="server" Visible="<%# !string.IsNullOrEmpty( Article.AttachedDocument) %>" CssClass="doc-link" NavigateUrl="<%# Article.AttachedDocument %>"><%= Translate("/general/linktodocument")%></asp:HyperLink>
    <ht:tags runat="server" ID="tags" />
</div>