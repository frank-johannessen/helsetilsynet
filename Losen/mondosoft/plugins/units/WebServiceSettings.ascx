<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WebServiceSettings.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.WebServiceSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/searchservice_license" />
	</div>
	<div class="configValue">
		<asp:TextBox id="SearchService_License" runat="server" Width="300px"></asp:TextBox>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/searchservice_url"/>
	</div>
	<div class="configValue">
		<asp:TextBox id="SearchService_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>
<hr />
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/connectionstring_ms"/>
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_MS" runat="server" Width="500px"></asp:TextBox> <asp:Button id="CreateNew_MS" Visible="True" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/createnew")%>' runat="server"></asp:Button>
		<asp:Panel id="GenerateConnectionStringArea_MS" Visible="False" Runat="server">
			<p><strong><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/info")%></strong></p>
			<p><i><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/remember")%></i></p>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/user")%></div>
			<div class="configValue"><asp:TextBox ID="UserName_MS" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/password")%></div>
			<div class="configValue"><asp:TextBox ID="Password_MS" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/hostname")%></div>
			<div class="configValue"><asp:TextBox ID="HostName_MS" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/licensecode")%></div>
			<div class="configValue"><asp:TextBox ID="LicenseCode_MS" runat="server" /></div>
			<br />
			<asp:Button id="Generate_MS" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttongenerate")%>' runat="server">
			</asp:Button> <asp:Button id="Cancel_MS" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttoncancel")%>' runat="server"></asp:Button>
		</asp:Panel>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/ms_url"/>
	</div>
	<div class="configValue">
		<asp:TextBox id="MS_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>

<hr />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/connectionstring_bt" />
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_BT" runat="server" Width="500px"></asp:TextBox> <asp:Button id="CreateNew_BT" Visible="True" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/createnew")%>' runat="server"></asp:Button>
		<asp:Panel id="GenerateConnectionStringArea_BT" Visible="False" Runat="server">
			<p><strong><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/info")%></strong></p>
			<p><i><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/remember")%></i></p>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/user")%></div>
			<div class="configValue"><asp:TextBox ID="UserName_BT" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/password")%></div>
			<div class="configValue"><asp:TextBox ID="Password_BT" runat="server" /></div>
			<br />
			<asp:Button id="Generate_BT" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttongenerate")%>' runat="server">
			</asp:Button> <asp:Button id="Cancel_BT" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttoncancel")%>' runat="server"></asp:Button>
		</asp:Panel>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/bt_url" />
	</div>
	<div class="configValue">
		<asp:TextBox id="BT_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>

<hr />

<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/connectionstring_im" />
	</div>
	<div class="configValue">
		<asp:TextBox id="ConnectionString_IM" runat="server" Width="500px"></asp:TextBox> <asp:Button id="CreateNew_IM" Visible="True" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/createnew")%>' runat="server"></asp:Button>
		<asp:Panel id="GenerateConnectionStringArea_IM" Visible="False" Runat="server">
			<p><strong><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/info")%></strong></p>
			<p><i><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/remember")%></i></p>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/user")%></div>
			<div class="configValue"><asp:TextBox ID="UserName_IM" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/password")%></div>
			<div class="configValue"><asp:TextBox ID="Password_IM" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/hostname")%></div>
			<div class="configValue"><asp:TextBox ID="HostName_IM" runat="server" /></div>
			<div class="configLabel"><%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/licensecode")%></div>
			<div class="configValue"><asp:TextBox ID="LicenseCode_IM" runat="server" /></div>
			<br />
			<asp:Button id="Generate_IM" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttongenerate")%>' runat="server">
			</asp:Button> <asp:Button id="Cancel_IM" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/generate/buttoncancel")%>' runat="server"></asp:Button>
		</asp:Panel>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/im_url" />
	</div>
	<div class="configValue">
		<asp:TextBox id="IM_Url" runat="server" Width="400px"></asp:TextBox>
	</div>
</div>
<br /><br />

<asp:Literal ID="Message" Runat="server" />

<asp:Button id="SaveSettingsBottom" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/savebutton")%>' runat="server"></asp:Button>
&nbsp;<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/webservicesettings/warning"/>
<asp:Button id="DemoSettingsBottom" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/webservicesettings/demosettingsbutton")%>'  runat="server"></asp:Button>
