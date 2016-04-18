<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Page language="c#" Codebehind="EditGroup.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.Security.EditGroup" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="ss" TagName="EditGroupTabPageGroupSettings" Src="EditGroupTabPageGroupSettings.ascx" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>EditGroup</title>
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
		<form id="EditGroup" method="post" runat="server">
		    <h1><%= PageTitle %></h1>
        	<sc:SaveResultPanel id="saveResultPanel" runat="server" />
	        <asp:CustomValidator ID="groupValidator" runat="server" Display="None" EnableClientScript="False"></asp:CustomValidator>
		
			<table cellpadding="0" cellspacing="0" border="0" class="epi-default">
				<thead>
					<tr>
						<th><asp:Label ID="labelName" Runat="server" /></th>
					</tr>
				</thead>
				<tbody>
					<asp:Panel id="panelEditGroupMainProceed" width="100%" visible="false" runat="server">
						<tr>
							<td><asp:Label id="labelProceedMessage" CssClass="editLabel" runat="server" /></td>
						</tr>
						<tr>
							<td align="right"><asp:Button id="buttonAddGroup" CssClass="button" runat="server" onclick="buttonAddGroup_Click" /></td>
						</tr>
					</asp:Panel>
					<asp:Panel ID="panelEditGroupMenu" Runat="server">
						<tr>
							<td><asp:Button ID="buttonSave" Runat="server" CssClass="button" />&nbsp;<span onclick="return confirm('<% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Common.EditGroup.RemoveWarning") %>')"><asp:Button ID="buttonRemove" Runat="server" CssClass="button" /></span></td>
						</tr>
					</asp:Panel>
				</tbody>
			</table><br />
			<asp:Panel id="panelEditGroupError" visible="false" runat="server">
				<table cellSpacing="0" cellPadding="0" border="0" class="epi-default">
					<tr>
						<td valign="top" width="32"><img height="32" src="../images/general/404.png" width="32" border="0"></td>
						<td valign="top"><asp:Label id="labelErrorMessage" runat="server"></asp:Label></td>
					</tr>
				</table>
				<br />
			</asp:Panel>
			<asp:Panel id="panelEditGroupMain" width="100%" runat="server" CssClass="panelBorder">
				<asp:Panel id="panelEditGroupMainTabPage" width="100%" runat="server">
					<ss:EditGroupTabPageGroupSettings id="tabPageGroupSettings" runat="server" />
				</asp:Panel>
			</asp:Panel>
		</form>
	</body>
</html>