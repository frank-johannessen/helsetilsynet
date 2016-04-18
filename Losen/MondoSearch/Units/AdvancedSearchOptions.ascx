<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="AdvancedSearchOptions.ascx.cs" Inherits="BVNetwork.EPiMss.Units.AdvancedSearchOptions" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<br>
<asp:placeholder id="pnlSearchFailed" visible=false runat="server">
	<episerver:translate runat="server" text="/mondosearch/searchfailed/searchfailedreason" id="Translate7" />
	<asp:placeholder id="pnlSearchFailedDebugInfo" visible='<%# BVNetwork.EPiMss.Library.Configuration.SearchConfiguration.UserIsDebuggingMember %>' runat="server">
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
<asp:radiobuttonlist id="cboAndOrExact" runat="server" datatextfield="Text" datavaluefield="Value" enableviewstate="True" />
<br>
<span class="advancedsearchheading"><episerver:translate text="/mondosearch/advancedsearch/category" runat="server"/></span>
<br>
<asp:checkboxlist id="chkCategories" runat="server" DataValueField="Name" DataTextField="Title" repeatcolumns="2" enableviewstate="True" />
<br/>
<span class="advancedsearchheading"><episerver:translate text="/mondosearch/advancedsearch/sortorder/caption" runat="server" /></span>
<br/>
<asp:radiobuttonlist id="rblSortByDateOn" runat="server" datatextfield="Text" datavaluefield="Value" enableviewstate="True" />
<br/>
<asp:checkbox id="cboTitle" runat="server" />