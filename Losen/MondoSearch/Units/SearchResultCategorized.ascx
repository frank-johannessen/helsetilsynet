<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SearchResultCategorized.ascx.cs" Inherits="BVNetwork.EPiMss.Units.SearchResultCategorized" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!-- The User Control listing the search result is loaded dynamically (one instance for each category). -->
<asp:Placeholder id="pnlResultArea" runat="server" visible="<%# HasDoneSearch && HasResult == true %>">
	<div class="MssSearchResultHeading">
		<br/>
		<asp:Literal runat="server" id="lblCategorySummary" />
	</div>
	<div class="searchresulttext">
		<asp:literal runat="server" id="lblResultText" />
	</div>
</asp:Placeholder>