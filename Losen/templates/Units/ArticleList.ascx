<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ArticleList.ascx.cs" Inherits="development.templates.Units.ArticleList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<episerver:newslist id="lstArticles" SortOrder="<%#GetSortOrder()%>" MaxCount=<%#GetCount()%> PageLinkProperty="ListingContainer" runat="server">
	<HeaderTemplate>
	</HeaderTemplate>
	<NewsTemplate>
		<DIV class="link">
			<a href="<%#Container.CurrentPage.LinkURL%>">
				<%#Container.CurrentPage["PageName"]%>
			</a>
			(<%#((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yy")%>)
		</DIV>
		<episerver:property PropertyName="MainIntro" runat="server" ID="Property3" />	
		<br>
	</NewsTemplate>
	<FooterTemplate></FooterTemplate>
</episerver:newslist>