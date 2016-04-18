<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ApproveClubMemberControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ApproveClubMemberControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>

<script language="javascript" src="Administration.js"></script>
<!--<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />-->

<div id="tabStrip">
	<ComponentArt:TabStrip id="tabStripApproveClubMembers" 
	CssClass="subGroup"
	DefaultItemLookId="DefaultTabLook"
	DefaultSelectedItemLookId="SelectedTabLook"
	DefaultDisabledItemLookId="DisabledTabLook"
	DefaultGroupTabSpacing="0"
	ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
	MultiPageId="multiPageApproveClubMembers"
	runat="server">
	<ItemLooks>
		<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
		<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
	</ItemLooks>
	</ComponentArt:TabStrip>
	<ComponentArt:MultiPage id="multiPageApproveClubMembers" CssClass="multiPage" runat="server" />
</div>