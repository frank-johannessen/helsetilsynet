<%@ Control Language="c#" AutoEventWireup="True" Codebehind="RelatedQuestionsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.RelatedQuestionsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript">
<!--
function <% = this.ClientID %>_CheckUncheckAll()
{
	var totalCount = 0;
	var checkCount = 0;
	
	var i;
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf("checkBoxAssociate") >= 0)
		{
			totalCount = totalCount + 1;
			if (elem.checked)
			{
				checkCount = checkCount + 1;
			}
		}
	}
		
	var j;
	for (j = 0; j < document.forms[0].elements.length; j++) {
		var elem = document.forms[0].elements[j];
		if (elem.name.indexOf("checkBoxAssociate") >= 0)
		{
			if (checkCount < totalCount)
			{
				elem.checked = true;
			}
			else
			{
				elem.checked = false;
			}
		}
	}
}
//-->
</script>

<script language="javascript" src="Administration.js"></script>
<!--<link rel="stylesheet" type="text/css" href="Administration.css" />-->
<table cellpadding="0" cellspacing="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="6"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Header") %></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Top.Header.QuestionHeader") %></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Top.Header.Author") %></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Top.Header.Created") %></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Top.Header.Category") %></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Top.Header.Status") %></th>
			<th align="left">&nbsp;</th>
		</tr>
		<asp:Repeater ID="repeaterRelatedQuestions" EnableViewState="True" Runat="server">
			<ItemTemplate>
				<tr>
					<td valign="top">
						<a href="javascript:SCExpertOpenQuestionInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<%# this.UniqueID %>', '<% = this.ResolveUrl("~/EPiServerCommunity/") %>');"><%# GetHeader((EPiServer.Community.Expert.Question)Container.DataItem) %></a>&nbsp;
					</td>
					<td><%# GetAuthorName((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetCreatedDate((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetCategory((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetStatus((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td align="right">
						<asp:Button ID="buttonRemoveRelatedQuestion" Runat="server" CssClass="button"></asp:Button>&nbsp;
					</td>
				</tr>
			</ItemTemplate>
		</asp:Repeater>
		<tr runat="server" id="rowNoRelatedQuestions">
			<td colspan="5"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.NoResult") %>.</td>
		</tr>
	</tbody>
</table>
<br />
			
<!-- table of all questions with paging -->
<table cellpadding="0" cellspacing="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="6"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.HeaderAddRelated") %></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th align="left"><asp:LinkButton ID="linkButtonHeaderHeader" Runat="server" CssClass="button"></asp:LinkButton></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Bottom.Header.Author") %></th>
			<th align="left"><asp:LinkButton ID="linkButtonHeaderCreated" Runat="server" CssClass="button"></asp:LinkButton></th>
			<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.Bottom.Header.Category") %></th>
			<th align="left"><asp:LinkButton ID="linkButtonHeaderStatus" Runat="server" CssClass="button"></asp:LinkButton></th>
			<th align="left">&nbsp;</th>
		</tr>
		<tr runat="server" id="rowPagingTop">
			<td colspan="6"><sc:PagingControl id="pagingControlTop" runat="server" /></td>
		</tr>
		<asp:Repeater ID="repeaterAllQuestions" EnableViewState="True" Runat="server">
			<ItemTemplate>
				<tr>
					<td valign="top">
						<a href="javascript:SCExpertOpenQuestionInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<%# this.UniqueID %>', '<% = this.ResolveUrl("~/EPiServerCommunity/") %>');"><%# GetHeader((EPiServer.Community.Expert.Question)Container.DataItem) %></a>&nbsp;
					</td>
					<td><%# GetAuthorName((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetCreatedDate((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetCategory((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td><%# GetStatus((EPiServer.Community.Expert.Question)Container.DataItem) %></td>
					<td align="right">
						<asp:Button ID="buttonAddRelatedQuestion" Runat="server" CssClass="button"></asp:Button>&nbsp;
					</td>
				</tr>
			</ItemTemplate>
		</asp:Repeater>	
		<tr runat="server" id="rowNoResult">
			<td colspan="6"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Expert.RelatedQuestions.AddRelated.NoResult") %>.</td>
		</tr>
		<tr runat="server" id="rowPagingBottom">
			<td colspan="6"><sc:PagingControl id="pagingControlBottom" runat="server" /></td>
		</tr>
	</tbody>
</table>