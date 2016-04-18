<%@ Control Language="c#" AutoEventWireup="false" Codebehind="KeywordListSearch.ascx.cs" Inherits="development.templates.UserControls.KeywordListSearch" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!-- print_start -->
<table border="0" width="370" cellpadding="0" cellspacing="0" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
	<tr>
		<td>
			<asp:Literal id="Result" runat="server"></asp:Literal>
			<br>
			
			<EPiServer:PageSearch PageLink = <%#((EPiServer.PageBase)Page).CurrentPage["MainContainer"]%> ID = "KeywodSearch"></EPiServer:PageSearch>			
						
			<episerver:PropertySearch PageLink=<%#((EPiServer.PageBase)Page).CurrentPage["MainContainer"]%> runat="server" ID="PropertySearchControl"></episerver:PropertySearch>
				
			<episerver:PageList SortBy="PageName" SortDirection="Ascending" DataSource=<%#PropertySearchControl%> runat="server" ID="PageList1">
				<ItemTemplate>
					<a href="<%#Container.CurrentPage.LinkURL%>"><%#Container.CurrentPage.PageName%></a>
					&nbsp;(<%#((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yy")%>)<br>
					<%#Container.CurrentPage["MetaDescription"]%>
					<br><br>
				</ItemTemplate>
			</episerver:PageList>
			<br>
			<asp:Label Runat="server" ID="LinkBack"></asp:Label>
		</td>
	</tr>
</table>
<!-- print_end -->