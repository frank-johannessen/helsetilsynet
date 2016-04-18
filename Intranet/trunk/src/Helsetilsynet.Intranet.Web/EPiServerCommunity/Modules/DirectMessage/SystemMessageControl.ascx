<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SystemMessageControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SystemMessageControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript" src="Administration.js"></script>
<script language="javascript">
<!--
	document.title = "System Message";
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<table class="epi-default" cellpadding="0" cellspacing="0">
	<tr>
		<td>Subject:</td>
		<td><asp:TextBox ID="textBoxMessageSubject" Runat="server" CssClass="input" Width="400" MaxLength="400"></asp:TextBox>
			<asp:RequiredFieldValidator id="RequiredFieldSubject" runat="server" ErrorMessage="Subject missing" EnableClientScript="False" Display="None" ControlToValidate="textBoxMessageSubject"></asp:RequiredFieldValidator></td>
	</tr>
	<tr>
		<td valign="top">Message:</td>
		<td valign="top">
			<asp:TextBox ID="textBoxSystemMessageText" Runat="server" CssClass="input" TextMode="MultiLine" Width="400" Height="200"></asp:TextBox>
			<asp:RequiredFieldValidator id="RequiredFieldBody" runat="server" ErrorMessage="Message missing" Display="None" EnableClientScript="False" ControlToValidate="textBoxSystemMessageText"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td align="right" colspan="2">
			<asp:Button ID="buttonSendSystemMessage" CssClass="button" Runat="server" Text="Send" onclick="buttonSendSystemMessage_Click"></asp:Button></td>
	</tr>
</table>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<SCRIPT language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{						
			if(window.opener)
			{
				window.opener.document.getElementById('<% = SystemMessageSubjectId %>').value = document.getElementById('<% = textBoxMessageSubject.ClientID %>').value;
				window.opener.document.getElementById('<% = SystemMessageBodyId %>').value = document.getElementById('<% = textBoxSystemMessageText.ClientID %>').value;
				window.opener.__doPostBack('<% = SystemMessageControlId %>', '<% = ReceiverType %>');
			}
			window.close();
			
		}
	</SCRIPT>
</asp:PlaceHolder>
