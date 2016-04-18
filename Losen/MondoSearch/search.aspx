<%@ Page language="c#" Codebehind="search.aspx.cs" AutoEventWireup="false" Inherits="BVNetwork.EPiMss.SearchTemplate" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="Mss" TagName="CategoryInformation"	Src="~/mondosearch/units/categoryinformation.ascx"%>
<%@ Register TagPrefix="Mss" TagName="SearchTips" Src="~/mondosearch/units/searchtips.ascx"%>
<%@ Register TagPrefix="Mss" TagName="AdvancedSearchOptions" Src="~/mondosearch/units/advancedsearchoptions.ascx"%>
<%@ Register TagPrefix="Mss" TagName="SearchSummary" Src="~/mondosearch/units/searchsummary.ascx"%>
<%@ Register TagPrefix="Mss" TagName="SearchHeaders" Src="~/mondosearch/units/searchheaders.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>

<development:DefaultFramework ID=defaultframework runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHeadPrint id="SectionHeadPrint" runat="server" />
	</EPiServer:Content>
	<EPiServer:Content Region="RegionCenter" runat="server">
		<style>
			body 
			{
				background-image: url(/images/bg_list_dot.gif);
			}
		</style>
		<div class="mainarea">
			<table width="380px" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<asp:placeholder id="pnlSearchServicesDisabled" visible="false" runat="server">
							<h1><episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/disabledhead"/></h1>
							<br>
							<episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/disabledtext"/>
						</asp:placeholder>
						
						<asp:placeholder id="pnlSearchDebugModeDescription" visible="false" runat="server">
							<div style="border: 1px solid #ff8787; background-color: #ffc387; padding: 6px;">
								<b><episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/debugdisabledhead"/></b>
								<br>
								<episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/debugdisabledtext"/>
								<a href="/admin">
								<episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/debugdisabledtext2"/>
								</a><episerver:translate runat="server" text="/mondosearch/searchservicesdisabled/debugdisabledtext3"/>
							</div>
						</asp:placeholder>
						
						<asp:placeholder id="pnlSearchArea" visible="false" runat="server">
							<br>
							<asp:textbox id="txtSearch" cssclass="MssSearchTextBox" runat="server" />
							&nbsp;
							<asp:imagebutton id="cmdSearch" cssclass="searchbutton" imageurl="/images/search.gif" runat="server" />
						
							<mss:advancedsearchoptions id="ucAdvancedSearchOptions" runat="server" visible="false" />

							<asp:placeholder id="pnlSearchFailed" visible="false" runat="server">
								<episerver:translate runat="server" text="/mondosearch/searchfailed/searchfailedreason"/>
								<asp:placeholder id="pnlSearchFailedDebugInfo" visible="false" runat="server">
									<br><br>
									<div style="border: 1px solid #ff8787; background-color: #ffc387; padding: 6px;">
										<b><episerver:translate runat="server" text="/mondosearch/searchfailed/debugtext"/></b>
										<br>
										<episerver:translate runat="server" text="/mondosearch/searchfailed/debugerrornumber"/><asp:literal id="lblErrorNumber" runat="server" />
										<br>
										<episerver:translate runat="server" text="/mondosearch/searchfailed/debugerrormessage"/><asp:literal id="lblErrorMessage" runat="server" />
									</div>
								</asp:placeholder>
							</asp:placeholder>
					
							<!-- Begin Search Result Area -->	
							<!-- The user controls are loaded dynamically 
								depending on wether the search result should categorized or not --> 	
							<asp:placeholder id="pnlLoadedSearchResultControls" runat="server" visible="false">
								<mss:searchheaders runat="server" id="ucSearchHeaders" />
							</asp:placeholder>				
							<!-- End Search Result Area -->

							<asp:placeholder id="pnlSearchDebuggingInfo" visible="false" runat="server">
								<div style="border: 1px solid silver; background-color: #f0f0f0; padding: 6px; margin-top: 10px; margin-bottom: 10px">
									<b><episerver:translate runat="server" text="/mondosearch/developer/debuginformation"/></b>
									<br>
									<episerver:translate runat="server" text="/mondosearch/developer/debugmql"/>
									<div style="margin-left: 10px;">
										<asp:literal runat="server" id="lblDebugMql" />
									</div> 
									<asp:literal runat="server" id="lblDebugInfo" />
								</div>
							</asp:placeholder>
						</asp:placeholder>
					</td>
				</tr>
			</table>
		</div>
	</EPiServer:Content>
	
	<EPiServer:Content ID=Events Region="RegionBody" runat="server">
		<div class="rightarea">
			<asp:placeholder id="pnlSearchSummary" visible="false" runat="server">
					<mss:categoryinformation runat="server" id="ucCategorySidebar" />
			</asp:placeholder>		
			<mss:searchtips runat="server"/>
		</div>
	</EPiServer:Content>
	
</development:DefaultFramework>	