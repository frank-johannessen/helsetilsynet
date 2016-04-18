<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LoginStatus.ascx.cs" Inherits="development.UserControls.LoginStatus" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table width="100%" cellpadding="1" cellspacing="1" bgcolor="#ededf3" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td height="20" width="15"><img width="15" alt="" src="~/images/os.gif" runat="server" ID="Img3"></td>
		<td>
			<asp:Label Runat="server" ID="UserName" CssClass="LoginUser" />
			<asp:LinkButton Runat="server" ID="Login" CssClass="LoginButton">
				<EPiServer:Translate Text="/templates/page/login" runat="server" ID="UsernameLabel" />
			</asp:LinkButton>
			<asp:LinkButton Runat="server" ID="Logout" CssClass="LoginButton">
				<EPiServer:Translate Text="/templates/page/logout" runat="server" ID="Translate1" />
			</asp:LinkButton>
		</td>
	</tr>
	<tr>
		<td height="1" width="100%" colspan="2" bgcolor="white"><img width="1" height="1" src="~/images/os.gif" alt="" runat="server" ID="Img4"></td>
	</tr>
</table>
