<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Page language="c#" Codebehind="NewsGroupItem.aspx.cs" AutoEventWireup="false" Inherits="development.NewsGroupItem" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
		<style>
		BODY { BACKGROUND: #ffffff }
		</style>
	</HEAD>
	<body class="NewsGroupItem" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
		<form id="NewsGroupItem" method="post" runat="server">
			<asp:panel runat="server" id="TableHeader" Visible="false">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top" align="right" background="../images/bar_background.gif">
							<TABLE cellSpacing="0" cellPadding="0" border="0">
								<TR>
									<TD vAlign="top" align="left" background=""><IMG src="../images/bar_separator_button.gif" border="0"></TD>
									<asp:Panel id="Answer" runat="server" Visible="false">
										<TD vAlign="center" align="middle" background=""><A 
            class=NewsgroupBarButton 
            href="NewsGroupItem.aspx?parent=<%#CurrentPage.PageLink%>&amp;type=<%#ItemPageType%>&amp;pagename=<%#CurrentPage.PageName%>">
												<episerver:translate id="Translate1" runat="server" Text="#reply"></episerver:translate></A></TD>
										<TD vAlign="top" align="left" background=""><IMG src="../images/bar_separator_button.gif" border="0"></TD>
										<TD vAlign="center" align="middle" background="">
											<asp:LinkButton class="NewsgroupBarButton" id="Subscribe" onclick="ChangeSubscribtion" runat="server"></asp:LinkButton></A></TD>
										<TD vAlign="top" align="left" background=""><IMG src="../images/bar_separator.gif" border="0"></TD>
										<TD vAlign="top" align="left" background=""><IMG height="26" alt="" src="../images/clear.gif" width="10" border="0"></TD>
									</asp:Panel></TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td background="../images/heading_background.gif" valign="bottom" align="left">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#name" runat="server" ID="Translate2" />:&nbsp;</td>
								<td class="NewsgroupItemHeading2" valign="top" align="left">
									<episerver:property id="WriterName" propertyname="WriterName" runat="server"></episerver:property>
								</td>
							</tr>
							<tr>
								<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#email" runat="server" ID="Translate3" />:&nbsp;</td>
								<td class="NewsgroupItemHeading2" valign="top" align="left">
									<episerver:property id="WriterEmail" propertyname="WriterEmail" runat="server"></episerver:property>
								</td>
							</tr>
							<tr>
								<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#subject" runat="server" ID="Translate4" />:&nbsp;</td>
								<td class="NewsgroupItemHeading2" valign="top" align="left">
									<episerver:property id="PageName" propertyname="PageName" runat="server"></episerver:property>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td bgcolor="#000000"><img src="images/clear.gif" width="1" height="1" border="0"></td>
				</tr>
			</table>
			<div style="MARGIN-LEFT: 10px">
				<episerver:property id="pageBody" class="NewsGroupItemMessage" propertyname="MainBody" runat="server"></episerver:property>
			</div>
			<asp:Button name="SaveAndPublish" Runat="server" Translate="/button/publish" ID="publish" Visible="false"></asp:Button>
		</form>
	</body>
</HTML>
