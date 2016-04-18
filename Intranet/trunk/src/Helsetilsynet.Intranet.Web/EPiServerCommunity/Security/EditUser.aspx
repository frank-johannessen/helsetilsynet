<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Page language="c#" Codebehind="EditUser.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.EditUserPage" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="EditUserTabPageUserSettings" Src="EditUserTabPageUserSettings.ascx" %>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
	<head>
		<title>EditUser</title>
        <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
        <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
        
        <link href="../styles/main.css" type="text/css" rel="stylesheet" />
        <link href="../styles/tabstrip.css" type="text/css" rel="stylesheet">
        <link href="../Administration.css" type="text/css" rel="stylesheet" />
		<!--[if gte IE 5.5000]>
			<SCRIPT src="../js/pngfix.js" type="text/javascript"></SCRIPT>
		<![endif]-->
		<script type='text/javascript'>
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function TestOfficeAddin()
		{
			if(!document.getElementById("componentTable"))
			{
		        return;
		    }
		}
		
		function onLoad()
		{
		    if(window.TestClientTools)
		    {
		        TestClientTools();
		    } 
		    if(window.TestOfficeAddIn)
		    { 
		        TestOfficeAddIn();
		    }
		}	
	
	</script>	
	</head>
	<body id="adminPage">
		<form id="EditUser" method="post" runat="server">
		    <h1><%= PageTitle %></h1>
		    <sc:SaveResultPanel ID="saveResultPanel" runat="server" />
		    <asp:CustomValidator ID="removalValidator" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>
			<table cellpadding="0" cellspacing="0" border="0" class="epi-default">
				<thead>
					<tr>
						<th><asp:Label id="labelName" runat="server" /></th>
					</tr>
				</thead>
				<tbody>
					<asp:Panel id="panelEditUserMainProceed" width="100%" visible="false" runat="server" style="padding:10px;">
						<tr>
							<td><asp:Label id="labelProceedMessage" runat="server" /></td>
						</tr>
						<tr>
							<td><asp:Button id="buttonAddUser" CssClass="button" runat="server" onclick="buttonAddUser_Click" /></td>
						</tr>
					</asp:Panel>
					<asp:Panel ID="panelEditUserMenu" Runat="server">
						<tr>
							<td><asp:Button ID="buttonSave" Runat="server" CssClass="button" />&nbsp;<span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.EditUser.RemoveWarning") %>')"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" /></span></td>
						</tr>
					</asp:Panel>
				</tbody>
			</table><br />
			<asp:Panel id="panelEditUserError" visible="false" runat="server">
				<table class="epi-default" cellSpacing="0" cellPadding="0" border="0">
					<tr>
						<td valign="top" width="32"><img height="32" src="../images/general/404.png" width="32" border="0"></td>
						<td valign="top"><asp:Label id="labelErrorMessage" runat="server" /></td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Panel id="panelEditUserMain" width="100%" CssClass="panelBorder" runat="server">
				<asp:Panel id="panelEditUserMainTabPage" width="100%" runat="server">
					<uc1:EditUserTabPageUserSettings id="tabPageUserSettings" runat="server"></uc1:EditUserTabPageUserSettings>
				</asp:Panel>
			</asp:Panel>
		</form>
	</body>
</html>