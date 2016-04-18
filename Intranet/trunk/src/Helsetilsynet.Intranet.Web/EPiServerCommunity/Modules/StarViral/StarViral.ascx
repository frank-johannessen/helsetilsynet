<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="StarViral.ascx.cs" Inherits="EPiServer.Community.Web.Administration.StarViral" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="Campaigns" TagName="Campaigns" Src="CampaignListControl.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.referral")%></h1>
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.StarViral.Header") %></th>
</tr>
</thead>
<tr>
	<td width="200"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.StarViral.NumReferrals") %>:</td>
	<td><asp:Label ID="labelReferrals" Runat="server"></asp:Label></td>	
</tr>
<tr>
	<td width="200"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.StarViral.NumCompletions") %>:</td>
	<td><asp:Label ID="labelCompletions" Runat="server"></asp:Label></td>	
</tr>
</table>

<br />


<Campaigns:Campaigns id="campaigns" runat="server" />
