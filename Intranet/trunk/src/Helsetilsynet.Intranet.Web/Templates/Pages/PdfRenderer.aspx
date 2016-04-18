<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/PdfView.Master" AutoEventWireup="true" CodeBehind="PdfRenderer.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.PdfRenderer" %>
<%@ Register TagPrefix="ht" TagName="RenderLargeDocument" src="~/Templates/Units/Placeable/PdfRenderLargeDocument.ascx" %>
<%@ Register TagPrefix="ht" TagName="RenderArticle" src="~/Templates/Units/Placeable/PdfRenderArticle.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:PlaceHolder runat="server" ID="plhHeader">
    <div class="header">
        <img alt="Logo Image" src="/Templates/styles/images/pdf-logo2.png" />
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="plhFooter">
    <div class="footer">
        &nbsp;
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="plhContent">
    <ht:RenderLargeDocument runat="server" ID="RenderLargeDocument" Visible="False" />
    <ht:RenderArticle runat="server" ID="RenderArticle" Visible="False" />
</asp:PlaceHolder>
</asp:Content>
