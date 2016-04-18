<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="editlanguage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditLanguage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>editlanguage</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../util/styles/system.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<EPiServerSys:systemprefix id="SystemPrefix" runat="server"/>
		<form id="EditLanguage" method="post" runat="server">
			<table>
				<asp:Repeater id="CultureRepeater" runat="server">
					<ItemTemplate>
						<tr>
							<td><%# DataBinder.Eval( Container.DataItem, "EnglishName" ) %></td>
							<td><%# DataBinder.Eval( Container.DataItem, "Name" ) %></td>
							<td><%# DataBinder.Eval( Container.DataItem, "DateTimeFormat" ) %></td>
							<td><%# DataBinder.Eval( Container.DataItem, "Charset" ) %></td>
							<td><%# DataBinder.Eval( Container.DataItem, "IsInstalled" ) %></td>
						</tr>
					</ItemTemplate>
				</asp:Repeater>
			</table>
		</form>
	</body>
</HTML>
