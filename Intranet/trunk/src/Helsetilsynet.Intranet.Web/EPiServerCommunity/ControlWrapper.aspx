<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ControlWrapper.aspx.cs" Inherits="EPiServer.Community.Web.Administration.ControlWrapper" %>

<%@Import Namespace="EPiServer.Shell.Web.Mvc.Html"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>ControlWrapper</title>
    
    <%--=Page.ClientResources("Shell")--%>
    <%--=Page.ClientResources("ShellLightTheme")--%>
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Shell.css") %>" type="text/css" rel="stylesheet" />
    <link href="<%= EPiServer.Shell.Paths.ToShellResource("ClientResources/EPi/Shell/Light/Shell.css") %>" type="text/css" rel="stylesheet" />
    
    <link href="styles/main.css" type="text/css" rel="stylesheet" />
    <link href="styles/tabstrip.css" type="text/css" rel="stylesheet">
    <link href="Administration.css" type="text/css" rel="stylesheet" />
    <script language="javascript" src="Administration.js"></script>
	<!--[if gte IE 5.5000]>
		<script src="js/pngfix.js" type="text/javascript"></script>
	<![endif]-->
	
	<script type='text/javascript'>
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function TestOfficeAddin()
		{
			if(!document.getElementById("componentTable"))
			{
		        return;
		    }
		}
		
		function onLoad()
		{
		    if(window.TestClientTools)
		    {
		        TestClientTools();
		    } 
		    if(window.TestOfficeAddIn)
		    { 
		        TestOfficeAddIn();
		    }
		}	
	
	</script>	
	
  </head>
  <body id="adminPage">
    <form id="ControlWrapper" method="post" runat="server">
        <asp:ScriptManager id="ajaxScriptManager" EnablePartialRendering="true" runat="server" />
		<asp:PlaceHolder ID="placeHolderControl" Runat="server" />
    </form>
  </body>
</html>
