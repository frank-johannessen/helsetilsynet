<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CrawlerSettings.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.CrawlerSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/crawlerintervall" />
	</div>
	<div class="configValue">
		<asp:TextBox id="CrawlerInterval" runat="server" Width="100px"/>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/donotrun" ID="Translate2" NAME="Translate2"/>
	</div>
	<div class="configValue">
		<asp:TextBox id="DoNotRunStart" runat="server" Width="100px"/> - <asp:TextBox id="DoNotRunEnd" runat="server" Width="100px"/>
	</div>
</div>
<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/crawleragent" />
	</div>
	<div class="configValue">
		<asp:TextBox id="CrawlerAgent" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>
<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/alertmailto" />
	</div>
	<div class="configValue">
		<asp:TextBox id="AlertMailTo" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/alertmailfrom" />
	</div>
	<div class="configValue">
		<asp:TextBox id="AlertMailFrom" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>

<br /><br />
<asp:Button id="SaveSettingsBottom" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/crawlersettings/savebutton")%>' runat="server"></asp:Button>
&nbsp;<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/crawlersettings/warning"/>
