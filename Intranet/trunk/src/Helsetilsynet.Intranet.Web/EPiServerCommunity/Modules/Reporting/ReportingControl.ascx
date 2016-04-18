<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportingControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ReportingControl" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>
<%@ Register TagPrefix="Reporting" TagName="Reports" Src="ReportCasesControl.ascx" %>
<%@ Register TagPrefix="Reporting" TagName="UserStatistics" Src="ReportingUserStats.ascx" %>
<script language="javascript" src="Administration.js"></script>
<link rel="stylesheet" type="text/css" href="Administration.css" />
<link rel="stylesheet" type="text/css" href="Styles/Main.css" />
<link rel="stylesheet" type="text/css" href="Styles/TabStrip.css" />

<sc:SaveResultPanel id="saveResultPanel" runat="server" />
<div id="tabStrip">
	<ComponentArt:TabStrip id="tabStripAbuse" 
		CssClass="topGroup"
		DefaultItemLookId="DefaultTabLook"
		DefaultSelectedItemLookId="SelectedTabLook"
		DefaultDisabledItemLookId="DisabledTabLook"
		DefaultGroupTabSpacing="0"
		ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
		MultiPageId="multiPageAbuse"
		runat="server">
		<ItemLooks>
			<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="5" LabelPaddingBottom="4" LeftIconUrl="tab_left_icon.gif" RightIconUrl="tab_right_icon.gif" HoverLeftIconUrl="hover_tab_left_icon.gif" HoverRightIconUrl="hover_tab_right_icon.gif" LeftIconWidth="6" LeftIconHeight="27" RightIconWidth="6" RightIconHeight="27" />
			<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="4" LabelPaddingBottom="4" LeftIconUrl="selected_tab_left_icon.gif" RightIconUrl="selected_tab_right_icon.gif" LeftIconWidth="6" LeftIconHeight="27" RightIconWidth="6" RightIconHeight="27" />
		</ItemLooks>
		<Tabs>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabReports"></ComponentArt:TabStripTab>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabReportedUsers"></ComponentArt:TabStripTab>
			<ComponentArt:TabStripTab Runat="server" ID="tabStripTabInformers"></ComponentArt:TabStripTab>
		</Tabs>
	</ComponentArt:TabStrip>
	
	<ComponentArt:MultiPage id="multiPageAbuse" CssClass="multiPage" runat="server">
		
		<ComponentArt:PageView  runat="server" ID="pageViewReports">
		
			<table class="table" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td class="td"><%=EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Reporting.Header")%></td>
					</tr>
				</thead>
					<tbody>
						<tr>
							<td class="td">
								<ComponentArt:TabStrip id="tabStripReports" 
									CssClass="topGroup"
									DefaultItemLookId="DefaultTabLook"
									DefaultSelectedItemLookId="SelectedTabLook"
									DefaultDisabledItemLookId="DisabledTabLook"
									DefaultGroupTabSpacing="0"
									ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip"
									MultiPageId="multiPageReports"
									runat="server">
									<ItemLooks>
										<ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="5" LabelPaddingBottom="4" LeftIconUrl="tab_left_icon.gif" RightIconUrl="tab_right_icon.gif" HoverLeftIconUrl="hover_tab_left_icon.gif" HoverRightIconUrl="hover_tab_right_icon.gif" LeftIconWidth="6" LeftIconHeight="27" RightIconWidth="6" RightIconHeight="27" />
										<ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="4" LabelPaddingBottom="4" LeftIconUrl="selected_tab_left_icon.gif" RightIconUrl="selected_tab_right_icon.gif" LeftIconWidth="6" LeftIconHeight="27" RightIconWidth="6" RightIconHeight="27" />
									</ItemLooks>
									<Tabs>
										<ComponentArt:TabStripTab Runat="server" Value="new" ID="tabStripTabNewReports"></ComponentArt:TabStripTab>
										<ComponentArt:TabStripTab Runat="server" Value="ignored" ID="tabStripTabIgnoredReports"></ComponentArt:TabStripTab>
										<ComponentArt:TabStripTab Runat="server" Value="handled" ID="tabStripTabHandledReports"></ComponentArt:TabStripTab>
									</Tabs>
								</ComponentArt:TabStrip>
							
				
								<ComponentArt:MultiPage id="multiPageReports" CssClass="multiPage" runat="server">
								
									<ComponentArt:PageView  runat="server" ID="pageViewNewReports" >
										<Reporting:Reports id="reportsNew" runat="server" />
									</ComponentArt:PageView>
									
									<ComponentArt:PageView  runat="server" ID="pageViewIgnoredReports">
										<Reporting:Reports id="reportsIgnored" runat="server" />
									</ComponentArt:PageView>
									
									<ComponentArt:PageView  runat="server" ID="pageViewHandledReports">
										<Reporting:Reports id="reportsHandled" runat="server" />
									</ComponentArt:PageView>
										
								</ComponentArt:MultiPage>
				
							</td>
						</tr>
					</tbody>
			</table>
						
		</ComponentArt:PageView>
		
		<ComponentArt:PageView  runat="server" ID="pageViewReportedUsers">
		
							<Reporting:UserStatistics id="reportedUsers" runat="server" />
						
		</ComponentArt:PageView>
		
		<ComponentArt:PageView  runat="server" ID="pageViewStatistics">
		
							<Reporting:UserStatistics id="reportingUsers" runat="server" />
						
		</ComponentArt:PageView>
	
	</ComponentArt:MultiPage>
</div>