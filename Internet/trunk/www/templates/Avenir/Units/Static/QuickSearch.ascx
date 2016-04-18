<%@ Control EnableViewState="true" Language="C#" AutoEventWireup="False" CodeBehind="QuickSearch.ascx.cs" Inherits="Avenir.Templates.Units.Static.QuickSearch" %>

<asp:Panel runat="server" CssClass="QuickSearchArea l-640-table-cell" DefaultButton="SearchButton">


<div class="mainSearch">
	<div class="mainSearchField">
	      <asp:TextBox ID="SearchText" AccessKey="4" TabIndex="1" runat="server" />
           <label class="invisibleSearchLabel" for="ctl00_ctl03_SearchText">Search</label>
		
	</div>
	<div class="mainSearchButton">
    <asp:Button ID="SearchButton" runat="server" Text="" ToolTip="<%$ Resources: EPiServer, navigation.search %>" CausesValidation="false"  OnClick="Search_Click" />
	</div>
</div>

</asp:Panel>