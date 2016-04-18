<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Listing.ascx.cs" Inherits="development.UserControls.Listing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td>
			<episerver:newslist id="NewsList" PageLinkProperty="ListingContainer"  runat="server" MaxCount='<%#GetCount()%>'>
				<NewsTemplate>
					<hr size="1">
					<span class="DateText"><%#Container.CurrentPage["PageStartPublish"]%></span><br>
					<b><%#Container.CurrentPage["PageName"]%></b><br />
					<%#Container.PreviewText%><br /><br />
					<a href="<%#Container.CurrentPage.LinkURL%>"><b><episerver:translate Text="/templates/page/readmore" runat="server" ID="Translate3" /></b> <span class="Arrows">&gt;&gt;&gt;</span></a>
				</NewsTemplate>
				<FooterTemplate>
					<hr size="1">
				</FooterTemplate>
			</episerver:newslist>
		</td>
	</tr>
</table>
