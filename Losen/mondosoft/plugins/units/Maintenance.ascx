<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Maintenance.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.Maintenance" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<h1 class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/maintenance/mondosearchsectionheader" ID="Translate1"></episerver:translate>
</h1>
<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/maintenance/mondosearchsectiondescription" ID="Translate2"></episerver:translate>
<div class="configRow">
	<nobr class="mValue">
	<asp:Button id="StartButton" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/maintenance/startbutton")%>' runat=server /> 
	<asp:Button id="StopButton" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/maintenance/stopbutton")%>' Visible="False" runat=server /> 
	<asp:Button id="KillButton" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/maintenance/killbutton")%>' runat=server  /> 
	&nbsp;&nbsp;
	</nobr>
	<br />
</div>
<asp:Panel ID="StartOptions" Runat="server">
	<div class="configRow">
		<asp:CheckBox ID="Publish" Checked="True" Runat="server" /> <episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/maintenance/publishaftergrabbing" /><br />
	</div>
	<div class="configRow">
		<asp:CheckBox ID="VerboseLogging" Checked="True" Runat="server" /> <episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/maintenance/verboselogging" />
	</div>
</asp:Panel>
<asp:Literal id="KillCrawlerWarning" runat="server"/>
<hr />
<div class="configRow">
	<asp:Button id="PublishButton" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/controlcenter/maintenance/publishbutton")%>' runat=server  /> 
</div>

<asp:Label ID="ErrorMessage" Runat="server" Visable="False" />

