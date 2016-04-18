<%@ Page language="c#" Codebehind="ControlWrapper.aspx.cs" AutoEventWireup="True" Inherits="EPiServer.Community.Web.Administration.Modules.Expert.ControlWrapper" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title></title>
    <link href="../../../admin/styles/main.css" type="text/css" rel="stylesheet" />
    <link href="../../../admin/styles/tabstrip.css" type="text/css" rel="stylesheet" />
    <link href="../../Administration.css" type="text/css" rel="stylesheet" />
    <script language="javascript" src="../../Administration.js"></script>
	<!--[if gte IE 5.5000]>
		<SCRIPT src="js/pngfix.js" type="text/javascript"></SCRIPT>
	<![endif]-->
  </head>
  <body id="adminPage">
	<form id="ControlWrapper" method="post" runat="server">
		<asp:PlaceHolder ID="placeHolderControl" Runat="server" />
	</form>
  </body>
</html>
