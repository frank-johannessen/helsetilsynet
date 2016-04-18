<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master"
    CodeBehind="Tilsynssaker.aspx.cs" AutoEventWireup="true" Inherits="Avenir.Templates.Pages.Tilsynssaker" %>

<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.Helpers" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.PropertyMappings" %>
<%@ Register TagPrefix="ht" TagName="PageBody" Src="~/templates/Avenir/Units/Placeable/PageBody.ascx" %>
<%@ Register TagPrefix="ht" TagName="Pager" Src="~/templates/Avenir/Units/Placeable/Pager.ascx" %>
<%@ Register TagPrefix="ht" TagName="SearchSummary" Src="~/templates/Avenir/Units/Placeable/SearchSummary.ascx" %>
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
                    <!--Undersøkelsessaker - Varsel OM alvorlig hendelse etter spesialisthelsetjenesteloven §3-3a-->
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerUndersokelsessaker) %>">
                        <h3 class="accordion-header">
                           Undersøkelsessaker
                           <br/> 
                           <span style="font-weight:normal;">Varsel om alvorlig hendelse etter spesialisthelsetjenesteloven § 3-3a.</span>
                           <span class="icon-arrow-right"></span>
                        </h3>
                        <div id="Div6" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="Undersokelsessaker" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                      
                    </div>
                    
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerVirksomheterList) %>">
                        <h3 class="accordion-header">
                            
                            Virksomhetssaker<span class="icon-arrow-right"></span>
                        </h3>
                        <div id="Div3" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="virksomheter" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                      
                    </div>
                    
                     <!--Virksomhets- og individsaker-->
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerVirksomhetsIndividSaker) %>">
                        <h3 class="accordion-header">
                            
                            Virksomhets- og individsaker<span class="icon-arrow-right"></span>
                        </h3>
                        <div id="Div7" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="VirksomhetIndividSaker" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                      
                    </div>

                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerHpCategoriList) %>">
                        <h3 class="accordion-header">
                            Helsepersonellkategori<span class="icon-arrow-right"></span></h3>
                        <div id="Div4" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="hpKategori" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div> 
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerYearList) %>">
                        <h3 class="accordion-header">
                            Vedtaksår<span class="icon-arrow-right"></span></h3>
                        <div id="Div5" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="tYear" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                        
                    </div>


                    <!-- end .leftCol -->
                </div>
                <div class="rightCol">
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerVurderingList) %>">
                        <h3 class="accordion-header">
                            Vurderingsgrunnlag<span class="icon-arrow-right"></span></h3>
                        <div id="Div2" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="vurdering" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                       
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerReaksjonList) %>">
                       <h3 class="accordion-header">
                            Reaksjonstype<span class="icon-arrow-right"></span></h3>
                        <div id="Div1" class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="reaksjon" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
                        </div>
                        
                    </div>
                    <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.TilsynssakerTjenesteList) %>">
                       <h3 class="accordion-header">
                            Tjenesteområde<span class="icon-arrow-right"></span></h3>
                        <div class="searchDrillDown accordion-tab-content" runat="server">
                            <asp:CheckBoxList ID="tjeneste" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
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
                    <ht:SearchSummary runat="server" ID="searchSummary" />
                </p>
                <div class="orderCriteria">
                    <span>Sorter etter:</span>
                    <asp:DropDownList AutoPostBack="true" ID="Sortby" OnSelectedIndexChanged="Button1_Click"
                        runat="server" />
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
