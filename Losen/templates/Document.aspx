<%@ Page language="c#" Codebehind="Document.aspx.cs" AutoEventWireup="false" Inherits="development.Document" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"	Src="~/templates/Units/Sec_Doc_Head.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server" />
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body">
					<episerver:property PropertyName="MainIntro" runat="server" ID="Property1" />
					<br>
					<%#((EPiServer.PageBase)Page).CurrentPage["Link"]%>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
