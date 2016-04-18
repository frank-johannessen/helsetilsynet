<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="NewsWithNewsList.aspx.cs" AutoEventWireup="false" Inherits="development.NewsWithNewsList" %>

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
					<div class="subtitle"><episerver:property PropertyName="HeadDocumentList" runat="server" ID="Property2"/></div>
					<!-- print_end -->
					<development:PageBody id="PageBody" runat="server"></development:PageBody>
					<!-- print_start -->
					<br>
					<!-- print_end -->
					<episerver:PropertySearch PageLink=<%#(EPiServer.Core.PageReference)((EPiServer.PageBase)Page).CurrentPage.Property["ListingContainer"].Value%> runat="server" ID="PropertySearchControl">
					</episerver:PropertySearch>
					<episerver:PageList SortOrder=8 DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
						<ItemTemplate>		
							<!-- print_start -->
							<DIV class="link"><episerver:property PropertyName="PageLink" runat="server" ID="Property1"/> (<%#((DateTime)Container.CurrentPage.Property["PageCreated"].Value).ToString("dd.MM.yyyy")%>)</DIV>
							<episerver:property PropertyName="MainIntro" runat="server" ID="Property3" />
							<br>
							<!-- print_end -->
						</ItemTemplate>
					</episerver:PageList>

				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links id="Links" runat="server"></development:Links>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
