<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="Section.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.Section" %>
<%@ Import Namespace="Relate.HelpersAndExtensions" %>
<%@ Register tagPrefix="ht" tagName="teaser" src="~/Templates/Units/Placeable/ArticleTeaser.ascx" %>
<%@ Register tagPrefix="Relate" tagName="Calendar" src="~/Templates/Units/Placeable/MinimalCalendarView.ascx" %>
<%@ Register tagPrefix="Relate" tagName="UserSearchShortVersion" src="~/Templates/Units/Placeable/UserSearchShortVersion.ascx" %>
<%@ Register tagPrefix="ht" tagName="LeftMenu" src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>
<%@ Register TagPrefix="ht" TagName="SectionLastPublished" Src="~/Templates/Units/Placeable/SectionLastPublished.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../scripts/lib/stickyfloat.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper">
        <h1 class="heading"><%= CurrentPage.Heading %></h1>

        <div class="featured">
            <asp:Repeater runat="server" ID="rptSelectedArticles">
                <HeaderTemplate><ul class="articles"></HeaderTemplate>
                <ItemTemplate>
                    <li><ht:teaser ID="Teaser1" runat="server" Article="<%# Container.DataItem %>" ShortTextLength="90" LongTextLength="120" /></li>
                </ItemTemplate>
                <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>
        </div>

        <div class="section main-content">
            <ht:SectionLastPublished runat="server"/>
        </div>
        <div class="aside">
            <Relate:UserSearchShortVersion runat="server" />
            <div class="section section-calendar">
                <h2 class="heading"><%= Translate("/calendar/calendaractivity")%></h2>
                <Relate:Calendar runat="server" ID="ucCalendar" PageSize="5" PagePosition="1" ShowAddEventButton="True" />
                <a href="<%= RelateTemplatePage<RelateGlobalSettings>.CalendarYearOverview.LinkURL %>" class="all-events-link" title="<%= Translate("/calendar/seeall") %>" ><%= Translate("/calendar/seeall") %></a>
            </div>
            
            <div class="freetextcontent">
                <EPiServer:Property ID="Property2" runat="server" PropertyName="RightContent"/>    
            </div>
        </div>
    
    </div>
    <ht:LeftMenu runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('.aside.nav').first().stickyfloat({ delay: 0, duration: 20, easing: 'swing' });
        });
    </script>
    <script type="text/javascript" src="../scripts/lib/jquery.tabs.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.section.feeds').accessibleTabs({ tabhead: 'h2', fx: 'fadeIn', currentInfo: 'Viser' }).addClass('tabbed');
            $('.section.feeds .tabs-list').wrap($('<div class="tabs-wrapper"/>'));

        });
    </script>
</asp:Content>
