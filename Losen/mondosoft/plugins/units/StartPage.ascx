<%@ Control Language="c#" AutoEventWireup="false" Codebehind="StartPage.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.StartPage" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<% if(Mondosoft.EPiServerIntegration.Core.BaseSettings.IsEmpty) {%>
<div class="configRow">
<span class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/startpage/firsttime"/>
</span>
</div>
<% } else {%>
<span class="configInfo">
	<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/startpage/info"/>
</span>
<% } %>
<br /><br /><br />
<img src="<%=EPiServer.Global.EPConfig.RootDir%>mondosoft/images/productcircle.gif" />
