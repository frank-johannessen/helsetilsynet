<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ChangedPages.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.ChangedPages" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>

<episerver:SearchDataSource 
    runat="server" 
    ID="RecentSearchDataSource"
/>
<asp:Repeater ID="Repeater" runat="server">
	<ItemTemplate>
	        <p><%# LinkHeader((EPiServer.Core.PageData)Container.DataItem) %>
	        <%--<p><episerver:property ID="Property1" runat="server" PropertyName="PageLink" />--%>
			<span class="date"><%#((DateTime)((EPiServer.Core.PageData)Container.DataItem)["PageChanged"]).ToString("d")%></span></p>
	</ItemTemplate>
</asp:Repeater>
	