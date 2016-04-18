<%@ Page language="c#" Codebehind="NewsGroup.aspx.cs" AutoEventWireup="false" Inherits="development.NewsGroup" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<HEAD>
		<development:header ID="pageHeader" runat="server" />
	</HEAD>
  <frameset cols="20%,*" FRAMESPACING="2" FRAMEBORDER="1" BORDERCOLOR="#555555">
	<frame frameborder="0" scrolling="yes" name="NewsGroupTree" src="NewsGroupTree.aspx?id=<%=CurrentPageLink.ID%>" id="NewsGroupTree" />
	<frame frameborder="0" scrolling="yes" name="NewsGroupView" src="NewsGroupView.aspx?id=<%=CurrentPageLink.ID%>" id="NewsGroupView" />
  </frameset>
</html>
