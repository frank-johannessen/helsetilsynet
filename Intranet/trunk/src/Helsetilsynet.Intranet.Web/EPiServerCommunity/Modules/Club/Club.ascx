<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="Club.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Club" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript" src="Administration.js"></script>

<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" />
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.club")%></h1>
<div id="tabStrip">
    <ComponentArt:TabStrip ID="tabStripClubs" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageClubs" runat="server">
        <ItemLooks>
            <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
            <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
        </ItemLooks>
        <Tabs>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabSearchClubs">
            </ComponentArt:TabStripTab>
            <ComponentArt:TabStripTab runat="server" ID="tabStripTabApproveClubs">
            </ComponentArt:TabStripTab>
        </Tabs>
    </ComponentArt:TabStrip>
    <ComponentArt:MultiPage ID="multiPageClubs" CssClass="multiPage" runat="server" >
        <ComponentArt:PageView runat="server" ID="pageViewSearchClubs" />
        <ComponentArt:PageView runat="server" ID="pageViewApproveClubs">
            <ComponentArt:TabStrip ID="tabStripApproveClubs" CssClass="subGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageApproveClubs" runat="server">
                <ItemLooks>
                    <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                    <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
                </ItemLooks>
                <Tabs>
                    <ComponentArt:TabStripTab runat="server" Value="notApproved" ID="tabStripTabNotApprovedClubs">
                    </ComponentArt:TabStripTab>
                    <ComponentArt:TabStripTab runat="server" Value="approved" ID="tabStripTabApprovedClubs">
                    </ComponentArt:TabStripTab>
                </Tabs>
            </ComponentArt:TabStrip>
            <ComponentArt:MultiPage ID="multiPageApproveClubs" CssClass="multiPage" runat="server" />
        </ComponentArt:PageView>
    </ComponentArt:MultiPage>
</div>
