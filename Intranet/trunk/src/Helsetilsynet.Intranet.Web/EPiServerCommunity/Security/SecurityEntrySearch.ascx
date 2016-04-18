<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecurityEntrySearch.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Security.SecurityEntrySearch" %>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Register Src="~/EPiServerCommunity/Security/SecurityEntryLink.ascx" TagName="Link" TagPrefix="community" %>

<h2><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.SearchUsersAndGroups")%></h2>
<table class="epi-default" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <span><%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.SearchGroupsAndUsers.labelSearchFor")%></span>
            <asp:TextBox runat="server" ID="TextBoxSearch" CssClass="input" />
            <span class="divider">&nbsp;</span>
            <span><%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.SearchGroupsAndUsers.labelSearchIn")%></span>
            <asp:DropDownList runat="server" ID="DropDownListType" CssClass="input" DataTextField="Text" DataValueField="Value" />
            <span class="divider">&nbsp;</span>
            <asp:Button runat="server" ID="ButtonSearch" CssClass="adminButton" OnClick="ButtonSearch_Click"
                Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.SearchGroupsAndUsers.buttonSearch") %>' />
        </td>
    </tr>
</table>

<asp:Repeater runat="server" ID="RepeaterSearch" OnItemCommand="RepeaterSearch_ItemCommand">
    <HeaderTemplate>
    
<table class="epi-default" cellpadding="0" cellspacing="0">
    <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td class="first">
                <community:Link runat="server" ID="LinkRights" Entry='<%# Container.DataItem %>' />
            </td>
            <td class="last">
                <asp:Button runat="server" ID="ButtonAdd" CssClass="adminButton" CommandName="Add" CommandArgument='<%# Container.DataItem %>'
                    Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.SearchGroupsAndUsers.buttonAdd") %>' />
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
    </tbody>
</table>

    </FooterTemplate>
</asp:Repeater>
<asp:PlaceHolder runat="server" ID="PlaceHolderEmpty" Visible="false">

<table class="epi-default" cellpadding="0" cellspacing="0">
    <tr>
        <td><%# GetEmptyMessage() %></td>
    </tr>
</table>

</asp:PlaceHolder>
