<%@ Page language="c#" Codebehind="CategoryPage.aspx.cs" AutoEventWireup="false" Inherits="development.CategoryPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="CategoryList"			Src="~/templates/Units/CategoryList.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server"></EPiServer:Content>
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">
		<style>
body {
	background-image: url(/images/bg_list_dot.gif);
}
</style>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body">
					<!-- print_start -->
					<development:CategoryList id="CategoryList" runat="server"></development:CategoryList>
					<!-- print_end -->
				</td>
				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links id="Links" runat="server"></development:Links>
				</td>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
