<%@ Control Language="C#" AutoEventWireup="False" CodeBehind="PageList.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.PageList" %>
<EPiServer:PageList id="epiPageList" runat="server">
	<ItemTemplate>
<%--			<h3><EPiServer:Property PropertyName="PageLink" ToolTip="<%$ Resources: EPiServer, navigation.readmore %>" runat="server" /></h3>
--%>		<h3><%#GetTitle(Container.CurrentPage)%></h3>	
			<p><%#GetPreviewText(Container.CurrentPage)%>
            <span class="date" visible="<%#DateProperty!=null%>" runat="server"><%#GetFormattedDate(Container.CurrentPage)%></span></p>
	</ItemTemplate>	
</EPiServer:PageList>

