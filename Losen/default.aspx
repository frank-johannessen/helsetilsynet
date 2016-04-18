<%@ Page language="c#" EnableViewState="False" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="development._default" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" Namespace="development" Assembly="episerversample" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">		
		<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0">
			<tr>				
				<td valign="top">														
					<div class="title">
						<span class="PrintTitle">
							Siste endrede sider på Losen
						</span>
					</div>			
					<div class="smallTitle">
						<episerver:ChangedPages 
									Runat="server" 
									ID="RecentList" 
									PageLink='<%# EPiServer.Global.EPConfig.RootPage %>'
									MaxCount='<%#GetCount()%>'
									ChangedSince='<%#((EPiServer.PageBase)Page).CurrentPage["ChangedDays"] != null ? TimeSpan.Parse(((EPiServer.PageBase)Page).CurrentPage.Property["ChangedDays"].Value.ToString() + ".00:00:00") : TimeSpan.Parse("60.00:00:00") %>'									
									SortOrder=8>
									<HEADERTEMPLATE>
									</HEADERTEMPLATE>
									<ITEMTEMPLATE>
										<DIV class="hr"><IMG alt="" src="/images/pxl.gif"><BR></DIV>
										<DIV class="link"><a href="<%#Container.CurrentPage.LinkURL%>"><%#((DateTime) Container.CurrentPage.Property["PageChanged"].Value).ToString("dd.MM.yy")%>&nbsp;<episerver:property id="Property4" runat="server" PropertyName="PageName"/></a></DIV>
									</ITEMTEMPLATE>
								</episerver:ChangedPages>
								<a href="<%#GetLink("LastChangedURL")%>"><img alt="" src="/images/arrow-red.gif" width="6" height="10" class="arrow-left">Flere</a>
					</div>																		
				</td>
			</tr>			
		</table>
	</EPiServer:Content>
	
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">		
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="3">
			<tr valign="top">
				<td>
					<episerver:property runat="server" propertyname="MainBody"/>
				</td>
			</tr>
		</table>		
		<br>
		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
					<div class="copyText">
						<episerver:property runat="server" propertyname="CopyText"/>						
					</div>
				</td>
			</tr>
		</table>
		<br>		
	</EPiServer:Content>
</development:DefaultFramework>
