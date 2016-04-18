<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticBTService.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticBTService" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticItem"			Src="~/mondosoft/plugins/units/DiagnosticItem.ascx"%>

<Mondosoft:DiagnosticItem id="BTAccess" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/btserviceaccess"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/btserviceaccesshelp"
			DiagnosticTest="TestBTAccess"  />
<Mondosoft:DiagnosticItem id="TestBTServiceIsOK" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/btserviceisok"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/btserviceisokhelp"
			DiagnosticTest="TestBTServiceIsOK"  />
<Mondosoft:DiagnosticItem id="TestBTServiceCanRun" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/btservicecanrun"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/btservicecanrunhelp"
			DiagnosticTest="TestBTServiceCanRun"  />
<hr />
