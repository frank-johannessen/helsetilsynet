<%@ Page language="c#" Codebehind="SectionList.aspx.cs" AutoEventWireup="false" Inherits="development.SectionList" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHeadPrint id="SectionHeadPrint" runat="server"></development:SectionHeadPrint>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server">
		<style>
			body {
				background-image: url(/images/bg_list_dot.gif);
			}
		</style>

		<table width="600" border="0" bordercolor="yellow" cellspacing="0" cellpadding="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<tr valign="top">
				<td width="400" class="reports">
					<table width="400" border="0" cellpadding="0" cellspacing="0" class="updates">
						<tr>
							<td valign="top" class="title"><episerver:property PropertyName="HeadMiddle" runat="server" ID="Property3" /><BR>
							</td>
						</tr>
						<tr>
							<td valign="top" class="content">
									<episerver:ChangedPages 
									Runat="server" 
									ID="RecentList" 
									PageLink='<%#((EPiServer.PageBase)Page).CurrentPage["ChangedContainer"] != null ? ((EPiServer.PageBase)Page).CurrentPage["ChangedContainer"] : ((EPiServer.PageBase)Page).CurrentPage.PageLink %>'									
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
				<td width="200" class="article">
					<development:links runat="server" ID="Links1"/>
				</td>
			</tr>	
		</table>
		
	</EPiServer:Content>
</development:DefaultFramework>
