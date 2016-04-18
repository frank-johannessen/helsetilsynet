<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Conference.ascx.cs" Inherits="development.templates.Units.Conference" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="MW" Namespace="development.Class.MyEPiServer" Assembly="episerversample" %>

<table border="0" cellpadding="3" cellspacing="0"  XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td width="100%">
			<asp:Panel ID="StartPage" Runat="server" Visible="false">
				<table border="0" width="100%">
					<tr>
						
						<td colspan=2 valign="top">
							<asp:Panel ID="CreateNew" Runat="server" Visible="False">
								<a href="Conference.aspx?id=<%#((EPiServer.PageBase)Page).CurrentPage.PageLink%>&parent=<%#((EPiServer.PageBase)Page).CurrentPage.PageLink%>&type=<%#((EPiServer.PageBase)Page).CurrentPage.PageTypeID%>">[<episerver:translate Text="#createnew" runat="server" ID="Translate3" />]</a>
							</asp:Panel>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<br/>
							<episerver:property id=pageBody runat="server" propertyname="MainBody"></episerver:property>
						</td>
					</tr>
				</table>
				<br />
				
				<B><episerver:translate Text="#post" runat="server" ID="Translate1" /></B>
				
				<mw:WrappingExplorerTree width="100" EnableVisibleInMenu="False" ShowRootPage="False" PageLink=<%#TreeRoot%> ShowIcons="True"  ClickScript="window.location.href = '{PageLinkURL}'" id="Explorertree1" runat="server" />

			</asp:Panel>
			<asp:Panel ID="EditPanel" runat="server" Visible="false">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="middle" align="left"><episerver:translate Text="#heading" runat="server" ID="Translate2" />:&nbsp;</td>
						<td valign="top" align="left" width="500">
							<episerver:property id="PageName" propertyname="PageName" runat="server" EditMode="true"></episerver:property>
						</td>
					</tr>
					<tr>
						<td valign="middle" align="left"><episerver:translate Text="#author" runat="server" ID="Translate5" />:&nbsp;</td>
						<td valign="top" align="left">
							<episerver:property id="WriterName" propertyname="WriterName" runat="server" EditMode="true" value="<%#GetCurrentUserName()%>"></episerver:property>
						</td>
					</tr>
					<tr>
						<td valign="top" align="left" colspan="2">
							<br />
							<episerver:property id="MainBody" propertyname="MainBody" runat="server" EditMode="true"></episerver:property>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<asp:Button Runat="server" Translate="/button/publish" ID="publish" OnClick="SavePage"></asp:Button>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Panel ID="ViewPanel" Runat="server" Visible="false">
				<table>
					<tr>
						<td width="300">
							<b><%#((EPiServer.PageBase)Page).CurrentPage["PageName"]%></b><br>
							<%#((EPiServer.PageBase)Page).CurrentPage["WriterName"]%>
						</td>
						<td align="right" width="300" valign="top">
							<table border="0" cellspacing="2" cellpadding="2" align="right">
								<tr>	
							<asp:Panel id="PreviousPageLink" runat="server" Visible="false">
								<td><a href="<%#PreviousPageURL%>">[<episerver:translate Text="#previous" runat="server" ID="Translate6" />]</a></td>
							</asp:Panel>
							<asp:Panel id="NextPageLink" runat="server" Visible="false">
								<td><a href="<%#NextPageURL%>">[<episerver:translate Text="#next" runat="server" ID="Translate7" />]</a></td>
							</asp:Panel>
							<asp:Panel ID="Reply" Runat="server" Visible="false">
								<td><a href="Conference.aspx?id=<%#((EPiServer.PageBase)Page).CurrentPage.PageLink%>&parent=<%#((EPiServer.PageBase)Page).CurrentPage.PageLink%>&type=<%#((EPiServer.PageBase)Page).CurrentPage.PageTypeID%>">[<episerver:translate Text="#reply" runat="server" ID="Translate8" />]</a></td>
							</asp:Panel>
							<asp:Panel id="Change" runat="server" Visible="false">
								<td><a href="<%#((EPiServer.PageBase)Page).CurrentPage.LinkURL%>&change=1&type=<%#((EPiServer.PageBase)Page).CurrentPage.PageTypeID%>">[<episerver:translate Text="#change" runat="server" ID="Translate9" />]</a></td>
							</asp:Panel>
							<asp:Panel id="Delete" runat="server" Visible="False">
								<td><asp:LinkButton id="DeleteButton" runat="Server" OnClick="DeletePage">[<episerver:translate Text="#delete" runat="server" ID="Translate20" />]</asp:LinkButton></td>
							</asp:Panel>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br />
							<episerver:property id="Property1" propertyname="MainBody" runat="server"></episerver:property>
						</td>
					</tr>
				</table>
				<hr>
				<b><episerver:translate Text="#replies" runat="server" ID="Translate11" /> </b>(<a href="<%#((EPiServer.PageBase)Page).GetPage(((EPiServer.PageBase)Page).CurrentPage.ParentLink).LinkURL%>"><episerver:translate Text="#uponelevel" runat="server" ID="Translate12" /></a>)
				<mw:WrappingExplorerTree width="100" EnableVisibleInMenu="False" ShowRootPage="False" PageLink=<%#TreeRoot%> ShowIcons="True" ClickScript="window.location.href = '{PageLinkURL}'" id="ExplorerTree" runat="server" />
			</asp:Panel>
		</td>
	</tr>
</table>