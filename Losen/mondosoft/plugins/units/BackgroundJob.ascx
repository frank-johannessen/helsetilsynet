<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BackgroundJob.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.BackGroundJob" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />
<episerver:translate runat="server" Text="/mondosoft/plugins/configuration/backgroundjob/info" ></episerver:translate>
<asp:Button id="CreateScheduler" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/createschedulerbutton")%>' runat="server" />
<asp:Button id="KillJob" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/killjobbutton")%>' runat="server" />
<asp:Button id="RunJob" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/runjobbutton")%>' runat="server" />
<asp:Button id="LoadLog" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/loadlogbutton")%>' runat="server" />
<asp:TextBox ID="NoOfLogItems" Text='<%#EPiServer.Global.EPLang.Translate("/mondosoft/plugins/configuration/backgroundjob/nofologitems")%>' Width="30px" Runat="server" />
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

<asp:Label ID="ErrorMessage" Runat="server" Visable="False" />

