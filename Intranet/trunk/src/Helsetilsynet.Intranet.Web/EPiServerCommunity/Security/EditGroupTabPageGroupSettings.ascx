<%@ Control Language="c#" AutoEventWireup="True" Codebehind="EditGroupTabPageGroupSettings.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Security.EditGroupTabPageGroupSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellSpacing="0" cellPadding="0" border="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.EditGroup.tabPageGroupSettings") %></th>
		</tr>
	</thead>
	<tr>
		<td><asp:Label id="labelGroupName" runat="server" CssClass="editLabel" /></td>
		<td><asp:TextBox id="textBoxGroupName" runat="server" CssClass="input" Width="200" />&nbsp;<asp:RequiredFieldValidator id="validatorGroupName" runat="server" CssClass="requiredField" ControlToValidate="textBoxGroupName" ErrorMessage="*" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator></td>
	</tr>
</table>
<br />
<table cellSpacing="0" cellPadding="0" border="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="5"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.Members") %></th>
		</tr>
	</thead>
	<tr>
		<th colspan="2" align="left"><asp:Label id="labelAvailableGroups" runat="server"></asp:Label></th>
		<th>&nbsp;</th>
		<th align="left"><asp:Label id="labelSelectedGroups" runat="server"></asp:Label></th>
		<th>&nbsp;</th>
	</tr>
	<tr>
        <td><asp:Panel ID="panelSearchGroups" runat="server" DefaultButton="btnSearchGroups"><asp:TextBox CssClass="input" ID="txtSearchGroups" runat="server" /> <asp:Button ID="btnSearchGroups" CssClass="button" runat="server" OnClick="BtnSearchGroups_Click" CausesValidation="false" /></asp:Panel></td>
	    <td style="text-align:right;"><asp:Button runat="server" CssClass="button" ID="btnShowAllGroups" OnClick="BtnShowAllGroups_Click" Text="Show all" CausesValidation="false" /></td>
	    <td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" width="45%"><asp:ListBox id="listBoxAvailableGroups" runat="server" Width="97%" Height="88" CssClass="input" SelectionMode="Multiple"></asp:ListBox></td>
		<td valign="middle" align="center" width="5%"><asp:Button id="buttonAddGroupToList" runat="server" Width="24" Height="47" CssClass="button" Text=">" CausesValidation="false"></asp:Button></td>
		<td width="45%"><asp:ListBox id="listBoxSelectedGroups" runat="server" Width="97%" Height="88" CssClass="input" SelectionMode="Multiple"></asp:ListBox></td>
		<td valign="top" width="5%"><asp:LinkButton id="linkButtonRemoveGroupFromList" style="cursor:hand;" runat="server" CausesValidation="false"><img src="../images/general/remove.png" width="16" height="16" border="0"></asp:LinkButton></td>
	</tr>
</table>