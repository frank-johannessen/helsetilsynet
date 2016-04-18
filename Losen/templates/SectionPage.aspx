<%@ Page language="c#" EnableViewState="False" Codebehind="SectionPage.aspx.cs" AutoEventWireup="false" Inherits="development.SectionPage" %>
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
								<!-- Default is the list set to be collected from the actual section, MaxCount is 5 and ChangedSince is 60(days) !-->							
								<episerver:ChangedPages 
									Runat="server" 
									ID="RecentList" 
									PageLink='<%#((EPiServer.PageBase)Page).CurrentPage["ChangedContainer"] != null ? ((EPiServer.PageBase)Page).CurrentPage["ChangedContainer"] : ((EPiServer.PageBase)Page).CurrentPage.PageLink %>'
									MaxCount='<%#((EPiServer.PageBase)Page).CurrentPage["ChangedCount"] != null ? (int)((EPiServer.PageBase)Page).CurrentPage.Property["ChangedCount"].Value : 5 %>'
									ChangedSince='<%#((EPiServer.PageBase)Page).CurrentPage["ChangedDays"] != null ? TimeSpan.Parse(((EPiServer.PageBase)Page).CurrentPage.Property["ChangedDays"].Value.ToString() + ".00:00:00") : TimeSpan.Parse("60.00:00:00") %>'>
									<HEADERTEMPLATE>
									</HEADERTEMPLATE>
									<ITEMTEMPLATE>
										<DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV>
										<DIV class="link"><a href="<%#Container.CurrentPage.LinkURL%>"><%#((DateTime) Container.CurrentPage.Property["PageChanged"].Value).ToString("dd.MM.yy")%>&nbsp;<episerver:property id="Property2" runat="server" PropertyName="PageName"/></a></DIV>
									</ITEMTEMPLATE>
								</episerver:ChangedPages>
							</td>
						</tr>
					</table>
				</td>
				<td width="200">
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
