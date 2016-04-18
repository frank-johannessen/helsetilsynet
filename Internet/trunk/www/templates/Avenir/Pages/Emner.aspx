<%@ Page Language="C#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" Codebehind="Emner.aspx.cs" Inherits="Avenir.Templates.Pages.Emner" %>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<%@ Register TagPrefix="ht" TagName="KeywordList"	Src="~/Templates/Avenir/Units/Placeable/KeywordList.ascx" %>
<%@ Register TagPrefix="ht" TagName="Pager"	    Src="~/templates/Avenir/Units/Placeable/Pager.ascx"%>
<%@ Register TagPrefix="cust" Assembly="Helsetilsynet" Namespace="Avenir.WebControls" %>
<%@ Register tagPrefix="ht" tagName="LimitText" src="~/templates/Avenir/Units/Placeable/LimitTextAndLinkForSearch.ascx" %>
<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
	<div class="framedBox">
		<div class="reportSearch">
			<ht:LimitText runat="server" />
            <asp:TextBox ID="Sok" CssClass="searchBox"  TabIndex="1" runat="server" />
            <asp:Button ID="Button1" CssClass="searchButton" runat="server" TabIndex="2" OnClick="Button1_Click" Text="<%$ Resources: EPiServer, navigation.search %>" /><br />
		</div>
		<p class="listHeading"><%=((EPiServer.PageBase)Page).CurrentPage.Property["FilterDocTypeTxt"]%></p>
			<div id="Div1" class="searchDrillDown" runat="server">
    		    <cust:ULcheckboxlist  ID="Doctype" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
           </div>
        <br />
		<p class="listHeading"><%=((EPiServer.PageBase)Page).CurrentPage.Property["YearTxt"]%></p>
		<div class="searchDrillDown">
            <asp:checkboxlist ID="Year" CssClass="searchDrillDown" runat="server" RepeatLayout="Flow" />
        </div>
        <br />
		<div class="reportSearch">
            <asp:Button CssClass="searchButton" runat="server" TabIndex="2" OnClick="Button1_Click" Text="<%$ Resources: EPiServer, navigation.search %>" /><br />
		</div>
	</div>
</asp:Content>

<asp:Content ContentPlaceHolderID="CenterArea" runat="server">
    <div id="MainBody">
		<h1><asp:Literal ID="ResultHead" runat="server" /></h1>
        <asp:Literal runat="server" ID="litIngress" />
        <p class="searchResult"><%=((EPiServer.PageBase)Page).CurrentPage.Property["YourSearchTxt"]%> <span>
            <asp:Literal ID="AntallTreff" runat="server" /> <%=((EPiServer.PageBase)Page).CurrentPage.Property["HitsTxt"]%></span></p>			
            
		<div class="orderCriteria">
			<span><label style="font-weight: bold;" for="Sortby">Sorter etter:</label></span>
		    <asp:DropDownList AutoPostBack="true" ID="Sortby" OnSelectedIndexChanged="Button1_Click" runat="server" />
		</div>
			
        <asp:Literal ID="Resultatet" runat="server" />
    		<ht:Pager id="Pager" runat="server" Visible="false" />	
		<div class="message"><p><%=((EPiServer.PageBase)Page).CurrentPage.Property["SearchMessage"]%>
		 </p></div>
	</div> 
</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
	<ht:KeywordList ID="KeywordList" runat="server" />
</asp:Content>
