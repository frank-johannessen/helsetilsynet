<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tags.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Tags" %>

<table class="epi-default" cellpadding="0" cellspacing="0">
<thead>
		<tr>
			<th colspan="4"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.EntityEditorExtensions.Tags.Header")%></th>
		</tr>
</thead>
<tbody>
    <tr>
        <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.EntityEditorExtensions.Tags.inputPredefinedTags")%>:</td>
        <td colspan="3"><asp:DropDownList ID="dropDownPredefinedTags" runat="server" CssClass="input" OnSelectedIndexChanged="dropDownPredefinedTags_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList></td>
    </tr>
	<tr>
		<td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.EntityEditorExtensions.Tags.inputTagName")%>:</td>
		<td>
		    <asp:TextBox ID="textBoxTagName" runat="server" CssClass="input" MaxLength="100" Width="120"></asp:TextBox>
		</td>
		<td colspan="2" align="right"><asp:Button ID="buttonAddTag" runat="server" CssClass="button" OnClick="buttonAddTag_Click" /></td>
	</tr>
</tbody>
</table>

<br />

<table class="epi-default" cellpadding="0" cellspacing="0">
<thead>
		<tr>
			<th colspan="2"><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.EntityEditorExtensions.Tags.HeaderResult")%></th>
		</tr>
</thead>
	
<tbody>

<asp:DataList ID="dataListTags" runat="server" RepeatLayout="Flow" 
	RepeatDirection="Horizontal" DataKeyField="Name" OnItemCreated="dataListTags_ItemCreated" 
	OnDeleteCommand="dataListTags_Remove">
	<ItemTemplate>
		<tr>
			<td><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem,"Name")) %></td>
			<td align="right"><asp:Button ID="buttonRemove" runat="server" CssClass="button" CommandName="Delete" /></td>
		</tr>
	</ItemTemplate>
</asp:DataList>
</tbody></table>