<%@ Page language="c#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" 
Codebehind="Subsection.aspx.cs" AutoEventWireup="false" Inherits="Avenir.Templates.Pages.Subsection"  %>
<%@ Register TagPrefix="ht" TagName="Links"			Src="~/templates/Avenir/Units/Placeable/Links.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/ChangedPages.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" TagName="ManagementConsole" Src="~/templates/Avenir/webparts/managementconsole.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" Namespace="EPiCode.WebParts.EPiChrome" Assembly="EPiCode.WebParts.Core" %>
<%@ Register TagPrefix="ht" TagName="PageListGoogle"	Src="~/templates/Avenir/Units/Placeable/PageListGoogle.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="WebParts" runat="server">
    <asp:WebPartManager runat="server" 
            ID="MainWebPartManager" 
            Personalization-Enabled="true"
            Personalization-InitialScope="shared" />
</asp:Content>

<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
    <EPiCodeWP:ZoneLowUiImpact runat="server" ID="ZoneLowUiImpactLeft" CatalogZoneId="ThemeCatalogZone" />

    <asp:PlaceHolder ID="PlaceHolder" runat="server"> 
        <EPiCodeWP:ManagementConsole ID="ManagementConsole1" runat="server" /> 
    </asp:PlaceHolder>
    <div class="<%=GetBoxClass()%>"> 
      <EPiServer:Property ID="Property3" PropertyName="LeftBody" DisplayMissingMessage="false" EnableViewState="false" runat="server" />
    </div>
    <%=getNavigator()%>
</asp:Content>

<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server">
	<h2 class="go-to-top"><a name="go-to-top" id="go-to-top">Innhold</a></h2>
    <h1><%= Heading %></h1>
	<p class="ingress"><EPiServer:Property ID="MainIntro" PropertyName="MainIntro" DisplayMissingMessage="false" EnableViewState="false" runat="server" /></p>
    <EPiServer:Property ID="Property2" PropertyName="MainBody" DisplayMissingMessage="false" EnableViewState="false" runat="server" />
    <ht:PageListGoogle ID="PageListGoogle" runat="server" />
    <EPiServer:PageList id="EpiPageList" runat="server">
	    <ItemTemplate>
			    <div class="subFrontListItem"><h2>
				    <EPiServer:Property ID="Property1" PropertyName="PageLink" ToolTip="<%$ Resources: EPiServer, navigation.readmore %>" runat="server" />
			    </h2>
			    <p><%#GetPreviewText(Container.CurrentPage)%> </p></div>
	    </ItemTemplate>	
    </EPiServer:PageList>
    <a class="go-to-top" href="#go-to-top">Gå til toppen</a>  
</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
    <ht:Links id="Links" runat="server" />
    <div class="subBox">
        <EPiServer:Property ID="Property4" PropertyName="RightBody" DisplayMissingMessage="false" EnableViewState="false" runat="server" />
    </div>
</asp:Content>
