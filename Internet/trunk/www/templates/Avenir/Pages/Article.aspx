<%@ Page language="c#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" Codebehind="Article.aspx.cs" AutoEventWireup="false" Inherits="Avenir.Templates.Pages.Article"  %>

<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="PageBody"		Src="~/templates/Avenir/Units/Placeable/PageBody.ascx"%>
<%@ Register TagPrefix="ht" TagName="Links"			Src="~/templates/Avenir/Units/Placeable/Links.ascx"%>
<%@ Register TagPrefix="ht" TagName="LetterHead"	Src="~/templates/Avenir/Units/Placeable/LetterHead.ascx"%>
<%@ Register TagPrefix="ht" TagName="PageListGoogle"	Src="~/templates/Avenir/Units/Placeable/PageListGoogle.ascx" %>
<%@ MasterType VirtualPath="~/Templates/Avenir/MasterPages/HTMaster.master" %>
<%@ Register TagPrefix="EPiCodeWP" TagName="ManagementConsole" Src="~/templates/Avenir/Webparts/ManagementConsole.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" Namespace="EPiCode.WebParts.EPiChrome" Assembly="EPiCode.WebParts.Core" %>

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
    <style type="text/css" id="PdfStyle" visible="false" runat="server">
       @import "/templates/Avenir/Styles/Pdf.css";
    </style>
    <h2 class="go-to-top"><a name="go-to-top" id="go-to-top">Innhold</a></h2>
	<h1><%= Heading %></h1>
	<div class="articleMetaArea">
	<%= GetAdresseInfo() %>
	<p class="ingress"><%= Intro %></p>
	<p class="date"><%= Date %></p>
	
	<div class="pageUtilities" id="pageUtilities">
		<p class="email"><a href="http://www.addthis.com/bookmark.php" class="addthis_button"><img src="<%=ResolveUrl("~/Templates/Avenir/images/iconShare.gif")%>" width="16" height="14" alt="" /> Del</a></p>
	    <p class="generatePdf"><a href="<%= GetPdfPage() %>">Lag PDF</a></p>
		<p class="print"><a href="#" onclick="javascript:window.print();return null;">Skriv ut</a></p>
		<%--<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=xa-4b2f541165db5dfa"></script>--%>
		<script type="text/javascript">
		    var addthis_config = {
//		        services_custom: {
//		            name: "Nettby",
//		            url: "http://www.nettby.no/user/edit_link.php?name=Helsetilsynet&amp;url={{URL}}",
//		            icon: "http://img.nettby.no/img/share_icon.gif"
//		        },
		        ui_language: "nb",
		        services_compact: 'email, facebook, favorites, twitter, linkedin'
		    }
		</script>
		<script type="text/javascript" src="https://s7.addthis.com/js/250/addthis_widget.js#username=xa-4b2f541165db5dfa"></script>
</div>
	</div>
	
	<div class="articleBody">
        <ht:LetterHead id="LetterHead" runat="server" visible="false" />
        <ht:PageBody id="PageBody" runat="server"></ht:PageBody>	
        <a class="go-to-top" href="#go-to-top">Gå til toppen</a>   	
	</div>
       
       
        <ht:PageListGoogle ID="PageListGoogle" runat="server" />

    
</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
    <ht:Links id="Links" runat="server" />
    <div class="subBox">
        <EPiServer:Property ID="Property4" PropertyName="RightBody" DisplayMissingMessage="false" EnableViewState="false" runat="server" />
    </div>
</asp:Content>
