<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/PdfView.Master" AutoEventWireup="true" CodeBehind="PdfRenderer.aspx.cs" Inherits="Helsetilsynet.templates.Avinir.Units.Placeable.LargeDocuments.Pages.PdfRenderer" %>
<%@ Register TagPrefix="ht" TagName="RenderLargeDocument" src="~/templates/Avenir/Units/Placeable/LargeDocuments/PdfRenderLargeDocument.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:PlaceHolder runat="server" ID="plhHeader">
    <div class="header">
        <img alt="Logo Image" src="/Templates/Avenir/images/pdf-logo2.png" />
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="plhFooter">
    <div class="footer">
        &nbsp;
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="plhContent">
    <ht:RenderLargeDocument runat="server" ID="RenderLargeDocument" Visible="False" />
</asp:PlaceHolder>
</asp:Content>
