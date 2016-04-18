<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrintPdfButton.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.PrintPdfButton" %>
<%@ Register TagPrefix="ht" TagName="pdf" Src="~/Templates/Units/Placeable/GeneratePDF.ascx" %>

<%--<a href="dummy" class="action pdf">Lag PDF</a>--%>

<ht:pdf runat="server" ID="pdfConverter" LinkText="Lag PDF" />