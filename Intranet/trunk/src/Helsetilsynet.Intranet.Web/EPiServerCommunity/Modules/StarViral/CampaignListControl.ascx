<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CampaignListControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.CampaignListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<script language="javascript" src="Administration.js"></script>

<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignList.Header") %></th>
</tr>
</thead>
	<tr>
		<td class="menu">
			
			<button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="SCStarViralOpenCampaignInfo(-1);return false;"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignList.buttonNewCampaign") %></button>
		</td>
		<td class="epi-noPadding">
			<div id="campaigns">
				<table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%">
				<tr>
					<th align="left"><asp:LinkButton ID="linkButtonName" Runat="server"></asp:LinkButton></th>	
					<th align="left"><asp:LinkButton ID="linkButtonIsActive" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonReferrals" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonCompletions" Runat="server"></asp:LinkButton></th>
					<th align="left"><asp:LinkButton ID="linkButtonHitRatio" Runat="server"></asp:LinkButton></th>
					<th>&nbsp;</th>																		
				</tr>
				<tr runat="server" id="rowPagingTop">
					<td colspan="6"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
				</tr>
				<asp:DataList ID="dataListCampaigns" ItemStyle-VerticalAlign="Top" CellPadding="5" RepeatDirection="Horizontal" 
				RepeatLayout="Flow" Runat="server" DataKeyField="ID" OnDeleteCommand="dataListCampaigns_DeleteCommand">
					<ItemTemplate>
					<tr>
						<td><a href="javascript:SCStarViralOpenCampaignInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>);"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></a></td>
						<td><%# (bool)DataBinder.Eval(Container.DataItem, "IsActive") == true ? EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignList.IsActive.Yes") : EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignList.IsActive.No") %></td>
						<td><%# DataBinder.Eval(Container.DataItem, "NumReferrals") %></td>
						<td><%# DataBinder.Eval(Container.DataItem, "NumCompletions") %></td>
						<td><%# GetHitRatio((EPiServer.Community.StarViral.Campaign)Container.DataItem) %></td>
						<td align="right"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" OnClientClick="<%#RemoveConfirmationMessage %>" CommandName="Delete" Text="Remove" Enabled='<% # AccessRights.Administrate %>'></asp:Button></td>
						</tr>
					</ItemTemplate>
				</asp:DataList>
				<tr runat="server" id="rowNoResult">
					<td colspan="6"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.StarViral.CampaignList.NoResult") %>.</td>
				</tr>
				<tr runat="server" id="rowPagingBottom">
					<td colspan="6"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
				</tr>
				</table>
			</div>
		</td>
	</tr>
</table>