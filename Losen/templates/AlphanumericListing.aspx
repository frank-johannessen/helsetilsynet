<%@ Page language="c#" Codebehind="AlphanumericListing.aspx.cs" AutoEventWireup="false" Inherits="development.AlphanumericListing" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="AlphanumericListing"	Src="~/templates/Units/AlphanumericListing.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<development:DefaultFramework ID="Defaultframework1" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<development:AlphanumericListing id="Alphanumericlisting1" runat="server"></development:AlphanumericListing>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>