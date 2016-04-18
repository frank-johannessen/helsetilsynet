<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SingleAlternativeQuestionControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.SingleAlternativeQuestionControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css">
<script language="javascript">
<!--
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SingleAlternative.Title") %>'
//-->
</script>

<sc:SaveResultPanel id="saveResultPanel" runat="server" />

<table cellpadding="0" cellspacing="0" class="epi-default">
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SingleAlternative.inputText") %>:</td>
	<td><asp:TextBox Runat="server" CssClass="input" ID="textBoxSingleAlternativeQuestionText" Width="100%" MaxLength="2000"></asp:TextBox><asp:RequiredFieldValidator ID="validatorText" Runat="server" ControlToValidate="textBoxSingleAlternativeQuestionText" Display="None" ErrorMessage="Text missing" EnableClientScript="False"></asp:RequiredFieldValidator></td>	
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SingleAlternative.inputImage") %>:</td>
	<td>
	    <asp:Image ID="imageQuestion" Runat="server"></asp:Image>&nbsp;
	    <INPUT class="input" type="file" runat="server" ID="fileSingleAlternativeQuestionImage" />
	    <asp:CheckBox ID="checkBoxRemoveImage" Runat="server"></asp:CheckBox>
	</td>	
</tr>
<tr>
	<td colspan="2">
	    <asp:UpdatePanel runat="server">
	        <ContentTemplate>
		            <table cellpadding="0" cellspacing="0" width="100%" class="table">
		            <tr>
			            <td><asp:Button ID="buttonAddAlternative" Runat="server" CssClass="button"></asp:Button>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SingleAlternative.HeaderIsCorrect") %></td>			
			            <td>&nbsp;</td>
		            </tr>
                    <asp:DataList ID="dataListSingleAlternatives" Runat="server" DataKeyField="ID" RepeatLayout="Flow" RepeatDirection="Horizontal" OnDeleteCommand="dataListSingleAlternatives_DeleteCommand">
                        <ItemTemplate>
                            <tr>
	                            <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Contest.SingleAlternative.Alternative") %><input type="hidden" runat="server" id="hiddenAlternativeID" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' /></td>
	                            <td><asp:TextBox Runat="server" CssClass="input" ID="textBoxSingleAlternativeText" Width="200" MaxLength="2000" Text='<%# DataBinder.Eval(Container.DataItem, "AlternativeText") %>'></asp:TextBox><asp:RequiredFieldValidator ID="validatorAlternativeText" Runat="server" ControlToValidate="textBoxSingleAlternativeText" Display="None" EnableClientScript="False"></asp:RequiredFieldValidator></td>
	                            <td><asp:RadioButton ID="radioButtonSingleAlternative" AutoPostBack="True" OnCheckedChanged="FixRadioButtons" Runat="server" GroupName="SingleAlternative" Text="" Checked='<%# (bool)DataBinder.Eval(Container.DataItem, "IsCorrect") %>'></asp:RadioButton></td>
	                            <td align="right"><asp:Button ID="buttonDelete" Runat="server" CommandName="Delete" CssClass="button" Enabled='<%# !(bool)DataBinder.Eval(Container.DataItem, "IsCorrect") %>'></asp:Button>&nbsp;</td>
                            </tr>
                        </ItemTemplate>
                    </asp:DataList>
		         </table>
		    </ContentTemplate>
	    </asp:UpdatePanel>
    </td>
</tr>
<tr>
	<td colspan="2" align="right"><asp:Button ID="buttonSaveQuestion" Runat="server" CssClass="button"></asp:Button>&nbsp;</td>
</tr>
</table>

<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
	<!--
		setTimeout('CloseWindow()', 1000);

		function CloseWindow() {
		    if (window.opener && window.opener.RefreshQuestionsList) {
		        window.opener.RefreshQuestionsList();
		    }
		    window.close();
		}
	//-->
	</script>
</asp:PlaceHolder>