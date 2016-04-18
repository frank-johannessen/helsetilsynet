<%@ Control Language="C#" EnableViewState="false" AutoEventWireup="False" CodeBehind="MainMenu.ascx.cs" Inherits="Avenir.Templates.Units.Static.MainMenu" %>
<EPiServer:MenuList runat="server" id="Menu">
	<HeaderTemplate>
		<ul class="mainMenu">
	</HeaderTemplate>
	<ItemTemplate>
			<li><%#GetLink(Container.CurrentPage)%></li>
	</ItemTemplate>
	<SelectedTemplate>
			<li class="selected"><span><EPiServer:Property runat="server" PropertyName="PageLink" /></span></li>
	</SelectedTemplate>
	<FooterTemplate>
		</ul>
	</FooterTemplate>
</EPiServer:MenuList>


