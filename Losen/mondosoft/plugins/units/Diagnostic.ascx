<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Diagnostic.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.Diagnostic" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticItem"			Src="~/mondosoft/plugins/units/DiagnosticItem.ascx"%>

<Mondosoft:DiagnosticItem id="internet" runat="server"
TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/intenetaccess"
TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/intenetaccesshelp"
DiagnosticTest="TestInternet"  />
<hr />

