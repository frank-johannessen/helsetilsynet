<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="ClubListPage.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.ClubListPage" %>
<%@ Register tagPrefix="Relate" tagName="AddNewClub" src="~/Templates/Units/Placeable/AddNewClub.ascx" %>
<%@ Register TagPrefix="ht" TagName="pager" Src="~/Templates/Units/Placeable/ResultPager.ascx" %>
<%@ Import Namespace="EPiServer.Community.Club" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.Constants" %>
<%@ Import Namespace="Relate.HelpersAndExtensions.ExtensionMethods" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="section main-content">
        <h1 class="heading"><span><%= Translate("/club/list-heading") %></span></h1>
    <asp:ListView ID="lvClubs" ItemPlaceholderID="pnlItemContainer" runat="server"  >
        <LayoutTemplate>
            <ul class="projects-list"><asp:Panel ID="pnlItemContainer" runat="server" /></ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li class="project">
                <a href="<%# ((Club)Container.DataItem).GetClubUri() %>"  title="<%# ((Club)Container.DataItem).Header %>">
                    <img src="<%# ((Club)Container.DataItem).GetPresentationImageUri(Enums.ImageSize.Large) %>" alt="<%# ((Club)Container.DataItem).Header %>" />
                    <h2 class="heading"><%# ((Club)Container.DataItem).Header %></h2>
                    <dl>
                        <dt><%= Translate("/general/admin") %></dt>
                        <dd><%# ((Club)Container.DataItem).Owner.GetPresentationName() %></dd>
                        <dt><%= Translate("/club/description") %></dt>
                        <dd><%# ((Club)Container.DataItem).Body %></dd>
                        <dt><%= Translate("/club/period") %></dt>
                        <dd><%# ((Club)Container.DataItem).GetProjectPeriod()%></dd>
                    </dl>
                </a>
            </li>
        </ItemTemplate>      
    </asp:ListView>
    <ht:pager runat="server" ID="pager" />
    </div>
    <div class="aside">
    <asp:Button ID="btnCreateClub" CssClass="button-add-club" runat="server" OnClick="btnCreateClub_OnClick" Text="<%$ Resources: EPiServer, createclub.create %>" />
    <relate:AddNewClub runat="server" ID="ucAddNewClub" Visible="False" />
    </div>
</asp:Content>
