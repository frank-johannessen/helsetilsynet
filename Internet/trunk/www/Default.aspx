<%@ Page language="c#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" 
Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="Avenir._default"  %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="News"	Src="~/Templates/Avenir/Units/Placeable/News.ascx" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/ChangedPages.ascx" %>
<%@ Register TagPrefix="ht" TagName="ChangedPagesFront" Src="~/Templates/Avenir/Units/Placeable/ChangedPagesFront.ascx" %>
<%@ Register TagPrefix="ht" TagName="KeywordList"	Src="~/Templates/Avenir/Units/Placeable/KeywordList.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" TagName="ManagementConsole" Src="~/templates/Avenir/Webparts/ManagementConsole.ascx" %>
<%@ Register TagPrefix="EPiCodeWP" Namespace="EPiCode.WebParts.EPiChrome" Assembly="EPiCode.WebParts.Core" %>

<asp:Content ID="Content1" ContentPlaceHolderID="WebParts" runat="server">
    <asp:WebPartManager runat="server" 
            ID="MainWebPartManager" 
            Personalization-Enabled="true"
            Personalization-InitialScope="shared" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CenterArea" runat="server">
<%--	 <EPiCodeWP:ZoneLowUiImpact runat="server" ID="ZoneLowUiImpactCenter" CatalogZoneId="ThemeCatalogZone" />
--%>	<div class="tabBox">
		<ul class="liveTabs">
			<li class="selected"><%=((EPiServer.PageBase)Page).CurrentPage.Property["NewsTxt"]%></li>
			<li>Sist publisert</li>
		</ul>
		<div class="contentWrapper">
			<div class="content">
			
				<div class="contentItem">
			        <div id="NewsArea">
				        <ht:News
					        PageLinkProperty="NewsMore" 
					        PreviewTextLength="150"
					        SeeMoreText="<%$ Resources: EPiServer, news.morenews %>"
					        MaxCountProperty="ListingCount"
					        DateProperty="StartPublish"
					        runat="server" />
			        </div>
					
					<p class="readMoreOtherPage"><a href="<%=getNewsArchive() %>"><%=((EPiServer.PageBase)Page).CurrentPage.Property["NewsArchiveTxt"]%></a></p>
				</div>
			    <div class="contentItem">
			        <h1 class="contentItemHead"><%=((EPiServer.PageBase)Page).CurrentPage.Property["LastPublishedTxt"]%></h1>
                    <ht:ChangedPagesFront ID="ChangedPages" runat="server" Visible="false" />	 
	                <p class="readMoreOtherPage"><a href="<%=getLastPubPage() %>"><%=((EPiServer.PageBase)Page).CurrentPage.Property["ShowAllTxt"]%></a></p>
			    </div>
				
			</div>
			<!-- end .content -->
		</div>
		<!-- end .contentWrapper -->
		
	<!-- end .tabBox -->
	</div>


	<div class="focusBox focusBoxLeft focusBoxFramed">
		<div class="focusBoxInner"><img class="focusTopImage"  src="<%=ResolveUrl("~/Templates/Avenir/images/focusInspect.jpg")%>" alt="Fokusikon" />
			<h2><span><%=((EPiServer.PageBase)Page).CurrentPage.Property["InFocusTxt"]%></span></h2>
            <EPiServer:Property ID="Property1" PropertyName="InfocusText" runat="server" />			
            <%#GetTeaser(3)%>
		</div>
	</div> 

	<div class="focusBox focusBoxRight">
		<div class="focusBoxInner"><img class="focusTopImage"  src="<%=ResolveUrl("~/Templates/Avenir/images/focusSpeaker.jpg")%>" alt="Fokusikon" />
			<h2><span><%=((EPiServer.PageBase)Page).CurrentPage.Property["ComplaintsTxt"]%></span></h2>
			<EPiServer:Property PropertyName="CopyText" runat="server" />
		</div>
	</div>
     
</asp:Content>


<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
    <EPiCodeWP:ZoneLowUiImpact runat="server" ID="ZoneLowUiImpactLeft" CatalogZoneId="ThemeCatalogZone" />
           
    <asp:PlaceHolder ID="PlaceHolder" runat="server"> 
        <EPiCodeWP:ManagementConsole ID="ManagementConsole1" runat="server" /> 
    </asp:PlaceHolder> 
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="RightArea" runat="server">
    <ht:KeywordList ID="KeywordList" runat="server" />

</asp:Content>
