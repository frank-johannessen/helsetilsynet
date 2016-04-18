<%@ Page language="c#" Codebehind="SearchAndReplace.aspx.cs" AutoEventWireup="false" Inherits="Avenir.SearchAndReplace" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SearchAndReplace</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="~/util/styles/system.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="SearchAndReplace" method="post" runat="server">
			<h2>Search and replace</h2>
			<br>
			<table>
				<tr>
					<td>Property name</td>
					<td><asp:TextBox Runat="server" ID="SearchProperty" /></td>
				</tr>
				<tr>
					<td>Find value</td>
					<td><asp:TextBox Runat="server" ID="SearchValue" /></td>
				</tr>
				<tr>
					<td>Replace with</td>
					<td><asp:TextBox Runat="server" ID="ReplaceWithValue" /></td>
				</tr>
			</table>
			<br>
			<asp:Button Runat="server" Text="Search" ID="SearchButton"></asp:Button>&nbsp;
			<asp:Button Runat="server" Text="Search and replace" ID="SearchAndReplaceButton"></asp:Button>
			<br>&nbsp;<br>
			<b><asp:Label Runat="server" ID="Message" /></b>
			<br>&nbsp;<br>
			<asp:DataGrid Runat="server" ID="ResultForm" AutoGenerateColumns="True" runat="server" AlternatingItemStyle-BackColor="#eeeeee" HeaderStyle-BackColor="#cccccc" PageSize="10" Cellpadding="4" EnableViewState="True"></asp:DataGrid>
		</form>
	</body>
</HTML>
