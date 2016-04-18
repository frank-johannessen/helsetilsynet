<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Page language="c#" Codebehind="SearchGroupsAndUsers.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.Security.SearchGroupsAndUsers" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>SearchGroupsAndUsers</title>
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
		<form id="SearchGroupsAndUsers" method="post" runat="server">
		    <h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.SearchUsersAndGroups")%></h1>
			<asp:Panel id="panelError" Visible="false" Runat="server">
				<table cellSpacing="0" cellPadding="0" border="0">
					<tr>
						<td valign="top"><img height="32" src="../images/error/404.png" width="32" border="0"></td>
						<td valign="top"><asp:Label id="labelErrorMessage" runat="server" /></td>
					</tr>
				</table>
				<br />
			</asp:Panel>
			<asp:Panel id="panelSearchGroupsAndUsers" Width="100%" Runat="server">
				<table width="100%" class="epi-default" cellpadding="0" cellspacing="0" border="0">
					<thead>
						<tr>
							<th><asp:Label ID="labelName" Runat="server" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td nowrap><asp:Label id="labelSearchFor" CssClass="label" Runat="server" /></td>
										<td nowrap width="10"><img src="../images/pixel.gif" width="10" height="1"></td>
										<td nowrap><asp:TextBox id="textBoxSearchFor" Width="200" CssClass="input" Runat="server" style="margin-right:2px;" /></td>
										<td nowrap><asp:DropDownList id="dropDownListSearchBy" CssClass="input" Runat="server" style="margin-right:2px;" /></td>
										<td nowrap><asp:Button id="buttonSearch" CssClass="button" Runat="server" onclick="buttonSearch_Click" /></td>
										<td width="100%">&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
				<asp:Panel id="panelSearchResults" Width="100%" Visible="false" Runat="server">
					<br /><asp:Table id="tblSearchResults" Width="100%" CellPadding="0" CellSpacing="0" Runat="server" CssClass="epi-default">
							<asp:TableRow CssClass="thead"><asp:TableCell ColumnSpan="4">Search Result</asp:TableCell></asp:TableRow>
						  </asp:Table>
				</asp:Panel>
			</asp:Panel>
		</form>
	</body>
</html>
