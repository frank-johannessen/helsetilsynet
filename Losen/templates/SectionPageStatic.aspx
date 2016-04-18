<%@ Page language="c#" Codebehind="SectionPageStatic.aspx.cs" AutoEventWireup="false" Inherits="development.SectionPageStatic" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<%@ Register TagPrefix="development" TagName="sitemap"		Src="~/templates/Units/sitemap.ascx"%>
<%@ Register TagPrefix="development" Namespace="development" Assembly="episerversample" %>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server">
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<tr valign="top">
				<td width="400" class="reports">
					<table width="400" height="168" border="0" cellpadding="0" cellspacing="0" class="updates">
						<tr>
							<td valign="top" class="title"><episerver:property PropertyName="HeadMiddle" runat="server" ID="Property3" /><BR>
							</td>
						</tr>
						<tr>
							<td valign="bottom" class="content">
								<!-- Listing 5 static articles !-->							
								<%# LinkListLeft() %>
							</td>
						</tr>
					</table>
				</td>
				<td width="200" class="rights">
					<table width="200" height="168" border="0" cellspacing="0" cellpadding="0" <%#(((EPiServer.PageBase)Page).CurrentPage.Property["PicRight"].Value != null ? "background=/images/" + ((EPiServer.PageBase)Page).CurrentPage["PicRight"] : "")%> class="relations">
						<tr>
							<td valign="top"><div class="title"><episerver:property PropertyName="HeadRight" runat="server" ID="Property1" /><BR>
								</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
								<div class="content"><EPiServer:Property PropertyName="BlueBoxRight" ID="BlueBoxRight" runat="server"></EPiServer:Property></div>
								<!-- <div class="content"><%# ExternalLinks() %></div> -->
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">	
		<!-- BEGIN SiteMap -->	
		<table width="600" border="0" cellspacing="0" cellpadding="0" class="section">
			<tr valign="top" class="sitemap"> 
				<td colspan="5" class="title"><episerver:property PropertyName="HeadSiteMap" runat="server" ID="Property4" /></td>
			</tr>
			<tr valign="top" class="sitemap">
				<td colspan="5">
					<development:sitemap id="sitemapNew" runat="server"></development:sitemap>
				</td>
			</tr>
		</table>
		<!-- END SiteMap -->	
	</EPiServer:Content>
</development:DefaultFramework>
