<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="Article.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.Article" %>
<%@ Register tagPrefix="ht" tagName="author" src="../Units/Placeable/ResponsibleAuthor.ascx" %>
<%@ Register tagPrefix="ht" tagName="lastUpdated" src="../Units/Static/LastUpdated.ascx" %>
<%@ Register tagPrefix="ht" tagName="CMSPageEntityComments" src="../Units/Static/CMSPageEntityComments.ascx" %>

<%@ Register TagPrefix="EPiImage" TagName="EPiImageResizer" Src="~/EPiImage/UserControls/EPiImageResizer.ascx" %>
<%@ Register TagPrefix="ht" TagName="LeftMenu" Src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../scripts/lib/stickyfloat.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="section main-content">
        <!--googleoff: snippet-->
        <h1 class="heading"><%= CurrentPage.Heading %></h1>
        <!--googleon: snippet-->
        <EPiServer:Property ID="Property1" runat="server" PropertyName="MainIntro" CustomTagName="p" CssClass="main-intro" />
        <%--<EPiImage:EPiImageResizer ID="imgMainImage" Width="512" Transformation="ScaleToFit" runat="server" CssClass="floatright" /> 
        Main Image is now only for teasers and to represent the article, not to show on the article itself--%>
        <EPiServer:Property ID="Property3" runat="server" PropertyName="MainBody" CssClass="article-body" />
        <asp:HyperLink runat="server" ID="lnkAttachment" CssClass="doc-link">lenke til vedlegg</asp:HyperLink>
        
        <ht:CMSPageEntityComments runat="server" ID="ucComments" Visible ="False" />
    </div>
    <div class="aside">
        <div class="section">
            <h2 class="heading"><%= Translate("/general/lastupdated")%></h2>
            <ht:lastUpdated runat="server" />
            <ht:author ID="responsibleAuthor" runat="server" UserName="<%# CurrentPage.ResponsibleAuthor %>" />
            <%--<p>Revideres: <%= GetToBeRevised() %></p>--%>
        </div>
        
        <div class="freetextcontent">
            <EPiServer:Property ID="Property2" runat="server" PropertyName="RightContent"/>    
        </div>
    </div>
    
    <ht:LeftMenu runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('.aside.nav').first().stickyfloat({delay: 0, duration: 20, easing: 'swing'});
        });
    </script>
</asp:Content>
