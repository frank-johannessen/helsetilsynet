<%@ Control Language="c#" AutoEventWireup="True" Codebehind="AccessRightsControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Security.AccessRightsControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<link rel="stylesheet" type="text/css" href="Administration.css" >
<script src="Administration.js"></script>
<script language="javascript">
    SCSetTitle('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Security.AccessRights.Title") %>');
</script>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" class="epi-default">
    <thead>
        <tr>
	        <th><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Security.AccessRights.Title") %></th>
        </tr>	
    </thead>
    <tr>
	    <td><asp:Button ID="buttonSave" Runat="server" CssClass="button"></asp:Button></td>
    </tr>
    <tr>
	    <td><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Security.AccessRights.searchText") %>:&nbsp;&nbsp;<asp:TextBox id="textBoxSearchFor" runat="server" width="200" CssClass="input"></asp:TextBox>&nbsp;
		    <asp:DropDownList id="dropDownListSearchBy" runat="server" CssClass="input"></asp:DropDownList>&nbsp;
		    <asp:Button id="buttonSearch" runat="server" CssClass="button"></asp:Button></td>
    </tr>
</table>

<br />
<asp:Panel ID="panelAccessRightsToAdd" Runat="server" Visible="False">
<asp:Table id="tableAccessRightsToAdd" runat="server" CellPadding="0" CellSpacing="0" CssClass="epi-default" Width="100%"></asp:Table>
<asp:Label runat="server" ID="NoSearchHitsFoundMessage" />
</asp:Panel>
<br />

<asp:Table id="tableExistingAccessRights" runat="server" CellPadding="0" CellSpacing="0" CssClass="epi-default" Width="100%"></asp:Table>
