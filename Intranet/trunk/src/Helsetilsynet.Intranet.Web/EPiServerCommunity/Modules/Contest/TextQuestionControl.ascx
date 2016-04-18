<%@ Control Language="c#" AutoEventWireup="True" Codebehind="TextQuestionControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.TextQuestionControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript">
<!--
	document.title = "Question Information";
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<asp:CustomValidator Display="None" EnableClientScript="False" runat="server" ID="SystemMessageValidator"></asp:CustomValidator>
<table cellpadding="0" cellspacing="0" class="epi-default">
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Text.inputText") %>:</td>
	<td><asp:TextBox ID="textBoxQuestionText" Runat="server" CssClass="input" Width="100%" MaxLength="2000"></asp:TextBox><asp:RequiredFieldValidator ID="validatorText" Runat="server" ControlToValidate="textBoxQuestionText" Display="None" ErrorMessage="Text missing" EnableClientScript="False"></asp:RequiredFieldValidator></td>	
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.Text.inputImage") %>:</td>
	<td><asp:Image ID="imageQuestion" Runat="server"></asp:Image>&nbsp;<INPUT id="fileTextQuestionImage" class="input" type="file" runat="server"><asp:CheckBox ID="checkBoxRemoveImage" Runat="server"></asp:CheckBox></td>	
</tr>
<tr>
	<td colspan="2" align="right"><asp:Button ID="buttonSaveQuestion" Runat="server" CssClass="button"></asp:Button>&nbsp;</td>
</tr>
</table>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
	<!--
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
		    if (window.opener && window.opener.RefreshQuestionsList) {
		        window.opener.RefreshQuestionsList();
		    }
			window.close();
		}
	//-->
	</script>
</asp:PlaceHolder>