<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticMainView.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticMainView" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<span class="configInfo">
	<p><episerver:translate runat="server" Text="/mondosoft/plugins/configuration/diagnostic/info" ID="Translate1"/></p>
</span>
<asp:Button ID="RunInternetDiagnostic" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttoninternettest")%>' />
<asp:Button ID="RunSearchServiceDiagnostic" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttonsearchservicetest")%>' />
<asp:Button ID="RunMSDiagnostic" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttonmstest")%>' />
<asp:Button ID="RunBTDiagnostic" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttonbttest")%>' />
<asp:Button ID="RunIMDiagnostic" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttonimtest")%>' />
<asp:Button ID="RunAllDiagnostics" Runat="server" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/diagnostic/buttonalltests")%>' />
<br />
<br />