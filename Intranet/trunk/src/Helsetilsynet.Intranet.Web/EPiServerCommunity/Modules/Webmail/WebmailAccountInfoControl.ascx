<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WebmailAccountInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailAccountInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
	document.title = '<% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.Title") %>'
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />


<div class="webmailAccountInfo">

<asp:Panel ID="panelWebmailAccountInfo" Runat="server">
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
	<thead>
	<tr>
		<th colspan="3"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.Title") %></th>
	</tr>
	</thead>
			
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputMailServer") %>:</td>
		<td valign="top">
    		<asp:DropDownList ID="dropDownMailServer" runat="server" CssClass="input" AutoPostBack="true"></asp:DropDownList>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="dropDownMailServerValidator" runat="server" ControlToValidate="dropDownMailServer" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
<asp:Panel ID="panelInternalMailAccount" runat="server" Visible="false">
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputLocalPart") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxLocalPart" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorLocalPart" runat="server" ControlToValidate="textBoxLocalPart" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
    <tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputDomain") %>:</td>
		<td valign="top">
		    <asp:DropDownList ID="dropDownDomain" runat="server" CssClass="input"></asp:DropDownList>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorDomain" runat="server" ControlToValidate="dropDownDomain" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
</asp:Panel>
<asp:Panel ID="panelExternalMailAccount" runat="server" Visible="false">
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputUsername") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxUsername" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorUsername" runat="server" ControlToValidate="textBoxUsername" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputPassword") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxPassword" TextMode="Password" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorPassword" runat="server" ControlToValidate="textBoxPassword" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputMailAddress") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailAddress" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorEmail" runat="server" ControlToValidate="textBoxMailAddress" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailAccountInfoControl.inputMailName") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailName" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="requiredFieldValidatorName" runat="server" ControlToValidate="textBoxMailName" CssClass="validator" 
			Display="None" EnableClientScript="False"></asp:RequiredFieldValidator>&nbsp;
		</td>
	</tr>
    
</asp:Panel>
			
	<tr>
		<td colspan="5" align="right"><asp:Button ID="buttonSaveWebmailAccount" Runat="server" CssClass="button"></asp:Button></td>
	</tr>

</table>

</asp:Panel>