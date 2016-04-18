<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SystemSettings.ascx.cs" Inherits="BVNetwork.EPiMss.Plugins.SystemSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div style="padding-left: 10px; padding-top: 10px;">

	Mondosoft License:<br>
	<asp:textbox id="EPsMondosoftLicense" runat="server" columns="80" />
	<br>
	MondoSearch host URL:<br>
	<asp:textbox id="EPsMondosoftHostUrl" runat="server" columns="80" />
	<br>
	Url to Search Service:<br>
	<asp:textbox id="EPsMondosoftSearchServiceUrl" runat="server" columns="80" />
	<br>
	Url to InSite:<br>
	<asp:textbox id="EPsMondosoftInSiteUrl" runat="server" columns="80" />
	<br>
	Url to Information Manager:<br>
	<asp:textbox id="EPsMondosoftInformationManagerUrl" runat="server" columns="80" />
	<br>
	Url to Behavior Tracking:<br>
	<asp:textbox id="EPsMondosoftBehaviorTrackingUrl" runat="server" columns="80" />
	<br>
	Path to MondoSearch data folder:<br>
	<asp:textbox id="EPsMondosoftDataFolderPath" runat="server" columns="80" />
	<br>
	Path to MondoSearch exec folder:<br>
	<asp:textbox id="EPsMondosoftExecFolderPath" runat="server" columns="80" />
	<br>
	Number of hits per page:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:textbox id="EPnMondosoftPagingNumberOfHitsOnPage" runat="server" columns="2" />
	<br>
	Number of hits per category: <asp:textbox id="EPnMondosoftNumberOfHitsPerCategory" runat="server" columns="2" />
	<br>
	Paging - Number of pages:&nbsp;&nbsp;&nbsp;&nbsp; <asp:textbox id="EPnMondosoftPagingMaxNumberOfPages" runat="server" columns="2" />
	<br>
	<br>
	<hr noshade style="color: silver; height: 1px;" size="1px;">
	<b>User Interface Settings</b>
	<br>

	<asp:checkbox id="EPfMondosoftEnablePageEditTreePlugin" runat="server" />
	<label for="<%= EPfMondosoftEnablePageEditTreePlugin.ClientID %>">Enable Edit Tree Information Plugin</label>
	<br>
	
	<hr noshade="true" style="color: silver; height: 1px;" size="1px;">
	
	<div style="padding-left: 10px;">
		<table cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td valign="top" style="padding-top: 5px;"><img src="../util/images/warning.gif" /></td>
				<td valign="top">
					<b>Troubleshooting</b>
					<br>
					If you are experiencing problems on the site, you can disable all search services. A friendly message will be shown
					on the search page.
					<br>
					<asp:checkbox id="EPfMondosoftSearchServicesDisabled" runat="server" />
					<label for="<%= EPfMondosoftSearchServicesDisabled.ClientID %>">Disable Mondosoft on this Site</label>
					
					<br>
					<br>
					
					Except for members of the following groups:<br>
					<asp:textbox id="EPsMondosoftDebuggingGroups" runat="server" columns="100" />
					<br>
					<span style="color: gray">
					Enter a comma separated list of the groups that should have access to search, for troubleshooting reasons.
					</span>
				</td>
			</tr>
		</table>
	</div>

	
</div>