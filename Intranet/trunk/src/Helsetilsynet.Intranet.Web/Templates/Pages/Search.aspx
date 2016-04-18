<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.Search" %>
<%@ Register src="../Units/Placeable/SearchFilter.ascx" tagPrefix="ht" tagName="SearchFilter" %>
<%@ Register src="../Units/Placeable/SearchResult.ascx" tagPrefix="ht" tagName="SearchResult" %>
<%@ Register src="../Units/Static/InspectionReportsSection.ascx" tagPrefix="ht" tagName="InspectionReportsSection" %>
<%@ Register src="../Units/Static/SearchHelp.ascx" tagPrefix="ht" tagName="SearchHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="section main-content">
        <h1 class="heading"><span><%= Translate("/SearchFilter/searchresult")%></span></h1>
        <ht:SearchResult runat="server" ID="htSearchResult"/>
    </div>
    <div class="aside filters">
        <ht:SearchFilter ID="htSearchFilter" runat="server" />
    </div>
    <div class="secondary aside">
        <ht:InspectionReportsSection runat="server" />
        <ht:SearchHelp runat="server" />
    </div>
    <script type="text/javascript" src="/Templates/scripts/search.js"></script>
    <script type="text/javascript">
        var losen = losen || {};
        losen.searchResult = losen.searchResult || {};
        losen.searchResult.resultCountUrl = '/WebServices/SearchService.asmx/SearchCount'; 
    </script>
</asp:Content>
