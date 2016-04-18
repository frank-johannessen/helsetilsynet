<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ApproveImagesControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ApproveImagesControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.imagegallery")%></h1>
<div id="tabStrip">
	<ComponentArt:TabStrip id="tabStripApproveImages" 
	CssClass="topGroup"
	DefaultItemLookId="DefaultTabLook"
	DefaultSelectedItemLookId="SelectedTabLook"
	DefaultDisabledItemLookId="DisabledTabLook"
	DefaultGroupTabSpacing="0"
	ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
	MultiPageId="multiPageApproveImages"
	runat="server">
	<ItemLooks>
		<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
		<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" />
	</ItemLooks>
	</ComponentArt:TabStrip>
	<ComponentArt:MultiPage id="multiPageApproveImages" CssClass="multiPage" runat="server" />
</div>