<%@ Page language="c#" Codebehind="ChangedPages.aspx.cs" AutoEventWireup="false" Inherits="development.ChangedPages" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="ChangedPages"		Src="~/templates/Units/ChangedPages.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_HeadPrint.ascx"%>

<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<!-- Print_start -->
					<episerver:property PropertyName="MainBody" runat="server" ID="Property1" />
					
					<br><br>
					
					<development:ChangedPages id="ChangedPages" runat="server"></development:ChangedPages>
					<!-- Print_end -->
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>