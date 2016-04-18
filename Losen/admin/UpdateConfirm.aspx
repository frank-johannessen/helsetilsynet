<%@ Page language="c#" Codebehind="UpdateConfirm.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.UpdateConfirm" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <title>UpdateConfirm</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
  </HEAD>
  <body>
	
    <form id="UpdateConfirm" method="post" runat="server">
		<episerversys:systemprefix id="SystemPrefix" runat="server" />
		<p>
		<asp:Button id=Button1 runat="server" Translate="/button/ok"></asp:Button>
		</p>

     </form>
	
  </body>
</HTML>
