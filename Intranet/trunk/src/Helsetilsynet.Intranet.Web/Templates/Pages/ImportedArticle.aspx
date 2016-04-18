<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="ImportedArticle.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.ImportedArticle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h1><%= string.IsNullOrEmpty(CurrentPage.PageHeader) ? CurrentPage.PageName : CurrentPage.PageHeader %></h1>
    <EPiServer:Property runat="server" PropertyName="MainIntro"/>
    <EPiServer:Property runat="server" PropertyName="MainBody"/>
    
</asp:Content>
