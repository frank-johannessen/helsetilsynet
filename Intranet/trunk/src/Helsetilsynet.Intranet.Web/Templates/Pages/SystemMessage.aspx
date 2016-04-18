<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="SystemMessage.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.SystemMessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <EPiServer:Property runat="server" PropertyName="MainBody" />
</asp:Content>
