<%@ Page language="c#" Codebehind="NewsGroupSearch.aspx.cs" AutoEventWireup="false" Inherits="development.templates.NewsGroupSearch" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <development:header ID="pageHeader" runat="server"></development:header>
  </head>
  <body class="NewsGroupList" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 bottommargin=0>
    <form id="NewsGroupSearch" method="post" runat="server">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td class="NewsGroupBarTitle" background="../images/bar_background.gif" valign="middle" align="left">&nbsp;&nbsp;<%=GetPage(NewsGroupRoot).PageName%></td>
				<td background="../images/bar_background.gif" valign="top" align="left"><img src="../images/clear.gif" width="10" height="26" alt="" border="0"></td>
			</tr>
			<tr>
				<td colspan=2 height="1" background="../images/bar_shadow_white.gif" valign=top align=left><img src="../images/clear.gif" width="10" height="4" alt="" border="0"></td>
			</tr>
			<tr>
				<td colspan="2">
					<table cellspacing="2" border="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
						<tr>
							<td>
								<asp:TextBox ID="SearchQuery" TabIndex="1" Runat="server" Text="" Width="250px" />&nbsp;
								<asp:Button Translate="/button/search" TabIndex="2" Text="Search" Runat="server" ID="SearchButton" Width="75px" />
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" Value="?" id="SearchHelpButton" Width="22px" OnClick="ToggleHelp()">
							</td>
						</tr>
						</tr>
						<tr>
							<td>
								<asp:CheckBox Runat="server" ID="OnlyWholeWords" Checked="true" />
								<episerver:Translate CssClass="EP-tableHeading" Text="/templates/search/onlywholewords" runat="server" id="Translate2" />
							</td>
						</tr>
						<tr>
							<td>
								<div id="SearchHelp" style="DISPLAY:none" runat="server"></div>
								<div id="Message" style="DISPLAY:none" runat="server"></div>
								<!-- Note: PageLink is the default start page for search, used if MainContainer is empty -->
								<episerver:PageSearch 
											Runat="server" 
											ID="SearchResults"
											SearchQuery='<%# SearchQuery.Text %>'
											SearchFiles="False"
											OnlyWholeWords='<%# OnlyWholeWords.Checked %>'
											MainScope='<%# ((EPiServer.PageBase)Page).CurrentPage["MainScope"] %>'
											MainCatalog='<%# ((EPiServer.PageBase)Page).CurrentPage["MainCatalog"] %>' 
											PageLink='<%# NewsGroupRoot %>'	
											PageLinkProperty="MainContainer"
								>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="1">
											<TR class="NewsGroupRow">
												<TD colspan="2">
													<B>
														<episerver:Translate id="Translate6" runat="server" Text="/templates/search/searchresult" CssClass="EP-tableHeading"></episerver:Translate>
													</B>
												</TD>
											</TR>
											<TR class="NewsGroupRow">
												<TD colspan="2">&nbsp;</TD>
											</TR>
											<TR class="NewsGroupRow">
												<TD align="left" width="50"><b><episerver:translate id="Translate4" runat="server" Text="/templates/search/rank" /></b></TD>
												<TD><b><episerver:translate id="Translate5" runat="server" Text="/templates/search/match" /></b></TD>
												</TD>
											</TR>
									</HeaderTemplate>
									<ItemTemplate>
										<TR class="NewsGroupRow">
											<TD align="left" width="50">
												<%#(int)Container.CurrentPage["PageRank"]/10%>
												%</TD>
											<TD align="left"><B>
													<episerver:property id="Property1" runat="server" PropertyName="PageLink" Target="_top"></episerver:property></B></TD>
										</TR>
										<TR class="NewsGroupRow">
											<TD></TD>
											<TD><%#Container.PreviewText%></TD>
										</TR>
									</ItemTemplate>
									<FooterTemplate>
										</table>
									</FooterTemplate>
									<NoMatchesTemplate>
										<br />
										<br />
										<episerver:Translate CssClass="EP-tableHeading" Text="/templates/search/nomatches" runat="server" ID="Translate3" />
									</NoMatchesTemplate>
								</episerver:PageSearch>
							</td>
						</tr>
					</table>
				</td>		
			</tr>
		</table>
     </form>
  </body>
</html>
