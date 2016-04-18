<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Register TagPrefix="sc" TagName="DateTimePicker" Src="../../DateTimePicker.ascx" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="Poll.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Poll" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<LINK href="Administration.css" type="text/css" rel="stylesheet">
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.poll")%></h1>
<table class="epi-default" cellSpacing="0" cellPadding="0" border="0">
	<thead>
		<tr>
			<th colspan="8"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.Title") %></th>
		</tr>
	</thead>
	<tbody>
		<tr>	
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.PollTextLabel") %>:</td>
			<td colSpan="3"><asp:textbox id="textBoxPollText" Width="95%" CssClass="input" Runat="server"></asp:textbox></td>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.PollAuthorLabel") %>:</td>
			<td colSpan="3"><asp:textbox id="textBoxPollAuthor" Width="95%" CssClass="input" Runat="server"></asp:textbox></td>
		</tr>
		<tr>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.ActiveDatesLabel") %>:</td>
			<td><sc:datetimepicker id="dateTimePickerActiveFrom" Width="100%" ShowTimePicker="False" runat="server"></sc:datetimepicker></td>
			<td>&nbsp;<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.AndLabel") %>&nbsp;</td>
			<td><sc:datetimepicker id="dateTimePickerActiveTo" Width="100%" ShowTimePicker="False" runat="server"></sc:datetimepicker></td>
			<td align="right"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.CreatedDatesLabel") %>:</td>
			<td><sc:datetimepicker id="dateTimePickerCreatedFrom" Width="100%" ShowTimePicker="False" runat="server"></sc:datetimepicker></td>
			<td>&nbsp;<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.AndLabel") %>&nbsp;</td>
			<td><sc:datetimepicker id="dateTimePickerCreatedTo" Width="100%" ShowTimePicker="False" runat="server"></sc:datetimepicker></td>
		</tr>
		<tr>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.PollTypeLabel") %>:</td>
			<td colSpan="3"><asp:checkboxlist id="checkBoxListPollType" Runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
					<asp:ListItem Value="1" Selected="True"></asp:ListItem>
					<asp:ListItem Value="2" Selected="True"></asp:ListItem>
					<asp:ListItem Value="4" Selected="True"></asp:ListItem>
					<asp:ListItem Value="8" Selected="True"></asp:ListItem>
				</asp:checkboxlist></td>
			<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Poll.Search.ActiveLabel")%>:</td>
			<td colspan="3"><asp:checkboxlist id="checkBoxListActiveStatus" Runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
					<asp:ListItem Value="1" Selected="True"></asp:ListItem>
					<asp:ListItem Value="2" Selected="True"></asp:ListItem>
				</asp:checkboxlist></td>
		</tr>
		<tr>
			<td colspan="8" align="right"><asp:button id="buttonPollsSearch" Runat="server" Text="Filter polls" CssClass="button"></asp:button></td>
		</tr>
	</tbody>
</table>
<br>
<asp:panel id="panelPolls" Runat="server"></asp:panel>