<%@ Page language="c#" Codebehind="PrintPageDemo.aspx.cs" AutoEventWireup="false" Inherits="development.PrintPageDemo" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFrameworkPrint"	Src="~/templates/Frameworks/DefaultFrameworkPrint.ascx"%>

<development:DefaultFrameworkPrint ID="DefaultFrameworkPrint" runat="server">

	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">	

		<episerver:property PropertyName="PageHeader" CssClass="PrintTitle" runat="server" id="Property2" /><br><br>
		<episerver:property PropertyName="MainIntro" CssClass="PrintIntro" runat="server" id="Property1" />
		<episerver:property PropertyName="MainBody" runat="server" id="Property3" />

	</EPiServer:Content>
</development:DefaultFrameworkPrint>
