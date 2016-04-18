<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticMSService.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticMSService" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticItem"			Src="~/mondosoft/plugins/units/DiagnosticItem.ascx"%>

<Mondosoft:DiagnosticItem id="MSAccess" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/msserviceaccess"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/msserviceaccesshelp"
			DiagnosticTest="TestMSAccess"  />
<Mondosoft:DiagnosticItem id="TestMSServiceIsOK" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/msserviceisok"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/msserviceisokhelp"
			DiagnosticTest="TestMSServiceIsOK"  />
<Mondosoft:DiagnosticItem id="TestMSServiceCanRun" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/msservicecanrun"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/msservicecanrunhelp"
			DiagnosticTest="TestMSServiceCanRun"  />
<hr />
