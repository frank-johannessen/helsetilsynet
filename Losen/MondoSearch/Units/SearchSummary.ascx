<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SearchSummary.ascx.cs" Inherits="BVNetwork.EPiMss.Units.SearchSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:placeholder id="pnlSearchSummary" runat="server" Visible=False>
	<div class="MssSearchSummary">
		<div class="MssSearchSummaryCaption">
			<episerver:translate text="/mondosearch/search/summary/caption" runat="server"/>
		</div>
		<episerver:translate text="/mondosearch/search/summary/pagesfound" runat="server"/>
		<%# HasDoneSearch == true && HasResult == true ? " " + SearchInstance.NumberOfPagesFound.ToString() : ""%>
		<br>
		<episerver:translate text="/mondosearch/search/summary/pagesindatabase" runat="server"/>
		<%# HasDoneSearch == true && HasResult == true ? " " + SearchInstance.NumberOfPagesInDatabase.ToString() : ""%>
		<br>
		<episerver:translate text="/mondosearch/search/summary/pageswithallwords" runat="server"/>
		<%# HasDoneSearch == true && HasResult == true ? " " + SearchInstance.NumberOfPagesWithAllWords.ToString() : ""%>
	</div>
</asp:PlaceHolder>