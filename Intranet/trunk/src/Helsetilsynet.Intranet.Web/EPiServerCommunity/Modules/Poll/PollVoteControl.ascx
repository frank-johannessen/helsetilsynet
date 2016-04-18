<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="PollVoteControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.PollVoteControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>

<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollVote.Title") %>'
</script>
<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css">

<table cellpadding="0" cellspacing="0" class="epi-default">
<thead>
<tr>
	<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollVote.Header") %> "<%= ChoiceText %>"</th>
</tr>
</thead>

<tr>
	<th align="left"><asp:LinkButton ID="linkButtonAlias" Runat="server"></asp:LinkButton></th>
	<th align="left"><asp:LinkButton ID="linkButtonDate" Runat="server"></asp:LinkButton></th>		
</tr>
<tr runat="server" id="rowPagingTop">
	<td colspan="2"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
</tr>

<asp:DataList ID="dataListPollVotes" Runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
	<ItemTemplate>
		<tr>
			<td><%# DataBinder.Eval(Container.DataItem, "User") != null ? "<a href=\"javascript:SCMyPageOpenEditUser(" + DataBinder.Eval(Container.DataItem, "User.ID") + ");\">" + AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "User.Alias")) + "</a>" : "[" + EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.PollVote.Anonymous") + "]" %></td>
			<td><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "VoteDate")) %></td>		
		</tr>
	</ItemTemplate>
</asp:DataList>

<tr runat="server" id="rowPagingBottom">
	<td colspan="2"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
</tr>

</table>