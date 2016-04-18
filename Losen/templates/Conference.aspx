<%@ Page language="c#" Codebehind="Conference.aspx.cs" AutoEventWireup="false" Inherits="development.Conference" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Conference"	Src="~/templates/Units/Conference.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="BreadCrumbs"		Src="~/templates/Units/BreadCrumbs.ascx"%>
<development:DefaultFramework ID="Defaultframework1" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<!-- Print_start -->
					<development:Conference id="Conference1" runat="server"></development:Conference>
					<!-- Print_end -->
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>