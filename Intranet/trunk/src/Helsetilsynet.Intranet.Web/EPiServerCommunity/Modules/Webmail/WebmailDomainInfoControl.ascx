<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WebmailDomainInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailDomainInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
	document.title = '<% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainInfoControl.Title") %>'
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />


<div class="webmailDomainInfo">

<asp:Panel ID="panelWebmailDomainInfo" Runat="server">
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
	<thead>
	<tr>
		<th colspan="3"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainInfoControl.Title") %></th>
	</tr>
	</thead>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainInfoControl.inputDomainName") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxDomainName" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorDomainName" runat="server" ControlToValidate="textBoxDomainName" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailDomainInfoControl.inputMailServer") %>:</td>
		<td valign="top">
    		<asp:DropDownList ID="dropDownMailServer" runat="server" CssClass="input"></asp:DropDownList>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="dropDownMailServerValidator" runat="server" ControlToValidate="dropDownMailServer" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="5" align="right"><asp:Button ID="buttonSaveWebmailDomain" Runat="server" CssClass="button"></asp:Button></td>
	</tr>

</table>

</asp:Panel>