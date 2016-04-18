<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticSearchService.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticSearchService" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Mondosoft" TagName="DiagnosticItem"			Src="~/mondosoft/plugins/units/DiagnosticItem.ascx"%>

<Mondosoft:DiagnosticItem id="searchservice" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/searchserviceaccess"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/searchserviceaccesshelp"
			DiagnosticTest="TestSearchServiceAccess"  />
<Mondosoft:DiagnosticItem id="searchserviceisok" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/searchserviceisok"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/searchserviceisokhelp"
			DiagnosticTest="TestSearchServiceIsOK"  />
<Mondosoft:DiagnosticItem id="TestSearchServiceCanRun" runat="server"
			TranslateDiagnosticLabel="/mondosoft/plugins/configuration/diagnostic/searchservicecanrun"
			TranslateHelpText="/mondosoft/plugins/configuration/diagnostic/searchservicecanrunhelp"
			DiagnosticTest="TestSearchServiceCanRun"  />
<hr />
