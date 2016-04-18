<%@ Page language="c#" Codebehind="CrawlerLog.aspx.cs" AutoEventWireup="false" Inherits="BVNetwork.EPiMss.CrawlerLog" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script language="JavaScript">
			<!--
			//Needed for standard EPiServer functionality
				function onNavigate(newPageLink)
				{
				return -1;
				}
				  
				function onCommand(newCommand)
				{
				return -1;
				}
			//-->			
		</script>
		<LINK href="<%= EPiServer.Global.EPConfig.RootDir %>util/styles/system.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<h1>
			Crawler Status
		</h1>
		<pre>
<asp:literal id="lblStatus" runat="server" />
</pre>
	</body>
</html>
