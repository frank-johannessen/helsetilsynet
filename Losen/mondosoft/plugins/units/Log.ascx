<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Log.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.Log" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<span class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/log/info"/>
</span>
<div class="configRow">
	<asp:TextBox ID="LogBox" TextMode="MultiLine" Height="400px" Width="100%" Runat=server></asp:TextBox>
</div>
<br />
<asp:Button id="GetLog" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/log/getlogbutton")%>' runat="server"></asp:Button>