<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditTree.ascx.cs" Inherits="BVNetwork.EPiMss.Plugins.MssEditTree" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<style>
h2 {
	font-size: 10pt;
	margin-top: 6px;
	margin-bottom: 6px;
}	
</style>
<div style="WIDTH: 100%; BACKGROUND-COLOR: black; padding-top: 4 px; padding-bottom: 4px; margin-top: 4px; margin-bottom: 4px;" 
	 align="right">
<img runat="server" src="~/MondoSearch/images/MondoSearch_top.gif" border="0">
</div>
<script>
	function doShowStatus(sLogFile)
	{
		parent.frames["EditPanel"].location.href = '<%= Configuration.RootDir %>MondoSearch/Plugins/CrawlerLog.aspx?LogFile=' + sLogFile;
	}	
</script>
<h2>Crawler Status</h2>
<asp:label id="lblStatus" Runat="server" Font-Italic="True" Font-Bold="True" />
&nbsp;&nbsp;<a href="javascript:__doPostBack('actionTab:PlugInTab1','TabClicked')" style="TEXT-DECORATION:underline"><episerver:translate runat="server" text="/mondosearch/plugin/plugintree/refreshstatus"/></a>
<h2><episerver:translate runat="server" text="/mondosearch/plugin/plugintree/startcrawler"/></h2>
<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/startcrawlerinfo"/>
<br>
<b><episerver:translate runat="server" text="/mondosearch/plugin/plugintree/startcrawlersettings"/></b>
<br>
<asp:CheckBox id="chkPublish" runat="server"></asp:CheckBox> <episerver:translate runat="server" text="/mondosearch/plugin/plugintree/dopublish"/>
<br>
<div style="MARGIN-LEFT: 18px;COLOR: gray">
	<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/dopublishinfo"/>
</div>
<br>
<asp:button id="btnStartCrawler" runat="server" Text=""></asp:button>
<br>
<br>
<h2><episerver:translate runat="server" text="/mondosearch/plugin/plugintree/logs"/></h2>
<div style="padding-left: 6px;">
	<b><a href="javascript:doShowStatus('Crawler.log')">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/viewcrawlerlog"/>	
	</a></b>
	<div style="padding-left: 10px; color: gray;">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/viewcrawlerloginfo"/>
	</div>
	<br>
	<b><a href="javascript:doShowStatus('Publish.log')">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/viewpublishlog"/>
	</a></b>
	<div style="padding-left: 10px; color: gray;">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/viewpublishloginfo"/>
	</div>
</div>
<br>
<h2><episerver:translate runat="server" text="/mondosearch/plugin/plugintree/links"/></h2>
<div style="padding-left: 6px;">
	<asp:placeholder enableviewstate="False" visible=<%# Configuration["EPsMondosoftInSiteUrl"].ToString().Length > 0 %> runat="server">
	<b><a target="EditPanel" href="<%# Configuration["EPsMondosoftInSiteUrl"] %>">InSite</a></b>
	<div style="padding-left: 10px; color: gray;">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/insiteinfo"/>
	</div>
	<br>
	</asp:placeholder>
	<asp:placeholder enableviewstate="False" visible=<%# Configuration["EPsMondosoftInformationManagerUrl"].ToString().Length > 0 %> runat="server">
	<b><a target="EditPanel" href="<%# Configuration["EPsMondosoftInformationManagerUrl"] %>">InformationManager</a></b>
	<div style="padding-left: 10px; color: gray;">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/informationmanagerinfo"/>	
	</div>
	<br>
	</asp:placeholder>
	<asp:placeholder enableviewstate="False" visible=<%# Configuration["EPsMondosoftBehaviorTrackingUrl"].ToString().Length > 0 %> runat="server">
	<b><a target="EditPanel" href="<%# Configuration["EPsMondosoftBehaviorTrackingUrl"] %>">BehaviorTracking</a></b>
	<div style="padding-left: 10px; color: gray;">
		<episerver:translate runat="server" text="/mondosearch/plugin/plugintree/behaviortrackinginfo"/>
	</div>
	<br>
	</asp:placeholder>
</div>

