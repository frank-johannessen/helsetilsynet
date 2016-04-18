<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" EnableViewState="true" AutoEventWireup="true" CodeBehind="LargeDocument.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.LargeDocument" %>
<%@ Register TagPrefix="ht" TagName="LeftMenu" Src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>
<%@ Register TagPrefix="ht" TagName="lastUpdated" Src="~/Templates/Units/Static/LastUpdated.ascx" %>
<%@ Register tagPrefix="ht" tagName="author" src="../Units/Placeable/ResponsibleAuthor.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="section main-content" id="main-content">
        <h1><EPiServer:Property runat="server" PropertyName="PageName" /></h1>

        <EPiServer:Property runat="server" PropertyName="MainIntro" CssClass="main-intro" />
        
        
        <div class="table-of-contents">
            <a href="<%= GetDetailsLinkUrl() %>"><%= GetDetailsLinkText() %></a>
            <EPiServer:PageTree PageLink="<%# CurrentPage.PageLink %>" ID="ptLargeDocumentToc" runat="server" ExpandAll="True" NumberOfLevels="<%# GetDisplayNumberOfLevels() %>" ShowRootPage="False" >
                <HeaderTemplate>
                    <div class="largeDocumentToc">
                </HeaderTemplate>
                <IndentTemplate>
                    <ol>
                </IndentTemplate>
                <ItemHeaderTemplate>
                    <li class="level<%# GetLargeDocumentChapterLevel(Container.DataItem) %>">
                </ItemHeaderTemplate>
                <ItemFooterTemplate>
                    </li>
                </ItemFooterTemplate>
                <ItemTemplate>
                    <a href="<%# Container.CurrentPage.LinkURL %>"><asp:PlaceHolder runat="server" Visible="<%# GetLargeDocumentChapterNumber(Container.DataItem) != String.Empty %>"><span class="chapter-number"><%# GetLargeDocumentChapterNumber(Container.DataItem) %></span> </asp:PlaceHolder><span class="chapter-name"><%# GetLargeDocumentChapterPageNameWithoutChapterNumber(Container.DataItem) %></span></a>
                </ItemTemplate>
                <UnindentTemplate>
                    </ol>
                </UnindentTemplate>    
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </EPiServer:PageTree> 
        </div>
    </div>
    <ht:LeftMenu runat="server" />

    <div class="aside">
        
        <div class="section">
            <h2 class="heading"><%= Translate("/general/lastupdated")%></h2>
            <ht:lastUpdated runat="server" />
            <ht:author ID="author" runat="server" UserName="<%# CurrentPage.ResponsibleAuthor %>" />
        </div>

    </div>


</asp:Content>
