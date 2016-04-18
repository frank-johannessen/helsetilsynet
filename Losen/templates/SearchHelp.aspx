<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="SearchHelp.aspx.cs" AutoEventWireup="false" Inherits="development.SearchHelp" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/Units/header.ascx"%>
<HTML>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
	</HEAD>
	<body leftmargin="20" topmargin="20" marginwidth="0" marginheight="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
		<form runat="server" id="_default">
			<episerver:property id="Property3" runat="server" propertyname="SearchHelp" />
			<br>
			<a href="javascript:this.close()">Lukk </a>
		</form>
	</body>
</HTML>
