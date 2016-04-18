<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchFilter.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.SearchFilter" %>


<!-- <asp:Literal runat="server" ID="tempLiteral"></asp:Literal> -->

<h2>Avgrens</h2>
<div class="text-filter">
    <asp:TextBox runat="server" ID="tbxSearchString"></asp:TextBox>
    <asp:Button runat="server" ID="btnSubmit" Text="Søk" />
</div>

<div class="reports-filter">
    <asp:CheckBox runat="server" ID="chbRemoveInspectionReports" AutoPostBack="True" Text="Fjern tilsynsrapporter fra trefflisten" />
</div>

<h3>Tjenester</h3>

<asp:CheckBoxList runat="server" ID="cblCategoryList" AutoPostBack="True" CssClass="search-filter-kategori" RepeatLayout="UnorderedList"></asp:CheckBoxList>

<h3>Dokumenttype</h3>
<asp:CheckBoxList runat="server" ID="cblDocumentTypeList" AutoPostBack="True" CssClass="search-filter-dokumenttype" RepeatLayout="UnorderedList"></asp:CheckBoxList>

<h3>År</h3>
<asp:CheckBoxList runat="server" ID="cblYearList" CssClass="search-filter-year" AutoPostBack="True" RepeatLayout="OrderedList"/>

<h3>Nettsted</h3>
<asp:CheckBoxList runat="server" ID="cblCollections" AutoPostBack="True" RepeatLayout="OrderedList"/>