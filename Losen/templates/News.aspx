<%@ Page language="c#" Codebehind="News.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.News" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>

<%@ Register TagPrefix="development" TagName="PageBody"		Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="RssListing"	Src="~/templates/Units/RssListing.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing"		Src="~/templates/Units/Listing.ascx"%>
<EPiServer:ContentFrameworkSelector runat="server" FrameworkKeyName="MyMode" ID="FrameworkSelector" DefaultFramework="DefaultFramework">
	<development:DefaultFramework ID="DefaultFramework" runat="server">		
		<EPiServer:Content Region="RegionBody" runat="server">
			<development:PageBody id=Body runat="server" />
			<development:RssListing id="RssListing" runat="server"></development:RssListing><br />
			<development:listing ID="Listing" runat="server"></development:listing>
		</EPiServer:Content>
	</development:DefaultFramework>
	
</EPiServer:ContentFrameworkSelector>