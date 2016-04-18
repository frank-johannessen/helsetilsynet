<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="LargeDocumentChapter.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.LargeDocumentChapter" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Model" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common" %>

<%@ Register TagPrefix="ht" TagName="LeftMenu" Src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>
<%@ Register tagPrefix="ht" tagName="LeftMenu2" src="~/Templates/Units/Placeable/LeftMenuLargeDocuments.ascx" %>
<%@ Register tagPrefix="ht" tagName="LargeDocumentChapterNavigation" src="~/Templates/Units/Placeable/LargeDocumentChapterNavigation.ascx" %>

<%@ Register tagPrefix="ht" tagName="pdf" src="~/Templates/Units/Placeable/GeneratePDF.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
    <div class="section main-content" id="main-content">
        
        <h1><%= LargeDocumentHelper.GetMainDocumentPage(CurrentPage).PageName %></h1>
        
        <ht:LargeDocumentChapterNavigation runat="server"/>
        
        <h2><%= CurrentPage.PageName %></h2>
        <EPiServer:Property  runat="server" PropertyName="MainBody" CssClass="article-body" />
    
        <EPiServer:PageTree runat="server" PageLink="<%#CurrentPage.PageLink%>" ShowRootPage="false" NumberOfLevels="4" ExpandAll="True" >
            <ItemTemplate>
                <h3 class="heading<%#(((LargeDocumentChapter)Container.DataItem)).GetChapterLevel() %>"><%# (((LargeDocumentChapter)Container.DataItem).ChapterNumber)%> <%# (((LargeDocumentChapter)Container.DataItem).PageNameWithoutChapterNumber)%></h3>
                <div class="article-body">
                    <EPiServer:Property runat="server" PropertyName="MainBody" />
                </div>
            </ItemTemplate>
       </EPiServer:PageTree>
       
       <ht:LargeDocumentChapterNavigation runat="server"/>


        <a href="#main-content" class="top-link"><%= Translate("/general/totop") %></a>
    </div>
    

    <ht:LeftMenu2 ID="LeftMenu2" runat="server"/>
   

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderPopup" runat="server">
</asp:Content>

