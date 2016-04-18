<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApproveVideosControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ApproveVideosControl" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" src="Administration.js"></script>

<script language="javascript" src="js/StarSuite.js"></script>

<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />

<script language="javascript">
function TabSelected(sender, args)
    {
        var tabIndex = args.get_tab().get_index();
        
        if(navigator.appName.indexOf('Microsoft') > -1)
        {
            if(tabIndex == 0)
                document.getElementById('<% = multiPageApproveVideos.PageViews[0].Controls[0].FindControl("buttonReload").ClientID %>').click();
            else if(tabIndex == 1)
                document.getElementById('<% = multiPageApproveVideos.PageViews[1].Controls[0].FindControl("buttonReload").ClientID %>').click();
            else if(tabIndex == 2)
                document.getElementById('<% = multiPageApproveVideos.PageViews[2].Controls[0].FindControl("buttonReload").ClientID %>').click();
        }
        else
        { 
            var evObj = document.createEvent('MouseEvents');
            evObj.initEvent( 'click', true, true );

            if(tabIndex == 0)
                document.getElementById('<% = multiPageApproveVideos.PageViews[0].Controls[0].FindControl("buttonReload").ClientID %>').dispatchEvent(evObj);
            else if(tabIndex == 1)
                document.getElementById('<% = multiPageApproveVideos.PageViews[1].Controls[0].FindControl("buttonReload").ClientID %>').dispatchEvent(evObj);
            else if(tabIndex == 2)
                document.getElementById('<% = multiPageApproveVideos.PageViews[2].Controls[0].FindControl("buttonReload").ClientID %>').dispatchEvent(evObj);
        }
    }
</script>

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.videogallery")%></h1>
<div id="tabStrip">
    <ComponentArt:TabStrip ID="tabStripApproveVideos" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageApproveVideos" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
        </ItemLooks>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageApproveVideos" CssClass="multiPage" runat="server" />
</div>
