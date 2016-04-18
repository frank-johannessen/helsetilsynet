<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportingUserStats.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ReportingUserStats" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="~/EPiServerCommunity/PagingControl.ascx" %>
<div id="reportedUsers">
	<table class="table"  cellspacing="0" border="0">
		<thead>
			<tr>
				<td class="td" colspan="10">
				<asp:label ID="labelHeadingResults" Runat="server" />
				</td>
			</tr>
		</thead>
		<tr>
			<asp:PlaceHolder id="placeHolderHeadingsReportedUsers" Runat="server">
				<th align="left" class="td" style="width:50%"><asp:Label ID="labelUserAlias" Runat="server" /></th>
				<th align="left" class="td"><asp:LinkButton ID="linkButtonSortNumNewReports" OnCommand="SortCommand" CommandArgument="NumNewReports" Runat="server"></asp:LinkButton></th>
				<th align="left" class="td"><asp:LinkButton ID="linkButtonSortNumIgnoredReports" OnCommand="SortCommand" CommandArgument="NumIgnoredReports" Runat="server"></asp:LinkButton></th>
				<th align="left" class="td"><asp:LinkButton ID="linkButtonSortNumHandledReports" OnCommand="SortCommand" CommandArgument="NumHandledReports" Runat="server"></asp:LinkButton></th>
			</asp:PlaceHolder>
		</tr>
		<tbody>
			<tr runat="server" id="rowPagingTop" visible="false">
				<td colspan="4" class="td"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
			</tr>
			<asp:Repeater ID="repeaterUserReportStats" EnableViewState="True" Runat="server" OnItemDataBound="repeaterUserReportStats_ItemDataBound">
				<ItemTemplate>
					<tr>
					    <td class="td">
					        <asp:Label ID="labelUserAlias" runat="server" />
					    </td>
						<td class="td">
							<%# GetInt(Container.DataItem, "NumNewReports") %>
						</td>
						<td class="td">
							<%# GetInt(Container.DataItem, "NumIgnoredReports") %>
						</td>
						<td class="td">
							<%# GetInt(Container.DataItem, "NumHandledReports") %>
						</td>
					</tr>
				</ItemTemplate>
			</asp:Repeater>	
			<tr runat="server" id="rowPagingBottom" Visible="false">
				<td colspan="4" class="td"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
			</tr>
		</tbody>
	</table>				
</div>