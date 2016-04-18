<%@ Page language="c#" Codebehind="AccessDenied.aspx.cs" AutoEventWireup="True" Inherits=" EPiServer.Community.Web.Administration.AccessDenied" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title><% = EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("AccessDenied.labelErrorMessage") %></title>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="styles/main.css" type="text/css" rel="stylesheet" />
    <link href="Administration.css" type="text/css" rel="stylesheet" />
		<!--[if gte IE 5.5000]>
			<script src="js/pngfix.js" type="text/javascript"></script>
		<![endif]-->
	</head>
	<body id="adminPage">
		<form id="AccessDenied" method="post" runat="server">
			<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" class="epi-default">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" class="epi-default" align="center" style="width: 150px">
							<tr>
								<td width="32"><img src="images/security/access_denied_large.png" width="32" height="32" border="0"></td>
								<th align="left"><asp:Label id="labelErrorMessage" runat="server" /></th>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>