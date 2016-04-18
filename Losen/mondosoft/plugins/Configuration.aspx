<%@ Page language="c#" Codebehind="Configuration.aspx.cs" AutoEventWireup="false" Inherits="Mondosoft.EPiServerIntegration.Plugins.Configuration" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="Mondosoft" TagName="WebServiceSettings"		Src="~/mondosoft/plugins/units/WebServiceSettings.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="GeneralSettings"		Src="~/mondosoft/plugins/units/GeneralSettings.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="CrawlerSettings"		Src="~/mondosoft/plugins/units/CrawlerSettings.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="BackgroundJob"			Src="~/mondosoft/plugins/units/BackgroundJob.ascx"%>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticMainView"		Src="~/mondosoft/plugins/units/DiagnosticMainView.ascx"%>
<%@ Register TagPrefix="Mondosoft" Namespace="Mondosoft.EPiServerIntegration.WebControls" Assembly="Mondosoft.EPiServerIntegration" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><episerver:translate runat="server" Text="/mondosoft/plugins/configuration/title" /></title>
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
				<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/heading" /><%=Mondosoft.EPiServerIntegration.Core.Util.RenderHelpLink("EPiServerIntegration","pdf")%>
			</h1>
			<span class="configInfo">
				<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/info" />
			</span>
			<br />
			<Mondosoft:ClientTab TabSelected=1 CssContent="configTabArea" CssPrefix="admintab-" AutoPostBack=true runat="server" ID="ConfigurationTabStrip">
				<Mondosoft:ClientTabItem id="tab1" Index=1 runat="server" ViewArea="GeneralSettings" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/settings/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab2" Index=2 runat="server" ViewArea="WebServiceSettings" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab3" Index=3 runat="server" ViewArea="CrawlerSettings" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/crawlersettings/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab4" Index=4 runat="server" ViewArea="BackgroundJob" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/tabname") %>' />
				<Mondosoft:ClientTabItem id="tab5" Index=5 runat="server" ViewArea="DiagnosticMainView" TabName='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/tabname") %>' />
			</Mondosoft:ClientTab><br />
			<Mondosoft:WebServiceSettings id="WebServiceSettings" runat="server"></Mondosoft:WebServiceSettings>
			<Mondosoft:GeneralSettings id="GeneralSettings" runat="server"></Mondosoft:GeneralSettings>
			<Mondosoft:CrawlerSettings id="CrawlerSettings" runat="server"></Mondosoft:CrawlerSettings>
			<Mondosoft:BackgroundJob id="BackgroundJob" runat="server"></Mondosoft:BackgroundJob>
			<Mondosoft:DiagnosticMainView id="DiagnosticMainView" runat="server"></Mondosoft:DiagnosticMainView>
			
		</form>
	</body>
</HTML>
