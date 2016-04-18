<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccessRights.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Security.AccessRights" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration.Security" %>
<%@ Register Src="~/EPiServerCommunity/Security/SecurityEntryLink.ascx" TagName="Link" TagPrefix="community" %>

<h2><%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.Members")%></h2>

<asp:Repeater runat="server" ID="RepeaterMain" OnItemCommand="RepeaterMain_ItemCommand">
    <HeaderTemplate>
    
<table class="epi-default">
    <thead>
        <tr>
            <th>
                <%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.labelGroupsUsers")%>
            </th>
            
        <asp:Repeater runat="server" ID="RepeaterNames" DataSource='<%# Properties %>'>
            <ItemTemplate>
                <th>
                    <%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.AccessLevel" + ((PropertyInfo)Container.DataItem).Name)%>
                </th>
            </ItemTemplate>
        </asp:Repeater>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
    
    </HeaderTemplate>
    <ItemTemplate>
        
        <tr>
            <td>
                <community:Link runat="server" ID="LinkRights" Entry='<%# Eval("Entry") %>' />
            </td>
        <asp:Repeater runat="server" ID="RepeaterRights" DataSource='<%# Eval("Rights") %>'>
            <ItemTemplate>
                <td>
                    <asp:CheckBox runat="server" ID="CheckBoxRights" Checked='<%# Container.DataItem %>' />
                </td>
            </ItemTemplate>
        </asp:Repeater>
            <td>
                <asp:Button runat="server" ID="ButtonRemove" CssClass="adminButton" CommandName="Remove" CommandArgument='<%# Eval("Entry") %>'
                    Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.buttonRemoveAccess") %>' />
            </td>
        </tr>
        
    </ItemTemplate>
    <FooterTemplate>
    
    </tbody>
</table>
        
    </FooterTemplate>
</asp:Repeater>
<asp:PlaceHolder runat="server" ID="PlaceHolderEmpty" Visible="false">
    <div class="adminPanel">
        <span><%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.labelEmpty")%></span>
    </div>
</asp:PlaceHolder>