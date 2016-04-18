<%@ Control Language="c#" AutoEventWireup="false" Codebehind="GeneralSettings.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.GeneralSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/accessgroupms"/>
	</div>
	<div class="configValue">
		<asp:DropDownList id="AccessGroupMS" runat="server" />
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/accessgroupbt"/>
	</div>
	<div class="configValue">
		<asp:DropDownList id="AccessGroupBT" runat="server" />
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/accessgroupim"/>
	</div>
	<div class="configValue">
		<asp:DropDownList id="AccessGroupIM" runat="server" />
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/useshorttabnames" />
	</div>
	<div class="configValue">
		<asp:CheckBox id="UseShortTabNames" runat="server" ></asp:CheckBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/datespan"/>
	</div>
	<div class="configValue">
		<asp:DropDownList id="DateSpan" runat="server" />
	</div>
</div>


<br /><br />

<asp:Button id="SaveSettingsBottom" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/settings/savebutton")%>' runat="server"></asp:Button>
&nbsp;<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/warning"/>