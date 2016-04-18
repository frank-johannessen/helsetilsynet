<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SearchHeaders.ascx.cs" Inherits="BVNetwork.EPiMss.Units.SearchHeaders" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:repeater id="rptSearchHeaders" runat="server" enableviewstate="False">
	<HeaderTemplate>
		<br>
	</HeaderTemplate>
	<ItemTemplate>
		<%# DataBinder.Eval(Container.DataItem, "SearchHeader") %> <br>
	</ItemTemplate>
	<FooterTemplate>
	</FooterTemplate>
</asp:repeater>
