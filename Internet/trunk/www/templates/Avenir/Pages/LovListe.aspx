<%@ Page language="c#" Codebehind="LovListe.aspx.cs" AutoEventWireup="false" Inherits="Avenir.Templates.Pages.LovListe" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="KeywordList"	Src="~/Templates/Avenir/Units/Placeable/KeywordList.ascx" %>
<%--<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/ChangedPages.ascx" %>
--%>
<%@ Register TagPrefix="ht" TagName="DocList"			Src="~/templates/Avenir/Units/Placeable/DocList.ascx"%>

<%@ Register TagPrefix="EPiCodeWP" TagName="ManagementConsole" Src="~/templates/Avenir/webparts/managementconsole.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" Namespace="EPiCode.WebParts.EPiChrome" Assembly="EPiCode.WebParts.Core" %>

<asp:Content ID="Content1" ContentPlaceHolderID="WebParts" runat="server">
    <link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/templates/Avenir/styles/webparts.css") %>" />    
    <asp:WebPartManager runat="server" 
            ID="MainWebPartManager" 
            Personalization-Enabled="true" Personalization-InitialScope="shared" />
</asp:Content>

<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
    <EPiCodeWP:ZoneLowUiImpact runat="server" ID="ZoneLowUiImpactLeft" CatalogZoneId="ThemeCatalogZone" />

    <asp:PlaceHolder ID="PlaceHolder" runat="server"> 
        <EPiCodeWP:ManagementConsole ID="ManagementConsole1" runat="server" /> 
    </asp:PlaceHolder> 
</asp:Content>

<%--<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
	<div class="box">
		<h2>Siste publiserte</h2>
		<%--<ht:ChangedPages ID="ChangedPages" runat="server" />--%>
<%--		<p class="readMore"><a href="<%= ResolveUrl("~/no/nyheter/sistpub/") %>">Se alle</a></p>
	</div>
</asp:Content>
--%>

<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server">
	<div class="tabBox">
		<ul class="tabs">
		    <%=GetMenu()%>
		</ul>
		<div class="contentWrapper">
			<div class="content">
				<div class="contentItem">
					<table>
					    <%=GetLaws()%>
					</table>
				</div>
				<div class="contentItem"></div>
				<div class="contentItem"></div>
				<div class="contentItem"></div>
			<!-- end .content -->
			</div>
		<!-- end .contentWrapper -->
		</div>
	<!-- end .tabBox -->
	</div>
	<%--<ht:DocList id="DocList" runat="server"></ht:DocList>--%>
</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
	<ht:KeywordList ID="KeywordList" runat="server" />
</asp:Content>


