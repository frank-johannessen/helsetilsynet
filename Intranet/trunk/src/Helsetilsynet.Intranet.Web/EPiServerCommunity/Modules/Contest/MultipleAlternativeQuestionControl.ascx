<%@ Control Language="c#" AutoEventWireup="True" Codebehind="MultipleAlternativeQuestionControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.MultipleAlternativeQuestionControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript">
<!--
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.MultipleAlternative.Title") %>'
//-->
</script>
<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<table cellpadding="0" cellspacing="0" class="epi-default">
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.MultipleAlternative.inputText") %>:</td>
	<td><asp:TextBox Runat="server" CssClass="input" ID="textBoxMultipleAlternativeQuestionText" Width="100%" MaxLength="2000"></asp:TextBox><asp:RequiredFieldValidator ID="validatorText" Runat="server" ControlToValidate="textBoxMultipleAlternativeQuestionText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator></td>	
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.MultipleAlternative.inputImage") %>:</td>
	<td><asp:Image ID="imageQuestion" Runat="server"></asp:Image>&nbsp;<INPUT class="input" type="file" runat="server" ID="fileMultipleAlternativeQuestionImage" NAME="fileMultipleAlternativeQuestionImage"><asp:CheckBox ID="checkBoxRemoveImage" Runat="server"></asp:CheckBox></td>	
</tr>
<tr>
	<td colspan="2">
	    <asp:UpdatePanel runat="server">
	        <ContentTemplate>
		        <table cellpadding="0" cellspacing="0" width="100%" class="epi-default">
		        <tr>
			        <td><asp:Button ID="buttonAddAlternative" Runat="server" CssClass="button" Visible="True"></asp:Button>&nbsp;</td>
			        <td>&nbsp;</td>
			        <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.MultipleAlternative.HeaderIsCorrect") %></td>			
			        <td>&nbsp;</td>
		        </tr>
		        <asp:DataList ID="dataListMultipleAlternatives" Runat="server" DataKeyField="ID" RepeatLayout="Flow" RepeatDirection="Horizontal"  OnDeleteCommand="dataListMultipleAlternatives_DeleteCommand">
		        <ItemTemplate>
			        <tr>
				        <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.MultipleAlternative.Alternative") %><input type="hidden" runat="server" id="hiddenAlternativeID" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' NAME="hiddenAlternativeID"/></td>
				        <td><asp:TextBox Runat="server" CssClass="input" MaxLength="2000" Width="200" ID="textBoxMultipleAlternativeText" Text='<%# DataBinder.Eval(Container.DataItem, "AlternativeText") %>'></asp:TextBox><asp:RequiredFieldValidator ID="validatorAlternativeText" Runat="server" ControlToValidate="textBoxMultipleAlternativeText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator></td>
				        <td><asp:CheckBox ID="checkBoxMultipleAlternative" Runat="server" Checked='<%# (bool)DataBinder.Eval(Container.DataItem, "IsCorrect") %>'></asp:CheckBox></td>
				        <td align="right"><asp:Button ID="buttonDelete" Runat="server" CommandName="Delete" CssClass="button"></asp:Button>&nbsp;</td>
			        </tr>
		        </ItemTemplate>
		        </asp:DataList>
		        </table>
		    </ContentTemplate>
		</asp:UpdatePanel>
	</td>
</tr>
<tr>
	<td colspan="2" align="right"><asp:Button ID="buttonSaveQuestion" Runat="server" CssClass="button" Text="Save Question"></asp:Button>&nbsp;</td>
</tr>
</table>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);

		function CloseWindow() {
		    if (window.opener && window.opener.RefreshQuestionsList) {
		        window.opener.RefreshQuestionsList();
		    }
		    window.close();
		}
	</script>
</asp:PlaceHolder>