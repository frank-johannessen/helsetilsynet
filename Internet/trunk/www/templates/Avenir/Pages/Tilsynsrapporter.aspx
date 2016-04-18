<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master"
    CodeBehind="Tilsynsrapporter.aspx.cs" AutoEventWireup="true" Inherits="Avenir.Templates.Pages.Tilsynsrapporter" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.Helpers" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.PropertyMappings" %>

<%@ Register TagPrefix="ht" TagName="PageBody" Src="~/templates/Avenir/Units/Placeable/PageBody.ascx" %>
<%@ Register TagPrefix="ht" TagName="Pager" Src="~/templates/Avenir/Units/Placeable/Pager.ascx" %>
<%@ Register TagPrefix="ht" TagName="SearchSUmmary" Src="~/templates/Avenir/Units/Placeable/SearchSummary.ascx" %>
<%@ Register tagPrefix="ht" tagName="LimitText" src="~/templates/Avenir/Units/Placeable/LimitTextAndLinkForSearch.ascx" %>
<asp:Content ID="AllArea" ContentPlaceHolderID="WideArea" runat="server">
    <div id="innerWrapper" class="twoCols">
        <div id="left">
            <div class="framedBox">
                <ht:LimitText runat="server" />
                <div class="reportSearch">
                    <asp:TextBox ID="Sok" CssClass="searchBox" TabIndex="1" runat="server" />
                    <asp:Button ID="Button1" CssClass="searchButton" runat="server" TabIndex="2" OnClick="Button1_Click"
                        Text="<%$ Resources: EPiServer, navigation.search %>" /><br />
                </div>
                <div class="leftCol">
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterFylkeList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["CountyTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Fylke" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                       
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterYearList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["YearTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Year" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                        
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterRegionList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["RegionTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Region" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                        
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterInstitutionList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["InstitutionTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Institution" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                       
                    </div>
                    <!-- end .leftCol -->
                </div>
                <div class="rightCol">
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterCountryWideList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["CountryWideTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="CountryWide" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                       
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynrapporterCategoriesList) %>">
                        <h3 class="accordion-header">
                            <%=((EPiServer.PageBase)Page).CurrentPage.Property["CategoriesTxt"]%><span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown  accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Categories" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                       
                    </div>
                    <!-- end .rightCol -->
                </div>
                <!-- end .framedBox -->
            </div>
            <!-- end #left -->
        </div>
        <div id="main">
            <h1>
                <%= Heading %></h1>
            <div class="resultHead" id="resultHead" runat="server" visible="false">
                <p>
                    <ht:SearchSUmmary runat="server" ID="searchSummary" />
                </p>
                <div class="orderCriteria">
                    <span>Sorter etter:</span>
                    <asp:DropDownList AutoPostBack="true" ID="Sortby" OnSelectedIndexChanged="Button1_Click" runat="server" />
                </div>
            </div>
            <asp:Literal ID="Resultatet" runat="server" />
            <ht:Pager ID="Pager" runat="server" Visible="false" />
            <p class="ingress">
                <EPiServer:Property ID="MainIntro" PropertyName="MainIntro" DisplayMissingMessage="false"
                    EnableViewState="false" runat="server" />
            </p>
            <ht:PageBody ID="PageBody" runat="server" />
            <!-- end #main -->
        </div>
        <!-- end #innerWrapper -->
    </div>
</asp:Content>
