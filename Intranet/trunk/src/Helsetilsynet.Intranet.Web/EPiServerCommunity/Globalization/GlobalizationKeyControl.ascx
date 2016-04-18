<%@ Control Language="c#" AutoEventWireup="True" Codebehind="GlobalizationKeyControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.GlobalizationKeyControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script language="javascript">
	document.title = '<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Globalization.EditKeyTitle") %>';
</script>
<table class="epi-default" cellpadding="0" cellspacing="0" border="0">
<thead>
	<tr>
		<th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Globalization.EditKeyTitle") %></th>
	</tr>
</thead>
<tr>
	<td><asp:Button ID="buttonSave" Runat="server" CssClass="button" OnClick="ButtonSave_Click" />&nbsp;<span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.Globalization.RemoveKeyConfirm") %>');"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" OnClick="ButtonRemove_Click" /></span></td>
</tr>
</table>
<br />
<table class="epi-default" cellpadding="0" cellspacing="0" border="0">
<thead>
	<tr>
		<th><asp:label id="labelKey" runat="server"></asp:label></th>
	</tr>
</thead>
<tr>
	<td>
		<table border="0" cellspacing="2" width="100%">
			<tr>
				<td width="100"><asp:Label id="labelNewCulture" CssClass="label" runat="server" Width="100px">Add:</asp:Label></td>
				<td><asp:DropDownList id="dropDownListNewCulture" CssClass="input" runat="server" AutoPostBack="True" Width="300px" onselectedindexchanged="dropDownListNewCulture_SelectedIndexChanged"></asp:DropDownList></td>
			</tr>
			<asp:panel id="panelKeyRow" runat="server"></asp:panel>
		</table>
	</td>
</tr>
</table>
<asp:PlaceHolder ID="placeHolderCloseWindow" Runat="server" Visible="False">
	<script language="javascript">
		if(window.opener)
		    window.opener.__doPostBack('<% = SearchControlId %>', '');
		window.close();
	</script>
</asp:PlaceHolder>