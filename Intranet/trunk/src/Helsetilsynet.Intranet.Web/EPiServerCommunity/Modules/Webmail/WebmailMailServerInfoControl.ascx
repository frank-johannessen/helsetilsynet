<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WebmailMailServerInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailMailServerInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
	document.title = '<% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.Title") %>'
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />


<div class="webmailMailServerInfo">

<asp:Panel ID="panelWebmailMailServerInfo" Runat="server">
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
	<thead>
	<tr>
		<th colspan="3"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.Title") %></th>
	</tr>
	</thead>
			
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerName") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerName" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ControlToValidate="textBoxMailServerName" CssClass="validator" 
			Display="None" EnableClientScript="False" />
			<asp:CustomValidator ID="CustomValidatorName" runat="server" ControlToValidate="textBoxMailServerName" CssClass="validator" 
			Display="None" EnableClientScript="False" OnServerValidate="CustomValidatorName_ServerValidate" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerImapHostName") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerImapHostName" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorImapHost" runat="server" ControlToValidate="textBoxMailServerImapHostName" CssClass="validator" 
			Display="None" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerImapPort")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerImapPort" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorImapPort" runat="server" ControlToValidate="textBoxMailServerImapPort" CssClass="validator" 
			Display="None" EnableClientScript="False" />
			<asp:RangeValidator runat="server" ID="RangeValidatorImapPort" ControlToValidate="textBoxMailServerImapPort" CssClass="validator"
			Display="None" EnableClientScript="False" Type="Integer" MinimumValue="0" MaximumValue="65535" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerSmtpHostName") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerSmtpHostName" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorSmtpHost" runat="server" ControlToValidate="textBoxMailServerSmtpHostName" CssClass="validator" 
			Display="None" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerSmtpPort")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerSmtpPort" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorSmtpPort" runat="server" ControlToValidate="textBoxMailServerSmtpPort" CssClass="validator" 
			Display="None" EnableClientScript="False" />
			<asp:RangeValidator Type="Integer" runat="server" ID="RangeValidatorSmtpPort" ControlToValidate="textBoxMailServerSmtpPort" CssClass="validator" 
			Display="None" EnableClientScript="False" MinimumValue="0" MaximumValue="65535" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerImapSeparator")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerImapSeparator" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorImapSeparator" runat="server" ControlToValidate="textBoxMailServerImapSeparator" CssClass="validator" 
			Display="None" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerImapBaseFolder")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerImapBaseFolder" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerImapAuthMode")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerImapAuthMode" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
			<asp:RequiredFieldValidator ID="RequiredFieldValidatorImapAuthMode" runat="server" ControlToValidate="textBoxMailServerImapAuthMode" CssClass="validator" 
			Display="None" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerInternalServer")%>:</td>
		<td valign="top">
		    <asp:CheckBox ID="checkBoxInternalMailServer" runat="server" autopostback="true" CssClass="input" />
		</td>
		<td>
		    &nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerWebServiceUrl")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerWebServiceUrl" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
		    &nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerWebServiceSecret")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerWebServiceSecret" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
		    &nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerUsernamePrefix")%>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerUsernamePrefix" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
		    &nbsp;
		</td>
	</tr>
	<tr>
		<td width="100"><% =EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.WebmailMailServerInfoControl.inputMailServerDefaultQuota") %>:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxMailServerDefaultQuota" Runat="server" CssClass="input"></asp:TextBox>
		</td>
		<td>
		    <asp:CustomValidator runat="server" ID="DefaultQuotaCustomValidator" Display="None" 
		        OnServerValidate="ValidateServerQuota" CssClass="validator" EnableClientScript="false" ValidateEmptyText="true" />
		    <asp:RangeValidator runat="server" ID="RangeValidatorServerDefaultQuota" ControlToValidate="textBoxMailServerDefaultQuota" Type="Integer" 
		    CssClass="validator" Display="None" MinimumValue="0" MaximumValue="2147483647" EnableClientScript="false" />
		</td>
	</tr>
	
	<tr>
		<td colspan="5" align="right"><asp:Button ID="buttonSaveWebmailMailServer" Runat="server" CssClass="button"></asp:Button></td>
	</tr>

</table>

</asp:Panel>