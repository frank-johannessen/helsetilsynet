<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Menu.ascx.cs" Inherits="development.UserControls.Menu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="MenuItem" Src="MenuItem.ascx"%>
<table border="0" cellspacing="0" cellpadding="0" width="150" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
<episerver:PageTree runat="server" id="PageTreeControl" PageLink='<%#EPiServer.Global.EPConfig.StartPage%>'>
	<ItemTemplate>
		<development:menuitem HasChildren='<%#Container.HasChildren%>' Indent='<%#(Container.CurrentPage.Indent - 1)*10%>' runat="server" ID="Menuitem1"/>	
	</ItemTemplate>
	<SelectedItemTemplate>
		<development:menuitem BgColor="E2E6F6" HasChildren=<%#Container.HasChildren%> Indent='<%#(Container.CurrentPage.Indent - 1)*10%>' runat="server" ID="Menuitem3"/>	
	</SelectedItemTemplate>
</episerver:PageTree>
</table>