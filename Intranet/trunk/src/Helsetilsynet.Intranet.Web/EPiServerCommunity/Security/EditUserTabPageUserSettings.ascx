<%@ Control Language="c#" AutoEventWireup="True" Codebehind="EditUserTabPageUserSettings.ascx.cs" Inherits="EPiServer.Community.Web.Administration.EditUserTabPageUserSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellpadding="0" cellspacing="0" border="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.EditUser.tabPageUserSettings") %></th>
		</tr>
	</thead>
	<tr>
		<td><asp:Label id="labelGivenName" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxGivenName" Width="200" runat="server" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorGivenName1" CssClass="requiredField" ControlToValidate="textBoxGivenName" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" Enabled="false" />
			<asp:RegularExpressionValidator id="validatorGivenName2" CssClass="requiredField" ControlToValidate="textBoxGivenName" ValidationExpression="[a-zA-ZåäöÅÄÖ]+" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" Enabled="false" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelSurName" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxSurName" Width="200" runat="server" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorSurName1" CssClass="requiredField" ControlToValidate="textBoxSurName" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" Enabled="false" />
			<asp:RegularExpressionValidator id="validatorSurName2" CssClass="requiredField" ControlToValidate="textBoxSurName" ValidationExpression="[a-zA-ZåäöÅÄÖ]+" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" Enabled="false" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelEmail" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxEmail" Width="200" runat="server" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorEmail1" CssClass="requiredField" ControlToValidate="textBoxEmail" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" />
			<asp:RegularExpressionValidator id="emailValidator" CssClass="requiredField" ControlToValidate="textBoxEmail" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelDateOfBirth" runat="server" /></td>
		<td>
			<asp:DropDownList id="dropDownListDateYear" Runat="server" CssClass="input" AutoPostBack="true" style="margin-top:1px; margin-bottom:2px; margin-right:2px" onselectedindexchanged="dropDownListDateYear_SelectedIndexChanged" /><asp:DropDownList id="dropDownListDateMonth" Runat="server" CssClass="input" AutoPostBack="true" style="margin-top:1px; margin-bottom:2px; margin-right:2px" onselectedindexchanged="dropDownListDateMonth_SelectedIndexChanged" /><asp:DropDownList id="dropDownListDateDay" Runat="server" CssClass="input" Width="39" style="margin-top:1px; margin-bottom:2px; margin-right:2px;" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelLanguage" Runat="server" /></td>
		<td><asp:DropDownList id="dropDownListLanguage" runat="server" Width="200" CssClass="input" /></td>
	</tr>
	<tr>
		<td><asp:Label id="labelUserName" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxUserName" Width="200" runat="server" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorUserName" runat="server" ControlToValidate="textBoxUserName" CssClass="requiredField" ErrorMessage="*" Display="Dynamic" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td><asp:Label ID="labelAlias" runat="server"></asp:Label></td>
		<td>
			<asp:TextBox ID="textBoxAlias" runat="server" Width="200" CssClass="input" />
			<asp:RequiredFieldValidator ID="validatorAlias" runat="server" ControlToValidate="textBoxAlias" CssClass="requiredField" ErrorMessage="*" Display="Dynamic" EnableClientScript="false" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelPassword" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxPassword" TextMode="Password" runat="server" Width="200" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorPassword" ControlToValidate="textBoxPassword" CssClass="requiredField" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" />
		</td>
	</tr>
	<tr>
		<td><asp:Label id="labelConfirmPassword" runat="server" /></td>
		<td>
			<asp:TextBox id="textBoxConfirmPassword" TextMode="Password" runat="server" Width="200" CssClass="input" />
			<asp:RequiredFieldValidator id="validatorConfirmPassword1" ControlToValidate="textBoxConfirmPassword" CssClass="requiredField" ErrorMessage="*" Runat="server" Display="Dynamic" EnableClientScript="False" />
			<asp:CompareValidator id="validatorConfirmPassword2" ControlToValidate="textBoxConfirmPassword" ControlToCompare="textBoxPassword" CssClass="requiredField" ErrorMessage="*" Runat="server" Operator="Equal" Type="String" Display="Dynamic" EnableClientScript="False" /> 
		</td>
	</tr>
</table>
<br />
<table cellSpacing="0" cellPadding="0" border="0" class="epi-default">
	<thead>
		<tr>
			<th colspan="5"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.MemberOf") %></th>
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
		<td colspan="2" class="epi-table-absolutePadding"><asp:ListBox id="listBoxAvailableGroups" runat="server" Width="100%" Height="88" CssClass="input" SelectionMode="Multiple"></asp:ListBox></td>
		<td class="epi-alignMiddle" width="24"><asp:Button id="buttonAddGroupToList" runat="server" Width="24" Height="47" CssClass="button" Text=">" CausesValidation="false"></asp:Button></td>
		<td class="epi-table-absolutePadding">
		    <asp:ListBox id="listBoxSelectedGroups" runat="server" Width="100%" Height="88" CssClass="input" SelectionMode="Multiple"></asp:ListBox>
		    <br />
            <asp:CustomValidator runat="server" ID="validatorGroupsNotExist" ErrorMessage="*" CssClass="requiredField" onservervalidate="validatorGroups_ServerValidate"></asp:CustomValidator>
		</td>
		<td class="epi-alignTop" width="16"><asp:LinkButton id="linkButtonRemoveGroupFromList" style="cursor:hand;" runat="server" CausesValidation="false"><img src="../images/general/remove.png" width="16" height="16" border="0"></asp:LinkButton></td>
	</tr>
</table>