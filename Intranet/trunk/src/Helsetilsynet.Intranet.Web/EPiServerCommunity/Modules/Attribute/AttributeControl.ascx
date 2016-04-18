<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttributeControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AttributeControl" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<link rel="stylesheet" type="text/css" href="Administration.css" />

<script language="javascript" type="text/javascript" src="Administration.js"></script>

<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.Attributes")%></h1>
<% if (AdminAccess)
   { %>
    <button class="button" onclick="SCAttributeOpenAttributeInfo(-1, '<% = this.UniqueID %>');return false;" style="margin-bottom: 10px;">
    <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.CreateNew")%>
    </button>       
<% } %>

<table class="epi-default" cellpadding="0" cellspacing="0">
    <thead>
        <tr>
            <th colspan="3">
                <% = String.Format(EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.SearchResult"), dropDownObjectTypes.SelectedItem.Text) %>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="3">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.TypeFilter")%>:&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="dropDownObjectTypes" runat="server" CssClass="input" AutoPostBack="true" OnSelectedIndexChanged="dropDownObjectTypes_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr runat="server" id="rowHeader">
            <th align="left">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.HeaderAttribute")%>
            </th>
            <th align="left">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.HeaderType")%>
            </th>
            <th align="left">
                &nbsp;
            </th>
        </tr>
        <asp:DataList ID="dataListAttributes" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="ID" OnItemCreated="dataListAttributes_ItemCreated" OnDeleteCommand="dataListAttributes_Remove">
            <ItemTemplate>
                <tr>
                    <td>
                        <a href="javascript:SCAttributeOpenAttributeInfo(<%# DataBinder.Eval(Container.DataItem, "ID") %>, '<% = this.UniqueID %>');">
                            <%# AdministrationUtils.FormatString((string)DataBinder.Eval(Container.DataItem, "Name")) %>
                        </a>
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "DataType.Type") %>
                    </td>
                    <td align="right">
                        <asp:Button ID="buttonRemove" runat="server" CssClass="button" CommandName="Delete" OnClientClick="<%# RemoveConfirmationMessage %>" Visible="<%# AdminAccess %>" />&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:DataList>
        <tr runat="server" id="rowNoResult">
            <td colspan="2">
                <% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Attribute.List.NoResult")%>.
            </td>
        </tr>
    </tbody>
</table>
