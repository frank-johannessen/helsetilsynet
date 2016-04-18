<%@ Control Language="C#" EnableViewState="false" AutoEventWireup="False" CodeBehind="UtilMenu.ascx.cs" Inherits="Avenir.Templates.Units.Static.UtilMenu" %>
<EPiServer:MenuList runat="server" id="Menu">
	<HeaderTemplate>
	    <ul class="utilities">
	</HeaderTemplate>
	<ItemTemplate>
			<li class="unselected"><EPiServer:Property PropertyName="PageLink" runat="server" /></li>
	</ItemTemplate>
	<SelectedTemplate>
			<li class="selected"><EPiServer:Property runat="server" PropertyName="PageLink" /></li>
	</SelectedTemplate>
	<FooterTemplate>
	    </ul>
	</FooterTemplate>
</EPiServer:MenuList>
<asp:Repeater runat="server" ID="AccessKeyMenu">
    <HeaderTemplate>
        <ul style="display: none">
    </HeaderTemplate>
    <ItemTemplate>
        <li>
            <a href="<%# Eval("value") %>" accesskey="<%# Eval("key") %>" ></a>
        </li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>