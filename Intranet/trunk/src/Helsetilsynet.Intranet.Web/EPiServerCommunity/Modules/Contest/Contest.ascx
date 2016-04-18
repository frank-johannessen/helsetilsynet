<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="Contest.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Contest" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css" />

<script type="text/javascript">
function confirm_delete()
{
  if (confirm("Are you sure you want to remove this contest?")==true)
    return true;
  else
    return false;
}
</script>						
	
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.contest")%></h1>
<table class="epi-default" cellpadding="0" cellspacing="0">
<tr>
	<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Contest.MenuHeader") %></th>
	<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Contest.Header") %></th>
</tr>
<tr>
	<td class="menu">
		<button <% = (!AccessRights.Administrate ? "disabled" : "") %> class="button" onclick="SCContestOpenContestInfo(-1);return false;"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Contest.buttonNewContest") %></button>
	</td>
	<td valign="top" class="epi-noPadding">
		<table cellpadding="0" cellspacing="0" class="epi-default" style="width: 100%;">
		<tr>
			<th align="left"><asp:LinkButton ID="linkButtonName" Runat="server"></asp:LinkButton></th>
			<th align="left"><asp:LinkButton ID="linkButtonStartDate" Runat="server"></asp:LinkButton></th>			
			<th align="left"><asp:LinkButton ID="linkButtonEndDate" Runat="server"></asp:LinkButton></th>
			<th align="left">&nbsp;</th>
		</tr>
		
		<tr runat="server" id="rowPagingTop">
			<td colspan="5"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
		</tr>

		<asp:DataList ID="dataListContests" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" 
			DataKeyField="ID" OnDeleteCommand="dataListContests_DeleteCommand">
		<ItemTemplate>
			<tr>
				<td><a href="javascript:SCContestOpenContestInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>);"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Header")) %></a></td>
				<td><%# AdministrationUtils.FormatDate((DateTime)DataBinder.Eval(Container.DataItem, "StartDate")) %></td>
				<td><%# AdministrationUtils.FormatDate((DateTime)DataBinder.Eval(Container.DataItem, "EndDate")) %></td>
				<td align="right"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" CommandName="Delete"></asp:Button></td>
			</tr>
		</ItemTemplate>
		</asp:DataList>
		
		<tr runat="server" id="rowNoResult">
			<td colspan="5"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Contest.NoResult") %>.</td>
		</tr>
		<tr runat="server" id="rowPagingBottom">
			<td colspan="5"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
		</tr>
		</table>
	</td>
</tr>
</table>
