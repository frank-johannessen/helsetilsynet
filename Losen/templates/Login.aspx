<%@ Page language="c#" Codebehind="Login.aspx.cs" AutoEventWireup="false" Inherits="development.Login" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<episerver:translate Text="#logintitle" runat="server" ID="Translate3" /></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="../styles/episerver3.css">
	</HEAD>
	<body>
		<div align="center">
			<h1 class="login"><episerver:translate Text="#loginheading" runat="server" ID="Translate1" /></h1>
			<form id="Login" method="post" runat="server">
				<div class="loginBox">
					<table width="100%" height="100%" border="0">
						<tr class="login">
							<td class="login" colspan="2">
								<h2 class="login"><asp:Label Runat="server" ID="Message" /></h2>
								<asp:RequiredFieldValidator id="RequiredUsernameValidator" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="Username" />
							</td>
						</tr>
						<tr class="login">
							<td class="login" valign="center" align="left"><EPiServer:Translate Text="#username" runat="server" ID="UsernameLabel" /></td>
							<td class="login" valign="center" align="right"><asp:TextBox cssClass="loginInput" id="Username" runat="server"></asp:TextBox></td>
						</tr>
						<tr class="login">
							<td class="login" valign="center" align="left"><EPiServer:Translate Text="#password" runat="server" ID="PasswordLabel" /></td>
							<td class="login" valign="center" align="right"><asp:TextBox cssClass="loginInput" id="Password" runat="server" TextMode="Password"></asp:TextBox></td>
						</tr>
						<tr class="login">
							<td class="login" colspan="2"><asp:checkbox id="PersistCookie" runat="server" />
								<EPiServer:Translate Text="#persistentlogin" runat="server" ID="PersistentLabel" /></td>
						</tr>
						<tr class="login">
							<td class="login" align="right" colspan="2"><asp:button cssClass="loginButton" id="LoginButton" runat="server" Translate="/button/login"></asp:button></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</HTML>
