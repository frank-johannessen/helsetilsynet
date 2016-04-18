<%@ Page Language="c#" CodeBehind="ModuleAccessRights.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.ModuleAccessRights" %>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Register Src="AccessRights.ascx" TagPrefix="comm" TagName="AccessRights" %>
<%@ Register Src="SecurityEntrySearch.ascx"TagPrefix="comm" TagName="SecurityEntrySearch" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../SaveResultPanel.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>ModuleAccessRights</title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="../styles/main.css" type="text/css" rel="stylesheet" />
    <link href="../styles/tabstrip.css" type="text/css" rel="stylesheet">
    <link href="../Administration.css" type="text/css" rel="stylesheet" />
</head>
<body id="adminPage">
    <form id="ModuleAccessRights" method="post" runat="server">
        <sc:SaveResultPanel id="saveResultPanel" runat="server" />
        <h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.ModulesAccessRights")%></h1>
        <table class="epi-default" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <span><%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.ModuleAccessRights.labelModule")%></span>
                    <asp:DropDownList runat="server" ID="DropDownListModule" CssClass="input" DataTextField="Text" DataValueField="Value" />
                    <asp:Button runat="server" ID="ButtonModule" CssClass="adminButton" OnClick="ButtonModule_Click"
                        Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.ModuleAccessRights.buttonSelect") %>' />
                </td>
            </tr>
        </table>
        <comm:AccessRights runat="server" ID="AccessRightsMain" OnCommand="AccessRights_Command" />
        <div class="epi-buttonContainer">
            <asp:Button runat="server" ID="ButtonSave" CssClass="adminButton" OnClick="ButtonSave_Click"
                Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.itemSave") %>' />
        </div>
        <br /><br />
        
        <comm:SecurityEntrySearch runat="server" ID="SecurityEntrySearch" OnCommand="SecurityEntrySearch_Command" />
    </form>
</body>
</html>
