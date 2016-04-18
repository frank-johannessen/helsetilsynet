<%@ Register TagPrefix="EPiServerInstall" Namespace="EPiServer.Install" Assembly="EPiServer.Install" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="Update.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Update" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Update</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
  </HEAD>
	<body>
		<form id="Update" method="post" runat="server">
			<episerversys:systemprefix id="SystemPrefix" runat="server" />
			
			<EPiServerInstall:updateview runat="server" id=Updateview1>
			</EPiServerInstall:updateview>
		</form>
	</body>
</HTML>
