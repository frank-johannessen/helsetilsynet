<%@ Page language="c#" Codebehind="default2.aspx.cs" AutoEventWireup="false" Inherits="development.default2" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" Namespace="development" Assembly="episerversample" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<!-- Check if there is a page header saved - if not use page name -->
				<td valign="top">
					<div class="smallTitle"><episerver:property PropertyName="PageHeaderSmall" runat="server" ID="Property5" /></div>
					<div class="title"><%# GetPageName() %></div>
				</td>
			</tr>
			<tr>
				<td valign="bottom" class="leadtext">
					<%#Regex.Replace(((EPiServer.PageBase)Page).CurrentPage.Property["MainIntro"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase)%>
					<a href="<%#GetLink("MainLink")%>"><img src="/images/arrow-red.gif" width="6" height="10" alt="" class="arrow-right"></a><br>
					<%# GetLinks() %>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server">
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="400" class="reports">
					<table width="400" height="168" border="0" cellpadding="0" cellspacing="0" class="reports">
						<tr>
							<td valign="top" class="title"><episerver:property PropertyName="HeadMiddle" runat="server" ID="Property3" /><BR>
							</td>
						</tr>
						<tr>
							<td valign="bottom" class="content">	
								<DIV class="more"><a href="<%#GetLink("LinkTilsyn")%>"><episerver:property PropertyName="TilsynsReportTitle" runat="server" ID="Property6" /><img src="/images/arrow-black.gif" width="6" height="10" alt="" class="arrow-right"></a></DIV>
								<episerver:PropertySearch PageLink=<%#(EPiServer.Core.PageReference)((EPiServer.PageBase)Page).CurrentPage.Property["ListingContainer"].Value%> runat="server" ID="PropertySearchControl">
								</episerver:PropertySearch>
								<episerver:PageList MaxCount="<%#GetCount()%>" SortOrder=8 DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
									<ItemTemplate>
										<DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV>
										<DIV class="link"><a href="<%#Container.CurrentPage.Property["PageLinkUrl"].Value%>"><%#((DateTime)Container.CurrentPage.Property["PageCreated"].Value).ToString("dd.MM.yyyy")%>&nbsp;<%#Container.CurrentPage.Property["PageName"].Value%></a></DIV>																
											
									</ItemTemplate>
								</episerver:PageList>
							</td>
						</tr>
					</table>
				</td>
				<td width="200" class="rights">
					<table width="200" height="168" border="0" cellspacing="0" cellpadding="0" <%#(((EPiServer.PageBase)Page).CurrentPage.Property["PicRights"].Value != null ? "background=\"/images/image-rettigheter.gif\"" : "")%> class="relations">
						<tr>
							<td valign="top"><div class="title"><episerver:property PropertyName="HeadRights" runat="server" ID="Property1" /><BR>
								</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom"><div class="content"><A href="<%#GetLink("LinkRights")%>"><episerver:property PropertyName="TextRights" runat="server" ID="Property2" /><img src="/images/arrow-white.gif" alt="" width="6" height="10" class="arrow-right"></A><br>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">	
		
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0">
			<tr valign="top">

				<td width="400">
					<div class="headTitle"><%#((EPiServer.PageBase)Page).CurrentPage.Property["HeadSiteMap"]%></div>
				
					<%#GetTeaser(1)%>
					
					
					<%#GetTeaser(2)%>

				</td>

				<td width="200">
					<div style="margin-top:30px;">
						<%#GetTeaser(3)%>
					</div>
				</td>

			</tr>
		</table>
		
		<br>
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
					<div class="copyText">
						<%#((EPiServer.PageBase)Page).CurrentPage.Property["CopyText"]%>
					</div>
				</td>
			</tr>
		</table>
		<br>
		
	</EPiServer:Content>
</development:DefaultFramework>
