<%@ Page language="c#" Codebehind="NewsGroupIntro.aspx.cs" AutoEventWireup="false" Inherits="development.NewsGroupIntro" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
	<development:header ID="pageHeader" runat="server"></development:header>
		<style>
			body {background:ffffff;}
		</style>
</head>
<body class="NewsGroupItem" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<form runat="server" method="post" id="newsintro">
	<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td class="NewsGroupBarTitle" background="../images/bar_background.gif" valign="middle" align="left">&nbsp;&nbsp;<%=CurrentPage.PageName%>&nbsp;&nbsp;</td>
			<td background="../images/bar_background.gif" valign="top" align="left"><img src="../images/clear.gif" width="10" height="26" alt="" border="0"></td>				
		</tr>
		<tr>
			<td colspan="2" background="../images/bar_shadow_white.gif" valign="top" align="left"><img src="../images/newsgroup/clear.gif" width="10" height="4" alt="" border="0"></td>
		</tr>
	</table>
	<div style="margin-left: 10px;">
		<episerver:property id="pageBody" propertyname="MainBody" runat="server"></episerver:property>
	</div>
	</form>
</body>
</html>
