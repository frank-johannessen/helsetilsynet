<%@ Page language="c#" Codebehind="ArticleWithArticleList.aspx.cs" AutoEventWireup="false" Inherits="development.ArticleWithArticleList" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<%@ Register TagPrefix="development" TagName="ArticleList"			Src="~/templates/Units/ArticleList.ascx"%>

<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHeadPrint id="SectionHeadPrint" runat="server"></development:SectionHeadPrint>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server" />
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">
		<style>
			body {
			background-image: url(/images/bg_list_dot.gif);
			}
		</style>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<!-- print_start -->
					<DIV class="subtitle"><%#((EPiServer.PageBase)Page).CurrentPage.Property["HeadDocumentList"].Value%></DIV>
					<!-- print_end -->

					<development:PageBody id="PageBody" runat="server"></development:PageBody>
					
					<!-- print_start -->
					<development:ArticleList id="ArticleList" runat="server"></development:ArticleList>
					<!-- print_end -->
				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links id="Links" runat="server"></development:Links>
				</td>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
