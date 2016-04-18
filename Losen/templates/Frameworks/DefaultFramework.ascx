<%@ Register TagPrefix="development" TagName="Quicksearch"	Src="~/templates/Units/QuickSearch.ascx"%>
<%@ Register TagPrefix="development" TagName="LeftMenu"		Src="~/templates/Units/LeftMenu.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing"		Src="~/templates/Units/Listing.ascx"%>
<%@ Register TagPrefix="development" TagName="Header"		Src="~/templates/Units/Header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DefaultFramework.ascx.cs" Inherits="development.Frameworks.DefaultFramework" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<development:header ID="Header1" runat="server"></development:header>
	</HEAD>
	<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
		<form runat="server" id="Default">
			<table width="780" border="0" bordercolor="blue" cellspacing="0" cellpadding="0" class="frontpage">
				<tr valign="top" class="header">
					<td width="180">
						<!-- Logo -->
						<table width="180" height="168" border="0" cellspacing="0" cellpadding="0" class="ident">
							<tr>
								<td width="175" valign="top">
									<a href="<%#GetPageURL()%>"><img src="/images/helsetilsynet-logo.gif" width="180" alt="" height="50" border="0"></a>
									<noindex>
										<DIV id ="LatestFromNoticeBoard">
											<B><a href="http://losen.helsetilsynet.no/templates/Conference.aspx?id=6740">Oppslagstavla</a></B>
											<br/>															
											<episerver:PageList 
												Runat="server" 
												ID="RecentList" 
												PageLinkProperty="NoticeBoardURL"
												MaxCount="<%#GetCount()%>" 											
												SortOrder="8">
												<HEADERTEMPLATE>
													<table width="100%" border="0" cellpadding="0" cellspacing="0">
												</HEADERTEMPLATE>
												<ITEMTEMPLATE>
													<tr valign="top">													
														<td>
															<img src="/images/list_dot_blue.gif"/>
														</td>
														<td>&nbsp;</td>
														<td>
															<div class="link">
																<a href="<%#Container.CurrentPage.LinkURL%>"><episerver:property runat="server" PropertyName="PageName"/></a>													
															</div>
														</td>													
													</tr>
												</ITEMTEMPLATE>
												<footertemplate>
													</table>
												</footertemplate>
											</episerver:pagelist>
										</DIV>
									</noindex>
								</td>
							</tr>				
						</table>
					</td>
					<td width="400" class="news">
						<!-- Page content top -->
						<EPiServer:Region id="RegionTop" runat="server"></EPiServer:Region>
					</td>
					<td width="1" class="vr"><IMG src="/images/pxl.gif" alt="" width="1" height="168"></td>
					<td width="199" height="168">
						<!-- Simple search -->
						<development:Quicksearch id="search" runat="server" />
					</td>
				</tr>
				<tr valign="top">
					<td>
						<!-- Left menu -->
						<development:LeftMenu id="LeftMenu" runat="server" />
					</td>
					<td colspan="3">
						<!-- Body content -->
						<EPiServer:Region id="RegionCenter" runat="server"></EPiServer:Region>
						<EPiServer:Region id="RegionBody" runat="server"></EPiServer:Region>
					</td>
				</tr>
				<tr>
					<td width="180"><IMG src="/images/pxl.gif" alt="" width="180" height="1"><BR>
					</td>
					<td width="400"><IMG src="/images/pxl.gif" alt="" width="400" height="1"><BR>
					</td>
					<td width="1"><IMG src="/images/pxl.gif" alt="" width="1" height="1"><BR>
					</td>
					<td width="199"><IMG src="/images/pxl.gif" alt="" width="199" height="1"><BR>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
