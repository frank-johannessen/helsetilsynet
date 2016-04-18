<%@ Page language="c#" Codebehind="NotImplemented.aspx.cs" AutoEventWireup="false" Inherits="development.NotImplemented" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" ID="notImplementedContent" runat="server">
		<h3><episerver:translate Text="#notimplemented" runat="server" ID="Translate3" /></h3>
	</EPiServer:Content>
</development:DefaultFramework>