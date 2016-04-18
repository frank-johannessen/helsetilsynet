<%@ Page language="c#" Codebehind="ControlCenter.aspx.cs" AutoEventWireup="false" Inherits="Mondosoft.EPiServerIntegration.Plugins.ControlCenter" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="Mondosoft" TagName="StartPage"				Src="~/mondosoft/plugins/units/StartPage.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="Overview"				Src="~/mondosoft/plugins/units/Overview.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="Maintenance"				Src="~/mondosoft/plugins/units/Maintenance.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="Log"					Src="~/mondosoft/plugins/units/Log.ascx"%>
<%@ Register TagPrefix="Mondosoft" Namespace="Mondosoft.EPiServerIntegration.WebControls" Assembly="Mondosoft.EPiServerIntegration" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/title"/></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../styles/configuration.css" type="text/css" rel="stylesheet">
		<LINK href="../styles/tabcontrol.css" type="text/css" rel="stylesheet">
		<script src="../javascript/tabcontrol.js" type="text/javascript"></script>
	</HEAD>
	<body>	
		<form id="Form1" method="post" runat="server">
		
			<h1 class="configHeading"><IMG class="configLogo" src="../images/logo.gif">
				<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/heading" /><%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%>
			</h1>
			<span class="configInfo">
				<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/info" />
			</span>
			<br />
			<Mondosoft:ClientTab TabSelected=1 CssContent="configTabArea" CssPrefix="admintab-" AutoPostBack=true runat="server" ID="ControlCenterTabStrip">
				<Mondosoft:ClientTabItem id="tab1" Index=1 runat="server" ViewArea="StartPage" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/startpage/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab2" Index=2 runat="server" ViewArea="Overview" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/overview/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab3" Index=3 runat="server" ViewArea="Maintenance" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/maintenance/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab4" Index=4 runat="server" ViewArea="Log" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/log/tabname") %>' />
			</Mondosoft:ClientTab><br />
			<Mondosoft:StartPage id="StartPage" runat="server"></Mondosoft:StartPage>
			<Mondosoft:Overview id="Overview" runat="server"></Mondosoft:Overview>
			<Mondosoft:Maintenance id="Maintenance" runat="server"></Mondosoft:Maintenance>
			<Mondosoft:Log id="Log" runat="server"></Mondosoft:Log>
		</form>
	</body>
</HTML>
