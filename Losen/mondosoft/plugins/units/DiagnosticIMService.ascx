<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticIMService.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticIMService" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticItem"			Src="~/mondosoft/plugins/units/DiagnosticItem.ascx"%>

<Mondosoft:DiagnosticItem id="IMAccess" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/imserviceaccess"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/imserviceaccesshelp"
			DiagnosticTest="TestIMAccess"  />
<Mondosoft:DiagnosticItem id="TestIMServiceIsOK" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/imserviceisok"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/imserviceisokhelp"
			DiagnosticTest="TestIMServiceIsOK"  />
<Mondosoft:DiagnosticItem id="TestIMServiceCanRun" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/imservicecanrun"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/imservicecanrunhelp"
			DiagnosticTest="TestIMServiceCanRun"  />
<hr />
