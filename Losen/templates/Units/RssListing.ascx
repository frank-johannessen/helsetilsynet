<%@ Control Language="c#" AutoEventWireup="false" Codebehind="RssListing.ascx.cs" Inherits="development.Templates.Units.RssListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Label Runat="server" ID="ErrorMessage" Visible="False" />
<asp:DataGrid 
	ID="RssNewsGrid" 
	AutoGenerateColumns="False" 
	Runat="server"
	AlternatingItemStyle-CssClass="unevenrow"
	ItemStyle-CssClass="evenrow"
	HeaderStyle-CssClass="headerrow"
	PageSize='<%#CurrentPage["PagingSize"] == null ? 5 : (int)CurrentPage["PagingSize"]%>'
	OnPageIndexChanged="ChangePaging"
	AllowPaging="True"
	Width="100%"
	Cellpadding="4">
	<PagerStyle Mode="NumericPages" HorizontalAlign="Right" />
  <Columns>
    <asp:TemplateColumn>
		<HeaderTemplate>
			<b>EPiServer Rss Reader</b>
		</HeaderTemplate>
		<ItemTemplate>
			<b>
				<a href="<%# DataBinder.Eval(Container.DataItem, "link")%>" title="<%# Server.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "description")) %>" target="<%#CurrentPage["OpenItemsInNewWindow"] != null ? "_new" : "_self"%>" class="linklist">
					<%# DataBinder.Eval(Container.DataItem, "title") %>
				</a>
			</b>
			<span class="datelistingtext"><%# ((System.Data.DataRowView)Container.DataItem).Row.Table.Columns["date"] == null ? "" : "(" + DataBinder.Eval(Container.DataItem, "date") + ")"%></span>
			<br />
			<asp:Label Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "description") %>' Visible='<%#CurrentPage["OnlyShowHeaders"] == null? true : false%>' />
		</ItemTemplate>
    </asp:TemplateColumn>
  </Columns>
</asp:DataGrid>