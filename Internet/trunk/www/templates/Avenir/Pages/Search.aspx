<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" Codebehind="Search.aspx.cs" Inherits="Avenir.Templates.Pages.SearchPage" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.Helpers" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.PropertyMappings" %>
<%@ Register TagPrefix="ht" TagName="MainBody" Src="~/Templates/Avenir/Units/Placeable/MainBody.ascx" %>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<%@ Register TagPrefix="ht" TagName="KeywordList"	Src="~/Templates/Avenir/Units/Placeable/KeywordList.ascx" %>
<%@ Register TagPrefix="ht" TagName="Pager"	    Src="~/templates/Avenir/Units/Placeable/Pager.ascx"%>
<%@ Register TagPrefix="cust" Assembly="Helsetilsynet" Namespace="Avenir.WebControls" %>
<%@ Register TagPrefix="ht" TagName="SearchSummary" Src="~/templates/Avenir/Units/Placeable/SearchSummary.ascx" %>
<%@ Register tagPrefix="ht" tagName="LimitText" src="~/templates/Avenir/Units/Placeable/LimitTextAndLinkForSearch.ascx" %>
<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="<%=ResolveUrl("~/Templates/Avenir/scripts/googlesearch.js")%>"></script>

	<div class="framedBox">
		<div class="reportSearch">
			<ht:LimitText runat="server" />
		      
            <asp:TextBox ID="Sok" CssClass="searchBox"  TabIndex="1" runat="server" />
            <asp:Button ID="Button1" CssClass="searchButton" runat="server" TabIndex="2" OnClick="Button1_Click" Text="<%$ Resources: EPiServer, navigation.search %>" /><br />
		</div>
		
		<ul class="searchDrillDown">
			<li><asp:CheckBox ID="RemoveReports" runat="server" />
            <label for="RemoveReports"><%=((EPiServer.PageBase)Page).CurrentPage.Property["RemoveReportsTxt"]%></label></li>
		</ul>
		
		<p class="listHeading"><%=((EPiServer.PageBase)Page).CurrentPage.Property["FilterDocTypeTxt"]%></p>
		<div id="Div1" class="searchDrillDown" runat="server">
		    <cust:ULcheckboxlist  ID="Doctype" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" /> 
                 
       <div class="<%=MobileHelper.ShowCheckBoxList(MobilePropertyMappings.SearchFilterPaAr)%>">
		    <h4 class="accordion-header"><%=((EPiServer.PageBase)Page).CurrentPage.Property["YearFilterTxt"]%> <span  class="icon-arrow-right"></span></h4>
		    <div id="Div2" class="searchDrillDown accordion-tab-content" runat="server">
                <asp:checkboxlist ID="Year" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
            </div>
            <br />
        </div>
        </div>
		<div class="reportSearch">
			<%--<input class="searchButton" type="submit" value="S&oslash;k" />--%>
            <asp:Button ID="Button2" CssClass="searchButton" runat="server" TabIndex="2" OnClick="Button1_Click" Text="<%$ Resources: EPiServer, navigation.search %>" /><br />
		</div>
	</div>
	<div class="box mobile-hide">
		<h2><%=((EPiServer.PageBase)Page).CurrentPage.Property["HitsOtherTxt"]%>:</h2>
        <div id="venstreKolonne">Loading...</div>
        <div id="branding"></div>
	</div>    
</asp:Content>

<asp:Content ContentPlaceHolderID="CenterArea" runat="server">
    <div id="MainBody">
        <ht:MainBody Visible="false" runat="server" />
            <h1><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources: EPiServer, search.searchresult %>" /></h1>
            <p>
                <ht:SearchSummary ID="searchSummary" runat="server" />
            </p>			
		<div class="orderCriteria">
			<span id="sortText"><label style="font-weight: bold;" for="Sortby"><%=((EPiServer.PageBase)Page).CurrentPage.Property["SortTxt"]%>:</label></span>
            <asp:DropDownList AutoPostBack="true" ID="Sortby" OnSelectedIndexChanged="Button1_Click" runat="server">
<%--                <asp:ListItem Text=""></asp:ListItem>
                <asp:ListItem Text="" Selected="True" Value="Date"></asp:ListItem>
--%>            </asp:DropDownList>
		</div>
		<%--<asp:Literal ID="Nyno" Visible="false" runat="server"></asp:Literal>--%>
        <asp:Literal ID="Resultatet" runat="server"></asp:Literal>
		<%--<div class="pageNavigator">--%>
		    <asp:Literal ID="MoreResults" runat="server" />
		<%--</div>--%>
		<ht:Pager id="Pager" runat="server" Visible="false" />
		<div class="message"><p><%=((EPiServer.PageBase)Page).CurrentPage.Property["SearchMessage"]%>
		 </p></div>
   </div>
</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
    <ht:KeywordList ID="KeywordList" runat="server" />
</asp:Content>
