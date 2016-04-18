<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DiagnosticItem.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.DiagnosticItem" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div class="configRow" >
	<div style="float:left;">
		<asp:Literal ID="DiagnosticCheckBox" Runat="server" />
	</div>
	<div style="display:block; width:100%; padding:4px;">
		 <b><%#DiagnosticLabel%></b>
		<asp:Panel ID="MessageArea" Runat="server">
			<br />
			<asp:Literal ID="Message" Runat="server" />
			<br />
			<br />
			<i><asp:Literal ID="HelpTextLiteral" Runat="server"/></i>
		</asp:Panel>
	</div>
</div>
