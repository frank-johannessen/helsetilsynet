<%@ Page language="c#" Codebehind="MobileInfo.aspx.cs" AutoEventWireup="false" Inherits="development.MobileInfo" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>

<development:DefaultFramework ID="Defaultframework1" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<episerver:translate id="Translate2" runat="server" text="#maininfo"></episerver:translate>
	</EPiServer:Content>
</development:DefaultFramework>