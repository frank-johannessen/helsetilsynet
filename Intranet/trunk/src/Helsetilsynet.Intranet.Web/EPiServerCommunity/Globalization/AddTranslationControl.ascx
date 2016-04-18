<%@ Control Language="c#" AutoEventWireup="True" Codebehind="AddTranslationControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AddTranslationControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<asp:panel id="panelAdd" Width="100%" runat="server" Visible="True">
	<table cellPadding="0" cellspacing="0" width="100%" border="0" class="epi-default">
		<asp:Panel ID="panelValidationSummary" Runat="server" Visible="False">
			<tr>
				<td colspan="2"><asp:ValidationSummary CssClass="summary" Runat="server" DisplayMode="List"></asp:ValidationSummary></td>
			</tr>
		</asp:Panel>
		<tr>
			<td width="100"><asp:label id="labelAdd" runat="server" CssClass="label"></asp:label></td>
			<td><asp:TextBox id="textBoxNewKey" runat="server" Width="315" CssClass="input"></asp:TextBox><asp:requiredfieldvalidator id="validatorAddRequired" runat="server" ErrorMessage="*" CssClass="requiredField" ControlToValidate="textBoxNewKey" Display="Dynamic" EnableClientScript="False"></asp:requiredfieldvalidator></td>
		</tr>
		<tr>
			<td width="100"><asp:label id="labelText" runat="server" CssClass="label"></asp:label></td>
			<td><asp:TextBox ID="textBoxText" Width="315" Runat="server" CssClass="input"></asp:TextBox><asp:requiredfieldvalidator id="validatorAddTextRequired" runat="server" ErrorMessage="*" CssClass="requiredField" ControlToValidate="textBoxText" Display="Dynamic" EnableClientScript="False"></asp:requiredfieldvalidator></td>
		</tr>
		<tr>
			<td width="100"><asp:label id="labelCulture" runat="server" CssClass="label"></asp:label></td>
			<td><asp:DropDownList ID="dropDownListCulture" Runat="server" CssClass="input" Width="315"></asp:DropDownList></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><asp:Button ID="buttonAddTranslation" Runat="server" CssClass="button" CausesValidation="False"></asp:Button></td>
		</tr>
	</table>
</asp:panel>