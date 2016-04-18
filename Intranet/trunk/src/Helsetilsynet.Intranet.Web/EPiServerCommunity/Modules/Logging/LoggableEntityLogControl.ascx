<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoggableEntityLogControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.LoggableEntityLogControl" %>

<link rel="stylesheet" type="text/css" href="Administration.css" />
<script language="javascript" type="text/javascript" src="Administration.js"></script>

<table width="100%" class="epi-default">
    <tr>
        <td style="padding-left:5px;" colspan="5">
            <div class="section"><asp:Label ID="labelType" runat="server" /></div>
        </td>
    </tr>
    <tr>
        <td class="label">Log ID</td>
        <td class="label">Type</td>
        <td class="label">User</td>
        <td class="label">IP</td>
        <td class="label">Created</td>
    </tr>
    
    <asp:Repeater ID="repeaterLogEntries" runat="server">
        <ItemTemplate>
            <tr>
                <td class="label"><%# DataBinder.Eval(Container.DataItem, "ID") %></td>
                <td class="label"><%# DataBinder.Eval(Container.DataItem, "LogType") %></td>
                <td class="label"><%# GetUser((EPiServer.Common.Security.IUser)DataBinder.Eval(Container.DataItem, "User")) %></td>
                <td class="label"><%# DataBinder.Eval(Container.DataItem, "IP") %></td>
                <td class="label"><%# AdministrationUtils.FormatDateTime((DateTime)DataBinder.Eval(Container.DataItem, "Created")) %></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
</table>