<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Maintaince.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.Maintaince" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<h1 class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/mondosearchsectionheader" ID="Translate1"></episerver:translate>
</h1>
<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/mondosearchsectiondescription" ID="Translate2"></episerver:translate>
<div class="configRow">
	<nobr class="mValue">
	<asp:Button id="StartButton" runat=server/> 
	<asp:Button id="KillButton" runat=server  /> 
	</nobr>
	<br />
</div>
<asp:Panel ID="StartOptions" Runat="server">
	<div class="configRow">
		<asp:CheckBox ID="Publish" Checked="True" Runat="server" /> <episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/publishaftergrabbing" /><br />
	</div>
	<div class="configRow">
		<asp:CheckBox ID="VerboseLogging" Checked="True" Runat="server" /> <episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/verboselogging" />
	</div>
</asp:Panel>
<asp:Literal id="KillCrawlerWarning" runat="server"/>
<hr />
<h1 class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/episerverseactionheader"></episerver:translate>
</h1>
<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/maintaince/episerversectionheader" ID="Translate3"></episerver:translate>
<asp:Button id="CreateScheduler" Text="Create Heart Beat Trigger" runat="server" />
<asp:Button id="KillJob" Text="Delete Heart Beat Trigger" runat="server" /><br />
<asp:Button id="Activate" Text="Activate Heart Beat" runat="server" />
<asp:Button id="RunJob" Text="Manual Heart Beat" runat="server" />
<asp:Button id="LoadLog" Text="Load Log" runat="server" />
<asp:TextBox ID="NoOfLogItems" Text="15" Width="30px" Runat="server" />
<br />
<br />

<asp:Repeater ID="LogList" Runat="server" >
	<ItemTemplate>
		<div style="width:100%;height:100%;padding-bottom:5px;padding-top:5px;border-top:1px solid black;">
			<div style="float:left;width:15%;margin-right:10px;"><%#DataBinder.Eval(Container.DataItem, "Exec")%></div>
			<div style="float:left;width:70%;margin-right:10px;"><%#DataBinder.Eval(Container.DataItem, "Text")%></div> 
			<div style="float:left;width:10%;margin-right:10px;"><%#DataBinder.Eval(Container.DataItem, "StatusMessage")%></div> 
			<div style="float:none;width:5%;border:"><%#DataBinder.Eval(Container.DataItem, "Status")%></div>
		</div>
	</ItemTemplate>
</asp:Repeater>
