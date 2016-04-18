<%@ Control Language="c#" AutoEventWireup="True" Codebehind="WebmailSignatureControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.WebmailSignatureControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<script language="javascript" src="Administration.js"></script>
<table border="0" cellpadding="0" cellspacing="0" class="epi-default">
	<tr>
		<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.Signature.inputText") %>:</td>
		<td>
			<asp:TextBox Runat="server" ID="textSignatureTextBox" TextMode="MultiLine" Rows="10" Columns="60" CssClass="input"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td valign="top"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Webmail.Signature.inputHTML") %>:</td>
		<td>
			<asp:TextBox Runat="server" ID="htmlSignatureTextBox" TextMode="MultiLine" Rows="10" Columns="60" CssClass="input"></asp:TextBox><br>
		</td>
	</tr>
</table>