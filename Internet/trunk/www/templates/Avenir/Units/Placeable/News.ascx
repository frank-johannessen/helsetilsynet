<%@ Control Language="C#" AutoEventWireup="False" CodeBehind="News.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.News" %>
<EPiServer:PageList id="epiPageList" runat="server">
	<HeaderTemplate>
        <h1 class="contentItemHead">Nyheter</h1>
	</HeaderTemplate>
	<ItemTemplate>
		    <%# GetImage(Container.CurrentPage) %>
			<h2>
				<EPiServer:Property PropertyName="PageLink" ToolTip="<%$ Resources: EPiServer, navigation.readmore %>" runat="server" />
			</h2>
			<p><%#GetPreviewText(Container.CurrentPage)%>
            <span class="date" visible="true" runat="server"><%#GetFormattedDate(Container.CurrentPage)%></span></p>
	</ItemTemplate>	
	<FooterTemplate>
	</FooterTemplate>
</EPiServer:PageList>
