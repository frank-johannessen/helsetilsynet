<%@ Page language="c#" Codebehind="KeywordListPage.aspx.cs" AutoEventWireup="false" Inherits="development.KeywordListPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="KeyWordList"	Src="~/templates/Units/KeyWordList.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<development:DefaultFramework ID="Defaultframework1" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content Region="RegionBody" ID="FormContent" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<development:KeyWordList id="KeyWordList" runat="server"></development:KeyWordList>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>