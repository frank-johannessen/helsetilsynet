<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InspectionReportsSection.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.InspectionReportsSection" %>
<div class="section external-link">
    <h2 class="heading"><%= CurrentPage.TilsynsrapporterOverskrift %></h2>
    <asp:HyperLink runat="server" ID="lnkTilsynsrapporter" />
</div>
<div class="section external-link">
    <h2 class="heading"><%= CurrentPage.TilsynssakerOverskrift %></h2>
    <asp:HyperLink runat="server" ID="lnkTilsynssaker" />
</div>
