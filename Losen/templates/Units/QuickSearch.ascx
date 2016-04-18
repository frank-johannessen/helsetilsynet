<%@ Control Language="c#" AutoEventWireup="false" Codebehind="QuickSearch.ascx.cs" Inherits="development.UserControls.Quicksearch" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0" class="functions">
	<tr>
		<td valign="top" class="search">
			<span id="QuickSearchSpan" runat="server">
				<TABLE border="0" cellspacing="0" cellpadding="0">
					<TR>
						<TD valign="top"><asp:textbox id="searchText" runat="server" size="15" Width="110" Height="21"></asp:textbox><BR>
						</TD>
						<TD valign="top"><img alt="" src="/images/pxl.gif" width="1" height="1"><br><img alt="" src="/images/pxl.gif" width="5" height="1"><asp:imagebutton id="QuicksearchButton" runat="server" AlternateText="Søk" ImageUrl="/images/search.gif"></asp:imagebutton><BR>
						<asp:Label ID="ErrorInfo" runat="server" Visible="False" ForeColor="Red" />
						</TD>
					</TR>
				</TABLE>
			</span>
			<noindex>
				<span id="AdvancedSearchLink" runat="server">
					<a href='<%#GetSearchLink()%>'><img alt="" src="/images/arrow-red.gif" width="6" height="10" class="arrow-left"><%#GetSearchLinkText()%></a>
					<episerver 
				</span>
			</noindex>
		</td>
	</tr>
	<tr>
		<td valign="top" class="content">
			<noindex>
				<episerver:pagelist runat="server" PageLinkProperty="ToolPages">
					<itemtemplate>
						<p><A href="<%#Container.CurrentPage.LinkURL%>"><img alt="" src="/images/arrow-red.gif" width="6" height="10" class="arrow-left"><%#Container.CurrentPage.PageName%></A></p>
					</itemtemplate>
				</episerver:pagelist>
			</noindex>
		</td>
	</tr>
</table>
