<%@ Page language="c#" Codebehind="AdministrativeAccessRights.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.AdministrativeAccessRights" %>
<%@ Import Namespace="EPiServer.Community.Web.Administration"%>
<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Register Src="AccessRights.ascx" TagPrefix="comm" TagName="AccessRights" %>
<%@ Register Src="SecurityEntrySearch.ascx"TagPrefix="comm" TagName="SecurityEntrySearch" %>

<!DOCTYPE HTML>
<html>
  <head>
    <title>AdministrativeAccessRights</title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="../styles/main.css" type="text/css" rel="stylesheet" />
    <link href="../styles/tabstrip.css" type="text/css" rel="stylesheet">
    <link href="../Administration.css" type="text/css" rel="stylesheet" />
  </head>
  <body id="adminPage">
    <form id="AdministrativeAccessRights" method="post" runat="server">
        <h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.AdministrativeAccessRights")%></h1>
        
		<comm:AccessRights runat="server" ID="AccessRightsMain" OnCommand="AccessRights_Command" />
        <div class="epi-buttonContainer">
            <asp:Button runat="server" ID="ButtonSave" CssClass="adminButton" OnClick="ButtonSave_Click" Text='<%# GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.AdministrativeAccessRights.itemSave") %>' />
        </div>
        <br /><br />
        
        <comm:SecurityEntrySearch runat="server" ID="SecurityEntrySearch" OnCommand="SecurityEntrySearch_Command" />
    </form>
  </body>
</html>
