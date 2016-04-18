<%@ Page language="c#" Codebehind="CategoryFrameWrapper.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.CategoryFrameWrapper" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<HEAD>
		<title></title>
		<LINK href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/main.css") %>" type="text/css" rel="stylesheet"> 
		<!--[if gte IE 5.5000]>
			<SCRIPT src="<% = this.ResolveUrl("~/EPiServerCommunity/js/pngfix.js") %>" type=text/javascript></SCRIPT>
		<![endif]-->
			<script language="javascript" src="<% = this.ResolveUrl("~/EPiServerCommunity/js/StarSuite.js") %>"></script>
			<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.css") %>">
			<link rel="stylesheet" type="text/css" href="<% = this.ResolveUrl("~/EPiServerCommunity/styles/tabstrip.css") %>" />
            <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
            <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
			<script src="<% = this.ResolveUrl("~/EPiServerCommunity/Administration.js") %>"></script>
	</HEAD>
	<body id="adminPage" style="background-color: #ffffff">
		<form runat="server" ID="Form1">
			<asp:PlaceHolder ID="placeHolderControl" Runat="server" />
		</form>
	</body>
</html>
