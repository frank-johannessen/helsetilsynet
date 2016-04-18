<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Settings.ascx.cs" Inherits="Mondosoft.Plugins.Units.Settings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/crawlerintervall" />
	</div>
	<div class="configValue">
		<asp:TextBox id="CrawlerInterval" runat="server" Width="100px"> </asp:TextBox><asp:Button id="ActivateScheduler" Text="Create Heart Beat" runat="server" />
	</div>
</div>
<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/showbttab" />
	</div>
	<div class="configValue">
		<asp:CheckBox id="ShowBTTab" runat="server" ></asp:CheckBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/showmstab" />
	</div>
	<div class="configValue">
		<asp:CheckBox id="ShowMSTab" runat="server" ></asp:CheckBox>
	</div>
</div>

<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/crawleragent" />
	</div>
	<div class="configValue">
		<asp:TextBox id="CrawlerAgent" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>

<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/searchservice_license" />
	</div>
	<div class="configValue">
		<asp:TextBox id="SearchService_License" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/searchservice_url"/> - URL
	</div>
	<div class="configValue">
		<asp:TextBox id="SearchService_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>
<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/connectionstring_insite_ms"/>
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_MS" runat="server" Width="500px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/insite_ms_url"/> - URL
	</div>
	<div class="configValue">
		<asp:TextBox id="InSite_MS_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>

<hr />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/connectionstring_insite_bt" />
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_BT" runat="server" Width="500px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/insite_bt_url" /> - URL
	</div>
	<div class="configValue">
		<asp:TextBox id="InSite_BT_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>

<hr />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/connectionstring_insite_im" />
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_IM" runat="server" Width="500px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/insite_im_url" /> - URL
	</div>
	<div class="configValue">
		<asp:TextBox id="InSite_IM_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>
<br /><br />
<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/settings/warning"/><br /><br />
<asp:Button id="SaveSettings" Text="Save" runat="server"></asp:Button>
