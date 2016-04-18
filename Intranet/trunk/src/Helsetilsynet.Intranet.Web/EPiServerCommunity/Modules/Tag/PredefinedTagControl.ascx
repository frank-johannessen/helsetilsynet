<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PredefinedTagControl.ascx.cs"
    Inherits="EPiServer.Community.Web.Administration.PredefinedTagControl" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script type="text/javascript">
    function confirmDelete() {
        if (confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.deleteTagWarning")%>') == true)
            return true;
        else
            return false;
    }

    var RefreshTagList = function() { 
        <%=Page.ClientScript.GetPostBackEventReference(this,"") %>;
    }
</script>	

<script language="javascript" type="text/javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css" />

<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.Tags")%></h1>
<% if (AdminAccess)
   { %>
        <asp:Button ID="CreateTagButton" CssClass="button" OnClientClick="SCCreatePredefinedTagInfo('<%= this.UniqueID %>'); return false;" runat="server" style="margin-bottom:10px;" />
    <% } %>


<table class="epi-default" cellpadding="0" cellspacing="0">
    <thead>
        <tr>
            <th colspan="2">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.HeaderResult")%>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.inputType")%>:
            </td>
            <td>
                <asp:DropDownList ID="DropDownObjectTypes" runat="server" CssClass="input" AutoPostBack="true"
                    OnSelectedIndexChanged="DropDownObjectTypes_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr runat="server" id="rowHeader">
            <th class="th" align="left">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.ResultNameTitle")%>
            </th>
            <th class="th" align="left">
                &nbsp;
            </th>
        </tr>
        <asp:DataList ID="DataListPredefinedTags" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
            OnItemCreated="DataListPredefinedTags_ItemCreated" OnDeleteCommand="DataListPredefinedTags_Remove">
            <ItemTemplate>
                <tr>
                    <td>
                        <a href="javascript:SCOpenPredefinedTagInfo('<%= this.UniqueID %>', '<%# DataBinder.Eval(Container.DataItem, "Tag.ID") %>');"><%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Tag.Name")) %></a> 
                    </td>
                    <td align="right">
                        <asp:Button ID="ButtonRemove" runat="server" CssClass="button" OnClientClick="return confirmDelete()" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Tag.ID") %>'
                            CommandName="Delete" Visible="<%# AdminAccess %>" />&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:DataList>
        <tr runat="server" id="rowNoResult">
            <td colspan="2">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Tag.Predefined.NoResult") %>.
            </td>
        </tr>
    </tbody>
</table>
