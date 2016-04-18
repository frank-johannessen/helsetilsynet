<%@ Page language="c#" Codebehind="Mobile.aspx.cs" Inherits="EPiServer.templates.Mobile" AutoEventWireup="false" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<meta name="GENERATOR" content="Microsoft Visual Studio 7.0">
<meta name="CODE_LANGUAGE" content="C#">
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/Mobile/Page">
<body Xmlns:mobile="http://schemas.microsoft.com/Mobile/WebForm">
	<mobile:Form id="_default" runat="server" Title="<%#CurrentPage.PageName%>" Paginate=true>
		<mobile:TextView id="MainBody" Runat=server><%#CurrentPage["MainBody"]%><p/></mobile:TextView>
		<mobile:Panel Runat=server>
			<episerver:newslist runat=server id="NewsList" PageLinkProperty="ListingContainer">				
				<NEWSTEMPLATE>
					<mobile:link runat=server NavigateUrl='<%#Configuration.RootDir+"templates/mobile.aspx?id="+Container.CurrentPage.PageLink.ID %>' ID="Link1"><%#Container.CurrentPage.PageName%></mobile:link><br/>
				</NEWSTEMPLATE>				
			</episerver:newslist>
		</mobile:Panel>
	</mobile:Form>	
</body>
