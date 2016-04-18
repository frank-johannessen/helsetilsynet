<%@ Control  Language="C#" EnableViewState="true" AutoEventWireup="true" CodeBehind="RssQuery.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.RssQuery" %>
<%@ Register Assembly="Helsetilsynet" Namespace="Avenir" TagPrefix="cc1" %>

<asp:Table ID="Table1" runat="server" BorderStyle="Dotted">
    <asp:TableRow  runat="server">
        <asp:TableCell VerticalAlign="Top" runat="server">Fylke</asp:TableCell>
        <asp:TableCell runat="server"><asp:ListBox Rows="4" SelectionMode="Multiple" ID="Fylke" runat="server" /></asp:TableCell>
            </asp:TableRow>
    <asp:TableRow runat="server">
        <asp:TableCell VerticalAlign="Top" runat="server">Region &nbsp</asp:TableCell>
        <asp:TableCell runat="server"><asp:ListBox Rows="4" SelectionMode="Multiple" ID="Region" runat="server" /></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow runat="server">
        <asp:TableCell VerticalAlign="Top" runat="server">Dokumenttype &nbsp</asp:TableCell>
        <asp:TableCell runat="server"><asp:ListBox Rows="4" SelectionMode="Multiple" ID="Dokumenttype" runat="server" /></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow runat="server">
        <asp:TableCell VerticalAlign="Top" runat="server">Emne</asp:TableCell>
        <asp:TableCell runat="server"><asp:ListBox Rows="4" SelectionMode="Multiple" ID="Emne" runat="server" /></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow runat="server">
        <asp:TableCell VerticalAlign="Top" runat="server">Hovedmenyar</asp:TableCell>
        <asp:TableCell runat="server"><asp:ListBox Rows="4" SelectionMode="Multiple" ID="Menygren" runat="server" /></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow ID="Blank" runat="server">
        <asp:TableCell ID="TableCell1" runat="server">&nbsp</asp:TableCell>
        <asp:TableCell ID="TableCell2" runat="server"></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow ID="TableRow1" runat="server">
        <asp:TableCell ID="TableCell3" runat="server">&nbsp</asp:TableCell>
        <asp:TableCell ID="TableCell4" runat="server">
            <asp:Button ID="BtnCreate" OnClick="BtnCreate_Click" runat="server" Text="Lag lenke" /></asp:TableCell>
    </asp:TableRow>
</asp:Table>

<asp:Panel ID="ResultatPanel" Visible="false" runat="server"><hr />
<div>
    Vær så god, her er lenken: <asp:Literal ID="Resultat" runat="server"></asp:Literal>
</div>
<hr /></asp:Panel>
<br />


