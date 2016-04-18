<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.StartPage" %>
<%@ Import Namespace="MakingWaves.Common.Web" %>

<%@ Register tagPrefix="ht" tagName="losenIndex" src="~/Templates/Units/Static/LosenAlphabethicalIndex.ascx" %>
<%@ Register tagPrefix="ht" tagName="featured" src="~/Templates/Units/Placeable/FeaturedArticles.ascx" %>
<%@ Register tagPrefix="ht" tagName="mediawatch" src="~/Templates/Units/Static/MediaWatch.ascx" %>
<%@ Register tagPrefix="ht" tagName="activityFeed" src="~/Templates/Units/Static/ActivityFeed.ascx" %>
<%@ Register tagPrefix="ht" tagName="rss" src="~/Templates/Units/Placeable/RSS.ascx" %>

<%@ Register TagPrefix="Relate" TagName="CalendarFullVersion" Src="~/Templates/Units/Placeable/CalendarFullVersion.ascx" %>
<%@ Register TagPrefix="Relate" TagName="CalmeyersCorner" Src="~/Templates/Units/Placeable/CalmeyersCorner.ascx" %>
<%@ Register tagPrefix="Relate" tagName="UserSearchShortVersion" src="~/Templates/Units/Placeable/UserSearchShortVersion.ascx" %>

<%--<%@ Register tagPrefix="dummy" tagName="FilteredUserAndCompetenceLinks" src="~/Templates/Units/Dummy/FilteredUserAndCompetenceLinks.ascx" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='<%= Assets.Styles.GetUrl("activityFeed.css") %>' rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../styles/rcarousel.css" />
    
    <script src="../../Scripts/json2.js" type="text/javascript"></script>
    <script src="../../Scripts/knockout-2.1.0.js" type="text/javascript"></script>
    <script src="../../Scripts/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="../../Scripts/activityFeed.js" type="text/javascript"></script>
    <script src="../../Scripts/moment.js" type="text/javascript"></script>

    <script type="text/javascript" src="../scripts/lib/jquery.ui.core.js"></script>
    <script type="text/javascript" src="../scripts/lib/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="../scripts/lib/jquery.ui.rcarousel.js"></script>
    <!--[if IE 9]>
        <script type="text/javascript" src="/Templates/scripts/alphabetical-index-columns.js"></script>
    <![endif]-->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ht:featured runat="server" ID="featured" Title="Interninfo" />
    <ht:losenindex runat="server" />

    <div class="section main-content">
        <div class="section feeds">
            <h2>Nyhetsstrøm på Losen</h2>
            <ht:activityFeed ID="activityFeed" runat="server" CssClass="tabbody" />
            <h2>Nyhetsstrøm på Helsetilsynet.no</h2>
            <ht:rss ID="rssFrontPage" runat="server" CssClass="tabbody" />
        </div>
        <Relate:CalendarFullVersion ID="CalendarFullVersion1" runat="server" />
    </div>
    <div class="aside">
        <Relate:UserSearchShortVersion runat="server" />
        <ht:mediawatch runat="server" />
        <Relate:CalmeyersCorner runat="server" />
    </div>
    <script type="text/javascript" src="../scripts/frontpage-carousel.js"></script>
    <script type="text/javascript" src="../scripts/lib/jquery.tabs.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.section.feeds').accessibleTabs({ tabhead: 'h2', fx: 'fadeIn', currentInfo: 'Viser' }).addClass('tabbed');
            $('.section.feeds .tabs-list').wrap($('<div class="tabs-wrapper"/>'));
            $('.alphabetical-index .links')
        });
    </script>
    <!--[if IE 9]>
        <script type="text/javascript">
            $(document).ready(function () {
                $('.alphabetical-index .links').splitToColumns(3);
            });
        </script>
    <![endif]-->

</asp:Content>
