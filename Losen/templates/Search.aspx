<%@ Page language="c#" Codebehind="Search.aspx.cs" AutoEventWireup="false" Inherits="development.Search" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Search"	Src="~/templates/Units/Search.ascx"%>
<%@ Register TagPrefix="development" TagName="Quicksearch"	Src="~/templates/Units/QuickSearch.ascx"%>
<%@ Register TagPrefix="development" TagName="LeftMenu"		Src="~/templates/Units/LeftMenu.ascx"%>
<%@ Register TagPrefix="development" TagName="Header"		Src="~/templates/Units/Header.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<development:header ID="Header1" runat="server"></development:header>
	</HEAD>
	<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
		<form runat="server" id="Default">
			<table width="780" border="0" bordercolor="blue" cellspacing="0" cellpadding="0" class="frontpage">
				<development:Search id="Search1" runat="server"></development:Search>
				<tr>
					<td width="180"><IMG alt="" src="/images/pxl.gif" width="180" height="1"><BR>
					</td>
					<td width="400"><IMG alt="" src="/images/pxl.gif" width="400" height="1"><BR>
					</td>
					<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="1"><BR>
					</td>
					<td width="199"><IMG alt="" src="/images/pxl.gif" width="199" height="1"><BR>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
