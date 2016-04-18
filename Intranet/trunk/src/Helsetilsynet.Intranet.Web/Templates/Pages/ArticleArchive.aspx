<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="ArticleArchive.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.ArticleArchive" %>
<%@ Register src="../Units/Placeable/ArticleArchiveSearchFilter.ascx" tagPrefix="ht" tagName="ArticleArchiveSearchFilter" %>
<%@ Register src="../Units/Placeable/ResultPager.ascx" tagPrefix="ht" tagName="pager" %>
<%@ Register tagPrefix="ht" tagName="tags" src="../Units/Placeable/Tags.ascx" %>
<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Util.GoogleMini" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="main-content section">
        <h1><span><%= CurrentPage.Heading %></span></h1>
        <div class="articles">
            <asp:Repeater ID="rptArticles" runat="server">
                <HeaderTemplate>
                    <ul class="articles-list">
                </HeaderTemplate>
                <ItemTemplate>
                    <li class="article">
                        <ht:tags ID="Tags1" runat="server" Categories="<%# ((ResultElement)Container.DataItem).CatIds %>" />
                        <a href="<%# ((ResultElement)Container.DataItem).Url %>">
                        <EPiImage:EPiImageResizer ImageUrl="<%# GetImageUrlFromPage((ResultElement)Container.DataItem) %>" 
                          Width="60" 
                          Height="60" 
                          Transformation="ScaleToFit" 
                          runat="server" />
<%--
                            <img style="max-height: 60; max-width: 60" src="<%# GetImageUrl((ResultElement)Container.DataItem) %>" />
--%>
                            <h2 class="heading">
                                <%# ((ResultElement)Container.DataItem).Title %>
                            </h2>
                            <span class="pubdate" title="<%# ((ResultElement)Container.DataItem).Date.FormatToShortDateString() %>"><%#  ((ResultElement)Container.DataItem).Date.FormatToShortDateString()%></span>
                            <p class="body"><%# ((ResultElement)Container.DataItem).Description  %></p>
                        </a>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <ht:pager runat="server" ID="pager" />
    </div>

    <div class="filters aside">
        <ht:ArticleArchiveSearchFilter ID="htArticleArchiveSearchFilter" runat="server" />
    </div>
</asp:Content>
