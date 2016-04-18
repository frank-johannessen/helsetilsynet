<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Overview.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Plugins.Units.Overview" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/overview/crawlerstate"/>
	</div>
	<div class="configValue">
		<%=ServerState.State%>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/overview/productionstate" />
	</div>
	<div class="configValue">
		<%=PublishState.State%>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/overview/lastproductionpublish"/>
	</div>
	<div class="configValue">
		<%=PublishState.LastProductionPublish.ToLongDateString()%> - <%=PublishState.LastProductionPublish.ToLongTimeString()%>
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/overview/pagessavedtodb"/>
	</div>
	<div class="configValue">
		<%=ServerState.PagesSavedToDB.ToString()%> <br />
	</div>
</div>
<div class="configRow">
	<div class="configLabel">
		<episerver:translate runat="server" Text="/mondosoft/plugins/controlcenter/overview/pagesnotgrabbed"/>
	</div>
	<div class="configValue">
		<%=ServerState.PagesNotGrabbed.ToString()%> <br />
	</div>
</div>
<asp:Button id="RefreshOverview" Text="Refresh" runat="server"></asp:Button>
