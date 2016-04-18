<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ChangedPages.ascx.cs" Inherits="development.templates.Units.ChangedPages" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<table cellspacing="2" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	</tr>
	<TR>
		<td>
			<div id="Message" style="DISPLAY:none" runat="server"></div>
			<table cellpadding="0" cellspacing="5">
				<episerver:ChangedPages 
					Runat="server" 
					ID="RecentList" 					
					PageLink='<%#((EPiServer.PageBase)Page).CurrentPage["RecentContainer"] != null ? ((EPiServer.PageBase)Page).CurrentPage["RecentContainer"] : EPiServer.Global.EPConfig.StartPage %>'
					ChangedSince='<%#((EPiServer.PageBase)Page).CurrentPage["RecentHours"] != null ? TimeSpan.FromHours((int)((EPiServer.PageBase)Page).CurrentPage["RecentHours"]) : TimeSpan.FromHours(1000)%>'
				>
					<HEADERTEMPLATE>
						<TBODY>
							<TR>
								<TD vAlign="top" align="left" width="100"><B>
										<episerver:Translate id="Translate2" CssClass="EP-tableHeading" Text="/templates/changedpages/lastmodified" runat="server"></episerver:Translate></B></TD>
								<TD vAlign="top" align="left" width="350"><B>
										<episerver:Translate id="Translate3" CssClass="EP-tableHeading" Text="/templates/changedpages/page" runat="server"></episerver:Translate></B></TD>
							</TR>
					</HEADERTEMPLATE>
					<ITEMTEMPLATE>
						<TR>
							<TD>
								<%#((DateTime) Container.CurrentPage.Property["PageChanged"].Value).ToString("dd.MM.yyyy")%>
							</TD>
							<TD>
								<episerver:property id="Property1" runat="server" PropertyName="PageLink"></episerver:property>
							</TD>
						</TR>
					</ITEMTEMPLATE>
				</episerver:ChangedPages>
			</table>
		</td>
	</TR>
	</TBODY></table>
