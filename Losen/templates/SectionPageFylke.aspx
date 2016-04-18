<%@ Register TagPrefix="development" Namespace="development" Assembly="episerversample" %>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<%@ Register TagPrefix="development" TagName="sitemap"		Src="~/templates/Units/sitemap.ascx"%>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" EnableViewState="False" Codebehind="SectionPageFylke.aspx.cs" AutoEventWireup="false" Inherits="development.SectionPageFylke" %>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content id="ContentTop" runat="server" Region="RegionTop">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content id="Fylker" runat="server" Region="RegionCenter">
		<TABLE class="fylke" borderColor="yellow" cellSpacing="0" cellPadding="0" width="600" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<tr>
				<td valign="top">
					<div class="title"><episerver:property PropertyName="HeadMiddle" runat="server" ID="Property3" /></div>
					<br>
					<img alt="" src="/images/pxl.gif" width="1" height="3"><br>
					<episerver:newslist id="NewsList" SortOrder="<%#GetSortOrder()%>" PageLinkProperty="ListingContainer" runat="server">
						<HeaderTemplate>
							<TABLE borderColor="yellow" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<tr>
									<td colspan="5" class="hr"><IMG alt="" src="/images/pxl.gif" width="1" height="1"></td>
								</tr>
								<tr>
						</HeaderTemplate>
						<NewsTemplate>
							<td valign="top">
								<DIV class="link">
									<div class="fylkeMargin">
										<a href="<%#Container.CurrentPage.LinkURL%>">
											<%#Container.CurrentPage["PageName"]%>
										</a>
									</div>
								</DIV>
							</td>
							<%# count++ == 3 ? "<td width=\"180\">&nbsp</td></tr><tr><td colspan=\"5\" class=\"hr\"><IMG alt=\"\" src=\"/images/pxl.gif\"></td></tr><tr>" : "" %>
							<%# count == 8 ? "<td width=\"180\">&nbsp</td></tr><tr><td colspan=\"5\" class=\"hr\"><IMG alt=\"\" src=\"/images/pxl.gif\"></td></tr><tr>" : "" %>
							<%# count == 12 ? "<td width=\"180\">&nbsp</td></tr><tr><td colspan=\"5\" class=\"hr\"><IMG alt=\"\" src=\"/images/pxl.gif\"></td></tr><tr>" : "" %>
							<%# count == 16 ? "<td width=\"180\">&nbsp</td></tr><tr><td colspan=\"5\" class=\"hr\"><IMG alt=\"\" src=\"/images/pxl.gif\"></td></tr><tr>" : "" %>
							<%# count == 19 ? "<td><div class=\"link\">&nbsp;</link></td><td width=\"180\">&nbsp</td></tr>" : "" %>
						</NewsTemplate>
						<FooterTemplate>
		</TABLE>
							<IMG alt="" src="/images/pxl.gif" width="1" height="1"><br>
						</FooterTemplate>
					</episerver:newslist>
				</td>
			</tr>
		</TABLE>
	</EPiServer:Content>
	<EPiServer:Content id="contentBody" runat="server" Region="RegionBody"> <!-- BEGIN SiteMap -->
		<!-- BEGIN SiteMap -->	
		<table width="600" border="0" cellspacing="0" cellpadding="0" class="section">
			<tr valign="top" class="sitemap"> 
				<td colspan="5" class="title"><episerver:property PropertyName="HeadSiteMap" runat="server" ID="Property4" /></td>
			</tr>
			<tr valign="top" class="sitemap">
				<td colspan="5">
					<development:sitemap id="sitemapNew" runat="server"></development:sitemap>
				</TD>
			</TR>
		</TABLE> 
		<!-- END SiteMap -->
	</EPiServer:Content>
</development:DefaultFramework>
	