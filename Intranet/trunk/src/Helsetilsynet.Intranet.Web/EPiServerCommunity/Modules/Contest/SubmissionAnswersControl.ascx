<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SubmissionAnswersControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SubmissionAnswersControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<link rel="stylesheet" type="text/css" href="Administration.css" />
<script language="javascript">
<!--
	document.title = "Submission Answers";
//-->
</script>

<table cellpadding="0" cellspacing="0" class="epi-default">
<tr>
	<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SubmissionAnswers.HeaderQuestion") %></th>
	<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SubmissionAnswers.HeaderAnswer") %></th>
	<th align="left"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SubmissionAnswers.HeaderIsCorrect") %></th>	
</tr>

<asp:Repeater ID="repeaterSubmissionAnswers" Runat="server">
<ItemTemplate>
	<tr>
		<td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Question.Body")) %></td>
		<td><%# AdministrationUtils.FormatString(GetAnswer((EPiServer.Community.Contest.Answer)Container.DataItem)) %></td>
		<td><%# GetIsCorrect((EPiServer.Community.Contest.Answer)Container.DataItem, (bool)DataBinder.Eval(Container.DataItem, "IsCorrect")) %></td>
	</tr>
</ItemTemplate>
</asp:Repeater>

</table>