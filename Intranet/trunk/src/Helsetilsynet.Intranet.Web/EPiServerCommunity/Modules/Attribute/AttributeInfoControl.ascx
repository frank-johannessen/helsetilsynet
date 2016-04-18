<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttributeInfoControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AttributeInfoControl" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="sc" TagName="NoEntityError" Src="../../NoEntityError.ascx" %>

<link rel="stylesheet" type="text/css" href="Administration.css" />

<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<sc:NoEntityError runat="server" ID="NoEntityError"  />
<asp:RequiredFieldValidator ID="validatorName" Display="None" EnableClientScript="False" ControlToValidate="textboxName" runat="server"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="validatorChoices" Display="None" EnableClientScript="False" runat="server"></asp:CustomValidator>
<asp:CustomValidator ID="validatorAttribute" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>

<asp:Panel ID="MainPanel" runat="server">
<table class="epi-default" cellpadding="0" cellspacing="0">
<thead>
<tr>
	<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.AttributeDetails")%></th>
</tr>
</thead>
<tbody>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.inputName")%>:</td>
	<td><asp:TextBox ID="textboxName" runat="server" CssClass="input" MaxLength="100" Width="200"></asp:TextBox></td>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.inputEntityType")%>:</td>
	<td><asp:DropDownList ID="dropDownObjectTypes" runat="server" CssClass="input" AutoPostBack="true" OnSelectedIndexChanged="dropDownObjectTypes_SelectedIndexChanged"></asp:DropDownList></td>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.inputDataType")%>:</td>
	<td><asp:DropDownList ID="dropDownComplexType" runat="server" CssClass="input" AutoPostBack="true" OnSelectedIndexChanged="dropDownComplexType_SelectedIndexChanged"></asp:DropDownList></td>
</tr>
<tr>
	<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.inputHide")%>:</td>
	<td><asp:CheckBox ID="chkHideAttribute" runat="server" />&nbsp;</td>	
</tr>
<tr>
	<td colspan="2" align="Right"><asp:Button ID="buttonSaveAttribute" runat="server" CssClass="button" OnClick="buttonSaveAttribute_Click" /></td>
</tr>
</tbody>
</table>
<br />
<table class="epi-default" cellpadding="0" cellspacing="0">
<thead>
<tr>
	<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.AttributeInfo.Choices")%></th>
</tr>
</thead>
<tbody>
<tr>
	<td align="right"><asp:Button ID="buttonAddChoice" runat="server" CssClass="button" OnClick="buttonAddChoice_Click" /></td>
</tr>
<tr runat="server" id="choicesRow" visible="false">
	<td>
		<table class="epi-default" cellpadding="0" cellspacing="0">
		<tr>
			<td>Name</td>
			<td>Value</td>
			<td>&nbsp;</td>
		</tr>
		<asp:Panel ID="panelChoice" runat="server"></asp:Panel>
		</table>
	</td>
</tr>
</tbody>
</table>
</asp:Panel>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		setTimeout('CloseWindow()', 1000);
		
		function CloseWindow()
		{
		    if (window.opener)
		        window.opener.__doPostBack('<% = AttributeControlId %>', '');
		    window.close();
		}
	</script>
</asp:PlaceHolder>