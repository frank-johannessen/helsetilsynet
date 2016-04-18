<%@ Page language="c#" Codebehind="NewsGroupTree.aspx.cs" AutoEventWireup="false" Inherits="development.NewsGroupTree" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
		<style>
			body {background:ffffff;}
		</style>
	</HEAD>
  <body topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 bgcolor="#FFFFFF">
    <form id="NewsGroupTree" method="post" runat="server">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td class="NewsGroupBarTitle" background="/images/bar_background.gif" valign=middle align=left>
				&nbsp;&nbsp;<%=GetPage(NewsGroupRoot).PageName%>&nbsp;&nbsp;
				<i>
					<a href="<%#((EPiServer.PageBase)Page).Configuration.RootDir%>" target="_parent">
						<episerver:Translate Text="#back" runat="server" ID="Translate3" />
					</a>
				</i>
			</td>
			<td background="/images/bar_background.gif" valign="top" align="left"><img alt="" src="/images/clear.gif" width="10" height="26" alt="" border="0"></td>				
		</tr>
		<tr>
			<td colspan=2 height="1" background="~/images/bar_shadow_white.gif" valign=top align=left><img src="~/images/clear.gif" width="10" height="4" alt="" border="0"></td>
		</tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		</tr>
		<episerver:PageTree 
			runat="server" 
			id="Pagedatatree1"
			PageLink="<%#NewsGroupRoot%>"
		>
			<ItemTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#F9F9FF" width="100%">
							<tr>
								<td width="1" bgcolor="#CCCCCC"></td>
								<td height="18" valign="top" width="10">
									<nobr>
										<img alt="" src="/images/os.gif" width=<%#(Container.CurrentPage.Indent - 1)*10%> height="15" ID="Img3"/>
										<img alt="" src="/images/<%# Container.CurrentPage["AllowNewsItem"]==null ? "NewsGroupCat.gif\" width=\"9\" height=\"9\"" : "NewsGroup.gif\" width=\"16\" height=\"16\""%>  />
										<img alt="" src="/images/os.gif" width="1" height="5" />														
									</nobr>
								</td>
								<td class="MenuText">
									<a href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent"><%#Container.CurrentPage.PageName%></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#CCCCCC"></td>
				</tr>
			</ItemTemplate>
			<SelectedItemTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#F3F3FF" width="100%">
							<tr>
								<td width="1" bgcolor="#CCCCCC"></td>
								<td height="18" valign="top" width="10">
									<nobr>
										<img alt="" src="/images/os.gif" alt="" width=<%#(Container.CurrentPage.Indent - 1)*10%> height="15" ID="Img3"/>
										<img alt="" src="/images/<%# Container.CurrentPage["AllowNewsItem"]==null ? "NewsGroupCat.gif\" width=\"9\" height=\"9\"" : "NewsGroup.gif\" width=\"16\" height=\"16\""%> alt="" />
										<img alt="" src="/images/os.gif" alt="" width="1" height="5" />														
									</nobr>
								</td>
								<td class="MenuText">
									<a href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent"><%#Container.CurrentPage.PageName%></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#CCCCCC"></td>
				</tr>
			</SelectedItemTemplate>
			<SelectedTopTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#F3F3FF" width="100%">
							<tr>
								<td width="1" bgcolor="#CCCCCC"></td>
								<td height="18" valign="top" width="10">
									<nobr>
										<img alt="" src="/images/os.gif" width=<%#(Container.CurrentPage.Indent - 1)*10%> height="15" ID="Img3"/>
										<img alt="" src="/images/<%# Container.CurrentPage["AllowNewsItem"]==null ? "NewsGroupCat.gif\" width=\"9\" height=\"9\"" : "NewsGroup.gif\" width=\"16\" height=\"16\""%>  />
										<img alt="" src="/images/os.gif" width="1" height="5" />														
									</nobr>
								</td>
								<td class="MenuText">
									<a href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent"><%#Container.CurrentPage.PageName%></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#CCCCCC"></td>
				</tr>
			</SelectedTopTemplate>
		</episerver:PageTree>
		</table>
     </form>
  </body>
</html>
