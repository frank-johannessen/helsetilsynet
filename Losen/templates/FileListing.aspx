<%@ Page language="c#" Codebehind="FileListing.aspx.cs" AutoEventWireup="false" Inherits="development.FileListing" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_HeadPrint.ascx"%>

<development:DefaultFramework ID="Defaultframework1" runat="server">
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
					
					<EPiServer:FileTree runat="server" ID="Filetree1" rootpath='<%#CurrentPage["WebBaseURL"]%>' expansionmode="Manual" filenamepattern="*.*" />
					<!-- Print_end -->
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>